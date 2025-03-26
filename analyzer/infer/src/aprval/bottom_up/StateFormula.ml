open! IStd
open! Vocab
module L = Logging
open SymDom
open AccessAnalysis
open ValueAnalysis
module Domain = SpecCheckerDomain
module AccessedAP = AccessAnalysis.AccessedAP
module APUse = ValueAnalysis.APUse
module APDep = ValueAnalysis.APDep
module APSet = AccessExpr.AbsSet
module APMem = ValToAP.APMem
module Formula = ValToAP.Formula

module Spec = struct
  type t =
    { pdesc: Procdesc.t [@compare.ignore]
    ; is_exceptional: AbsBool.t
    ; is_patch: bool
    ; pc: Formula.t
    ; mem: APMem.t
    ; uncaught_npes: APSet.t
    ; potential_npes: APSet.t
    ; runtime_crash: RuntimeCrash.t
    ; used_val_local: APUse.t
    ; accessed: AccessedAP.t
    ; derefed: APSet.t
    ; ap_dep: APDep.t }
  [@@deriving compare]

  let pp fmt
      { pdesc
      ; is_exceptional
      ; is_patch
      ; pc
      ; mem
      ; uncaught_npes
      ; potential_npes
      ; runtime_crash
      ; accessed
      ; ap_dep
      ; derefed
      ; used_val_local } =
    F.fprintf fmt
      "\n\
      \    - Target Proc:@,\
      \   %a@,\n\
      \    - Is Exceptional?:@,\
      \   %a@,\n\
      \    - Is Patch?:@,\
      \   %b@,\n\
      \    - Formula:@,\
      \   %a@,\n\
      \     - Local Mem:@,\
      \   %a@,\n\
      \     - Uncaught NPES:@,\
      \   %a@,\n\
      \     - Potential NPES:@,\
      \   %a@,\n\
      \     - Runtime Crash:@,\
      \   %a@,\n\
      \     - Accessed Exprs:@,\
      \   %a@.\n"
      Procdesc.pp_signature pdesc AbsBool.pp is_exceptional is_patch Formula.pp_set pc APMem.pp mem
      APSet.pp uncaught_npes APSet.pp potential_npes RuntimeCrash.pp runtime_crash AccessedAP.pp
      accessed


  let do_work Domain.{mem; pc} val_to_ap : ValToAP.t =
    ValToAP.update_by_mem mem val_to_ap |> ValToAP.update_by_pc pc


  let rec do_worklist astate acc =
    let acc' = do_work astate acc in
    L.progress "Val to AP Cur : %a@." ValToAP.pp acc' ;
    if ValToAP.equal APSet.equal acc acc' then acc else do_worklist astate acc'


  let get_ret_loc t = AccessExpr.get_ret t.pdesc

  let get_ret_vals t = APMem.find (get_ret_loc t) t.mem

  let get_error_infos {runtime_crash} = runtime_crash

  let get_uncaught_npes {uncaught_npes} = uncaught_npes

  let get_formals {pdesc} = APSet.of_list (AccessExpr.get_formals pdesc)

  let get_locals {pdesc} = APSet.of_list (AccessExpr.get_locals pdesc)

  let get_field_accesses {mem; accessed} =
    let add_if_field ap_loc =
      if AccessExpr.contains_field_access ap_loc then APSet.add ap_loc else fun x -> x
    in
    APMem.fold (fun ap_loc _ -> add_if_field ap_loc) mem APSet.empty
    |> AccessedAP.fold (fun (ap_loc, _) _ -> add_if_field ap_loc) accessed


  let from_state proc_desc (astate_local : Domain.t) : t =
    let val_to_ap = do_worklist astate_local ValToAP.empty in
    set_msg_debugger
      (F.asprintf "=========================original state (%a) ================@.%a@."
         Procdesc.pp_signature proc_desc Domain.pp astate_local) ;
    set_msg_debugger (F.asprintf "ValToAP: %a@." ValToAP.pp val_to_ap) ;
    (* L.progress "ValToAP: %a@." ValToAP.pp val_to_ap_public ; *)
    let mem =
      let ret_loc = AccessExpr.get_ret proc_desc in
      let mem = APMem.construct val_to_ap astate_local.mem in
      (* if the return is not exists (void method) explicitly make return location *)
      if APMem.mem ret_loc mem then mem else APMem.add ret_loc (APSet.singleton ret_loc) mem
    in
    let find_ap_heaps nullptrs =
      Val.Set.fold
        (fun v acc ->
          let ap_of_null =
            ValToAP.find v val_to_ap
            |> APSet.filter (fun ap ->
                   (not (AccessExpr.is_concrete ap)) && not (AccessExpr.contains_method_access ap))
          in
          APSet.union acc ap_of_null)
        nullptrs APSet.empty
    in
    let pc_formula = Formula.construct val_to_ap astate_local.pc in
    L.progress "PC Formula %a@." Formula.pp_set pc_formula ;
    let uncaught_npes = find_ap_heaps astate_local.uncaught_npes in
    let potential_npes = find_ap_heaps astate_local.potential_npes in
    let derefed = find_ap_heaps astate_local.derefed_heaps in
    let used_val_local = APUse.construct val_to_ap astate_local.used_val_local in
    let accessed = AccessedAP.construct val_to_ap astate_local.accessed.analysis in
    let ap_dep = APDep.construct val_to_ap astate_local.value_dependency in
    let r =
      { pdesc= proc_desc
      ; is_exceptional= AbsBool.v astate_local.is_exceptional
      ; is_patch= astate_local.is_patched && Domain.is_affected_state astate_local
      ; pc= pc_formula
      ; mem
      ; uncaught_npes
      ; potential_npes
      ; derefed
      ; runtime_crash= astate_local.runtime_crash
      ; used_val_local
      ; accessed
      ; ap_dep }
    in
    set_msg_debugger
      (F.asprintf "=========================convertion result ================@.%a@." pp r) ;
    r


  let check_valid t1 t2 = Formula.check_sat t1.pc t2.pc

  let joinable lhs rhs =
    check_valid lhs rhs
    && AbsBool.equal lhs.is_exceptional rhs.is_exceptional
    && Bool.equal lhs.is_patch rhs.is_patch


  let join lhs rhs =
    let pdesc = lhs.pdesc in
    let is_exceptional = AbsBool.join lhs.is_exceptional rhs.is_exceptional in
    let pc = Formula.weak_join ~lhs:lhs.pc ~rhs:rhs.pc in
    let mem = APMem.join lhs.mem rhs.mem in
    let uncaught_npes = APSet.union lhs.uncaught_npes rhs.uncaught_npes in
    let potential_npes = APSet.union lhs.potential_npes rhs.potential_npes in
    let derefed = APSet.union lhs.derefed rhs.derefed in
    let runtime_crash = RuntimeCrash.union lhs.runtime_crash rhs.runtime_crash in
    let used_val_local = APUse.join lhs.used_val_local rhs.used_val_local in
    let accessed = AccessedAP.join lhs.accessed rhs.accessed in
    let ap_dep = APDep.join lhs.ap_dep rhs.ap_dep in
    { pdesc
    ; is_exceptional
    ; is_patch= lhs.is_patch
    ; pc
    ; mem
    ; derefed
    ; uncaught_npes
    ; potential_npes
    ; runtime_crash
    ; used_val_local
    ; accessed
    ; ap_dep }


  let is_exceptional spec = spec.is_exceptional
end

module Specs = struct
  include PrettyPrintable.MakePPSet (Spec)

  let from_disjuncts proc_desc disjuncts =
    List.map disjuncts ~f:(Spec.from_state proc_desc) |> of_list


  let merge specs =
    let rec _merge worklist acc =
      match worklist with
      | [] ->
          acc
      | hd :: tl ->
          let joinable, unjoinable = List.partition_tf tl ~f:(Spec.joinable hd) in
          if List.is_empty joinable then _merge tl (hd :: acc)
          else
            let joined = List.map joinable ~f:(Spec.join hd) in
            _merge (joined @ unjoinable) acc
    in
    _merge (elements specs) [] |> of_list


  let merge_all specs =
    let spec = choose specs in
    fold (fun spec rhs -> Spec.join spec rhs) (remove spec specs) spec


  let pp fmt specs =
    let pp_elements fmt specs =
      List.iteri (elements specs) ~f:(fun i spec -> F.fprintf fmt "#%d: @[%a@]@;" i Spec.pp spec)
    in
    F.fprintf fmt "%d specs:@.%a@." (cardinal specs) pp_elements specs
end

module SpecMap = struct
  include PrettyPrintable.MakePPMonoMap (Procname) (Specs)

  (* cacheing the spec of original program for patch analysis *)
  let cache = ref empty

  let marshalled_path = Filename.concat Config.aprval_org_dir "spec_origin.data"

  let to_marshal spec_org =
    Utils.with_file_out marshalled_path ~f:(fun oc -> Marshal.to_channel oc spec_org [])


  let create ~get_summary =
    let program = Program.from_marshal () in
    let patch = Patch.from_marshal () in
    let target_procs = Patch.get_target_procs patch in
    Procname.Set.fold
      (fun target_proc spec_map ->
        match get_summary target_proc with
        | Some summary ->
            let target_pdesc = Program.pdesc_of program target_proc in
            (* Extract specs of original *)
            let analysis_target =
              if Config.aprval_launch_spec_inference then "origin" else "patch"
            in
            msg_task := F.asprintf "spec_%s_%a" analysis_target Procname.pp target_proc ;
            let specs =
              SpecCheckerSummary.get_local_disjuncts summary |> Specs.from_disjuncts target_pdesc
            in
            (*
            Vocab.print_to_file ~dirname:(Some Config.aprval_summary_dir)
              ~msg:(Format.asprintf "%a" Specs.pp specs_buggy)
              ~filename:(Format.asprintf "specs_of_%a" Procname.pp target_proc) ;
            Vocab.print_to_file ~dirname:(Some Config.aprval_result_dir)
              ~msg:(Format.asprintf "%a" Specs.pp specs_patch)
              ~filename:(Format.asprintf "specs_of_%a" Procname.pp target_proc) ;
            *)
            add target_proc specs spec_map
        | None ->
            spec_map)
      target_procs empty


  let from_marshal () =
    if is_empty !cache then (
      let spec_org =
        try Utils.with_file_in marshalled_path ~f:Marshal.from_channel
        with _ -> L.(die InternalError) "Original program is not analyzed yet@."
      in
      cache := spec_org ;
      spec_org )
    else !cache
end
