(* Auto-generated from "config_impact_data.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type config_item = Config_impact_data_t.config_item = {
  method_name: string;
  class_name: string
}

type config_data = Config_impact_data_t.config_data

val write_config_item :
  Bi_outbuf.t -> config_item -> unit
  (** Output a JSON value of type {!config_item}. *)

val string_of_config_item :
  ?len:int -> config_item -> string
  (** Serialize a value of type {!config_item}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_config_item :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> config_item
  (** Input JSON data of type {!config_item}. *)

val config_item_of_string :
  string -> config_item
  (** Deserialize JSON data of type {!config_item}. *)

val write_config_data :
  Bi_outbuf.t -> config_data -> unit
  (** Output a JSON value of type {!config_data}. *)

val string_of_config_data :
  ?len:int -> config_data -> string
  (** Serialize a value of type {!config_data}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_config_data :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> config_data
  (** Input JSON data of type {!config_data}. *)

val config_data_of_string :
  string -> config_data
  (** Deserialize JSON data of type {!config_data}. *)

