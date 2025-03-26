(* Auto-generated from "runstate.atd" *)
              [@@@ocaml.warning "-27-32-35-39"]

type infer_version = { major: int; minor: int; patch: int; commit: string }

type command = InferCommand.t

type run_info = {
  date: string;
  command: command;
  infer_version: infer_version
}

type t = {
  run_sequence: run_info list;
  results_dir_format: string;
  should_merge_capture: bool
}
