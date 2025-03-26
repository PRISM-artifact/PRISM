(* Auto-generated from "java_profiler_samples.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type sampled_method = Java_profiler_samples_t.sampled_method = {
  classname: string;
  methodname: string;
  signature: string
}

type java_profiler_sample = Java_profiler_samples_t.java_profiler_sample = {
  test: string;
  methods: sampled_method list
}

type java_profiler_samples = Java_profiler_samples_t.java_profiler_samples

val write_sampled_method :
  Bi_outbuf.t -> sampled_method -> unit
  (** Output a JSON value of type {!sampled_method}. *)

val string_of_sampled_method :
  ?len:int -> sampled_method -> string
  (** Serialize a value of type {!sampled_method}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_sampled_method :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> sampled_method
  (** Input JSON data of type {!sampled_method}. *)

val sampled_method_of_string :
  string -> sampled_method
  (** Deserialize JSON data of type {!sampled_method}. *)

val write_java_profiler_sample :
  Bi_outbuf.t -> java_profiler_sample -> unit
  (** Output a JSON value of type {!java_profiler_sample}. *)

val string_of_java_profiler_sample :
  ?len:int -> java_profiler_sample -> string
  (** Serialize a value of type {!java_profiler_sample}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_java_profiler_sample :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> java_profiler_sample
  (** Input JSON data of type {!java_profiler_sample}. *)

val java_profiler_sample_of_string :
  string -> java_profiler_sample
  (** Deserialize JSON data of type {!java_profiler_sample}. *)

val write_java_profiler_samples :
  Bi_outbuf.t -> java_profiler_samples -> unit
  (** Output a JSON value of type {!java_profiler_samples}. *)

val string_of_java_profiler_samples :
  ?len:int -> java_profiler_samples -> string
  (** Serialize a value of type {!java_profiler_samples}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_java_profiler_samples :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> java_profiler_samples
  (** Input JSON data of type {!java_profiler_samples}. *)

val java_profiler_samples_of_string :
  string -> java_profiler_samples
  (** Deserialize JSON data of type {!java_profiler_samples}. *)

