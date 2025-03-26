(* Auto-generated from "clang_profiler_samples.atd" *)
              [@@@ocaml.warning "-27-32-35-39"]

type native_symbol = {
  name: string;
  mangled_name: string option;
  hashed_mangled_name: string option
}

type profiler_sample = { test: string; native_symbols: native_symbol list }

type profiler_samples = profiler_sample list
