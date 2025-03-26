open! IStd
open! Vocab
open AccessAnalysis
open ValueAnalysis
open SymDom
module F = Format
module L = Logging
module Loc = SymDom.Loc
module Val = SymDom.Val
module PathCond = SymDom.PathCond
module PC = SymDom.PC
module Reg = SymDom.Reg
module Mem = SymDom.Mem
module UseCase = ValueAnalysis.UseCase
module Heaps = PrettyPrintable.MakePPSet (SymDom.SymHeap)

module PatchInfo = struct
  include AbstractDomain.Map (Procdesc.Node) (Val.Set)

  let weak_update pnode v t =
    let vset = find pnode t in
    let new_vset =
      (* List.fold (Val.get_subvalues v) ~init:vset ~f:(fun acc v -> Val.Set.remove v acc) *)
      vset |> Val.Set.add v
    in
    add pnode new_vset t
end

type t =
  { reg: Reg.t
  ; mem: Mem.t
  ; pc: PC.t
  ; patch_info: PatchInfo.t
  ; is_target: bool
  ; is_patched: bool
  ; patch_score: float
  ; accessed: AccessedLoc.t
  ; derefed_heaps: Val.Set.t
  ; is_exceptional: bool
  ; uncaught_npes: Val.Set.t
  ; potential_npes: Val.Set.t
  ; nullified: Val.Set.t [@compare: Val.compare_up_to_source] [@equal: Val.equal_up_to_source]
  ; used_val_local: ValUse.t
  ; current_proc: Procname.t
  ; runtime_crash: RuntimeCrash.t
  ; value_dependency: ValDep.t }

let pp_simple fmt
    { reg
    ; mem
    ; pc
    ; patch_info
    ; value_dependency
    ; is_target
    ; is_exceptional
    ; is_patched
    ; patch_score
    ; uncaught_npes
    ; runtime_crash } =
  F.fprintf fmt
    "@[<v 2>  - Register:@,\
    \   %a@,\
    \ - Memory:@,\
    \   %a@,\
    \ - Branch Conditions:@,\
    \   %a@,\
    \ - Patch Info:@,\
    \   %a@,\
    \ - Uncaught NPES:@,\
    \   %a@,\
    \ - Is Target Method? Is Patched State (Score)? Is Exceptional? @,\
    \   %b, %b (%f), %b@,\
    \ - Runtime Crash Info:@,\
    \   %a@]" Reg.pp reg Mem.pp mem PC.pp pc PatchInfo.pp patch_info Val.Set.pp uncaught_npes
    is_target is_patched patch_score is_exceptional RuntimeCrash.pp runtime_crash


let pp_full fmt
    { reg
    ; mem
    ; pc
    ; patch_info
    ; is_target
    ; accessed
    ; derefed_heaps
    ; is_exceptional
    ; is_patched
    ; patch_score
    ; uncaught_npes
    ; potential_npes
    ; nullified
    ; runtime_crash
    ; value_dependency
    ; used_val_local } =
  F.fprintf fmt
    "@[<v 2>  - Register:@,\
    \   %a@,\
    \ - Memory:@,\
    \   %a@,\
    \ - Branch Conditions:@,\
    \   %a@,\
    \ - Patch Info:@,\
    \   %a@,\
    \ - Accessed Locations:@,\
    \   %a@,\
    \ - Derefed Heaps:@,\
    \   %a@,\
    \ - Uncaught NPES:@,\
    \   %a@,\
    \ - Potential NPES:@,\
    \   %a@,\
    \ - Nullified Values:@,\
    \   %a@,\
    \ - Is Target Method? Is Patched State (Score)? Is Exceptional? @,\
    \   %b, %b (%f), %b@,\
    \ - Runtime Crash Info:@,\
    \   %a@,\
    \ - Value Dependency:@,\
    \   %a@,\n\
    \ - Val Used:@,\
    \   %a@]" Reg.pp reg Mem.pp mem PC.pp pc PatchInfo.pp patch_info AccessedLoc.pp accessed
    Val.Set.pp derefed_heaps Val.Set.pp uncaught_npes Val.Set.pp potential_npes Val.Set.pp nullified
    is_target is_patched patch_score is_exceptional RuntimeCrash.pp runtime_crash ValDep.pp
    value_dependency ValUse.pp used_val_local


let pp = pp_simple

let cardinal x =
  (* To minimize randomness in fixed-point iteration *)
  let is_exceptional = if x.is_exceptional then 1 else 0 in
  let reg = Reg.cardinal x.reg in
  let mem = Mem.cardinal x.mem in
  let pc = PC.cardinal x.pc in
  let accessed = AccessedLoc.DUMap.cardinal x.accessed.analysis in
  is_exceptional + reg + mem + pc + accessed


let leq ~lhs ~rhs =
  (* Optimization in disjunctive analysis: prune redundant states *)
  phys_equal lhs rhs


let bottom =
  { reg= Reg.bottom
  ; mem= Mem.bottom
  ; pc= PC.empty
  ; patch_info= PatchInfo.empty
  ; is_target= false
  ; is_patched= false
  ; patch_score= 1.
  ; accessed= AccessedLoc.bottom
  ; derefed_heaps= Val.Set.empty
  ; is_exceptional= false
  ; uncaught_npes= Val.Set.empty
  ; potential_npes= Val.Set.empty
  ; nullified= Val.Set.empty
  ; used_val_local= ValUse.empty
  ; current_proc= Procname.empty_block
  ; runtime_crash= RuntimeCrash.empty
  ; value_dependency= ValDep.empty }


let is_bottom {reg; mem; pc} = Reg.is_bottom reg && Mem.is_bottom mem && PC.is_bottom pc

(** Basic Queries **)
let is_unknown_loc {mem} l = Loc.is_unknown l || not (Mem.mem l mem)

let is_unknown_id {reg} id = Val.is_bottom (Reg.find id reg)

let is_target {is_target} = is_target

let is_patched {is_patched} = is_patched

let is_affected_state {is_patched; patch_score} =
  let patch_threshold = 0. in
  is_patched && Float.compare patch_score patch_threshold > 0


let is_exceptional {is_exceptional} = is_exceptional

let is_return_state astate = Mem.exists (fun l _ -> Loc.is_return l) astate.mem

let current_proc {current_proc} = current_proc

let get_patch_nodes {patch_info} =
  PatchInfo.fold (fun node _ acc -> Patch.NodeSet.add node acc) patch_info Patch.NodeSet.empty


let get_patch_values {patch_info} =
  PatchInfo.fold (fun _ vals acc -> Val.Set.union vals acc) patch_info Val.Set.empty


let get_ret_value {mem; current_proc} =
  let program = Program.from_marshal () in
  let pdesc = Program.pdesc_of program current_proc in
  let ret_loc = Procdesc.get_ret_var pdesc |> Loc.of_pvar in
  match Mem.find_opt ret_loc mem with Some v -> v | None -> Val.bottom


let is_valid_pc astate pathcond = PC.is_valid pathcond astate.pc

(** Read & Write **)
let read_loc ?(typ = None) astate l =
  match typ with
  | Some typ ->
      if is_unknown_loc astate l then
        match Val.symbol_from_loc_opt typ l with
        | Some symval ->
            symval
        | None ->
            Val.make_extern (InstrNode.dummy_of_proc astate.current_proc) typ
      else Mem.find l astate.mem
  | None ->
      if is_unknown_loc astate l then
        L.(die InternalError) "Fail to read unknown loc %a (type is not provided)" Loc.pp l
      else Mem.find l astate.mem


let read_id {reg} id = Reg.find id reg

let equal_values astate v = PC.equal_values astate.pc v

let inequal_values astate v = PC.inequal_values astate.pc v

let all_values {reg; pc; mem; uncaught_npes; potential_npes} =
  let reg_values = Reg.fold (fun _ v -> Val.Set.add v) reg Val.Set.empty in
  let pc_values = PC.all_values pc |> Val.Set.of_list in
  let mem_values =
    Mem.fold
      (fun l v ->
        match l with
        | Loc.Field (Loc.SymHeap sh, _) | Loc.Index (Loc.SymHeap sh, _) ->
            Val.Set.add v <<< Val.Set.add (Val.Vheap sh)
        | _ ->
            Val.Set.add v)
      mem Val.Set.empty
  in
  reg_values |> Val.Set.union pc_values |> Val.Set.union mem_values |> Val.Set.union uncaught_npes
  |> Val.Set.union potential_npes


let all_symbols astate =
  let rec add_if_symbol v acc_symvals =
    match v with
    | Val.Vint (SymExp.Symbol _) ->
        Val.Set.add v acc_symvals
    | Val.Vheap (SymHeap.Symbol _) ->
        Val.Set.add v acc_symvals
    | Val.Vextern (_, args) ->
        List.fold args ~init:acc_symvals ~f:(fun acc_symvals' v -> add_if_symbol v acc_symvals')
    | _ ->
        acc_symvals
  in
  let symvals_appered = Val.Set.fold add_if_symbol (all_values astate) Val.Set.empty in
  Val.Set.fold
    (fun v ->
      let s =
        match v with
        | Val.Vint (Symbol s) | Val.Vheap (Symbol s) ->
            s
        | _ ->
            L.(die InternalError) "%a is non-symbolic values" Val.pp v
      in
      List.map (Symbol.sub_symbols s) ~f:(fun s -> Val.Vheap (Symbol s))
      |> Val.Set.of_list |> Val.Set.union)
    symvals_appered symvals_appered


let store_loc astate l v : t =
  if Val.is_constant v then
    let extern_symbol = Val.make_const_extern v in
    let mem' = Mem.strong_update l extern_symbol astate.mem in
    let pc' = PC.add (PathCond.make_physical_equals Binop.Eq extern_symbol v) astate.pc in
    {astate with mem= mem'; pc= pc'}
  else {astate with mem= Mem.strong_update l v astate.mem}


let store_reg astate id v = {astate with reg= Reg.strong_update id v astate.reg}

let def_loc loc pnode astate =
  (* only store info of non-return locations *)
  if Loc.is_return loc then astate
  else
    let location = Procdesc.Node.get_loc pnode in
    let line = location.line in
    let line =
      match Procdesc.Node.get_kind pnode with
      | Procdesc.Node.Start_node ->
          (* variables defined at the start node means they are parameter of method *)
          -1
      | _ ->
          (* to make the line number the same regardless of the patch, compute its offset using patch info *)
          if Config.aprval_launch_spec_inference then
            let patch = Patch.from_marshal () in
            let source = location.file in
            Patch.LineMapping.compute_patch_line source line patch.line_mapping
          else line
    in
    let loc =
      (* if the defed loc is heap compute the variable points to this heap *)
      if Loc.is_var loc then Some loc else None
    in
    match loc with
    | Some loc ->
        {astate with accessed= AccessedLoc.def_loc loc (astate.current_proc, line) astate.accessed}
    | _ ->
        astate


let replace_value astate ~(src : Val.t) ~(dst : Val.t) =
  let replace_mem mem =
    match (src, dst) with
    | Vheap a, Vheap b ->
        Mem.fold
          (fun l v ->
            Mem.strong_update (Loc.replace_heap l ~src:a ~dst:b) (Val.replace_sub v ~src ~dst))
          mem Mem.empty
    | _ ->
        Mem.map (Val.replace_sub ~src ~dst) mem
  in
  let replace_accessed ({analysis; defmap} : AccessedLoc.t) =
    match (src, dst) with
    | Vheap a, Vheap b ->
        let analysis =
          AccessedLoc.DUMap.fold
            (fun (l, line) state acc ->
              let l' = Loc.replace_heap l ~src:a ~dst:b in
              AccessedLoc.DUMap.add (l', line) state acc)
            analysis AccessedLoc.DUMap.empty
        in
        let defmap =
          AccessedLoc.DefMap.fold
            (fun l lines acc ->
              let l' = Loc.replace_heap l ~src:a ~dst:b in
              AccessedLoc.DefMap.add l' lines acc)
            defmap AccessedLoc.DefMap.empty
        in
        AccessedLoc.{analysis; defmap}
    | _ ->
        AccessedLoc.{analysis; defmap}
  in
  let replace_set val_set = Val.Set.map (Val.replace_sub ~src ~dst) val_set in
  let reg = Reg.map (Val.replace_sub ~src ~dst) astate.reg in
  let mem = replace_mem astate.mem in
  let pc = PC.replace_value astate.pc ~src ~dst in
  let patch_info = PatchInfo.map replace_set astate.patch_info in
  let accessed = replace_accessed astate.accessed in
  let derefed_heaps = replace_set astate.derefed_heaps in
  let uncaught_npes = replace_set astate.uncaught_npes in
  let potential_npes = replace_set astate.potential_npes in
  let nullified = replace_set astate.nullified in
  let used_val_local =
    ValUse.map (fun vset -> Val.Set.map (Val.replace_sub ~src ~dst) vset) astate.used_val_local
  in
  let value_dependency =
    ValDep.fold
      (fun v vset ->
        ValDep.add (Val.replace_sub v ~src ~dst) (Val.Set.map (Val.replace_sub ~src ~dst) vset))
      astate.value_dependency ValDep.empty
  in
  { reg
  ; mem
  ; pc
  ; patch_info
  ; accessed
  ; derefed_heaps
  ; uncaught_npes
  ; potential_npes
  ; nullified
  ; used_val_local
  ; value_dependency
  ; is_target= astate.is_target
  ; is_patched= astate.is_patched
  ; patch_score= astate.patch_score
  ; is_exceptional= astate.is_exceptional
  ; runtime_crash= astate.runtime_crash
  ; current_proc= astate.current_proc }


let add_branch_only astate pathcond =
  let pathcond_to_add = PathCond.normalize pathcond in
  {astate with pc= PC.add_branch_only pathcond_to_add astate.pc}


let add_pc_simple ?(is_branch = false) astate pathcond : t =
  let pathcond_to_add = PathCond.normalize pathcond in
  if PC.is_valid pathcond_to_add astate.pc then astate
  else
    let pc' = PC.add ~is_branch pathcond_to_add astate.pc in
    {astate with pc= pc'}


let add_pc ?(is_branch = false) astate pathcond : t list =
  let replace_extern astate pc_set =
    (* HEURISTICS: replace an extern variable ex by v if there exists ex1 = ex2 or exn(ex) = exn(ex2) *)
    PC.PCSet.fold
      (fun cond astate_acc ->
        match cond with
        (*
        | PathCond.Eq (x, y)
          when Val.is_extern x && (not (Val.is_const_extern x)) && Val.is_constant y ->
            replace_value astate_acc ~src:x ~dst:(Val.make_const_extern y)
        | PathCond.Eq (x, y)
          when Val.is_extern y && (not (Val.is_const_extern y)) && Val.is_constant x ->
            replace_value astate_acc ~src:y ~dst:(Val.make_const_extern x)  
        *)
        | PathCond.Eq ((Val.Vint (SymExp.Extern _) as x), (Val.Vint (SymExp.Extern _) as y)) ->
            if Val.is_const_extern x then replace_value astate_acc ~src:y ~dst:x
            else replace_value astate_acc ~src:x ~dst:y
        | PathCond.Eq ((Val.Vheap (SymHeap.Extern _) as x), (Val.Vheap (SymHeap.Extern _) as y))
        | PathCond.Eq
            ( Val.Vexn (Val.Vheap (SymHeap.Extern _) as x)
            , Val.Vexn (Val.Vheap (SymHeap.Extern _) as y) ) ->
            if Val.is_const_extern x then replace_value astate_acc ~src:y ~dst:x
            else replace_value astate_acc ~src:x ~dst:y
        | _ ->
            astate_acc)
      pc_set astate
  in
  let pathcond_to_add = PathCond.normalize pathcond in
  if PC.is_valid pathcond_to_add astate.pc then
    (* Avoid overwritting modelNull by normalNull *)
    [astate]
  else
    let pc' = PC.add ~is_branch pathcond_to_add astate.pc in
    if PC.is_invalid pc' then [] else [{astate with pc= pc'}]


let set_exception astate = {astate with is_exceptional= true}

let set_patched astate = {astate with is_patched= true}

let set_patch_score astate score = {astate with patch_score= score}

let update_patch_score astate score = {astate with patch_score= astate.patch_score *. score}

let gen_error_info_by_call astate instr_node actual_values target_heaps callee : RuntimeCrash.V.t =
  (* if it succeed in computing heaps used in callee, remaining only the used heaps and const
     otherwise compute all values related to patch (for soundness) *)
  let patch_values, patch_nodes = (get_patch_values astate, get_patch_nodes astate) in
  let sub_patch_values =
    Val.Set.fold
      (fun v acc -> Val.Set.union (Val.get_subvalues v |> Val.Set.of_list) acc)
      patch_values Val.Set.empty
  in
  let vals_affected =
    if Val.Set.is_empty target_heaps then sub_patch_values
    else
      Val.Set.filter
        (fun v ->
          (not (Val.is_heap v))
          || Val.Set.mem v target_heaps
          || List.mem actual_values v ~equal:Val.equal)
        patch_values
  in
  L.d_printfln " Sub values in patch : %a@, Target heaps : %a@, Result : %a@, Actuals : %a."
    Val.Set.pp sub_patch_values Val.Set.pp target_heaps Val.Set.pp vals_affected (Pp.seq Val.pp)
    actual_values ;
  let is_modified = Patch.NodeSet.mem (InstrNode.pnode_of instr_node) patch_nodes in
  let is_affected =
    (* checking the arguments is in patched values
       or checking the patch values are dependant to arguments values *)
    match actual_values with
    | [Val.Vheap (SymHeap.Symbol (Param pv, _))] when Pvar.is_this pv ->
        true
    | _ ->
        List.exists actual_values ~f:(fun v ->
            Val.Set.exists
              (fun v' ->
                Val.equal v v'
                || ValueAnalysis.ValDep.is_dependent astate.value_dependency ~src:v' ~dst:v)
              vals_affected)
  in
  {node= instr_node; kind= RuntimeCrash.CALL callee; is_modified; is_affected}


let gen_error_info_by_access astate instr_node base_val idx_val : RuntimeCrash.V.t =
  (* checking the base and index value is affected by patch
     := checking the dependency between patches valeus and base, index *)
  let patch_values, patch_nodes = (get_patch_values astate, get_patch_nodes astate) in
  let is_modified = Patch.NodeSet.mem (InstrNode.pnode_of instr_node) patch_nodes in
  let is_affected =
    (* checking the arguments is in patched values
       or checking the patch values are dependant to arguments values *)
    List.exists [base_val; idx_val] ~f:(fun v ->
        Val.Set.exists
          (fun v' ->
            Val.equal v v'
            || ValueAnalysis.ValDep.is_dependent astate.value_dependency ~src:v' ~dst:v)
          patch_values)
  in
  {node= instr_node; kind= RuntimeCrash.OOB; is_modified; is_affected}


let gen_error_info_by_null astate instr_node base_val : RuntimeCrash.V.t =
  let patch_values, patch_nodes = (get_patch_values astate, get_patch_nodes astate) in
  let is_modified = Patch.NodeSet.mem (InstrNode.pnode_of instr_node) patch_nodes in
  let is_affected =
    (* checking the base obj is dependant to patched values *)
    Val.Set.exists
      (fun v ->
        Val.equal base_val v
        || ValueAnalysis.ValDep.is_dependent astate.value_dependency ~src:v ~dst:base_val)
      patch_values
  in
  {node= instr_node; kind= RuntimeCrash.NPE; is_modified; is_affected}


let set_runtime_crash astate pdesc err_info =
  if RuntimeCrash.V.is_non_target_mthd err_info then astate
  else
    let return_loc = Procdesc.get_ret_var pdesc |> Loc.of_pvar in
    let astate = store_loc astate return_loc Val.exn in
    {astate with is_exceptional= true; runtime_crash= RuntimeCrash.add err_info astate.runtime_crash}


let unwrap_exception astate =
  let runtime_crash = RuntimeCrash.map RuntimeCrash.V.set_affected astate.runtime_crash in
  {astate with is_exceptional= false; runtime_crash}


let is_null astate v = List.exists (equal_values astate v) ~f:Val.is_null

let is_non_null astate v = List.exists (inequal_values astate v) ~f:Val.is_null

let set_npes npes nullptrs =
  List.fold nullptrs ~init:npes ~f:(fun acc v ->
      if Val.Set.exists (fun v' -> Val.equal_up_to_source v v') acc then acc else Val.Set.add v acc)


let set_uncaught_npes astate pdesc nullptrs =
  (* set uncaught npes if it is not in potential npes *)
  (* let nullptrs =
       List.filter
         ~f:(fun v ->
           not (Val.Set.exists (fun v' -> Val.equal_up_to_source v v') astate.potential_npes))
         nullptrs
     in *)
  let return_loc = Procdesc.get_ret_var pdesc |> Loc.of_pvar in
  let astate = store_loc astate return_loc Val.npe in
  {astate with is_exceptional= true; uncaught_npes= set_npes astate.uncaught_npes nullptrs}


let set_potential_npes astate nullptrs =
  (* set potential npes when the value has no constrains *)
  (* let nullptrs = List.filter ~f:(not <<< is_non_null astate) nullptrs in *)
  {astate with potential_npes= set_npes astate.potential_npes nullptrs}


let is_affected_instr ?(usecase = UseCase.Any) instr_node v =
  (* The instruction affects the value if:
     1. it changes rhs value => generated value must be affected by patch
     2. it changes values in branch => it changes constraints of the value
     3. heaps used as param of void function => side effect may change the parameter
     4. param of boolean predicate (e.g., is*, instance of) may accumulate constraint
  *)
  let get_exp_of_id instrs x =
    List.find_map
      ~f:(fun instr ->
        match instr with Sil.Load {id= y; e} when Ident.equal x y -> Some e | _ -> None)
      instrs
  in
  let instr = InstrNode.get_instr instr_node in
  match usecase with
  | UseCase.RValue -> (
    match instr with
    | Sil.Store {e1= Exp.Lvar pv; _} when Pvar.is_frontend_tmp pv ->
        (* ignore the store to temp var *)
        false
    | _ ->
        true )
  | UseCase.Branch -> (
    match instr with
    | Sil.Prune (Exp.BinOp (_, Var id1, Var id2), _, _, _) -> (
        (* if the prune node is not excuted ignore the effect *)
        let preds = InstrNode.get_all_preds instr_node |> List.map ~f:InstrNode.get_instr in
        match (get_exp_of_id preds id1, get_exp_of_id preds id2) with
        | Some e1, Some e2 when Exp.equal e1 e2 ->
            false
        | _ ->
            true )
    | _ ->
        true )
  | UseCase.Param -> (
    match instr with
    | Sil.Call (_, Const (Cfun proc), _, _, _)
      when String.equal "__instanceof" (Procname.get_method proc) ->
        true
    | Sil.Call (_, Const (Cfun proc), [_], _, _)
      when String.is_prefix (Procname.get_method proc) ~prefix:"hasInstance" ->
        true
    | Sil.Call ((_, ret_typ), _, _, _, _) when Typ.is_void ret_typ && Val.is_heap v ->
        true
    | Sil.Call (_, Const (Cfun proc), [_], _, _)
      when String.is_prefix (Procname.get_method proc) ~prefix:"is" ->
        true
    | _ ->
        false )
  | _ ->
      false


let use_val ?(usecase = UseCase.Any) instr_node v astate =
  if astate.is_target then (
    let patch_nodes = get_patch_nodes astate in
    let pnode = InstrNode.pnode_of instr_node in
    let is_affected = is_affected_instr ~usecase instr_node v in
    L.d_printfln "[DEBUG] V(%a): %a, %b @." Val.pp v UseCase.pp usecase is_affected ;
    let patch_info =
      if Patch.NodeSet.mem pnode patch_nodes && (not (Val.is_constant v)) && is_affected then
        PatchInfo.weak_update pnode v astate.patch_info
      else astate.patch_info
    in
    let used_val_local = ValUse.weak_update usecase (Val.Set.singleton v) astate.used_val_local in
    {astate with patch_info; used_val_local} )
  else astate


let update_dependency astate ~lhs ~rhs =
  if astate.is_target then
    (* if the lhs dependent to patch value, store the information *)
    let _ = L.d_printfln "Update dep (LHS: %a, RHS: %a)@." Val.pp lhs Val.pp rhs in
    let patch_info =
      PatchInfo.map
        (fun patch_values ->
          if Val.Set.mem rhs patch_values then Val.Set.add lhs patch_values else patch_values)
        astate.patch_info
    in
    { astate with
      patch_info
    ; value_dependency= ValDep.weak_update lhs (Val.Set.singleton rhs) astate.value_dependency }
  else astate


let update_derefed_heaps v astate =
  match v with
  | Val.Vheap _ ->
      {astate with derefed_heaps= Val.Set.add v astate.derefed_heaps}
  | _ ->
      astate


(* Symbolic domain *)
let resolve_unknown_loc astate typ loc : t =
  if is_unknown_loc astate loc then
    match Val.symbol_from_loc_opt typ loc with
    | Some symval ->
        let mem' = Mem.strong_update loc symval astate.mem in
        {astate with mem= mem'}
    | None ->
        (* too complex symbol *)
        let value = Val.make_extern (InstrNode.dummy_of_proc astate.current_proc) typ in
        store_loc astate loc value
  else astate


let bind_exn_extern astate instr_node ret_var callee arg_values =
  (* return -> Exn extern
     Exn extern = callee(arg_values) *)
  let ret_loc = Loc.of_pvar ret_var in
  let value = Val.make_extern instr_node Typ.void_star |> Val.to_exn in
  let arg_values =
    List.map arg_values ~f:(fun v ->
        match List.find (equal_values astate v) ~f:Val.is_constant with Some v' -> v' | None -> v)
  in
  let astate =
    List.fold arg_values ~init:astate ~f:(fun astate v -> update_derefed_heaps v astate)
  in
  let call_value = Val.Vextern (callee, arg_values) in
  let call_cond = PathCond.make_physical_equals Binop.Eq value call_value in
  let astate_reg_stored = store_loc astate ret_loc value |> set_exception in
  add_pc astate_reg_stored call_cond


let bind_extern_value astate instr_node ret_typ_id callee arg_values =
  (* ret_id -> extern
     extern = callee(arg_values) *)
  let ret_id, ret_typ = ret_typ_id in
  let value = Val.make_extern instr_node ret_typ in
  let arg_values =
    List.map arg_values ~f:(fun v ->
        match List.find (equal_values astate v) ~f:Val.is_constant with Some v' -> v' | None -> v)
  in
  let astate =
    List.fold arg_values ~init:astate ~f:(fun astate v -> update_derefed_heaps v astate)
  in
  let call_value = Val.Vextern (callee, arg_values) in
  let call_cond = PathCond.make_physical_equals Binop.Eq value call_value in
  let astate_reg_stored = store_reg astate ret_id value in
  add_pc astate_reg_stored call_cond


let init proc_desc patch_info : t =
  let formals = Procdesc.get_pvar_formals proc_desc in
  let current_proc = Procdesc.get_proc_name proc_desc in
  (* compute patch info *)
  let is_target = Patch.PatchInfo.is_target_proc current_proc patch_info in
  let patch_nodes = Patch.PatchInfo.get_modified_nodes current_proc patch_info in
  let patch_info =
    Patch.NodeSet.fold
      (fun node acc -> PatchInfo.add node Val.Set.bottom acc)
      patch_nodes PatchInfo.bottom
  in
  let start_node = Procdesc.get_start_node proc_desc in
  let init_with_formals =
    (* init memory, def-use state with parameters *)
    List.fold formals ~init:bottom ~f:(fun astate (pv, typ) ->
        let pv_loc = Loc.of_pvar pv in
        resolve_unknown_loc astate typ pv_loc |> def_loc pv_loc start_node)
  in
  match List.find formals ~f:(fun (pv, _) -> Pvar.is_this pv) with
  | Some (this_pvar, _) when is_target ->
      (* Tracking non-null contraint for potential npe only target procs *)
      let null = Val.make_null () in
      let this_value = read_loc init_with_formals (Loc.of_pvar this_pvar) in
      { init_with_formals with
        pc= PC.add (PathCond.make_physical_equals Binop.Ne null this_value) PC.empty
      ; patch_info
      ; is_target
      ; current_proc }
  | _ ->
      {init_with_formals with patch_info; is_target; current_proc}


let append_ctx astate offset =
  (* append counter to distinguish obj generated by interprocedural call *)
  let reg = Reg.map (Val.append_ctx ~offset) astate.reg in
  let mem =
    Mem.fold
      (fun l v acc -> Mem.strong_update (Loc.append_ctx ~offset l) (Val.append_ctx ~offset v) acc)
      astate.mem Mem.empty
  in
  let pc = PC.replace_by_map ~f:(Val.append_ctx ~offset) astate.pc in
  let uncaught_npes = Val.Set.map (Val.append_ctx ~offset) astate.uncaught_npes in
  let potential_npes = Val.Set.map (Val.append_ctx ~offset) astate.potential_npes in
  let accessed =
    let analysis =
      AccessedLoc.DUMap.fold
        (fun (l, line) v -> AccessedLoc.DUMap.add (Loc.append_ctx ~offset l, line) v)
        astate.accessed.analysis AccessedLoc.DUMap.empty
    in
    let defmap =
      AccessedLoc.DefMap.fold
        (fun l lines -> AccessedLoc.DefMap.add (Loc.append_ctx ~offset l) lines)
        astate.accessed.defmap AccessedLoc.DefMap.empty
    in
    AccessedLoc.{analysis; defmap}
  in
  {astate with reg; mem; pc; uncaught_npes; potential_npes; accessed}


(** Eval functions *)
let eval_uop instrnode unop v =
  match unop with
  | Unop.LNot when Val.is_true v ->
      Val.zero
  | Unop.LNot when Val.is_false v ->
      Val.one
  | Unop.Neg when Val.is_int v ->
      Val.sub instrnode Val.zero v
  | _ ->
      Val.make_extern instrnode Typ.int


let eval_binop instrnode binop v1 v2 =
  match binop with
  | Binop.PlusA _ ->
      Val.add instrnode v1 v2
  | Binop.MinusA _ ->
      Val.sub instrnode v1 v2
  | Binop.Mult _ ->
      Val.mult instrnode v1 v2
  | Binop.Div ->
      Val.div instrnode v1 v2
  | Binop.Lt ->
      Val.lt instrnode v1 v2
  | Binop.Gt ->
      Val.lt instrnode v2 v1
  | Binop.Le ->
      Val.lte instrnode v1 v2
  | Binop.Ge ->
      Val.lte instrnode v2 v1
  | Binop.BAnd when Val.is_true v1 && Val.is_true v2 ->
      Val.one
  | Binop.BAnd when Val.is_false v1 || Val.is_false v2 ->
      Val.zero
  | Binop.BOr when Val.is_true v1 || Val.is_true v2 ->
      Val.one
  | Binop.BOr when Val.is_false v1 && Val.is_false v2 ->
      Val.zero
  | Binop.BXor when (Val.is_true v1 && Val.is_true v2) || (Val.is_false v1 && Val.is_false v2) ->
      Val.one
  | Binop.BXor when (Val.is_true v1 && Val.is_false v2) || (Val.is_false v1 && Val.is_true v2) ->
      Val.zero
  | _ ->
      Val.top


let rec eval ?(usecase = UseCase.Any) astate instr_node exp =
  let eval = eval ~usecase in
  let use_val = use_val ~usecase instr_node in
  (* update state with use info and return the updated state and evaluated value *)
  let f v t =
    let v =
      if PC.ConstMap.mem v astate.pc.const_map then PC.ConstMap.find v astate.pc.const_map else v
    in
    if
      (* When target value is constant and the node is patch node make the value point out by symbol *)
      Patch.NodeSet.mem (InstrNode.pnode_of instr_node) (get_patch_nodes astate)
      && Val.is_constant v
    then
      let add_pc_simple astate pathcond = add_pc_simple ~is_branch:false astate pathcond in
      let make_extern = Val.make_extern (InstrNode.dummy_of_proc astate.current_proc) in
      let new_value =
        match v with
        | Val.Vint _ ->
            make_extern Typ.int
        (* | Val.Vheap (SymHeap.Null _) ->
            make_extern Typ.void_star *)
        | _ ->
            v
      in
      let astate_new = add_pc_simple t (PathCond.make_physical_equals Binop.Eq new_value v) in
      (use_val new_value astate_new, new_value)
    else (use_val v t, v)
  in
  match exp with
  | Exp.Var id when Reg.mem id astate.reg ->
      f (Reg.find id astate.reg) astate
  | Exp.Var id ->
      L.(die InternalError) "%a is not assigned any value" Ident.pp id
  | Exp.UnOp (unop, e, _) ->
      let astate, v = eval astate instr_node e in
      let v' = eval_uop instr_node unop v in
      let astate = update_dependency astate ~lhs:v' ~rhs:v in
      f v' astate
  | Exp.BinOp (binop, e1, e2) ->
      let astate, v1 = eval astate instr_node e1 in
      let astate, v2 = eval astate instr_node e2 in
      let v' = eval_binop instr_node binop v1 v2 in
      let astate = update_dependency astate ~lhs:v' ~rhs:v1 |> update_dependency ~lhs:v' ~rhs:v2 in
      f v' astate
  | Exp.Exn e ->
      let astate, v = eval astate instr_node e in
      let v' = Val.to_exn v in
      let astate = update_dependency astate ~lhs:v' ~rhs:v in
      f v' astate
      (*
    try eval astate node instr e |> Val.to_exn with
    | _ when List.is_empty astate.uncaught_npes ->
        (* HEURISTICS: abstract all exn values to exn*)
        Val.exn
    | _ ->
        Val.npe *)
  | Exp.Const (Cstr str) ->
      f (Val.make_string str) astate
  | Exp.Const (Cint intlit) when IntLit.isnull intlit ->
      f (Val.make_null ()) astate
  | Exp.Const (Cint intlit) ->
      f (Val.of_intlit intlit) astate
  | Exp.Const (Cfloat flit) ->
      f (Val.of_float flit) astate
  | Exp.Const (Cclass name) ->
      f (Val.make_string (Ident.name_to_string name)) astate
  | Exp.Cast (_, e) ->
      let astate, v = eval astate instr_node e in
      f v astate
  | Exp.Lvar _ | Exp.Lfield _ | Exp.Lindex _ ->
      L.(die InternalError) "%a is not allowed as rvalue in java" Exp.pp exp
  | Exp.Closure _ | Exp.Sizeof _ | Exp.Const (Cfun _) ->
      f Val.top astate


let eval_value astate instr_node exp = snd (eval astate instr_node exp)

let rec eval_lv_sub astate instr_node exp =
  match exp with
  | Exp.Var id when Reg.mem id astate.reg -> (
    match Reg.find id astate.reg with
    | Val.Vheap h ->
        (Loc.SymHeap h, [Val.Vheap h])
    | Val.Top ->
        L.progress "[WARNING]: lvalue expression %a is evaluated to top" Exp.pp exp ;
        (Loc.unknown, [])
    | _ as v ->
        L.progress "[WARNING]: lvalue expression %a is evaluated to %a" Exp.pp exp Val.pp v ;
        (Loc.unknown, [])
        (* L.(die InternalError) "lvalue expression %a cannot be evaluated to %a" Exp.pp exp Val.pp v ) *)
    )
  | Exp.Var id ->
      L.(die InternalError) "%a is not loaded to reg" Ident.pp id
  | Exp.Const (Cstr str) ->
      (Loc.make_string str, [])
  | Exp.Cast (_, e) ->
      eval_lv_sub astate instr_node e
  | Exp.Lindex (e1, e2) ->
      let index_val = snd (eval astate instr_node e2) in
      let index = Val.to_symexp instr_node index_val in
      let base_loc, sub_vals = eval_lv_sub astate instr_node e1 in
      (Loc.append_index ~index base_loc, index_val :: sub_vals)
  | Exp.Lvar pv ->
      (Loc.of_pvar pv, [])
  | Exp.Lfield (e, fn, _) ->
      let base_loc, sub_vals = eval_lv_sub astate instr_node e in
      (Loc.append_field ~fn base_loc, sub_vals)
  | Exp.Const (Cclass name) ->
      (* value of the class variable is unknown, so init by global *)
      (Loc.make_string (Ident.name_to_string name), [])
      (* let cls_name = Ident.name_to_string cls in
         let cls_var = Pvar.mk_global (Mangled.from_string cls_name) in
         Loc.of_pvar cls_var *)
  | _ ->
      L.(die InternalError) "%a is not allowed as lvalue expression in java" Exp.pp exp


let eval_lv astate instr_node exp = fst (eval_lv_sub astate instr_node exp)

let access_loc node instr loc astate =
  (* if the loc aceessed by loaded before its field update do not change its access state:
     n = load(a) => in this point access of n is not stored (since n can be null)
     n.fn = v
  *)
  let instr_node = InstrNode.of_pnode node instr in
  let succ_instrs = InstrNode.get_all_succs instr_node |> List.map ~f:InstrNode.get_instr in
  let is_next_fn_store instr instr' =
    match (instr, instr') with
    | Sil.Load {id= id1}, Sil.Store {e1= Exp.Lfield (Var id2, _, _)} when Ident.equal id1 id2 ->
        true
    | _ ->
        false
  in
  if List.exists succ_instrs ~f:(fun instr' -> is_next_fn_store instr instr') && false then astate
  else {astate with accessed= AccessedLoc.access_loc astate.current_proc loc astate.accessed}


let access_loc_of_value node instr v astate =
  try access_loc node instr (Val.to_loc v) astate with _ -> astate


(** remove unreachables for summary resolving **)
let compute_reachable_locs_from astate base_locs =
  let visited = ref Loc.Set.empty in
  let rec iter worklist candidates acc =
    let is_reachable_from l =
      match l with
      | (Loc.Field (base, _) | Loc.Index (base, _)) when Loc.Set.mem base acc ->
          true
      | (Loc.Field (Loc.Var gv, _) | Loc.Index (Loc.Var gv, _)) when Pvar.is_global gv ->
          true
      | _ ->
          false
    in
    match worklist with
    | [] ->
        acc
    | work :: rest when Loc.Set.mem work !visited ->
        iter rest candidates acc
    | work :: rest ->
        visited := Loc.Set.add work !visited ;
        let reachables' =
          Loc.Set.fold
            (fun l acc -> if is_reachable_from l then Loc.Set.add l acc else acc)
            candidates Loc.Set.empty
        in
        iter
          (rest @ Loc.Set.elements reachables')
          (Loc.Set.diff candidates reachables')
          (Loc.Set.union acc reachables')
  in
  let all_locs =
    Mem.fold (fun l _ -> Loc.Set.add l) astate.mem Loc.Set.empty
    |> AccessedLoc.DUMap.fold (fun (l, _) _ -> Loc.Set.add l) astate.accessed.analysis
  in
  iter (Loc.Set.elements base_locs) all_locs base_locs


let compute_reachable_vals_from astate base_vals =
  let visited = ref Val.Set.empty in
  let rec iter worklist candidates acc =
    let is_reachable_from v =
      match v with
      | Val.Vheap (SymHeap.Symbol (base, [_])) ->
          Val.Set.mem (Val.Vheap (SymHeap.Symbol (base, []))) acc
      | Val.Vheap (SymHeap.Symbol (base, fn :: accesses)) ->
          let prev_accesses = fn :: (List.rev accesses |> List.tl_exn |> List.rev) in
          Val.Set.mem (Val.Vheap (SymHeap.Symbol (base, prev_accesses))) acc
      | _ ->
          false
    in
    match worklist with
    | [] ->
        acc
    | work :: rest when Val.Set.mem work !visited ->
        iter rest candidates acc
    | work :: rest ->
        visited := Val.Set.add work !visited ;
        let reachables' =
          Val.Set.fold
            (fun v acc -> if is_reachable_from v then Val.Set.add v acc else acc)
            candidates Val.Set.empty
        in
        iter
          (rest @ Val.Set.elements reachables')
          (Val.Set.diff candidates reachables')
          (Val.Set.union acc reachables')
  in
  iter (Val.Set.elements base_vals) (all_values astate) base_vals


let compute_reachables_from astate base_locs base_vals =
  let reachable_locs = compute_reachable_locs_from astate base_locs in
  let reachable_vals =
    Mem.fold
      (fun l v acc -> if Loc.Set.mem l reachable_locs then Val.Set.add v acc else acc)
      astate.mem base_vals
  in
  (* let reachable_vals = compute_reachable_vals_from astate reachable_vals in *)
  (reachable_locs, reachable_vals)


let remove_unreachables_from_base astate base_locs base_vals =
  let reachable_locs, reachable_vals = compute_reachables_from astate base_locs base_vals in
  let is_reachable_loc l = Loc.Set.mem l reachable_locs in
  let is_dependant_to_reachable v =
    match ValDep.find_opt v astate.value_dependency with
    | Some vset ->
        Val.Set.exists (fun v -> Val.Set.mem v reachable_vals) vset
    | None ->
        false
  in
  let is_reachable_value v =
    let sub = Val.get_subvalues v in
    Val.is_constant v || List.exists sub ~f:(fun v -> Val.Set.mem v reachable_vals)
  in
  let mem = Mem.filter (fun l _ -> is_reachable_loc l) astate.mem in
  let pc = PC.filter_by_value ~check_all:true ~f:is_reachable_value astate.pc in
  let accessed = AccessedLoc.filter_by_loc ~f:is_reachable_loc astate.accessed in
  let uncaught_npes = Val.Set.filter is_reachable_value astate.uncaught_npes in
  let potential_npes = Val.Set.filter is_reachable_value astate.potential_npes in
  let patch_info = PatchInfo.map (Val.Set.filter is_reachable_value) astate.patch_info in
  let nullified = Val.Set.filter is_reachable_value astate.nullified in
  let value_dependency =
    ValDep.fold
      (fun v vset acc ->
        if is_reachable_value v then
          let vset' = Val.Set.filter is_reachable_value vset in
          ValDep.add v vset' acc
        else acc)
      astate.value_dependency ValDep.empty
  in
  let astate' =
    { astate with
      mem
    ; pc
    ; accessed
    ; uncaught_npes
    ; potential_npes
    ; patch_info
    ; nullified
    ; value_dependency }
  in
  (* L.d_printfln
     "[DEBUG]: rechable locs : @,- %a@, rechable vals : @,- %a@, state after removing :@, %a@."
     Loc.Set.pp reachable_locs Val.Set.pp reachable_vals pp r ; *)
  astate'


let remove_unreachables_summary ?(is_local = false) astate pdesc =
  let base_vals =
    let formal_vals =
      Val.Set.filter
        (Val.is_symbol_of ~include_gv:true (Procdesc.get_proc_name pdesc))
        (all_values astate)
    in
    let local_vals =
      if is_local then Mem.fold (fun _ v acc -> Val.Set.add v acc) astate.mem Val.Set.empty
      else Val.Set.empty
    in
    Val.Set.union formal_vals local_vals
  in
  let base_locs =
    let formal_locs =
      Procdesc.get_pvar_formals pdesc |> List.map ~f:(fun (pv, _) -> Loc.of_pvar pv)
    in
    let ret_loc = Procdesc.get_ret_var pdesc |> Loc.of_pvar in
    let local_locs =
      if is_local then
        Procdesc.get_locals pdesc
        |> List.map ~f:(fun ProcAttributes.{name} ->
               Loc.of_pvar (Pvar.mk name (Procdesc.get_proc_name pdesc)))
      else []
    in
    ret_loc :: (formal_locs @ local_locs)
    |> Loc.Set.of_list
    |> Val.Set.fold
         (fun v acc -> Loc.Set.add (Val.to_loc v) acc)
         (Val.Set.filter Val.is_heap base_vals)
  in
  remove_unreachables_from_base astate base_locs base_vals


let remove_id astate id =
  if Reg.mem id astate.reg then {astate with reg= Reg.remove id astate.reg} else astate


let remove_pvar astate ~pv =
  let pvar_loc = Loc.of_pvar pv in
  if Mem.mem pvar_loc astate.mem then
    let mem = Mem.remove pvar_loc astate.mem in
    let accessed =
      AccessedLoc.filter_by_loc ~f:(fun l -> not (Loc.equal l pvar_loc)) astate.accessed
    in
    {astate with mem; accessed}
  else astate


let filter_unreachable_heaps astate vals vars =
  let pointed_by_mem =
    Mem.fold (fun l v acc ->
        match l with
        | (Loc.TempVar pv | Loc.Var pv) when List.mem vars ~equal:Var.equal (Var.of_pvar pv) ->
            acc
        | _ ->
            Val.Set.add v acc)
  in
  let pointed_by_reg =
    Reg.fold (fun id v acc ->
        if List.mem vars (Var.of_id id) ~equal:Var.equal then acc else Val.Set.add v acc)
  in
  let reachable_heaps = pointed_by_mem astate.mem Val.Set.empty |> pointed_by_reg astate.reg in
  Val.Set.filter (fun v -> not (Val.Set.mem v reachable_heaps)) vals


let remove_unreachable_heaps astate vals =
  L.d_printfln "found unreachabled heaps: %a" Val.Set.pp vals ;
  let is_reachable_loc l =
    match Loc.get_heap_opt l with Some sh -> not (Val.Set.mem (Val.Vheap sh) vals) | _ -> true
  in
  let mem = Mem.filter (fun l _ -> is_reachable_loc l) astate.mem in
  let accessed = AccessedLoc.filter_by_loc ~f:is_reachable_loc astate.accessed in
  {astate with mem; accessed}


let remove_temps astate pdesc temps =
  let astate, vals_pointed_by_temps =
    List.fold temps ~init:(astate, Val.Set.empty) ~f:(fun (astate, vals) var ->
        match var with
        | Var.ProgramVar pv ->
            (remove_pvar astate ~pv, Val.Set.add (Mem.find (Loc.of_pvar pv) astate.mem) vals)
        | Var.LogicalVar id ->
            (remove_id astate id, Val.Set.add (Reg.find id astate.reg) vals))
  in
  let heaps_pointed_by_temps =
    Val.Set.filter
      (fun v -> (not (Val.is_symbol_of astate.current_proc v)) && Val.is_heap v)
      vals_pointed_by_temps
  in
  let unreachable_heaps = filter_unreachable_heaps astate heaps_pointed_by_temps temps in
  let astate' = remove_unreachable_heaps astate unreachable_heaps in
  remove_unreachables_summary ~is_local:true astate' pdesc


let nullify_pvar astate ~pv =
  try
    let pv_loc = Loc.of_pvar pv in
    let val_to_nullify = Mem.find pv_loc astate.mem in
    {astate with nullified= Val.Set.add val_to_nullify astate.nullified}
  with _ -> astate


let remove_locals astate ~pdesc =
  let pname = Procdesc.get_proc_name pdesc in
  let ret_var = Procdesc.get_ret_var pdesc in
  let formal_pvars = Procdesc.get_pvar_formals pdesc |> List.map ~f:fst in
  let locals =
    Procdesc.get_locals pdesc |> List.map ~f:(fun ProcAttributes.{name} -> Pvar.mk name pname)
  in
  List.fold ((ret_var :: formal_pvars) @ locals) ~init:astate ~f:(fun acc pv -> remove_pvar acc ~pv)


(** For Join *)
let unify lhs rhs : t * t =
  let all_locs =
    (* TODO: unify non-memory symbols? or guarantee all symbols are in memory *)
    let left_locs = Mem.fold (fun l _ acc -> l :: acc) lhs.mem [] in
    Mem.fold
      (fun l' _ acc ->
        if Mem.mem l' lhs.mem then acc else if Loc.is_symbolic l' then l' :: acc else acc)
      rhs.mem left_locs
  in
  let lhs, rhs =
    List.fold all_locs ~init:(lhs, rhs) ~f:(fun (lhs_acc, rhs_acc) l ->
        if Loc.is_symbolic l then
          match (Mem.find l lhs.mem, Mem.find l rhs.mem) with
          | Val.Vheap _, Val.Bot ->
              (lhs_acc, resolve_unknown_loc rhs_acc Typ.void_star l)
          | Val.Vint _, Val.Bot ->
              (lhs_acc, resolve_unknown_loc rhs_acc Typ.int l)
          | Val.Bot, Val.Vheap _ ->
              (resolve_unknown_loc lhs_acc Typ.void_star l, rhs_acc)
          | Val.Bot, Val.Vint _ ->
              (resolve_unknown_loc lhs_acc Typ.int l, rhs_acc)
          | _ ->
              (lhs_acc, rhs_acc)
        else (lhs_acc, rhs_acc))
  in
  let extern_locs, concrete_locs =
    List.partition_tf all_locs ~f:(fun l -> Loc.is_extern l || Loc.is_allocsite l)
  in
  let replace_astate astate l v new_value introduced =
    L.d_printfln "[Debug Unify] Origianl V:%a, New V:%a, %a@." Val.pp v Val.pp new_value Val.Set.pp
      introduced ;
    let add_pc_simple astate pathcond = add_pc_simple ~is_branch:false astate pathcond in
    match v with
    | Val.Vexn v' ->
        if Val.Set.mem v' introduced then
          add_pc_simple
            (store_loc astate l (Val.to_exn new_value))
            (PathCond.make_physical_equals Binop.Eq v' new_value)
        else if Val.is_concrete v then
          (* If the value is constant, update the new value = v constant *)
          add_pc_simple
            (replace_value astate ~src:v ~dst:(Val.to_exn new_value))
            (PathCond.make_physical_equals Binop.Eq (Val.to_exn new_value) v)
        else replace_value astate ~src:v' ~dst:new_value
    | _ ->
        (* if Val.Set.mem v introduced then
             add_pc_simple (store_loc astate l new_value)
               (PathCond.make_physical_equals Binop.Eq v new_value)
           else
        *)
        if Val.is_allocsite v then
          add_pc_simple
            (replace_value astate ~src:v ~dst:new_value)
            (PathCond.make_physical_equals Binop.Ne new_value (Val.make_null ()))
        else if Val.is_concrete v then
          (* If the value is constant, update the new value = v constant *)
          add_pc_simple
            (replace_value astate ~src:v ~dst:new_value)
            (PathCond.make_physical_equals Binop.Eq new_value v)
        else replace_value astate ~src:v ~dst:new_value
  in
  let rec _unify worklist rest (lhs, rhs) introduced =
    let add = Val.Set.add in
    let mem = Val.Set.mem in
    let mem_mem = Mem.mem in
    let equal = Val.equal in
    let find = Mem.find in
    let make_extern = Val.make_extern (InstrNode.dummy_of_proc lhs.current_proc) in
    let replace_rest src dst rest =
      List.map
        ~f:(fun l -> match dst with Val.Vheap dst -> Loc.replace_heap ~src ~dst l | _ -> l)
        rest
    in
    let f (vals, rest, lhs, rhs, introduced) l =
      if mem_mem l rhs.mem then
        let v_lhs, v_rhs = (find l lhs.mem, find l rhs.mem) in
        match (v_lhs, v_rhs) with
        | _, _ when Val.equal_up_to_source v_lhs v_rhs ->
            (add v_lhs vals, rest, lhs, rhs, add v_lhs introduced)
        | Val.Vheap x, Val.Vheap y when SymHeap.is_unknown x || SymHeap.is_unknown y ->
            (vals, rest, lhs, rhs, introduced)
        | Val.Vint _, Val.Vint _ ->
            let new_value = make_extern Typ.int in
            ( vals
            , rest
            , replace_astate lhs l v_lhs new_value introduced
            , replace_astate rhs l v_rhs new_value introduced
            , add new_value introduced )
        | Val.Vheap sh1, Val.Vheap sh2 ->
            let new_value = make_extern Typ.void_star in
            ( add new_value vals
            , replace_rest sh1 new_value rest |> replace_rest sh2 new_value
            , replace_astate lhs l v_lhs new_value introduced
            , replace_astate rhs l v_rhs new_value introduced
            , add new_value introduced )
        | Vexn _, Vexn _ ->
            let new_value = make_extern Typ.void_star in
            (* exception heap cannot points-to something *)
            ( vals
            , rest
            , replace_astate lhs l v_lhs new_value introduced
            , replace_astate rhs l v_rhs new_value introduced
            , add new_value introduced )
        | Vextern _, _ ->
            (* uninterpretted function term is not in memory *)
            (vals, rest, lhs, rhs, introduced)
        | _, _ ->
            (vals, rest, lhs, rhs, introduced)
      else (vals, rest, lhs, rhs, introduced)
    in
    (* TODO: fix scalability issues *)
    let next_vals, next_rest, next_lhs, next_rhs, next_introduced =
      List.fold worklist ~init:(Val.Set.empty, rest, lhs, rhs, introduced) ~f:(fun acc l -> f acc l)
    in
    let next_worklist, next_rest =
      List.partition_tf next_rest
        ~f:(Loc.is_rec ~f:(function Loc.SymHeap sh -> mem (Val.Vheap sh) next_vals | _ -> false))
    in
    if List.is_empty next_worklist then (next_lhs, next_rhs)
    else _unify next_worklist next_rest (next_lhs, next_rhs) next_introduced
  in
  _unify concrete_locs extern_locs (lhs, rhs) Val.Set.empty


let get_null_values astate =
  let null_in_mem =
    Mem.fold
      (fun _ v acc -> if is_null astate v then Val.Set.add v acc else acc)
      astate.mem Val.Set.empty
  in
  PC.ConstMap.fold
    (fun v c acc -> if Val.is_null c then Val.Set.add v acc else acc)
    astate.pc.const_map null_in_mem


let get_null_symbols astate =
  let null_values = get_null_values astate in
  Val.Set.filter Val.is_symbolic null_values


let get_non_null_values astate =
  let nonnull_in_mem =
    Mem.fold
      (fun _ v acc -> if is_non_null astate v then Val.Set.add v acc else acc)
      astate.mem Val.Set.empty
  in
  PC.InEqualMap.fold
    (fun v consts acc -> if PC.ValSet.exists Val.is_null consts then Val.Set.add v acc else acc)
    astate.pc.inequal_map nonnull_in_mem


let collect_summary_symbols astate =
  (* TODO: HEURISTICS *)
  let symbols_in_mem =
    Mem.fold
      (fun l v acc ->
        match (l, v) with
        | (Loc.Field _, Val.Vint (Symbol s) | Loc.Index _, Val.Vint (Symbol s))
          when Symbol.is_pvar s ->
            Val.Set.add v acc
        | _ ->
            acc)
      astate.mem Val.Set.empty
  in
  symbols_in_mem


let collect_summary_locals astate =
  Mem.fold
    (fun l _ acc -> match l with Var pv when Pvar.is_local pv -> Loc.Set.add l acc | _ -> acc)
    astate.mem Loc.Set.empty


module Feature = struct
  (*
     Feature for partitioning states when conducting join operation
  *)
  type t = {is_exceptional: bool; is_patched: bool} [@@deriving compare]

  let pp fmt {is_exceptional; is_patched} = F.fprintf fmt "%b; %b" is_exceptional is_patched
end

module FeatureMap = PrettyPrintable.MakePPMap (Feature)

let partition_by_feature disjuncts =
  let add_state feature_map (astate : t) =
    let feature =
      Feature.
        { is_exceptional= astate.is_exceptional
        ; is_patched= astate.is_patched && is_affected_state astate }
    in
    match FeatureMap.find_opt feature feature_map with
    | Some states ->
        FeatureMap.add feature (astate :: states) feature_map
    | None ->
        FeatureMap.add feature [astate] feature_map
  in
  let feature_map = List.fold disjuncts ~init:FeatureMap.empty ~f:add_state in
  FeatureMap.fold (fun _ disjuncts acc -> disjuncts :: acc) feature_map []


let joinable lhs rhs =
  let debug_if_true msg b =
    L.d_printfln "@.%a and %a joinable on %s:@." pp_simple lhs pp_simple rhs msg ;
    b
  in
  let get_important_nulls astate =
    (* focus on the null values that are not inaccessed yet *)
    get_null_symbols astate |> Val.Set.filter (fun v -> not (Val.Set.mem v astate.nullified))
  in
  let has_diff_mem lhs rhs =
    Mem.exists
      (fun l v ->
        if Loc.is_return l then
          (* Two mem are different when their return values are different *)
          let lhs_const = equal_values lhs v |> List.filter ~f:Val.is_concrete in
          let rhs_const = equal_values rhs (Mem.find l rhs.mem) |> List.filter ~f:Val.is_concrete in
          not (List.equal Val.equal lhs_const rhs_const)
        else
          (* Two mem are different when some values in memory has different null constraint *)
          let v' = Mem.find l rhs.mem in
          (* if is_null lhs v && not (Val.Set.mem v lhs.nullified) then
               is_non_null rhs v' && not (Val.Set.mem v' rhs.nullified)
             else if is_non_null lhs v && not (Val.Set.mem v lhs.nullified) then
               is_null rhs v' && not (Val.Set.mem v' rhs.nullified) *)
          if is_null lhs v then is_non_null rhs v'
          else if is_non_null lhs v then is_null rhs v'
          else false)
      lhs.mem
  in
  if is_non_target_proc lhs.current_proc then true
  else if lhs.is_target && rhs.is_target then
    (* joinable checking is conducted only for the target methods *)
    if lhs.is_exceptional then
      (* when joining of exceptional states, consider only their exception types *)
      let both_runtime =
        RuntimeCrash.is_empty lhs.runtime_crash && RuntimeCrash.is_empty rhs.runtime_crash
      in
      let both_static =
        not (RuntimeCrash.is_empty lhs.runtime_crash || RuntimeCrash.is_empty rhs.runtime_crash)
      in
      ((both_runtime || both_static) && Val.equal (get_ret_value lhs) (get_ret_value rhs))
      |> debug_if_true "same exception type"
    else
      Val.Set.equal (get_important_nulls lhs) (get_important_nulls rhs)
      |> debug_if_true "same null values"
      && (not (has_diff_mem lhs rhs)) |> debug_if_true "similar memory state"
      && ((not (is_return_state lhs)) || (not (is_return_state rhs)) || PC.check_sat lhs.pc rhs.pc)
         |> debug_if_true "similar exit state"
  else true


let joinable lhs rhs = debug_time "Joinable" ~f:(joinable lhs) ~arg:rhs

(* TODO : how to join when one of states is a patched method *)
let weak_join lhs rhs : t =
  (* Assumption: lhs and rhs are joinable *)
  if phys_equal lhs rhs then (
    L.d_printfln "Two state are pyhsical equal" ;
    lhs )
  else if is_bottom lhs then (
    L.d_printfln "Right state is bottom" ;
    rhs )
  else if is_bottom rhs then (
    L.d_printfln "Left state is bottom" ;
    lhs )
  else
    let lhs_org, rhs_org = (lhs, rhs) in
    let lhs, rhs = unify lhs rhs in
    L.d_printfln " - Original Left - @.%a@." pp lhs_org ;
    L.d_printfln " - Unified Left - @.%a@." pp lhs ;
    L.d_printfln " - Original Right - @.%a@." pp rhs_org ;
    L.d_printfln " - Unified Right - @.%a@." pp rhs ;
    let reg = Reg.weak_join ~lhs:lhs.reg ~rhs:rhs.reg in
    let mem = Mem.weak_join ~lhs:lhs.mem ~rhs:rhs.mem ~current_proc:lhs.current_proc in
    let pc = PC.weak_join ~lhs:lhs.pc ~rhs:rhs.pc in
    let patch_info = PatchInfo.join lhs.patch_info rhs.patch_info in
    let accessed = AccessedLoc.join lhs.accessed rhs.accessed in
    let derefed_heaps = Val.Set.union lhs.derefed_heaps rhs.derefed_heaps in
    let is_exceptional = lhs.is_exceptional in
    let join_nulls lhs rhs =
      Val.Set.fold
        (fun v acc ->
          if Val.Set.exists (fun v' -> Val.equal_up_to_source v v') acc then acc
          else Val.Set.add v acc)
        lhs rhs
    in
    let uncaught_npes = join_nulls lhs.uncaught_npes rhs.uncaught_npes in
    let potential_npes = join_nulls lhs.potential_npes rhs.potential_npes in
    let nullified = join_nulls lhs.nullified rhs.nullified in
    let used_val_local = ValUse.join lhs.used_val_local rhs.used_val_local in
    let runtime_crash = RuntimeCrash.join lhs.runtime_crash rhs.runtime_crash in
    let value_dependency = ValDep.join lhs.value_dependency rhs.value_dependency in
    let joined =
      { reg
      ; mem
      ; pc
      ; patch_info
      ; is_target= lhs.is_target
      ; is_patched=
          lhs.is_patched || rhs.is_patched
          (* if non patch joined with patch it also affected by patch *)
      ; patch_score= (lhs.patch_score +. rhs.patch_score) /. 2.
      ; accessed
      ; derefed_heaps
      ; is_exceptional
      ; uncaught_npes
      ; potential_npes
      ; nullified
      ; used_val_local
      ; current_proc= lhs.current_proc
      ; runtime_crash
      ; value_dependency }
    in
    L.d_printfln " - Joined - @.%a@." pp joined ;
    joined


let merge disjuncts =
  let rec _merge worklist acc =
    match worklist with
    | [] ->
        acc
    | hd :: tl ->
        let joinable, unjoinable = List.partition_tf tl ~f:(joinable hd) in
        if List.is_empty joinable then _merge tl (hd :: acc)
        else
          let joined = List.fold joinable ~init:hd ~f:weak_join in
          _merge (joined :: unjoinable) acc
  in
  let partitioned = partition_by_feature disjuncts in
  let result = List.fold partitioned ~init:[] ~f:(fun acc disjuncts -> _merge disjuncts acc) in
  if Config.debug_mode && List.length result > 100 && false then (
    L.d_printfln " - Current States - @.%a@." (Pp.seq pp ~sep:"\n") result ;
    L.(die InternalError) "Too many states: %a" Procname.pp (List.hd_exn result).current_proc ) ;
  result
