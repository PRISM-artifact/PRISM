open! Vocab
module F = Format
module L = Logging
module CFG = ProcCfg.Exceptional
module Node = InstrNode
module Summary = SpecCheckerSummary
module Spec = StateFormula.Spec

module DisjReady = struct
  module CFG = CFG
  module Domain = SpecCheckerDomain

  module OrgSpecMap = struct
    include PrettyPrintable.MakePPMonoMap (Procname) (Spec)

    let create () =
      StateFormula.SpecMap.fold
        (fun key specs acc ->
          if StateFormula.Specs.is_empty specs then L.progress "Empty Specs : %a@." Procname.pp key ;
          add key (StateFormula.Specs.merge_all specs) acc)
        (StateFormula.SpecMap.from_marshal ())
        empty
  end

  type analysis_data =
    { program: Program.t
    ; interproc: SpecCheckerSummary.t InterproceduralAnalysis.t
    ; patch: Patch.t
    ; skipped_nodes: Preproc.SkippedNodes.t
    ; spec_org: OrgSpecMap.t }

  let analysis_data interproc : analysis_data =
    let program = Program.from_marshal () in
    let patch = Patch.from_marshal () in
    let skipped_nodes = Preproc.SkippedNodes.from_marshal () in
    let spec_org =
      if Config.aprval_launch_validate then OrgSpecMap.create () else OrgSpecMap.empty
    in
    {program; interproc; patch; skipped_nodes; spec_org}


  let pathcond_from_prune astate instr_node bexp =
    let eval = Domain.eval ~usecase:Domain.UseCase.Branch in
    match bexp with
    | Exp.BinOp ((Binop.Eq as binop), e1, e2) | Exp.BinOp ((Binop.Ne as binop), e1, e2) ->
        let astate, v1 = eval astate instr_node e1 in
        let astate, v2 = eval astate instr_node e2 in
        let pathcond = Domain.PathCond.make_physical_equals binop v1 v2 in
        let astate =
          Domain.update_dependency astate ~lhs:v1 ~rhs:v2
          |> Domain.update_dependency ~lhs:v2 ~rhs:v1
        in
        (astate, Some pathcond)
    | Exp.UnOp (Unop.LNot, Exp.BinOp ((Binop.Eq as binop), e1, e2), _)
    | Exp.UnOp (Unop.LNot, Exp.BinOp ((Binop.Ne as binop), e1, e2), _) ->
        let astate, v1 = eval astate instr_node e1 in
        let astate, v2 = eval astate instr_node e2 in
        let pathcond =
          Domain.PathCond.make_physical_equals binop v1 v2 |> Domain.PathCond.make_negation
        in
        let astate =
          Domain.update_dependency astate ~lhs:v1 ~rhs:v2
          |> Domain.update_dependency ~lhs:v2 ~rhs:v1
        in
        (astate, Some pathcond)
    | Exp.Var _ as e ->
        let astate, v = eval astate instr_node e in
        let pathcond = Domain.PathCond.make_physical_equals Binop.Eq v Domain.Val.one in
        (astate, Some pathcond)
    | Exp.UnOp (Unop.LNot, (Exp.Var _ as e), _) ->
        let astate, v = eval astate instr_node e in
        let pathcond = Domain.PathCond.make_physical_equals Binop.Eq v Domain.Val.zero in
        (astate, Some pathcond)
    (* Inequality is not accumulated but generate path cond for gathering values *)
    | Exp.BinOp (Binop.Lt, e1, e2)
    | Exp.BinOp (Binop.Gt, e2, e1)
    | Exp.UnOp (Unop.LNot, Exp.BinOp (Binop.Ge, e1, e2), _)
    | Exp.UnOp (Unop.LNot, Exp.BinOp (Binop.Le, e2, e1), _) ->
        (* e1 < e2 = e2 > e1 = not (e1 >= e2) = not (e2 <= e1) *)
        let astate, v1 = eval astate instr_node e1 in
        let astate, v2 = eval astate instr_node e2 in
        let pathcond = Domain.PathCond.make_lt_pred v1 v2 in
        let astate =
          Domain.update_dependency astate ~lhs:v1 ~rhs:v2
          |> Domain.update_dependency ~lhs:v2 ~rhs:v1
        in
        (astate, Some pathcond)
    | Exp.BinOp (Binop.Le, e1, e2)
    | Exp.BinOp (Binop.Ge, e2, e1)
    | Exp.UnOp (Unop.LNot, Exp.BinOp (Binop.Gt, e1, e2), _)
    | Exp.UnOp (Unop.LNot, Exp.BinOp (Binop.Lt, e2, e1), _) ->
        (* e1 <= e2 = e2 >= e1 = not (e1 > e2) = not (e2 < e1) *)
        let astate, v1 = eval astate instr_node e1 in
        let astate, v2 = eval astate instr_node e2 in
        let pathcond = Domain.PathCond.make_le_pred v1 v2 in
        let astate =
          Domain.update_dependency astate ~lhs:v1 ~rhs:v2
          |> Domain.update_dependency ~lhs:v2 ~rhs:v1
        in
        (astate, Some pathcond)
    | _ ->
        let astate, v = eval astate instr_node bexp in
        let pathcond =
          if Domain.Val.is_true v then Some Domain.PathCond.true_cond
          else if Domain.Val.is_false v then Some Domain.PathCond.false_cond
          else None
        in
        (astate, pathcond)


  let exec_prune astate pathcond =
    match pathcond with
    | Some pathcond when Domain.PathCond.is_true pathcond ->
        [astate]
    | Some pathcond when Domain.PathCond.is_false pathcond ->
        []
    | Some pathcond ->
        Domain.add_pc astate pathcond
    | None ->
        [astate]


  let exec_unknown_call astate instr_node (ret_id, ret_typ) arg_typs =
    L.d_printfln "no model found. exec unknown call" ;
    (* TODO: binding unknown values to arguments *)
    (* TODO: ret_typ is not reliable *)
    let value = Domain.Val.make_extern instr_node ret_typ in
    let astate =
      List.fold_left arg_typs ~init:astate ~f:(fun astate (arg_exp, _) ->
          let astate, v = Domain.eval ~usecase:Domain.UseCase.Param astate instr_node arg_exp in
          let astate = Domain.update_derefed_heaps v astate in
          Domain.update_dependency astate ~lhs:value ~rhs:v)
    in
    [Domain.store_reg astate ret_id value]


  let exec_unknown_method astate instr_node (ret_id, ret_typ) actual_values callee =
    let results =
      match callee with
      | Procname.Java mthd ->
          (* Formal return type is more precise than actual return type (i.e., ret_typ) *)
          let ret_typ = Procname.Java.get_return_typ mthd in
          Domain.bind_extern_value astate instr_node (ret_id, ret_typ) callee actual_values
      | _ ->
          Domain.bind_extern_value astate instr_node (ret_id, ret_typ) callee actual_values
    in
    L.d_printfln
      "*** No summary found from %a, %d states are returned by analyzing it as uninterpretted \
       function... ***"
      Procname.pp callee (List.length results) ;
    results


  let exec_getter astate instr_node callee (ret_id, ret_typ) base_exp =
    (* Modeling getter method (e.g., p.getField() returns p.field) *)
    let fieldname =
      String.chop_prefix_exn (Procname.get_method callee) ~prefix:"get" |> String.uncapitalize
    in
    let base_loc, base_vals = Domain.eval_lv_sub astate instr_node base_exp in
    let astate =
      List.fold base_vals ~init:astate ~f:(fun astate v -> Domain.update_derefed_heaps v astate)
    in
    let fn_loc =
      let field_class = Typ.Name.Java.from_string (String.capitalize fieldname) in
      let field_name = Fieldname.make field_class fieldname in
      Domain.Loc.append_field base_loc ~fn:field_name
    in
    let value =
      if Domain.is_unknown_loc astate fn_loc then
        match Domain.Val.symbol_from_loc_opt ret_typ fn_loc with
        | Some symval ->
            symval
        | None ->
            Domain.Val.make_extern instr_node ret_typ
      else Domain.read_loc astate fn_loc
    in
    let astate_field_stored = Domain.store_loc astate fn_loc value in
    [Domain.store_reg astate_field_stored ret_id value]


  let exec_setter astate instr_node callee (ret_id, ret_typ) base_exp arg_values =
    (* Modeling getter method (e.g., p.getField() returns p.field) *)
    let fieldname =
      String.chop_prefix_exn (Procname.get_method callee) ~prefix:"set" |> String.uncapitalize
    in
    let base_loc, base_vals = Domain.eval_lv_sub astate instr_node base_exp in
    let astate =
      List.fold base_vals ~init:astate ~f:(fun astate v -> Domain.update_derefed_heaps v astate)
    in
    let fn_loc =
      let field_class = Typ.Name.Java.from_string (String.capitalize fieldname) in
      let field_name = Fieldname.make field_class fieldname in
      Domain.Loc.append_field base_loc ~fn:field_name
    in
    let[@warning "-8"] [base_value; set_value] = arg_values in
    let locs_point_to_base =
      Domain.Mem.fold
        (fun l v acc ->
          if Domain.Val.equal base_value v && Domain.Loc.is_var l then Domain.Loc.Set.add l acc
          else acc)
        Domain.(astate.mem)
        Domain.Loc.Set.empty
    in
    let astate_field_stored = Domain.store_loc astate fn_loc set_value in
    [astate_field_stored]


  (* [ Domain.Loc.Set.fold
      (fun l acc -> Domain.def_loc l (InstrNode.pnode_of instr_node) acc)
      locs_point_to_base astate_field_stored ] *)

  let init_uninitialized_fields callee instr_node arg_typs actual_values astate =
    match callee with
    | Procname.Java mthd -> (
        let cls = Procname.Java.get_class_type_name mthd in
        match Tenv.load_global () with
        | Some tenv -> (
          match Tenv.lookup tenv cls with
          | Some Struct.{fields} ->
              (* modeling: update data-dependency between base class with inital values *)
              let astate =
                match actual_values with
                | hd :: tl ->
                    List.fold tl ~init:astate ~f:(fun acc v ->
                        Domain.update_dependency acc ~lhs:hd ~rhs:v)
                | _ ->
                    astate
              in
              List.fold fields ~init:astate ~f:(fun acc (fn, fn_typ, _) ->
                  let base_exp = List.hd_exn arg_typs |> fst in
                  let base_loc = Domain.eval_lv astate instr_node base_exp in
                  let field_loc = Domain.Loc.append_field ~fn base_loc in
                  if Domain.is_unknown_loc acc field_loc then
                    Domain.store_loc acc field_loc (Domain.Val.get_default_by_typ instr_node fn_typ)
                  else acc)
          | None ->
              astate )
        | None ->
            astate )
    | _ ->
        astate


  let instantiate_summary astate proc_desc instr_node ret arg_typs actual_values callee_pdesc
      callee_summaries =
    let resolved_callees =
      Summary.resolve_callee_state astate ~actual_values ~callee_pdesc callee_summaries
    in
    List.concat_map resolved_callees ~f:(fun callee_state ->
        let astate =
          Summary.update_caller_by_callee ~caller_state:astate ~callee_state ~caller_pdesc:proc_desc
            ~callee_pdesc ret
        in
        match astate with
        | Some astate ->
            if Procname.is_constructor (Procdesc.get_proc_name callee_pdesc) then
              [ init_uninitialized_fields
                  (Procdesc.get_proc_name callee_pdesc)
                  instr_node arg_typs actual_values astate ]
            else [astate]
        | None ->
            [])


  let exec_interproc_call astate
      {interproc= InterproceduralAnalysis.{analyze_dependency; proc_desc}; program} instr_node
      (ret_id, ret_typ) arg_typs actual_values callee =
    (* Instantiate the callee summaries *)
    match Program.unique_callee_of_instr_node_opt program instr_node with
    | Some callee -> (
      match analyze_dependency callee with
      | Some (callee_pdesc, callee_summaries) ->
          instantiate_summary astate proc_desc instr_node (ret_id, ret_typ) arg_typs actual_values
            callee_pdesc callee_summaries
      | None ->
          exec_unknown_method astate instr_node (ret_id, ret_typ) actual_values callee )
    | None ->
        exec_unknown_method astate instr_node (ret_id, ret_typ) actual_values callee


  let check_is_die astate analysis_data instr_node =
    (* Only checking non-npe crash *)
    let is_die_instr instr_node = (not (DynInfo.is_npe instr_node)) && DynInfo.is_die instr_node in
    if Config.aprval_launch_spec_inference && Domain.is_target astate then
      (* When analyzing orignal program checking only the dyninfo *)
      is_die_instr instr_node
    else if Config.aprval_launch_validate then
      (* when analyzing patch checking the following conditions:
         1. there exists instruction in patch line matched with original crash instruction
         2. if newly generated alarm occurs in patch only it may be problematic
      *)
      let current_proc = Domain.current_proc astate in
      try
        let errs_org =
          OrgSpecMap.find current_proc analysis_data.spec_org |> Spec.get_error_infos
        in
        RuntimeCrash.exists
          (fun {node; kind} ->
            RuntimeCrash.is_crash_call_kind kind
            && RuntimeCrash.V.is_comparable_node node instr_node)
          errs_org
        || is_die_instr instr_node
      with _ -> false
    else false


  let compute_used_heaps_in_callees astate actual_values callee_pdesc callee_summaries =
    let resolved_callees =
      Summary.resolve_callee_state astate ~actual_values ~callee_pdesc callee_summaries
    in
    let open Domain in
    List.fold_left resolved_callees ~init:Val.Set.empty ~f:(fun acc astate ->
        AccessAnalysis.AccessedLoc.DUMap.fold
          (fun (loc, _) state acc ->
            if AccessAnalysis.AccessState.is_accessed state then
              match loc with
              | Loc.SymHeap sh | Loc.Field (Loc.SymHeap sh, _) | Loc.Index (Loc.SymHeap sh, _) ->
                  Val.Set.add (Val.Vheap sh) acc
              | _ ->
                  acc
            else acc)
          astate.accessed.analysis acc)


  let check_is_npe astate {spec_org} instr_node =
    (* Checking the call with base obj has npe alarm *)
    let instr = InstrNode.get_instr instr_node in
    let succ_instrs = InstrNode.get_all_preds instr_node |> List.map ~f:InstrNode.get_instr in
    let is_base_load instr instr' =
      match (instr, instr') with
      | Sil.Call (_, _, (base_exp, _) :: _, _, _), Sil.Load {id; e} when Ident.is_none id ->
          L.d_printfln "Base : %a, Load: %a@." Exp.pp base_exp Exp.pp e ;
          Exp.equal base_exp e
      | _ ->
          false
    in
    List.exists succ_instrs ~f:(fun instr' -> is_base_load instr instr')
    && DynInfo.is_npe instr_node && Domain.is_target astate


  let exec_call astate
      ( {interproc= InterproceduralAnalysis.{analyze_dependency; proc_desc}; program} as
      analysis_data ) node instr (ret_id, ret_typ) callee arg_typs =
    let instr_node = Node.of_pnode node instr in
    (* evaluate paramters *)
    let astate, actual_values =
      List.fold_left arg_typs ~init:(astate, []) ~f:(fun (astate, vs) (arg_exp, _) ->
          let astate, v = Domain.eval ~usecase:Domain.UseCase.Param astate instr_node arg_exp in
          (astate, vs @ [v]))
    in
    (* compute interproc call *)
    let states_after_call =
      match instr with
      | Sil.Call (_, Const (Cfun proc), [(base_exp, base_typ)], _, _)
        when Typ.is_pointer base_typ && String.is_prefix (Procname.get_method proc) ~prefix:"get" ->
          (* model for getter without arguments *)
          exec_getter astate instr_node proc (ret_id, ret_typ) base_exp
      | Sil.Call (_, Const (Cfun proc), [(base_exp, base_typ); _], _, _)
        when Typ.is_void ret_typ && Typ.is_pointer base_typ
             && String.is_prefix (Procname.get_method proc) ~prefix:"set" ->
          (* model for setter with only one argument *)
          exec_setter astate instr_node proc (ret_id, ret_typ) base_exp actual_values
      | Sil.Call (_, _, arg_typs, _, {cf_virtual}) ->
          (* if the call is a virtual call, compute the callee by using class info of base obj *)
          let callee =
            if cf_virtual then Domain.Val.resolve_callee_by_base callee (List.hd_exn actual_values)
            else callee
          in
          L.d_printfln "[DEBUG] Calle%a@." Procname.pp callee ;
          if SpecCheckerModels.is_model callee instr then
            SpecCheckerModels.exec_model astate proc_desc instr_node callee (ret_id, ret_typ)
              arg_typs
          else
            exec_interproc_call astate analysis_data instr_node (ret_id, ret_typ) arg_typs
              actual_values callee
      | _ ->
          L.(die InternalError)
            "%a is not an interproc call instruction"
            (Sil.pp_instr ~print_types:true Pp.text)
            instr
    in
    (* update data dependency from arguments to return value *)
    let normal_states =
      List.map
        ~f:(fun astate ->
          let return_value = Domain.read_id astate ret_id in
          List.fold_left actual_values ~init:astate ~f:(fun acc v ->
              Domain.update_dependency acc ~lhs:return_value ~rhs:v))
        states_after_call
    in
    (* update runtime crash info if the call is determined as crash call *)
    if check_is_die astate analysis_data instr_node then (
      L.d_printfln "[DEBUG] crash occurs while invoking %a@." Procname.pp callee ;
      let heaps_used_in_callee =
        match Program.unique_callee_of_instr_node_opt program instr_node with
        | Some callee -> (
          match analyze_dependency callee with
          | Some (callee_pdesc, callee_summaries) ->
              compute_used_heaps_in_callees astate actual_values callee_pdesc callee_summaries
          | None ->
              Domain.Val.Set.empty )
        | None ->
            Domain.Val.Set.empty
      in
      let error_states =
        List.map normal_states ~f:(fun astate ->
            let err_info =
              Domain.gen_error_info_by_call astate instr_node actual_values heaps_used_in_callee
                callee
            in
            Domain.set_runtime_crash astate proc_desc err_info)
      in
      error_states @ normal_states )
    else if check_is_npe astate analysis_data instr_node then (
      L.d_printfln "[DEBUG] NPE occurs while invoking %a@." Procname.pp callee ;
      let base_val = List.hd_exn actual_values in
      if Domain.is_non_null astate base_val then normal_states
      else
        let npe_info = Domain.gen_error_info_by_null astate instr_node base_val in
        let null_cands =
          Domain.PC.ConstMap.fold
            (fun src c acc -> if Domain.Val.equal_up_to_source base_val c then src :: acc else acc)
            astate.pc.const_map
            (Domain.equal_values astate base_val)
        in
        let err_state =
          Domain.set_runtime_crash
            (Domain.set_uncaught_npes astate proc_desc null_cands)
            proc_desc npe_info
        in
        err_state :: normal_states )
    else (
      L.d_printfln "[DEBUG] %a is executed without error@." Procname.pp callee ;
      normal_states )


  let check_null astate {interproc= InterproceduralAnalysis.{proc_desc}; spec_org} instr_node e =
    match e with
    | Exp.Lvar _ | Exp.Lindex _ ->
        (* TODO: deal with null.f, null[x] cases
         * Currently, we assume _.f and _[] location is non-null *)
        [astate]
    | Exp.Lfield (Exp.Lvar _, _, _) | Exp.Lfield (Exp.Const _, _, _) ->
        (* Global.field, "".value: not null *)
        [astate]
    | Exp.Lfield (e', _, _) | e' ->
        let astate, v = Domain.eval astate instr_node e' in
        let null_cands =
          Domain.PC.ConstMap.fold
            (fun src c acc -> if Domain.Val.equal_up_to_source v c then src :: acc else acc)
            astate.pc.const_map (Domain.equal_values astate v)
        in
        (* if Null-dereference occurs, set current state to exceptional state and store uncaught loc *)
        if Domain.is_non_null astate v then [astate]
        else if Domain.is_null astate v then
          let npe_info = Domain.gen_error_info_by_null astate instr_node v in
          [ Domain.set_runtime_crash
              (Domain.set_uncaught_npes astate proc_desc null_cands)
              proc_desc npe_info ]
        else if Config.aprval_launch_validate then
          (* when analyzing patch program using npe alarm of original analysis *)
          let current_proc = Domain.current_proc astate in
          try
            let result_org = OrgSpecMap.find current_proc spec_org in
            let errs_org = Spec.get_error_infos result_org in
            let npe_org = Spec.get_uncaught_npes result_org in
            L.d_printfln "APSET ORG: %a @." AccessExpr.AbsSet.pp npe_org ;
            match Domain.Mem.ap_of_val astate.mem v with
            | Some ap when AccessExpr.AbsSet.mem ap npe_org ->
                (* if the existing alarm affected by patch => *)
                let patched_values = Domain.get_patch_values astate in
                let is_unpatched_npe =
                  RuntimeCrash.exists
                    (fun {node; kind} ->
                      RuntimeCrash.is_npe_kind kind
                      && RuntimeCrash.V.check_line_match node instr_node)
                    errs_org
                  && not (Domain.Val.Set.mem v patched_values)
                in
                if is_unpatched_npe then (
                  L.d_printfln "NPE by (%a) is unpatched@." Domain.Val.pp v ;
                  [ Domain.set_potential_npes astate null_cands
                  ; Domain.set_uncaught_npes astate proc_desc null_cands ] )
                else [astate]
            | _ ->
                L.d_printfln "AP of (%a) Not found@." Domain.Val.pp v ;
                [Domain.set_potential_npes astate null_cands]
          with _ -> [Domain.set_potential_npes astate null_cands]
        else
          (* if any null constraints are not accumulated, set it as may npe *)
          [Domain.set_potential_npes astate null_cands]


  let exec_load astate analysis_data node instr id e typ =
    let instr_node = InstrNode.of_pnode node instr in
    let astates = check_null astate analysis_data instr_node e in
    List.map
      ~f:(fun astate ->
        let loc, sub_vals = Domain.eval_lv_sub astate instr_node e in
        let value =
          (* if the result heap is exception class => make the it as given exception class heap *)
          match Procdesc.Node.get_kind node with
          | Procdesc.Node.Stmt_node Throw ->
              Domain.Val.make_string (Typ.to_string typ)
          | _ ->
              Domain.read_loc ~typ:(Some typ) astate loc
        in
        let astate =
          List.fold sub_vals ~init:astate ~f:(fun astate v ->
              Domain.update_dependency astate ~lhs:value ~rhs:v |> Domain.update_derefed_heaps v)
          |> Domain.use_val instr_node value
        in
        Domain.store_reg astate id value |> Domain.access_loc node instr loc)
      astates


  let exec_store astate (location : Location.t) node instr e1 e2 =
    let instr_node = InstrNode.of_pnode node instr in
    let loc, sub_vals = Domain.eval_lv_sub astate instr_node e1 in
    let astate =
      List.fold sub_vals ~init:astate ~f:(fun astate v -> Domain.update_derefed_heaps v astate)
    in
    let astate, value = Domain.eval ~usecase:Domain.UseCase.RValue astate instr_node e2 in
    let astate = Domain.store_loc astate loc value in
    [Domain.def_loc loc node astate]


  let is_patched_node {patch} node =
    let procname = Procdesc.Node.get_proc_name node in
    let modified = Patch.PatchInfo.get_modified_nodes procname patch.patch_info in
    let affected = Patch.PatchInfo.get_affected_nodes procname patch.patch_info in
    let patched_nodes =
      if Patch.NodeSet.is_empty modified then Patch.NodeSet.union modified affected else modified
    in
    Patch.NodeSet.mem node patched_nodes


  let compute_posts astate
      ({interproc= InterproceduralAnalysis.{proc_desc}; spec_org; patch} as analysis_data) node
      instr =
    let instr_node = Node.of_pnode node instr in
    match instr with
    | Sil.Load {id; e} when Ident.is_none id ->
        (* Ignore empty dereference and null-check on virtual invocation *)
        check_null astate analysis_data instr_node e
    | Sil.Load {id; e= Lindex (e1, e2) as e; typ} ->
        let normal_states = exec_load astate analysis_data node instr id e typ in
        if check_is_die astate analysis_data instr_node then
          (* handling OOB using dyninfo *)
          let error_states =
            List.map normal_states ~f:(fun astate ->
                let base_val, index_val =
                  (Domain.eval_value astate instr_node e1, Domain.eval_value astate instr_node e2)
                in
                let error_info =
                  Domain.gen_error_info_by_access astate instr_node base_val index_val
                in
                Domain.set_runtime_crash astate proc_desc error_info)
          in
          normal_states @ error_states
        else normal_states
    | Sil.Load {id; e; typ} ->
        exec_load astate analysis_data node instr id e typ
    | Sil.Store {e1; e2= Exp.Exn _ as e2; loc} ->
        exec_store astate loc node instr e1 e2 |> List.map ~f:Domain.set_exception
    | Sil.Store {e1= Lindex (e_base, e_idx) as e1; e2; loc} ->
        let normal_states = exec_store astate loc node instr e1 e2 in
        if check_is_die astate analysis_data instr_node then
          (* handling OOB using dyninfo *)
          let error_states =
            List.map normal_states ~f:(fun astate ->
                let base_val, index_val =
                  ( Domain.eval_value astate instr_node e_base
                  , Domain.eval_value astate instr_node e_idx )
                in
                let error_info =
                  Domain.gen_error_info_by_access astate instr_node base_val index_val
                in
                Domain.set_runtime_crash astate proc_desc error_info)
          in
          normal_states @ error_states
        else normal_states
    | Sil.Store {e1; e2; loc} ->
        exec_store astate loc node instr e1 e2
    | Sil.Call ((ret_id, _), Const (Cfun proc), arg_typs, _, _) when is_new proc ->
        let value = Domain.Val.make_allocsite instr_node in
        let astate =
          List.fold_left arg_typs ~init:astate ~f:(fun astate (arg_exp, _) ->
              let arg_exp = match arg_exp with Exp.Sizeof {dynamic_length= Some e} | e -> e in
              let astate, v = Domain.eval ~usecase:Domain.UseCase.Param astate instr_node arg_exp in
              let astate = Domain.update_derefed_heaps v astate in
              Domain.update_dependency astate ~lhs:value ~rhs:v)
        in
        Domain.add_pc
          (Domain.store_reg astate ret_id value)
          (Domain.PathCond.make_physical_equals Binop.Ne (Domain.Val.make_null ()) value)
    | Sil.Call (ret, Const (Cfun proc), arg_typs, _, _) ->
        (* interporc call *)
        exec_call astate analysis_data node instr ret proc arg_typs
    | Sil.Call (ret_typ, _, arg_typs, _, _) ->
        (* callback call *)
        exec_unknown_call astate instr_node ret_typ arg_typs
    | Sil.Prune (bexp, _, _, _) ->
        let astate, pathcond = pathcond_from_prune astate instr_node bexp in
        if Domain.is_patched astate && Patch.PatchInfo.is_modified_node node patch.patch_info then
          (* TODO: Optimization & Refactoring required *)
          let program_org =
            Utils.with_file_in
              (Filename.concat Config.aprval_org_dir "program.data")
              ~f:Marshal.from_channel
          in
          let pdesc_org = Program.pdesc_of_opt program_org astate.current_proc in
          match pdesc_org with
          | Some pdesc_org ->
              let prunes_org =
                Procdesc.get_nodes pdesc_org
                |> List.filter ~f:(fun pnode ->
                       match Procdesc.Node.get_kind pnode with
                       | Procdesc.Node.Prune_node _ ->
                           let file = (Procdesc.Node.get_loc pnode).file in
                           let line = (Procdesc.Node.get_loc pnode).line in
                           Int.equal (InstrNode.get_line instr_node)
                             (Patch.LineMapping.compute_patch_line file line patch.line_mapping)
                       | _ ->
                           false)
              in
              let c1 = ASTExp.Converter.init_by_pdesc pdesc_org in
              let aps_org =
                List.concat_map prunes_org ~f:Procdesc.Node.get_instr_list
                |> List.concat_map ~f:Sil.exps_of_instr
                |> List.filter_map ~f:(ASTExp.from_IR_exp_opt c1 astate.current_proc)
                |> List.concat_map ~f:ASTExp.get_leafs
                |> ASTExp.Set.of_list
              in
              let c2 = ASTExp.Converter.init_by_pdesc proc_desc in
              let aps_cur =
                List.filter_map [bexp] ~f:(ASTExp.from_IR_exp_opt c2 astate.current_proc)
                |> List.concat_map ~f:ASTExp.get_leafs
                |> ASTExp.Set.of_list
              in
              L.d_printfln "APS Org Prune Nodes : (%a)@." ASTExp.Set.pp aps_org ;
              L.d_printfln "APS Patch Prune Nodes : (%a)@." ASTExp.Set.pp aps_cur ;
              let astates = exec_prune astate pathcond in
              if
                Config.aprval_launch_validate
                && (not (ASTExp.Set.equal aps_org aps_cur))
                && not (ASTExp.Set.exists (fun ap -> ASTExp.equal ASTExp.null ap) aps_cur)
              then
                (* TODO: formally defined the invalid form of generated path condition
                   currently, checking it is null-handling related path or similar as original
                *)
                List.map astates ~f:(fun astate ->
                    let t, f = DynInfo.get_br_info instr_node in
                    let t, f = (Int.to_float t, Int.to_float f) in
                    L.d_printfln "T, F : (%f, %f)@." t f ;
                    let score =
                      match bexp with UnOp (Unop.LNot, _, _) -> f /. (t +. f) | _ -> t /. (t +. f)
                    in
                    Domain.update_patch_score astate score)
              else astates
          | _ ->
              exec_prune astate pathcond
        else exec_prune astate pathcond
    | Sil.Metadata (ExitScope (vars, _)) ->
        let vars_to_remove =
          List.filter vars ~f:(function
            | Var.LogicalVar _ ->
                true
            | Var.ProgramVar pv ->
                if is_bcvar pv then
                  let preds = Procdesc.Node.get_preds node in
                  (* removing temp storing exn obj *)
                  List.exists preds ~f:(fun node ->
                      match Procdesc.Node.get_kind node with
                      | Prune_node (_, _, PruneNodeKind_ExceptionHandler) ->
                          true
                      | kind ->
                          Procdesc.Node.equal_nodekind Procdesc.Node.exn_handler_kind kind)
                else Domain.Loc.of_pvar pv |> Domain.Loc.is_temp)
        in
        [Domain.remove_temps astate proc_desc vars_to_remove]
    | Sil.Metadata (Nullify (pv, _)) ->
        [Domain.nullify_pvar astate ~pv]
    | Sil.Metadata (Abstract _) | Sil.Metadata Skip | Sil.Metadata (VariableLifetimeBegins _) ->
        [astate]
    | _ ->
        raise
          (NotImplemented
             (F.asprintf "the exec of %a is undefined"
                (Sil.pp_instr ~print_types:true Pp.text)
                instr))


  let filter_invalid_states astate =
    (* State with unexpected flow (e.g., unhandled exception) *)
    function
    | (Sil.Load {e= Var id} | Sil.Store {e2= Var id}) when Domain.is_unknown_id astate id ->
        []
    | Sil.Call (_, _, arg_typs, _, _) ->
        let contains_unknown_id (arg_exp, _) =
          match arg_exp with Exp.Var id -> Domain.is_unknown_id astate id | _ -> false
        in
        if List.exists arg_typs ~f:contains_unknown_id then [] else [astate]
    | _ ->
        [astate]


  let exec_instr astate ({skipped_nodes} as analysis_data) cfg_node instr =
    let node = CFG.Node.underlying_node cfg_node in
    let astate = if is_patched_node analysis_data node then Domain.set_patched astate else astate in
    let is_exn_handler =
      Procdesc.Node.equal_nodekind Procdesc.Node.exn_handler_kind (Procdesc.Node.get_kind node)
    in
    let compute_posts astate =
      let pre_state = astate in
      let pre_states = filter_invalid_states pre_state instr in
      List.concat_map pre_states ~f:(fun astate -> compute_posts astate analysis_data node instr)
    in
    let results =
      if
        (Domain.is_exceptional astate && not is_exn_handler)
        || Preproc.SkippedNodes.mem node skipped_nodes
      then
        match instr with
        | Sil.Metadata _ ->
            (* in the case of meta instr (e.g., nullify), exec instr in exceptional case for optimization *)
            compute_posts astate
        | _ ->
            (* If a state is exceptional, stop executing instruction until it meet catch statement
               or if the node is skip node do not execute
            *)
            [astate]
      else compute_posts astate
    in
    results


  let exec_instr astate analysis_data node instr =
    debug_time "exec_instr" ~f:(exec_instr astate analysis_data node) ~arg:instr


  let pp_session_name node fmt =
    F.fprintf fmt "===== Spec Checker (%a) ====@." Procdesc.Node.pp (CFG.Node.underlying_node node)
end

module DisjunctiveConfig : TransferFunctions.DisjunctiveConfig = struct
  let join_policy = `UnderApproximateAfter 20

  let widen_policy = `UnderApproximateAfterNumIterations 2
end

module Analyzer = Fl4aprSymExecutor.Make (DisjReady) (DisjunctiveConfig)

let summary_serializer : Summary.t Serialization.serializer =
  Serialization.create_serializer Serialization.Key.summary


let compute_invariant_map : DisjReady.analysis_data -> Analyzer.invariant_map =
 fun ({interproc= {proc_desc}; patch} as analysis_data) ->
  let initial = [SpecCheckerDomain.init proc_desc patch.patch_info] in
  Analyzer.exec_pdesc ~do_narrowing:false ~initial analysis_data proc_desc


let cached_compute_invariant_map =
  let cache_get, cache_set = Procname.UnitCache.create () in
  fun (DisjReady.{interproc= {proc_desc}} as analysis_data) ->
    let pname = Procdesc.get_proc_name proc_desc in
    match cache_get pname with
    | Some inv_map ->
        inv_map
    | None ->
        let inv_map = compute_invariant_map analysis_data in
        cache_set pname inv_map ;
        inv_map


let compute_summary : Procdesc.t -> CFG.t -> Analyzer.invariant_map -> SpecCheckerSummary.t =
 fun proc_desc cfg inv_map ->
  let exit_node_id = CFG.exit_node cfg |> CFG.Node.id in
  match Analyzer.extract_post exit_node_id inv_map with
  | Some exit_state ->
      Summary.to_summary proc_desc exit_state
  | None ->
      Summary.empty


let checker ({InterproceduralAnalysis.proc_desc} as interproc) =
  let analysis_data = DisjReady.analysis_data interproc in
  let formals = Procdesc.get_pvar_formals proc_desc |> List.map ~f:fst in
  let procname = Procdesc.get_proc_name proc_desc in
  if List.exists formals ~f:Pvar.is_frontend_tmp then (
    (* In this case, IR might be incomplete *)
    L.(debug Analysis Quiet) "%a has incompletely translated IR" Procname.pp procname ;
    None )
  else if Procname.is_java_class_initializer procname then
    (* HEURISTICS: ignore class initializer which may be called at main procedure. *)
    None
  else if Program.is_sliced_method analysis_data.program procname then None
  else if
    Config.aprval_launch_validate
    && Sys.is_file_exn
         (Filename.concat Config.aprval_result_dir (Procname.to_filename procname ^ ".specs"))
  then
    (* Increamental analysis : if the current method does not calls target proc, skip analysis *)
    None
  else
    let inv_map = cached_compute_invariant_map analysis_data in
    let cfg = CFG.from_pdesc proc_desc in
    let summary = compute_summary proc_desc cfg inv_map in
    Some summary
