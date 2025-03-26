open! IStd
open! Vocab
module L = Logging
module TempVars = Pvar.Set
open Patch

module SkippedNodes = struct
  include PrettyPrintable.MakePPSet (Node)

  let get_nullified_temps node =
    let instrs = Node.get_instr_list node in
    L.progress "Instrs : %a@." (Pp.seq (Sil.pp_instr ~print_types:true Pp.text)) instrs ;
    List.fold instrs ~init:TempVars.empty ~f:(fun acc instr ->
        match instr with Sil.Metadata (Nullify (pv, _)) -> TempVars.add pv acc | _ -> acc)


  let rec get_used_temps_exp exp acc =
    match exp with
    | Exp.Lvar pv when Pvar.is_frontend_tmp pv ->
        TempVars.add pv acc
    | Exp.UnOp (_, e, _) | Exp.Exn e | Exp.Cast (_, e) | Exp.Lfield (e, _, _) ->
        get_used_temps_exp e acc
    | Exp.BinOp (_, e1, e2) | Exp.Lindex (e1, e2) ->
        get_used_temps_exp e1 acc |> get_used_temps_exp e2
    | Exp.Closure {captured_vars} ->
        List.fold captured_vars ~init:acc ~f:(fun acc (e, pv, _, _) ->
            if Pvar.is_frontend_tmp pv then get_used_temps_exp e acc |> TempVars.add pv
            else get_used_temps_exp e acc)
    | _ ->
        acc


  let get_used_temps_instr acc instr =
    match instr with
    | Sil.Load {e} | Sil.Prune (e, _, _, _) ->
        get_used_temps_exp e acc
    | Sil.Store {e1; e2} ->
        get_used_temps_exp e1 acc |> get_used_temps_exp e2
    | Sil.Call (_, e_fun, args, _, _) ->
        List.fold args ~init:(get_used_temps_exp e_fun acc) ~f:(fun acc (e, _) ->
            get_used_temps_exp e acc)
    | _ ->
        acc


  let get_used_temps node =
    let instrs = Node.get_instr_list node in
    List.fold instrs ~init:TempVars.empty ~f:get_used_temps_instr


  let rec get_preds_with_skipped t node =
    let preds_direct = Node.get_preds node in
    List.concat_map preds_direct ~f:(fun pred ->
        if mem pred t then get_preds_with_skipped t pred else [pred])


  let rec get_succs_with_skipped t node =
    let succs_direct = Node.get_succs node in
    List.concat_map succs_direct ~f:(fun succ ->
        if mem succ t then get_succs_with_skipped t succ else [succ])


  let is_negate_node node1 node2 =
    let get_prune_instr instrs =
      List.find instrs ~f:(fun instr -> match instr with Sil.Prune _ -> true | _ -> false)
    in
    let instrs1, instrs2 = (Node.get_instr_list node1, Node.get_instr_list node2) in
    match (get_prune_instr instrs1, get_prune_instr instrs2) with
    | Some (Sil.Prune (bexp1, _, _, _)), Some (Sil.Prune (UnOp (Unop.LNot, bexp2, _), _, _, _))
    | Some (Sil.Prune (UnOp (Unop.LNot, bexp1, _), _, _, _)), Some (Sil.Prune (bexp2, _, _, _)) ->
        Exp.equal bexp1 bexp2
    | _ ->
        false


  let get_skipped_nodes t node =
    match Node.get_kind node with
    | Node.Prune_node _ -> (
        (* checking one of its siblings is prune node whose bexp is negation of cuurent node *)
        let siblings =
          get_succs_with_skipped t node |> List.concat_map ~f:(fun succ -> Node.get_preds succ)
        in
        match List.find siblings ~f:(is_negate_node node) with
        | Some node' ->
            [node; node']
        | _ ->
            [] )
    | Node.Stmt_node _ ->
        (* chekcing its all direct successors (except join node) are skipped nodes and uses same the temps with current node *)
        let succs = Node.get_succs node in
        if
          List.for_all succs ~f:(fun succ ->
              if mem succ t then
                match Node.get_kind succ with
                | Node.Join_node | Node.Skip_node _ ->
                    true
                | _ ->
                    let temps_cur = get_used_temps node in
                    let temps_succ = get_used_temps succ in
                    TempVars.exists (fun temp -> TempVars.mem temp temps_cur) temps_succ
              else false)
        then [node]
        else []
    | Node.Join_node | Node.Skip_node _ ->
        (* othercases : just conduct tunneling *)
        let succs = Node.get_succs node in
        if List.for_all succs ~f:(fun succ -> mem succ t) then [node] else []
    | _ ->
        []


  let rec update_skipped_nodes exit_node t =
    let visited = ref NodeSet.empty in
    let rec work worklist acc =
      match worklist with
      | [] ->
          acc
      | cur :: rest when NodeSet.mem cur !visited ->
          work rest acc
      | cur :: rest ->
          visited := NodeSet.add cur !visited ;
          let preds = Node.get_preds cur in
          let skipped_nodes = get_skipped_nodes acc cur in
          let new_table = List.fold skipped_nodes ~init:acc ~f:(fun acc node -> add node acc) in
          work (rest @ preds) new_table
    in
    let t' = work [exit_node] t in
    if equal t t' then t'
    else (
      visited := NodeSet.empty ;
      update_skipped_nodes exit_node t' )


  let cache : t option ref = ref None

  let marshalled_path = Filename.concat Config.results_dir "skipped_nodes.data"

  let to_marshal path t = Utils.with_file_out path ~f:(fun oc -> Marshal.to_channel oc t [])

  let from_marshal () : t =
    match !cache with
    | Some nodes ->
        nodes
    | None ->
        let nodes = Utils.with_file_in marshalled_path ~f:Marshal.from_channel in
        nodes


  let create program target_procs =
    let t =
      Procname.Set.fold
        (fun pname acc ->
          let pdesc = Program.pdesc_of program pname in
          let exit_node = Procdesc.get_exit_node pdesc in
          update_skipped_nodes exit_node acc)
        target_procs empty
    in
    to_marshal marshalled_path t ;
    t
end
