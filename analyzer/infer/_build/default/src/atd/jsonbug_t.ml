(* Auto-generated from "jsonbug.atd" *)
              [@@@ocaml.warning "-27-32-35-39"]

type issue_method = { name: string; params: string list }

type parameter_not_nullable_info = {
  class_name: string;
  package_name: string option;
  method_info: issue_method;
  param_index: int
}

type nullsafe_mode = [
    `Default | `LocalTrustAll | `LocalTrustSome | `LocalTrustNone | `Strict
]

type nullsafe_meta_issue_info = {
  num_issues: int;
  curr_nullsafe_mode: nullsafe_mode;
  can_be_promoted_to: nullsafe_mode option
}

type method_info = {
  class_name: string;
  package: string;
  method_name: string;
  call_line: int
}

type field_name = {
  class_name: string;
  package_name: string option;
  field: string
}

type access_level = [ `Private | `Protected | `Public | `Default ]

type annotation_point_method = {
  method_name: string;
  params: string list;
  access_level: access_level
}

type annotation_point_kind = [ `Method | `Field | `Param ]

type annotation_point = {
  id: string;
  kind: annotation_point_kind;
  method_info: annotation_point_method option;
  field_name: string option;
  param_num: int option;
  num_violations: int;
  dependent_point_ids: string list
}

type nullsafe_extra = {
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

type loc = { file: string; lnum: int; cnum: int; enum: int }

type json_trace_item = {
  level: int;
  filename: string;
  line_number: int;
  column_number: int;
  description: string
}

type extra = {
  cost_polynomial: string option;
  cost_degree: int option;
  nullsafe_extra: nullsafe_extra option
}

type jsonbug = {
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

type report = jsonbug list

type item = {
  hash: string;
  loc: loc;
  procedure_name: string;
  procedure_id: string
}

type hum_info = { hum_polynomial: string; hum_degree: string; big_o: string }

type cost_info = {
  polynomial_version: int;
  polynomial: string;
  degree: int option;
  hum: hum_info;
  trace: json_trace_item list
}

type cost_item = {
  hash: string;
  loc: loc;
  procedure_name: string;
  procedure_id: string;
  is_on_ui_thread: bool;
  exec_cost: cost_info;
  autoreleasepool_size: cost_info
}

type costs_report = cost_item list

type config_impact_item = {
  hash: string;
  loc: loc;
  procedure_name: string;
  procedure_id: string;
  unchecked_callees: string
}

type config_impact_report = config_impact_item list
