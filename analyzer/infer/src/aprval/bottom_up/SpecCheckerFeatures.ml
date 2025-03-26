open! IStd
open! Vocab
module F = Format
module L = Logging
module APMem = StateFormula.APMem
module APUse = ValueAnalysis.APUse
module APDep = ValueAnalysis.APDep
module UseCase = ValueAnalysis.UseCase
module AccessState = AccessAnalysis.AccessState
module AccessedAP = StateFormula.AccessedAP
module APSet = StateFormula.APSet
module APDefSet = AccessedAP.APDefSet
module Spec = StateFormula.Spec
open Spec

type change = bool * bool * bool

type exec = Spec.t -> Spec.t -> change

type model = string * exec

let checker ~pred ~typ ~f_name target =
  (* typ : Gen, Rm, Remain *)
  APSet.exists
    (fun ap ->
      let r = pred ap in
      if r then set_msg_debugger (F.asprintf "[%s] %s: %a@." typ f_name AccessExpr.pp ap) ;
      r)
    target


let check_gen ~pred ~f_name target = checker ~pred ~typ:"Gen" ~f_name target

let check_rm ~pred ~f_name target = checker ~pred ~typ:"Rm" ~f_name target

let check_remain ~pred ~f_name target = checker ~pred ~typ:"Remain" ~f_name target

let pp_change fmt (gen, remove, remain) =
  F.fprintf fmt "{Gen: %b, Remove: %b, Remain: %b}" gen remove remain


(* unused variable (local, param, this, static field) *)
module DefUse = struct
  let get_all_local_acc spec =
    AccessedAP.fold
      (fun (ap_loc, line) _ acc ->
        if AccessExpr.is_local spec.pdesc ap_loc then APDefSet.add (ap_loc, line) acc else acc)
      spec.accessed APDefSet.empty


  let get_all_param_acc spec =
    AccessedAP.fold
      (fun (ap_loc, line) _ acc ->
        if AccessExpr.is_param spec.pdesc ap_loc then APDefSet.add (ap_loc, line) acc else acc)
      spec.accessed APDefSet.empty


  let get_all_fn_acc spec =
    AccessedAP.fold
      (fun (ap_loc, line) _ acc ->
        if AccessExpr.contains_field_access ap_loc then APDefSet.add (ap_loc, line) acc else acc)
      spec.accessed APDefSet.empty


  let defined_local spec_buggy spec_patch =
    let locals = APDefSet.union (get_all_local_acc spec_buggy) (get_all_local_acc spec_patch) in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_def du_buggy du_patch) locals in
    let rm = APDefSet.exists (AccessedAP.check_rm_def du_buggy du_patch) locals in
    let remain = APDefSet.exists (AccessedAP.check_remain_def du_buggy du_patch) locals in
    set_msg_debugger (F.asprintf "[Feature] defined local: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let used_local spec_buggy spec_patch =
    let locals = APDefSet.union (get_all_local_acc spec_buggy) (get_all_local_acc spec_patch) in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_used du_buggy du_patch) locals in
    let rm = APDefSet.exists (AccessedAP.check_rm_used du_buggy du_patch) locals in
    let remain = APDefSet.exists (AccessedAP.check_remain_used du_buggy du_patch) locals in
    set_msg_debugger (F.asprintf "[Feature] used local: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let unused_local spec_buggy spec_patch =
    let locals = APDefSet.union (get_all_local_acc spec_buggy) (get_all_local_acc spec_patch) in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_unused du_buggy du_patch) locals in
    let rm = APDefSet.exists (AccessedAP.check_rm_unused du_buggy du_patch) locals in
    let remain = APDefSet.exists (AccessedAP.check_remain_unused du_buggy du_patch) locals in
    set_msg_debugger (F.asprintf "[Feature] unused local: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let used_param spec_buggy spec_patch =
    let params =
      get_all_param_acc spec_buggy
      |> APDefSet.filter (fun (ap_loc, _) -> not (AccessExpr.is_this ap_loc))
    in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_used du_buggy du_patch) params in
    let rm = APDefSet.exists (AccessedAP.check_rm_used du_buggy du_patch) params in
    let remain = APDefSet.exists (AccessedAP.check_remain_used du_buggy du_patch) params in
    set_msg_debugger (F.asprintf "[Feature] used param: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let unused_param spec_buggy spec_patch =
    let params =
      get_all_param_acc spec_buggy
      |> APDefSet.filter (fun (ap_loc, _) -> not (AccessExpr.is_this ap_loc))
    in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_unused du_buggy du_patch) params in
    let rm = APDefSet.exists (AccessedAP.check_rm_unused du_buggy du_patch) params in
    let remain = APDefSet.exists (AccessedAP.check_remain_unused du_buggy du_patch) params in
    set_msg_debugger (F.asprintf "[Feature] unused param: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let used_this spec_buggy spec_patch =
    let target =
      get_all_param_acc spec_buggy |> APDefSet.filter (fun (ap_loc, _) -> AccessExpr.is_this ap_loc)
    in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_used du_buggy du_patch) target in
    let rm = APDefSet.exists (AccessedAP.check_rm_used du_buggy du_patch) target in
    let remain = APDefSet.exists (AccessedAP.check_remain_used du_buggy du_patch) target in
    set_msg_debugger (F.asprintf "[Feature] used this: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let unused_this spec_buggy spec_patch =
    let target =
      get_all_param_acc spec_buggy |> APDefSet.filter (fun (ap_loc, _) -> AccessExpr.is_this ap_loc)
    in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_unused du_buggy du_patch) target in
    let rm = APDefSet.exists (AccessedAP.check_rm_unused du_buggy du_patch) target in
    let remain = APDefSet.exists (AccessedAP.check_remain_unused du_buggy du_patch) target in
    set_msg_debugger (F.asprintf "[Feature] unused this: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let used_fn spec_buggy spec_patch =
    let targets = APDefSet.union (get_all_fn_acc spec_buggy) (get_all_fn_acc spec_patch) in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_used du_buggy du_patch) targets in
    let rm = APDefSet.exists (AccessedAP.check_rm_used du_buggy du_patch) targets in
    let remain = APDefSet.exists (AccessedAP.check_remain_used du_buggy du_patch) targets in
    set_msg_debugger (F.asprintf "[Feature] used fn: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let unused_fn spec_buggy spec_patch =
    let targets = APDefSet.union (get_all_fn_acc spec_buggy) (get_all_fn_acc spec_patch) in
    let du_buggy, du_patch = (spec_buggy.accessed, spec_patch.accessed) in
    let gen = APDefSet.exists (AccessedAP.check_gen_unused du_buggy du_patch) targets in
    let rm = APDefSet.exists (AccessedAP.check_rm_unused du_buggy du_patch) targets in
    let remain = APDefSet.exists (AccessedAP.check_remain_unused du_buggy du_patch) targets in
    set_msg_debugger (F.asprintf "[Feature] unused fn: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let models =
    [ ("defined_local", defined_local)
    ; ("used_local", used_local)
    ; ("unused_local", unused_local)
    ; ("used_param", used_param)
    ; ("unused_param", unused_param)
      (* ; ("used_this", used_this)
         ; ("unused_this", unused_this) *)
    ; ("used_fn", used_fn)
    ; ("unused_fn", unused_fn) ]
end

module Crash = struct
  open RuntimeCrash

  let npe spec_buggy spec_patch =
    let f_name = "NPE" in
    let gen =
      check_gen
        ~pred:(fun ap ->
          if APSet.mem ap spec_buggy.potential_npes && AccessExpr.is_formal ap then
            AccessExpr.contains_field_access ap
          else not (APSet.mem ap spec_buggy.uncaught_npes))
        ~f_name spec_patch.uncaught_npes
    in
    let rm =
      let npe_patch = APSet.union spec_patch.uncaught_npes spec_patch.potential_npes in
      check_rm ~pred:(fun ap -> not (APSet.mem ap npe_patch)) ~f_name spec_buggy.uncaught_npes
    in
    let remain =
      (* heuristic: to capture the remaining npe by simply removing null-handling code *)
      check_remain
        ~pred:(fun ap ->
          APSet.mem ap spec_patch.uncaught_npes || APSet.mem ap spec_patch.potential_npes)
        ~f_name spec_buggy.uncaught_npes
    in
    set_msg_debugger (F.asprintf "[Feature] npe: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  (* consider as the result is set
     : only contains the call cites with no modification and affection *)
  let gen_crash ~crash_name errs_org errs_patch =
    exists
      (fun ({is_modified; is_affected} as err_patch) ->
        if is_modified || is_affected then (
          let errs_org = filter (fun err_org -> V.is_comparable err_org err_patch) errs_org in
          let r = is_empty errs_org in
          if r then set_msg_debugger (F.asprintf "[Gen] %s: %a@." crash_name V.pp err_patch) ;
          r )
        else false)
      errs_patch


  let rm_crash ~crash_name errs_org errs_patch =
    exists
      (fun ({is_modified; is_affected} as err_org) ->
        let errs_patch = filter (V.is_comparable err_org) errs_patch in
        let r =
          for_all (fun err_patch -> V.is_modified err_patch || V.is_affected err_patch) errs_patch
          || is_modified || is_affected
        in
        if r then set_msg_debugger (F.asprintf "[Rm] %s: %a@." crash_name V.pp err_org) ;
        r)
      errs_org


  let remain_crash ~crash_name errs_org errs_patch =
    (* if the crash remains after patch, it satisfies the following conditions:
       1. the function call at error location is unpatched and unaffected in org or patch *)
    exists
      (fun ({is_modified; is_affected} as err_org) ->
        let errs_patch = filter (V.is_comparable err_org) errs_patch in
        let r =
          (not (is_empty errs_patch))
          && for_all
               (fun err_patch -> not (V.is_modified err_patch || V.is_affected err_patch))
               errs_patch
          && not (is_modified || is_affected)
        in
        if r then set_msg_debugger (F.asprintf "[Remain] %s: %a@." crash_name V.pp err_org) ;
        r)
      errs_org


  let illegal_call spec_buggy spec_patch =
    let crash_name = "Illegal Call" in
    let errs_org = filter RuntimeCrash.V.is_crash_call spec_buggy.runtime_crash in
    let errs_patch = filter RuntimeCrash.V.is_crash_call spec_patch.runtime_crash in
    let gen = gen_crash ~crash_name errs_org errs_patch in
    let rm = rm_crash ~crash_name errs_org errs_patch in
    let remain = remain_crash ~crash_name errs_org errs_patch in
    set_msg_debugger (F.asprintf "[Feature] illegal_call: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let out_of_bound spec_buggy spec_patch =
    let crash_name = "AOB" in
    let errs_org = filter RuntimeCrash.V.is_oob spec_buggy.runtime_crash in
    let errs_patch = filter RuntimeCrash.V.is_oob spec_patch.runtime_crash in
    let gen = gen_crash ~crash_name errs_org errs_patch in
    let rm = rm_crash ~crash_name errs_org errs_patch in
    let remain = remain_crash ~crash_name errs_org errs_patch in
    set_msg_debugger (F.asprintf "[Feature] out_of_bound: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let throwable_exn spec_buggy spec_patch =
    let f_name = "Throwable" in
    let exns_org, exns_patch =
      ( get_ret_vals spec_buggy |> APSet.filter AccessExpr.is_exn
      , get_ret_vals spec_patch |> APSet.filter AccessExpr.is_exn )
    in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap exns_org)) ~f_name exns_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap exns_patch)) ~f_name exns_org in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap exns_patch) ~f_name exns_org in
    (gen, rm, remain)


  let models =
    [ ("throwable_exn", throwable_exn)
    ; ("npe", npe)
    ; ("illegal_call", illegal_call)
    ; ("out_of_bound", out_of_bound) ]
end

module Memory = struct
  (* features about memory state *)
  let get_loc_by f mem =
    APMem.fold (fun ap vset acc -> if f ap vset then APSet.add ap acc else acc) mem APSet.empty


  let local_null spec_buggy spec_patch =
    let f spec ap vset =
      AccessExpr.is_local spec.pdesc ap
      && (not (AccessExpr.is_return spec.pdesc ap))
      && APSet.exists AccessExpr.is_null vset
    in
    let aps_buggy, aps_patch =
      (get_loc_by (f spec_buggy) spec_buggy.mem, get_loc_by (f spec_patch) spec_patch.mem)
    in
    let f_name = "local_null" in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap aps_buggy)) ~f_name aps_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap aps_patch)) ~f_name aps_buggy in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap aps_patch) ~f_name aps_buggy in
    set_msg_debugger (F.asprintf "[Feature] local_null: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let ret_null spec_buggy spec_patch =
    let f spec ap vset =
      AccessExpr.is_return spec.pdesc ap && APSet.exists AccessExpr.is_null vset
    in
    let aps_buggy, aps_patch =
      (get_loc_by (f spec_buggy) spec_buggy.mem, get_loc_by (f spec_patch) spec_patch.mem)
    in
    let f_name = "ret_null" in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap aps_buggy)) ~f_name aps_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap aps_patch)) ~f_name aps_buggy in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap aps_patch) ~f_name aps_buggy in
    set_msg_debugger (F.asprintf "[Feature] ret_null: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let fn_null spec_buggy spec_patch =
    let f ap vset =
      AccessExpr.contains_field_access ap
      && APSet.exists (fun v -> AccessExpr.is_null v && AccessExpr.is_constant v) vset
    in
    let aps_buggy, aps_patch = (get_loc_by f spec_buggy.mem, get_loc_by f spec_patch.mem) in
    let f_name = "fn_null" in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap aps_buggy)) ~f_name aps_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap aps_patch)) ~f_name aps_buggy in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap aps_patch) ~f_name aps_buggy in
    set_msg_debugger (F.asprintf "[Feature] fn_null: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let local_const spec_buggy spec_patch =
    let f spec ap vset =
      AccessExpr.is_local spec.pdesc ap
      && (not (AccessExpr.is_return spec.pdesc ap))
      && APSet.exists (fun ap -> AccessExpr.is_constant ap && not (AccessExpr.is_null ap)) vset
    in
    let aps_buggy, aps_patch =
      (get_loc_by (f spec_buggy) spec_buggy.mem, get_loc_by (f spec_patch) spec_patch.mem)
    in
    let f_name = "local_const" in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap aps_buggy)) ~f_name aps_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap aps_patch)) ~f_name aps_buggy in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap aps_patch) ~f_name aps_buggy in
    set_msg_debugger (F.asprintf "[Feature] local_const: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let ret_const spec_buggy spec_patch =
    let f spec ap vset =
      AccessExpr.is_return spec.pdesc ap
      && APSet.exists (fun ap -> AccessExpr.is_constant ap && not (AccessExpr.is_null ap)) vset
    in
    let aps_buggy, aps_patch =
      (get_loc_by (f spec_buggy) spec_buggy.mem, get_loc_by (f spec_patch) spec_patch.mem)
    in
    let f_name = "ret_const" in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap aps_buggy)) ~f_name aps_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap aps_patch)) ~f_name aps_buggy in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap aps_patch) ~f_name aps_buggy in
    set_msg_debugger (F.asprintf "[Feature] ret_const: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let fn_const spec_buggy spec_patch =
    let f ap vset =
      AccessExpr.contains_field_access ap
      && APSet.exists (fun ap -> AccessExpr.is_constant ap && not (AccessExpr.is_null ap)) vset
    in
    let aps_buggy, aps_patch = (get_loc_by f spec_buggy.mem, get_loc_by f spec_patch.mem) in
    let f_name = "fn_const" in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap aps_buggy)) ~f_name aps_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap aps_patch)) ~f_name aps_buggy in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap aps_patch) ~f_name aps_buggy in
    set_msg_debugger (F.asprintf "[Feature] fn_const: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let models =
    [ ("local_null", local_null)
    ; ("ret_null", ret_null)
    ; ("fn_null", fn_null)
    ; ("local_const", local_const)
    ; ("ret_const", ret_const)
    ; ("fn_const", fn_const) ]
end

module Mthd = struct
  let const_mthd spec_buggy spec_patch =
    let check_const_mthd spec =
      let normal_rets =
        get_ret_vals spec
        |> APSet.filter (fun ap -> not (AccessExpr.is_exn ~include_runtime:true ap))
      in
      (* does not checking constant method of void or boolean return type *)
      let is_target =
        let ret_typ = Procdesc.get_ret_type spec.pdesc in
        not (Typ.equal ret_typ Typ.boolean || Typ.equal ret_typ Typ.void)
      in
      (not (APSet.is_empty normal_rets))
      && is_target
      && APSet.for_all AccessExpr.is_constant normal_rets
    in
    let is_const_buggy, is_const_patch =
      (check_const_mthd spec_buggy, check_const_mthd spec_patch)
    in
    set_msg_debugger (F.asprintf "[Debug] Const mthd: %b, %b @." is_const_buggy is_const_patch) ;
    let gen = (not is_const_buggy) && is_const_patch in
    let rm = is_const_buggy && not is_const_patch in
    let remain = is_const_buggy && is_const_patch in
    set_msg_debugger (F.asprintf "[Feature] Const mthd: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let err_mthd spec_buggy spec_patch =
    let check_err_mthd spec = AbsBool.is_true spec.is_exceptional in
    let is_err_buggy, is_err_patch = (check_err_mthd spec_buggy, check_err_mthd spec_patch) in
    set_msg_debugger (F.asprintf "[Debug] Err mthd: %b, %b @." is_err_buggy is_err_patch) ;
    let gen = (not is_err_buggy) && is_err_patch in
    let rm = is_err_buggy && not is_err_patch in
    let remain = is_err_buggy && is_err_patch in
    set_msg_debugger (F.asprintf "[Feature] Err mthd: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let models = [("const_mthd", const_mthd); ("err_mthd", err_mthd)]
end

module Dep = struct
  let ret_dep_param spec_buggy spec_patch =
    let get_params spec =
      let ret_ap = get_ret_loc spec in
      APDep.find ret_ap spec.ap_dep |> APSet.filter (AccessExpr.is_param spec.pdesc)
    in
    let aps_buggy, aps_patch = (get_params spec_buggy, get_params spec_patch) in
    let f_name = "dep_param" in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap aps_buggy)) ~f_name aps_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap aps_patch)) ~f_name aps_buggy in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap aps_patch) ~f_name aps_buggy in
    set_msg_debugger
      (F.asprintf "[Feature] params related to ret: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let ret_dep_local spec_buggy spec_patch =
    let get_params spec =
      let ret_ap = get_ret_loc spec in
      APDep.find ret_ap spec.ap_dep |> APSet.filter (AccessExpr.is_local spec.pdesc)
    in
    let aps_buggy, aps_patch = (get_params spec_buggy, get_params spec_patch) in
    let f_name = "dep_local" in
    let gen = check_gen ~pred:(fun ap -> not (APSet.mem ap aps_buggy)) ~f_name aps_patch in
    let rm = check_rm ~pred:(fun ap -> not (APSet.mem ap aps_patch)) ~f_name aps_buggy in
    let remain = check_remain ~pred:(fun ap -> APSet.mem ap aps_patch) ~f_name aps_buggy in
    set_msg_debugger
      (F.asprintf "[Feature] locals related to ret: %a @." pp_change (gen, rm, remain)) ;
    (gen, rm, remain)


  let models = [("ret_dep_param", ret_dep_param); ("ret_dep_local", ret_dep_local)]
end

(* 
module MthdFeatures = struct
  let get_ret_values spec = APMem.find (get_return spec) spec.mem

  let get_all_sources spec =
    let return_values = get_ret_values spec in
    APSet.fold
      (fun ap -> APSet.union (ValueAnalysis.APDep.find ap spec.ap_dep))
      return_values APSet.empty


  let get_all_local_sources spec =
    get_all_sources spec |> APSet.filter (AccessExpr.is_local spec.pdesc)


  let get_all_param_sources spec =
    get_all_sources spec |> APSet.filter (AccessExpr.is_param spec.pdesc)


  let remove_dep_from_local ~spec_buggy ~spec_patch =
    if AbsBool.is_true spec_patch.is_exceptional then 0
    else
      let locals_buggy, locals_patch =
        (get_all_local_sources spec_buggy, get_all_local_sources spec_patch)
      in
      APSet.diff locals_buggy locals_patch
      |> APSet.filter (AccessExpr.is_local spec_patch.pdesc)
      |> APSet.cardinal


  let remove_dep_from_param ~spec_buggy ~spec_patch =
    if AbsBool.is_true spec_patch.is_exceptional then 0
    else
      let params_buggy, params_patch =
        (get_all_param_sources spec_buggy, get_all_param_sources spec_patch)
      in
      APSet.diff params_buggy params_patch |> APSet.cardinal


  let gen_dep_from_local ~spec_buggy ~spec_patch =
    let locals_buggy, locals_patch =
      (get_all_local_sources spec_buggy, get_all_local_sources spec_patch)
    in
    APSet.diff locals_patch locals_buggy
    |> APSet.filter (AccessExpr.is_local spec_patch.pdesc)
    |> APSet.cardinal


  let gen_dep_from_param ~spec_buggy ~spec_patch =
    let params_buggy, params_patch =
      (get_all_param_sources spec_buggy, get_all_param_sources spec_patch)
    in
    APSet.diff params_patch params_buggy |> APSet.cardinal



  let models =
    [ ("remove_dep_from_local_X", remove_dep_from_local)
    ; ("remove_dep_from_param_X", remove_dep_from_param)
    ; ("gen_dep_from_local_O", gen_dep_from_local)
    ; ("gen_dep_from_param_O", gen_dep_from_param)
    ; ("make_local_function_X", make_local_function)
    ; ("make_wrong_getter_X", make_wrong_getter)
    ; ("make_const_return_X", make_const_return)
    ; ("make_const_return2", make_const_return2)
    ; ("remove_all_exn_typs_X", remove_all_exn_typs)
    ; ("remove_all_exn_typs2", remove_all_exn_typs2) ]
end *)
