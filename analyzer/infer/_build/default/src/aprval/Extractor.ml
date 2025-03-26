open! IStd
open! Vocab
module L = Logging
module F = Format
module Specs = StateFormula.Specs
open! SpecCheckerFeatures

module type S = sig
  val models : model list
end

module PatchInsensitive : S = struct
  type model = string * exec

  let mthd_def = [("mthd_def", fun _ _ -> (false, false, false))]

  let models : model list =
    mthd_def @ DefUse.models @ List.tl_exn Crash.models @ Memory.models @ Dep.models
end

module PatchSensitive : S = struct
  type model = string * exec

  let models : model list = [("throwable_exn", Crash.throwable_exn)] @ Mthd.models
end

module Make (Feature : S) = struct
  (* Make Feature extractor which computes *)
  type t = (string * bool) list

  let merge : t -> t -> t =
   fun v1 v2 ->
    List.map2_exn v1 v2 ~f:(fun (f_name1, v1) (f_name2, v2) ->
        if String.equal f_name1 f_name2 then (f_name1, v1 || v2)
        else L.(die InternalError) "cannot merge two feature vec %s, %s@." f_name1 f_name2)


  let empty : t =
    List.concat_map
      ~f:(fun (feature, _) ->
        [("gen_" ^ feature, false); ("rm_" ^ feature, false); ("remain_" ^ feature, false)])
      Feature.models


  let activate target t =
    List.map
      ~f:(fun (f_name, v) -> if String.equal f_name target then (f_name, true) else (f_name, v))
      t


  let pp fmt t = List.iter t ~f:(fun (feature, v) -> F.fprintf fmt " - %s: %d@," feature v)

  let extract specs_buggy specs_patch =
    let _extract spec_buggy spec_patch models =
      set_msg_debugger (F.asprintf "====Current buggy state===@, %a@." Spec.pp spec_buggy) ;
      set_msg_debugger (F.asprintf "====Patch state===@, %a@." Spec.pp spec_patch) ;
      List.concat_map
        ~f:(fun (feature, feature_f) ->
          let gen, rm, remain = feature_f spec_buggy spec_patch in
          [("gen_" ^ feature, gen); ("rm_" ^ feature, rm); ("remain_" ^ feature, remain)])
        models
    in
    (* merge all *)
    let spec_buggy = Specs.merge_all specs_buggy in
    let spec_patch = Specs.merge_all specs_patch in
    _extract spec_buggy spec_patch Feature.models
end

module PIFeature = Make (PatchInsensitive)
module PSFeature = Make (PatchSensitive)
