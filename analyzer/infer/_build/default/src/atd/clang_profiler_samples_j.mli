(* Auto-generated from "clang_profiler_samples.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type native_symbol = Clang_profiler_samples_t.native_symbol = {
  name: string;
  mangled_name: string option;
  hashed_mangled_name: string option
}

type profiler_sample = Clang_profiler_samples_t.profiler_sample = {
  test: string;
  native_symbols: native_symbol list
}

type profiler_samples = Clang_profiler_samples_t.profiler_samples

val write_native_symbol :
  Bi_outbuf.t -> native_symbol -> unit
  (** Output a JSON value of type {!native_symbol}. *)

val string_of_native_symbol :
  ?len:int -> native_symbol -> string
  (** Serialize a value of type {!native_symbol}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_native_symbol :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> native_symbol
  (** Input JSON data of type {!native_symbol}. *)

val native_symbol_of_string :
  string -> native_symbol
  (** Deserialize JSON data of type {!native_symbol}. *)

val write_profiler_sample :
  Bi_outbuf.t -> profiler_sample -> unit
  (** Output a JSON value of type {!profiler_sample}. *)

val string_of_profiler_sample :
  ?len:int -> profiler_sample -> string
  (** Serialize a value of type {!profiler_sample}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_profiler_sample :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> profiler_sample
  (** Input JSON data of type {!profiler_sample}. *)

val profiler_sample_of_string :
  string -> profiler_sample
  (** Deserialize JSON data of type {!profiler_sample}. *)

val write_profiler_samples :
  Bi_outbuf.t -> profiler_samples -> unit
  (** Output a JSON value of type {!profiler_samples}. *)

val string_of_profiler_samples :
  ?len:int -> profiler_samples -> string
  (** Serialize a value of type {!profiler_samples}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_profiler_samples :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> profiler_samples
  (** Input JSON data of type {!profiler_samples}. *)

val profiler_samples_of_string :
  string -> profiler_samples
  (** Deserialize JSON data of type {!profiler_samples}. *)

