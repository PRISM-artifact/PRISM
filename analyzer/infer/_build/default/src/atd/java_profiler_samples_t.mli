(* Auto-generated from "java_profiler_samples.atd" *)
              [@@@ocaml.warning "-27-32-35-39"]

type sampled_method = {
  classname: string;
  methodname: string;
  signature: string
}

type java_profiler_sample = { test: string; methods: sampled_method list }

type java_profiler_samples = java_profiler_sample list
