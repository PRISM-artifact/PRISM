(* Auto-generated from "jsonbug.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type issue_method = Jsonbug_t.issue_method = {
  name: string;
  params: string list
}

type parameter_not_nullable_info = Jsonbug_t.parameter_not_nullable_info = {
  class_name: string;
  package_name: string option;
  method_info: issue_method;
  param_index: int
}

type nullsafe_mode = Jsonbug_t.nullsafe_mode

type nullsafe_meta_issue_info = Jsonbug_t.nullsafe_meta_issue_info = {
  num_issues: int;
  curr_nullsafe_mode: nullsafe_mode;
  can_be_promoted_to: nullsafe_mode option
}

type method_info = Jsonbug_t.method_info = {
  class_name: string;
  package: string;
  method_name: string;
  call_line: int
}

type field_name = Jsonbug_t.field_name = {
  class_name: string;
  package_name: string option;
  field: string
}

type access_level = Jsonbug_t.access_level

type annotation_point_method = Jsonbug_t.annotation_point_method = {
  method_name: string;
  params: string list;
  access_level: access_level
}

type annotation_point_kind = Jsonbug_t.annotation_point_kind

type annotation_point = Jsonbug_t.annotation_point = {
  id: string;
  kind: annotation_point_kind;
  method_info: annotation_point_method option;
  field_name: string option;
  param_num: int option;
  num_violations: int;
  dependent_point_ids: string list
}

type nullsafe_extra = Jsonbug_t.nullsafe_extra = {
  class_name: string;
  package: string option;
  method_info: issue_method option;
  field: field_name option;
  inconsistent_param_index: int option;
  parameter_not_nullable_info: parameter_not_nullable_info option;
  nullable_methods: method_info list option;
  unvetted_3rd_party: string list option;
  meta_issue_info: nullsafe_meta_issue_info option;
  annotation_graph: annotation_point list option
}

type loc = Jsonbug_t.loc = { file: string; lnum: int; cnum: int; enum: int }

type json_trace_item = Jsonbug_t.json_trace_item = {
  level: int;
  filename: string;
  line_number: int;
  column_number: int;
  description: string
}

type extra = Jsonbug_t.extra = {
  cost_polynomial: string option;
  cost_degree: int option;
  nullsafe_extra: nullsafe_extra option
}

type jsonbug = Jsonbug_t.jsonbug = {
  bug_type: string;
  doc_url: string option;
  qualifier: string;
  severity: string;
  line: int;
  column: int;
  procedure: string;
  procedure_start_line: int;
  file: string;
  bug_trace: json_trace_item list;
  key: string;
  node_key: string option;
  hash: string;
  dotty: string option;
  infer_source_loc: loc option;
  bug_type_hum: string;
  linters_def_file: string option;
  traceview_id: int option;
  censored_reason: string option;
  access: string option;
  extras: extra option
}

type report = Jsonbug_t.report

type item = Jsonbug_t.item = {
  hash: string;
  loc: loc;
  procedure_name: string;
  procedure_id: string
}

type hum_info = Jsonbug_t.hum_info = {
  hum_polynomial: string;
  hum_degree: string;
  big_o: string
}

type cost_info = Jsonbug_t.cost_info = {
  polynomial_version: int;
  polynomial: string;
  degree: int option;
  hum: hum_info;
  trace: json_trace_item list
}

type cost_item = Jsonbug_t.cost_item = {
  hash: string;
  loc: loc;
  procedure_name: string;
  procedure_id: string;
  is_on_ui_thread: bool;
  exec_cost: cost_info;
  autoreleasepool_size: cost_info
}

type costs_report = Jsonbug_t.costs_report

type config_impact_item = Jsonbug_t.config_impact_item = {
  hash: string;
  loc: loc;
  procedure_name: string;
  procedure_id: string;
  unchecked_callees: string
}

type config_impact_report = Jsonbug_t.config_impact_report

val write_issue_method :
  Bi_outbuf.t -> issue_method -> unit
  (** Output a JSON value of type {!issue_method}. *)

val string_of_issue_method :
  ?len:int -> issue_method -> string
  (** Serialize a value of type {!issue_method}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_issue_method :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> issue_method
  (** Input JSON data of type {!issue_method}. *)

val issue_method_of_string :
  string -> issue_method
  (** Deserialize JSON data of type {!issue_method}. *)

val write_parameter_not_nullable_info :
  Bi_outbuf.t -> parameter_not_nullable_info -> unit
  (** Output a JSON value of type {!parameter_not_nullable_info}. *)

val string_of_parameter_not_nullable_info :
  ?len:int -> parameter_not_nullable_info -> string
  (** Serialize a value of type {!parameter_not_nullable_info}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_parameter_not_nullable_info :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> parameter_not_nullable_info
  (** Input JSON data of type {!parameter_not_nullable_info}. *)

val parameter_not_nullable_info_of_string :
  string -> parameter_not_nullable_info
  (** Deserialize JSON data of type {!parameter_not_nullable_info}. *)

val write_nullsafe_mode :
  Bi_outbuf.t -> nullsafe_mode -> unit
  (** Output a JSON value of type {!nullsafe_mode}. *)

val string_of_nullsafe_mode :
  ?len:int -> nullsafe_mode -> string
  (** Serialize a value of type {!nullsafe_mode}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_nullsafe_mode :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> nullsafe_mode
  (** Input JSON data of type {!nullsafe_mode}. *)

val nullsafe_mode_of_string :
  string -> nullsafe_mode
  (** Deserialize JSON data of type {!nullsafe_mode}. *)

val write_nullsafe_meta_issue_info :
  Bi_outbuf.t -> nullsafe_meta_issue_info -> unit
  (** Output a JSON value of type {!nullsafe_meta_issue_info}. *)

val string_of_nullsafe_meta_issue_info :
  ?len:int -> nullsafe_meta_issue_info -> string
  (** Serialize a value of type {!nullsafe_meta_issue_info}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_nullsafe_meta_issue_info :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> nullsafe_meta_issue_info
  (** Input JSON data of type {!nullsafe_meta_issue_info}. *)

val nullsafe_meta_issue_info_of_string :
  string -> nullsafe_meta_issue_info
  (** Deserialize JSON data of type {!nullsafe_meta_issue_info}. *)

val write_method_info :
  Bi_outbuf.t -> method_info -> unit
  (** Output a JSON value of type {!method_info}. *)

val string_of_method_info :
  ?len:int -> method_info -> string
  (** Serialize a value of type {!method_info}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_method_info :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> method_info
  (** Input JSON data of type {!method_info}. *)

val method_info_of_string :
  string -> method_info
  (** Deserialize JSON data of type {!method_info}. *)

val write_field_name :
  Bi_outbuf.t -> field_name -> unit
  (** Output a JSON value of type {!field_name}. *)

val string_of_field_name :
  ?len:int -> field_name -> string
  (** Serialize a value of type {!field_name}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_field_name :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> field_name
  (** Input JSON data of type {!field_name}. *)

val field_name_of_string :
  string -> field_name
  (** Deserialize JSON data of type {!field_name}. *)

val write_access_level :
  Bi_outbuf.t -> access_level -> unit
  (** Output a JSON value of type {!access_level}. *)

val string_of_access_level :
  ?len:int -> access_level -> string
  (** Serialize a value of type {!access_level}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_access_level :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> access_level
  (** Input JSON data of type {!access_level}. *)

val access_level_of_string :
  string -> access_level
  (** Deserialize JSON data of type {!access_level}. *)

val write_annotation_point_method :
  Bi_outbuf.t -> annotation_point_method -> unit
  (** Output a JSON value of type {!annotation_point_method}. *)

val string_of_annotation_point_method :
  ?len:int -> annotation_point_method -> string
  (** Serialize a value of type {!annotation_point_method}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_annotation_point_method :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> annotation_point_method
  (** Input JSON data of type {!annotation_point_method}. *)

val annotation_point_method_of_string :
  string -> annotation_point_method
  (** Deserialize JSON data of type {!annotation_point_method}. *)

val write_annotation_point_kind :
  Bi_outbuf.t -> annotation_point_kind -> unit
  (** Output a JSON value of type {!annotation_point_kind}. *)

val string_of_annotation_point_kind :
  ?len:int -> annotation_point_kind -> string
  (** Serialize a value of type {!annotation_point_kind}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_annotation_point_kind :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> annotation_point_kind
  (** Input JSON data of type {!annotation_point_kind}. *)

val annotation_point_kind_of_string :
  string -> annotation_point_kind
  (** Deserialize JSON data of type {!annotation_point_kind}. *)

val write_annotation_point :
  Bi_outbuf.t -> annotation_point -> unit
  (** Output a JSON value of type {!annotation_point}. *)

val string_of_annotation_point :
  ?len:int -> annotation_point -> string
  (** Serialize a value of type {!annotation_point}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_annotation_point :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> annotation_point
  (** Input JSON data of type {!annotation_point}. *)

val annotation_point_of_string :
  string -> annotation_point
  (** Deserialize JSON data of type {!annotation_point}. *)

val write_nullsafe_extra :
  Bi_outbuf.t -> nullsafe_extra -> unit
  (** Output a JSON value of type {!nullsafe_extra}. *)

val string_of_nullsafe_extra :
  ?len:int -> nullsafe_extra -> string
  (** Serialize a value of type {!nullsafe_extra}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_nullsafe_extra :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> nullsafe_extra
  (** Input JSON data of type {!nullsafe_extra}. *)

val nullsafe_extra_of_string :
  string -> nullsafe_extra
  (** Deserialize JSON data of type {!nullsafe_extra}. *)

val write_loc :
  Bi_outbuf.t -> loc -> unit
  (** Output a JSON value of type {!loc}. *)

val string_of_loc :
  ?len:int -> loc -> string
  (** Serialize a value of type {!loc}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_loc :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> loc
  (** Input JSON data of type {!loc}. *)

val loc_of_string :
  string -> loc
  (** Deserialize JSON data of type {!loc}. *)

val write_json_trace_item :
  Bi_outbuf.t -> json_trace_item -> unit
  (** Output a JSON value of type {!json_trace_item}. *)

val string_of_json_trace_item :
  ?len:int -> json_trace_item -> string
  (** Serialize a value of type {!json_trace_item}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_json_trace_item :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> json_trace_item
  (** Input JSON data of type {!json_trace_item}. *)

val json_trace_item_of_string :
  string -> json_trace_item
  (** Deserialize JSON data of type {!json_trace_item}. *)

val write_extra :
  Bi_outbuf.t -> extra -> unit
  (** Output a JSON value of type {!extra}. *)

val string_of_extra :
  ?len:int -> extra -> string
  (** Serialize a value of type {!extra}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_extra :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> extra
  (** Input JSON data of type {!extra}. *)

val extra_of_string :
  string -> extra
  (** Deserialize JSON data of type {!extra}. *)

val write_jsonbug :
  Bi_outbuf.t -> jsonbug -> unit
  (** Output a JSON value of type {!jsonbug}. *)

val string_of_jsonbug :
  ?len:int -> jsonbug -> string
  (** Serialize a value of type {!jsonbug}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_jsonbug :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> jsonbug
  (** Input JSON data of type {!jsonbug}. *)

val jsonbug_of_string :
  string -> jsonbug
  (** Deserialize JSON data of type {!jsonbug}. *)

val write_report :
  Bi_outbuf.t -> report -> unit
  (** Output a JSON value of type {!report}. *)

val string_of_report :
  ?len:int -> report -> string
  (** Serialize a value of type {!report}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_report :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> report
  (** Input JSON data of type {!report}. *)

val report_of_string :
  string -> report
  (** Deserialize JSON data of type {!report}. *)

val write_item :
  Bi_outbuf.t -> item -> unit
  (** Output a JSON value of type {!item}. *)

val string_of_item :
  ?len:int -> item -> string
  (** Serialize a value of type {!item}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_item :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> item
  (** Input JSON data of type {!item}. *)

val item_of_string :
  string -> item
  (** Deserialize JSON data of type {!item}. *)

val write_hum_info :
  Bi_outbuf.t -> hum_info -> unit
  (** Output a JSON value of type {!hum_info}. *)

val string_of_hum_info :
  ?len:int -> hum_info -> string
  (** Serialize a value of type {!hum_info}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_hum_info :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> hum_info
  (** Input JSON data of type {!hum_info}. *)

val hum_info_of_string :
  string -> hum_info
  (** Deserialize JSON data of type {!hum_info}. *)

val write_cost_info :
  Bi_outbuf.t -> cost_info -> unit
  (** Output a JSON value of type {!cost_info}. *)

val string_of_cost_info :
  ?len:int -> cost_info -> string
  (** Serialize a value of type {!cost_info}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cost_info :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cost_info
  (** Input JSON data of type {!cost_info}. *)

val cost_info_of_string :
  string -> cost_info
  (** Deserialize JSON data of type {!cost_info}. *)

val write_cost_item :
  Bi_outbuf.t -> cost_item -> unit
  (** Output a JSON value of type {!cost_item}. *)

val string_of_cost_item :
  ?len:int -> cost_item -> string
  (** Serialize a value of type {!cost_item}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_cost_item :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> cost_item
  (** Input JSON data of type {!cost_item}. *)

val cost_item_of_string :
  string -> cost_item
  (** Deserialize JSON data of type {!cost_item}. *)

val write_costs_report :
  Bi_outbuf.t -> costs_report -> unit
  (** Output a JSON value of type {!costs_report}. *)

val string_of_costs_report :
  ?len:int -> costs_report -> string
  (** Serialize a value of type {!costs_report}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_costs_report :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> costs_report
  (** Input JSON data of type {!costs_report}. *)

val costs_report_of_string :
  string -> costs_report
  (** Deserialize JSON data of type {!costs_report}. *)

val write_config_impact_item :
  Bi_outbuf.t -> config_impact_item -> unit
  (** Output a JSON value of type {!config_impact_item}. *)

val string_of_config_impact_item :
  ?len:int -> config_impact_item -> string
  (** Serialize a value of type {!config_impact_item}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_config_impact_item :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> config_impact_item
  (** Input JSON data of type {!config_impact_item}. *)

val config_impact_item_of_string :
  string -> config_impact_item
  (** Deserialize JSON data of type {!config_impact_item}. *)

val write_config_impact_report :
  Bi_outbuf.t -> config_impact_report -> unit
  (** Output a JSON value of type {!config_impact_report}. *)

val string_of_config_impact_report :
  ?len:int -> config_impact_report -> string
  (** Serialize a value of type {!config_impact_report}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_config_impact_report :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> config_impact_report
  (** Input JSON data of type {!config_impact_report}. *)

val config_impact_report_of_string :
  string -> config_impact_report
  (** Deserialize JSON data of type {!config_impact_report}. *)

