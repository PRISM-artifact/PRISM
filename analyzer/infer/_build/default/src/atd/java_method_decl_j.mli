(* Auto-generated from "java_method_decl.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type java_method_decl = Java_method_decl_t.java_method_decl = {
  signature: string option;
  unresolved_signature: bool;
  method_name: string;
  source_file: string;
  start_line: int;
  end_line: int
}

type java_method_decls = Java_method_decl_t.java_method_decls

val write_java_method_decl :
  Bi_outbuf.t -> java_method_decl -> unit
  (** Output a JSON value of type {!java_method_decl}. *)

val string_of_java_method_decl :
  ?len:int -> java_method_decl -> string
  (** Serialize a value of type {!java_method_decl}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_java_method_decl :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> java_method_decl
  (** Input JSON data of type {!java_method_decl}. *)

val java_method_decl_of_string :
  string -> java_method_decl
  (** Deserialize JSON data of type {!java_method_decl}. *)

val write_java_method_decls :
  Bi_outbuf.t -> java_method_decls -> unit
  (** Output a JSON value of type {!java_method_decls}. *)

val string_of_java_method_decls :
  ?len:int -> java_method_decls -> string
  (** Serialize a value of type {!java_method_decls}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_java_method_decls :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> java_method_decls
  (** Input JSON data of type {!java_method_decls}. *)

val java_method_decls_of_string :
  string -> java_method_decls
  (** Deserialize JSON data of type {!java_method_decls}. *)

