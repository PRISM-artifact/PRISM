open! IStd
open! Vocab
module L = Logging
module F = Format
module Spec = StateFormula.Spec
module Specs = StateFormula.Specs
module SpecMap = StateFormula.SpecMap
open Extractor

let vec_to_json vec = `Assoc (List.map vec ~f:(fun (feature, v) -> (feature, `Bool v)))

let run ~get_buggy_summary ~get_patch_summary =
  let patch = Patch.from_marshal () in
  let target_procs = Patch.get_target_procs patch in
  L.progress "Extract@." ;
  (* Convert summary to comparable form *)
  let spec_map_buggy = SpecMap.from_marshal () in
  let spec_map_patch = SpecMap.create ~get_summary:get_patch_summary in
  (* Extract featrues from normal flow (unpatched states) *)
  let pi_feature =
    Procname.Set.fold
      (fun target_proc acc ->
        (* To extract method feature merge all states *)
        msg_task := F.asprintf "fi_feature_%a" Procname.pp target_proc ;
        if SpecMap.mem target_proc spec_map_buggy && SpecMap.mem target_proc spec_map_patch then (
          L.progress "Extract from %a@." Procname.pp target_proc ;
          let specs_buggy = SpecMap.find target_proc spec_map_buggy in
          let specs_patch = SpecMap.find target_proc spec_map_patch in
          (* method definition remain *)
          let new_vec =
            PIFeature.extract specs_buggy specs_patch |> PIFeature.activate "remain_mthd_def"
          in
          PIFeature.merge new_vec acc )
        else if not (SpecMap.mem target_proc spec_map_buggy) then
          (* method definition generated *)
          PIFeature.activate "gen_mthd_def" acc
        else if not (SpecMap.mem target_proc spec_map_patch) then
          (* method definition generated *)
          PIFeature.activate "rm_mthd_def" acc
        else acc)
      target_procs PIFeature.empty
    |> List.map ~f:(fun (f_name, v) -> ("PI_" ^ f_name, v))
  in
  let ps_feature =
    Procname.Set.fold
      (fun target_proc acc ->
        (* To extract method feature merge all states *)
        if SpecMap.mem target_proc spec_map_buggy && SpecMap.mem target_proc spec_map_patch then (
          L.progress "Extract from %a@." Procname.pp target_proc ;
          let specs_buggy =
            SpecMap.find target_proc spec_map_buggy |> Specs.filter (fun spec -> spec.is_patch)
          in
          let specs_patch =
            SpecMap.find target_proc spec_map_patch |> Specs.filter (fun spec -> spec.is_patch)
          in
          if Specs.is_empty specs_buggy || Specs.is_empty specs_patch then acc
          else (
            msg_task := F.asprintf "fp_feature_%a" Procname.pp target_proc ;
            let new_vec = PSFeature.extract specs_buggy specs_patch in
            PSFeature.merge new_vec acc ) )
        else acc)
      target_procs PSFeature.empty
    |> List.map ~f:(fun (f_name, v) -> ("PS_" ^ f_name, v))
  in
  let feature_vec = pi_feature @ ps_feature in
  Vocab.report_msg_debugger () ;
  Utils.with_file_out "result.json" ~f:(fun oc ->
      Yojson.Basic.to_channel oc (vec_to_json feature_vec)) ;
  ()
