open! IStd
open! Vocab
module F = Format
module L = Logging
module Domain = SpecCheckerDomain
open SymDom
open AccessAnalysis

module S = struct
  type t = {astate: Domain.t [@compare.ignore]; astate_with_local: Domain.t [@compare.ignore]}
  [@@deriving compare]

  let equal = [%compare.equal: t]

  let get_astate {astate} = astate

  let get_local_astate {astate_with_local} = astate_with_local

  let remove_temp_vars (Domain.{mem} as astate) =
    let temp_locs =
      Mem.fold
        (fun l _ acc ->
          match l with
          | Loc.TempVar pv ->
              (* if the temp var unused temp var (bcvar), it may be a dead code *)
              if not (is_bcvar pv) then Loc.Set.add l acc else acc
          | _ ->
              acc)
        mem Loc.Set.empty
    in
    let accessed =
      AccessAnalysis.AccessedLoc.
        { analysis=
            AccessAnalysis.AccessedLoc.DUMap.filter
              (fun (l, _) _ -> not (Loc.Set.mem l temp_locs))
              astate.accessed.analysis
        ; defmap=
            AccessAnalysis.AccessedLoc.DefMap.filter
              (fun l _ -> not (Loc.Set.mem l temp_locs))
              astate.accessed.defmap }
    in
    Domain.{astate with reg= Reg.empty; mem= Loc.Set.fold Mem.remove temp_locs mem; accessed}


  let from_state proc_desc astate =
    let astate_wo_temp = remove_temp_vars astate in
    let astate =
      (* if the return value is uninformative (extern symbol by join) converts it to uninterpreted format *)
      let astate_wo_local = Domain.remove_unreachables_summary astate_wo_temp proc_desc in
      let proc_name = Procdesc.get_proc_name proc_desc in
      let ret_typ, ret_loc =
        (Procdesc.get_ret_type proc_desc, Loc.of_pvar (Procdesc.get_ret_var proc_desc))
      in
      if not (Domain.is_unknown_loc astate_wo_local ret_loc) then
        let ret_val = Domain.read_loc ~typ:(Some ret_typ) astate_wo_local ret_loc in
        if Val.is_extern ret_val || Val.is_top ret_val then
          let formals = Procdesc.get_pvar_formals proc_desc in
          let arg_values =
            List.map formals ~f:(fun (pv, typ) ->
                match Val.symbol_from_loc_opt typ (Loc.of_pvar pv) with
                | Some symval ->
                    symval
                | None ->
                    Val.make_extern (InstrNode.dummy_of_proc proc_name) typ)
          in
          let call_value = Val.Vextern (proc_name, arg_values) in
          let call_cond = PathCond.make_physical_equals Binop.Eq ret_val call_value in
          Domain.add_pc_simple astate_wo_temp call_cond
        else astate_wo_local
      else astate_wo_local
    in
    { astate
    ; astate_with_local= Domain.remove_unreachables_summary ~is_local:true astate_wo_temp proc_desc
    }


  let pp fmt {astate_with_local} =
    F.fprintf fmt "== StateWithLocal ==@, %a" Domain.pp astate_with_local
end

type t = S.t list

let get_disjuncts t = List.map t ~f:S.get_astate

let get_local_disjuncts t = List.map t ~f:S.get_local_astate

let pp f t =
  let pp_elements f disjuncts =
    List.iteri disjuncts ~f:(fun i disjunct -> F.fprintf f "#%d: @[%a@]@;" i S.pp disjunct)
  in
  F.fprintf f "%d disjuncts:@.%a@." (List.length t) pp_elements t


type get_summary = Procname.t -> t option

let empty : t = []

let to_summary proc_desc disjuncts =
  (* filter invalid states *)
  L.(debug Analysis Quiet)
    "@.---- Analysis time result of %a ----@." Procname.pp
    (Procdesc.get_proc_name proc_desc) ;
  debug_time_finalize () ;
  let summary = List.map ~f:(S.from_state proc_desc) disjuncts in
  (* L.progress "State pruning : %d -> %d of %a@." (List.length disjuncts_local_removed) (List.length summary)
     Procname.pp (Procdesc.get_proc_name proc_desc) ; *)
  summary


let caller_counter = ref 0

let append_ctx astate =
  caller_counter := !caller_counter + 1 ;
  Domain.append_ctx astate !caller_counter


module SymResolvedMap = struct
  (* Summary resolve *)
  include PrettyPrintable.MakePPMonoMap (Symbol) (Val)

  let __cache = ref empty

  let __astate = ref Domain.bottom

  let init astate ~formals ~actual_values =
    let init_sym_resolved_map =
      List.fold2_exn formals actual_values ~init:empty ~f:(fun sym_resolved_map (fv, _) v ->
          add (Symbol.of_pvar fv) v sym_resolved_map)
    in
    __cache := init_sym_resolved_map ;
    __astate := astate ;
    L.d_printfln
      "[DEBUG]: init sym_resolved_map@. \n\
      \      - Formals: %a@.\n\
      \      - Sym Resolved Map: %a@.\n\
      \      ====================================@."
      (Pp.seq (Pvar.pp Pp.text))
      (List.map ~f:fst formals) pp init_sym_resolved_map


  let rec find ?(typ = None) (base, accesses) =
    match find_opt (base, accesses) !__cache with
    | Some v ->
        v
    | None ->
        (* L.d_printfln "[Here]: resolve @,- base: %a - accesses %a@." Symbol.pp_base base
           (Pp.seq Symbol.pp_access) accesses ; *)
        let resolved_val =
          match (base, List.rev accesses) with
          | Symbol.Global (pv, Symbol.Field fn), [] ->
              Domain.read_loc ~typ !__astate (Loc.of_pvar pv |> Loc.append_field ~fn)
          | Symbol.Global (_, Symbol.Index _), [] ->
              L.(die InternalError) "Invalid symbol"
          | Symbol.Param _, [] ->
              L.(die InternalError)
                "Initial Parameter should be initialized before find %a@.%a@." Symbol.pp
                (base, accesses) pp !__cache
          | base, Symbol.Field fn :: remain ->
              let base_loc = find ~typ:(Some Typ.void_star) (base, List.rev remain) |> Val.to_loc in
              let resolved_loc = Loc.append_field ~fn base_loc in
              Domain.read_loc ~typ !__astate resolved_loc
          | base, Symbol.Index index :: remain ->
              let base_loc = find ~typ:(Some Typ.void_star) (base, List.rev remain) |> Val.to_loc in
              let resolved_loc = Loc.append_index base_loc ~index:(SymExp.of_intlit index) in
              Domain.read_loc ~typ !__astate resolved_loc
        in
        (* L.d_printfln "[DEBUG]: resolve %a to %a@." Symbol.pp (base, accesses) Val.pp resolved_val ; *)
        __cache := add (base, accesses) resolved_val !__cache ;
        resolved_val


  let resolve_val =
    Val.replace_by_map ~f:(function
      | Val.Vint (SymExp.Symbol s) ->
          find ~typ:(Some Typ.int) s
      | Val.Vheap (SymHeap.Symbol s) ->
          find ~typ:(Some Typ.void_star) s
      | v ->
          v)


  let resolve_loc =
    Loc.replace_by_map ~f:(function
      | Loc.SymHeap (Symbol s) -> (
        match find ~typ:(Some Typ.void_star) s with
        | Val.Vheap sh ->
            Loc.SymHeap sh
        | v ->
            raise (Unexpected (F.asprintf "%a is cannot resolved as loc" Val.pp v)) )
      | l ->
          l)


  let resolve_pc = PC.replace_by_map ~f:resolve_val

  let resolve_accessed ({analysis; defmap} : AccessedLoc.t) =
    let analysis =
      AccessedLoc.DUMap.fold
        (fun (loc, line) state_callee ->
          let l' = resolve_loc loc in
          AccessedLoc.DUMap.add (l', line) state_callee)
        analysis AccessedLoc.DUMap.empty
    in
    let defmap =
      AccessedLoc.DefMap.fold
        (fun loc lines ->
          let l' = resolve_loc loc in
          AccessedLoc.DefMap.add l' lines)
        defmap AccessedLoc.DefMap.empty
    in
    AccessedLoc.{analysis; defmap}


  let resolve_valset = Val.Set.map resolve_val

  let resolve_state astate : Domain.t =
    try
      L.d_printfln "Callee summary to resolve :@, - %a @." Domain.pp astate ;
      let open Domain in
      let reg = Reg.empty in
      let mem =
        Mem.fold
          (fun l v acc ->
            (* some l.f could be resolved to null.f, but does not mean the state is invalid *)
            let resolved_loc = resolve_loc l in
            let resolved_val = resolve_val v in
            Mem.strong_update resolved_loc resolved_val acc)
          astate.mem Mem.empty
      in
      let pc = resolve_pc astate.pc in
      let patch_info = PatchInfo.map (fun vset -> resolve_valset vset) astate.patch_info in
      let accessed = resolve_accessed astate.accessed in
      let derefed_heaps = resolve_valset astate.derefed_heaps in
      let potential_npes = resolve_valset astate.potential_npes in
      let uncaught_npes = resolve_valset astate.uncaught_npes in
      let astate' =
        { reg
        ; mem
        ; pc
        ; patch_info
        ; accessed
        ; derefed_heaps
        ; uncaught_npes
        ; potential_npes
        ; nullified= astate.nullified
        ; used_val_local= astate.used_val_local
        ; is_target= astate.is_target
        ; is_patched= astate.is_patched
        ; patch_score= astate.patch_score
        ; is_exceptional= astate.is_exceptional
        ; current_proc= astate.current_proc
        ; runtime_crash= astate.runtime_crash
        ; value_dependency= astate.value_dependency }
      in
      L.d_printfln "Callee summary after resolving :@, - %a @." Domain.pp astate' ;
      astate'
    with Unexpected msg ->
      L.d_printfln
        "[WARING]: Failed to resolve the caller summary %a@. Sym_resolved_map : %a @.Callee mem : \
         %a@. Caller mem: %a@. Msg: %s@."
        Domain.pp astate pp !__cache Mem.pp
        Domain.(astate.mem)
        Mem.pp
        Domain.(!__astate.mem)
        msg ;
      {Domain.bottom with pc= PC.invalid}
end

let resolve_callee_state astate ~actual_values ~callee_pdesc callee_summaries =
  let formals = Procdesc.get_pvar_formals callee_pdesc in
  L.d_printfln "Callee summaries to resovle :@, %a" pp callee_summaries ;
  let callee_unreachable_removed =
    get_disjuncts callee_summaries |> List.map ~f:append_ctx
    |> List.filter ~f:(fun astate -> not (Domain.is_exceptional astate))
  in
  SymResolvedMap.init astate ~formals ~actual_values ;
  List.map callee_unreachable_removed ~f:SymResolvedMap.resolve_state


let update_caller_by_callee ~caller_state ~callee_state ~caller_pdesc ~callee_pdesc (ret_id, ret_typ)
    =
  let open Domain in
  let caller_state, callee_state =
    let ret_var = Procdesc.get_ret_var callee_pdesc in
    let return_value =
      let retval = Domain.read_loc ~typ:(Some ret_typ) callee_state (Loc.of_pvar ret_var) in
      if Domain.Val.equal Domain.Val.top retval then
        Val.make_extern (InstrNode.dummy_of_proc caller_state.current_proc) ret_typ
      else retval
    in
    let astate_ret_binded =
      if Domain.is_exceptional callee_state then
        let caller_ret_loc = Procdesc.get_ret_var caller_pdesc |> Loc.of_pvar in
        Domain.store_loc caller_state caller_ret_loc return_value
      else Domain.store_reg caller_state ret_id return_value
    in
    (astate_ret_binded, Domain.remove_locals ~pdesc:callee_pdesc callee_state)
  in
  L.d_printfln " * Callee after local remove@, %a@. * Caller to update :@, %a@." pp callee_state pp
    caller_state ;
  let mem = Mem.fold (fun l v -> Mem.strong_update l v) callee_state.mem caller_state.mem in
  let pc = PC.update_to ~src:callee_state.pc ~dst:caller_state.pc in
  let accessed =
    (* Callee def-use analysis only retains the symbolic location
        * if a loc newly defined at callee => strong update to caller (side effect)
        * if the def-use state is in the caller state => update all possible locs of caller
        * if the symbol is not defined at caller => generate new def-use state with caller dummy
    *)
    let analysis =
      let proc_caller = caller_state.current_proc in
      let dummy_line = AccessAnalysis.dummy_line in
      let callee_to_resolve, callee_local =
        AccessedLoc.DUMap.partition
          (fun (_, (_, line)) _ -> Int.equal line dummy_line)
          callee_state.accessed.analysis
      in
      AccessedLoc.DUMap.fold
        (fun def_callee du_callee acc -> AccessedLoc.DUMap.strong_update def_callee du_callee acc)
        callee_local caller_state.accessed.analysis
      |> AccessedLoc.DUMap.fold
           (fun (loc_callee, (_, _)) du_callee acc ->
             let new_key = (loc_callee, (proc_caller, dummy_line)) in
             if
               AccessedLoc.DUMap.exists
                 (fun (loc_caller, _) _ -> Loc.equal loc_callee loc_caller)
                 acc
             then
               match du_callee with
               | AccessState.Must ->
                   (* if the loc is always used in callee, update it must be used *)
                   AccessedLoc.DUMap.strong_update new_key AccessState.Must acc
               | _ ->
                   AccessedLoc.DUMap.weak_update new_key du_callee acc
             else AccessedLoc.DUMap.strong_update new_key du_callee acc)
           callee_to_resolve
    in
    let defmap = caller_state.accessed.defmap in
    AccessedLoc.{analysis; defmap}
  in
  let derefed_heaps = Val.Set.union caller_state.derefed_heaps callee_state.derefed_heaps in
  let uncaught_npes =
    Domain.set_npes caller_state.uncaught_npes (Val.Set.elements callee_state.uncaught_npes)
  in
  let potential_npes =
    let nulls_callee =
      Val.Set.filter (not <<< Domain.is_non_null caller_state) callee_state.potential_npes
    in
    Domain.set_npes caller_state.potential_npes (Val.Set.elements nulls_callee)
  in
  let astate' =
    { reg= caller_state.reg
    ; mem
    ; pc
    ; accessed
    ; derefed_heaps
    ; uncaught_npes
    ; potential_npes
    ; patch_info= caller_state.patch_info
    ; is_target= caller_state.is_target
    ; is_patched=
        caller_state.is_patched || callee_state.is_patched (* propagate patch state from callee *)
    ; patch_score= caller_state.patch_score *. callee_state.patch_score
    ; is_exceptional= caller_state.is_exceptional || callee_state.is_exceptional
    ; nullified= caller_state.nullified
    ; used_val_local= caller_state.used_val_local
    ; current_proc= caller_state.current_proc
    ; runtime_crash= caller_state.runtime_crash
    ; value_dependency= caller_state.value_dependency }
  in
  if PC.is_invalid pc then (
    L.d_printfln "@.===== Summary is invalidated by pathcond =====@." ;
    L.d_printfln " - resolved state: %a@." pp astate' ;
    L.d_printfln " - callee state: %a@." pp callee_state ;
    None )
  else (* Some (remove_unreachables_summary ~is_local:true astate' caller_pdesc) *)
    Some astate'
