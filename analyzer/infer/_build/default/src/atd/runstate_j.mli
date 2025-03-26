(* Auto-generated from "runstate.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type infer_version = Runstate_t.infer_version = {
  major: int;
  minor: int;
  patch: int;
  commit: string
}

type command = Runstate_t.command

type run_info = Runstate_t.run_info = {
  date: string;
  command: command;
  infer_version: infer_version
}

type t = Runstate_t.t = {
  run_sequence: run_info list;
  results_dir_format: string;
  should_merge_capture: bool
}

val write_infer_version :
  Bi_outbuf.t -> infer_version -> unit
  (** Output a JSON value of type {!infer_version}. *)

val string_of_infer_version :
  ?len:int -> infer_version -> string
  (** Serialize a value of type {!infer_version}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_infer_version :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> infer_version
  (** Input JSON data of type {!infer_version}. *)

val infer_version_of_string :
  string -> infer_version
  (** Deserialize JSON data of type {!infer_version}. *)

val write_command :
  Bi_outbuf.t -> command -> unit
  (** Output a JSON value of type {!command}. *)

val string_of_command :
  ?len:int -> command -> string
  (** Serialize a value of type {!command}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_command :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> command
  (** Input JSON data of type {!command}. *)

val command_of_string :
  string -> command
  (** Deserialize JSON data of type {!command}. *)

val write_run_info :
  Bi_outbuf.t -> run_info -> unit
  (** Output a JSON value of type {!run_info}. *)

val string_of_run_info :
  ?len:int -> run_info -> string
  (** Serialize a value of type {!run_info}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_run_info :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> run_info
  (** Input JSON data of type {!run_info}. *)

val run_info_of_string :
  string -> run_info
  (** Deserialize JSON data of type {!run_info}. *)

val write_t :
  Bi_outbuf.t -> t -> unit
  (** Output a JSON value of type {!t}. *)

val string_of_t :
  ?len:int -> t -> string
  (** Serialize a value of type {!t}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_t :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> t
  (** Input JSON data of type {!t}. *)

val t_of_string :
  string -> t
  (** Deserialize JSON data of type {!t}. *)

