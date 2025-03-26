open! IStd
open! Vocab
module F = Format
module Node = InstrNode

module Key = struct
  type t = string * int * int [@@deriving compare]

  let pp fmt (filepath, line, label) = F.fprintf fmt "%s,%d,%d" filepath line label
end

module LabelMap = struct
  include PrettyPrintable.MakePPMonoMap (Key) (Node.Set)

  let add_elt k v t =
    match find_opt k t with
    | None ->
        add k (Node.Set.singleton v) t
    | Some nodes ->
        add k (Node.Set.add v nodes) t


  let find (filepath, line, label) t =
    match find_opt (filepath, line, label) t with
    | Some v ->
        v
    | None ->
        (*
        if String.is_suffix filepath ~suffix:"Test" |> not then
          L.progress "[WARNING]: No %a in the label_map@." Key.pp (filepath, line, label) ;
          *)
        raise (Unexpected "NoLabel")
end

module LineNodeMap = struct
  include PrettyPrintable.MakePPMap (Location)

  let add_elt (k : Location.t) v t =
    match find_opt k t with None -> add k [v] t | Some nodes -> add k (nodes @ [v]) t
end

let compute_label (cond_label_acc, invo_label_acc, oob_label_acc) pdesc =
  let nodes =
    Procdesc.get_nodes pdesc
    |> List.sort ~compare:(fun x y ->
           Procdesc.Node.compare_id (Procdesc.Node.get_id x) (Procdesc.Node.get_id y))
  in
  (* TODO: check nodes are sorted *)
  let line_node_map =
    List.fold nodes ~init:LineNodeMap.empty ~f:(fun acc node ->
        let loc = Procdesc.Node.get_loc node in
        let instr_nodes = Node.list_of_pnode node in
        List.fold instr_nodes ~init:acc ~f:(fun acc instr_node ->
            LineNodeMap.add_elt loc instr_node acc))
  in
  let cls_str =
    match Procdesc.get_proc_name pdesc with
    | Procname.Java mthd ->
        Procname.Java.get_class_name mthd
    | _ as proc ->
        L.(die InternalError) "parse non-java methods: %a" Procname.pp proc
  in
  (* (class, branch line, t/f cnt) -> node *)
  let cond_label =
    LineNodeMap.fold
      (fun _ instr_nodes acc ->
        let acc, _, _ =
          List.fold instr_nodes ~init:(acc, 0, 0) ~f:(fun (acc, tcnt, fcnt) instr_node ->
              match InstrNode.get_instr instr_node with
              | Sil.Prune (_, loc, true, _) ->
                  ( LabelMap.add_elt (cls_str, Location.(loc.line), tcnt) instr_node acc
                  , tcnt + 1
                  , fcnt )
              | Sil.Prune (_, loc, false, _) ->
                  ( LabelMap.add_elt (cls_str, Location.(loc.line), fcnt) instr_node acc
                  , tcnt
                  , fcnt + 1 )
              | _ ->
                  (acc, tcnt, fcnt))
        in
        acc)
      line_node_map cond_label_acc
  in
  (* (class, call line, call cnt) -> node *)
  let invo_label =
    LineNodeMap.fold
      (fun _ instr_nodes acc ->
        let acc, _ =
          List.fold instr_nodes ~init:(acc, 0) ~f:(fun (acc, cnt) instr_node ->
              match InstrNode.get_instr instr_node with
              | Sil.Call (_, Const (Cfun proc), _, _, _) when is_builtin_proc proc ->
                  (acc, cnt)
              | Sil.Call (_, _, _, _, _) ->
                  let loc = InstrNode.get_loc instr_node in
                  (LabelMap.add_elt (cls_str, Location.(loc.line), cnt) instr_node acc, cnt + 1)
              | _ ->
                  (acc, cnt))
        in
        acc)
      line_node_map invo_label_acc
  in
  let oob_label =
    LineNodeMap.fold
      (fun _ instr_nodes acc ->
        let acc =
          List.fold instr_nodes ~init:acc ~f:(fun acc instr_node ->
              match InstrNode.get_instr instr_node with
              | Sil.Load {e= Lindex _} ->
                  let loc = InstrNode.get_loc instr_node in
                  LabelMap.add_elt (cls_str, Location.(loc.line), 0) instr_node acc
              | Sil.Store {e1= Lindex _} ->
                  let loc = InstrNode.get_loc instr_node in
                  LabelMap.add_elt (cls_str, Location.(loc.line), 0) instr_node acc
              | _ ->
                  acc)
        in
        acc)
      line_node_map oob_label_acc
  in
  (cond_label, invo_label, oob_label)


module Value = struct
  type t = {br_info: int * int; die_info: AbsBool.t; npe_info: AbsBool.t} [@@deriving compare]

  let pp fmt {br_info= t, f; die_info; npe_info} =
    F.fprintf fmt "(%d, %d),%a,%a" t f AbsBool.pp die_info AbsBool.pp npe_info


  let join ({br_info= t_lhs, f_lhs} as lhs) ({br_info= t_rhs, f_rhs} as rhs) =
    { br_info= (t_lhs + t_rhs, f_lhs + f_rhs)
    ; die_info= AbsBool.join lhs.die_info rhs.die_info
    ; npe_info= AbsBool.join lhs.npe_info rhs.npe_info }


  let bottom = {br_info= (0, 0); die_info= AbsBool.bottom; npe_info= AbsBool.bottom}

  let top = {br_info= (-1, -1); die_info= AbsBool.top; npe_info= AbsBool.top}

  let get_br_info {br_info} = br_info

  let get_die_info {die_info} = die_info

  let get_npe_info {npe_info} = npe_info
end

let parse_ctx invo_label ctx_str =
  match String.split ctx_str ~on:',' with
  | [_] ->
      Node.Set.singleton Node.dummy
  | [cls_str; line_str; label_str] ->
      let line = Int.of_string line_str in
      let label = Int.of_string label_str in
      LabelMap.find (cls_str, line, label) invo_label
  | _ as str_list ->
      L.(die ExternalError) "invalid ctx str %s: %s" ctx_str (String.concat ~sep:"," str_list)


let parse_cond_node cond_label key_str =
  match String.split key_str ~on:',' with
  | [cls_str; line_str; label_str] ->
      let line = Int.of_string line_str in
      let label = Int.of_string label_str in
      LabelMap.find (cls_str, line, label) cond_label
  | _ ->
      L.(die ExternalError) "invalid cond str %s" key_str


let parse_invo_node invo_label key_str =
  match String.split key_str ~on:',' with
  | [cls_str; line_str; label_str] ->
      let line = Int.of_string line_str in
      let label = Int.of_string label_str in
      LabelMap.find (cls_str, line, label) invo_label
  | _ ->
      L.(die ExternalError) "invalid invo str %s" key_str


let parse_exn_node exn_label key_str =
  match String.split key_str ~on:',' with
  | [cls_str; line_str] ->
      let line = Int.of_string line_str in
      LabelMap.find (cls_str, line, 0) exn_label
  | _ ->
      raise (Unexpected ("invalid invo str " ^ key_str))


let parse_cond_value value_str : int * int =
  match value_str with
  | "I" | "T" | "T,I" ->
      (1, 0)
  | "F" ->
      (0, 1)
  | "F,I" | "T,F" ->
      (1, 1)
  | _ ->
      L.(die ExternalError) "invalid cond str %s" value_str


let parse_die_value die_str : AbsBool.t =
  match String.split die_str ~on:',' with
  | [int_str; bool_str; _] | [int_str; bool_str] ->
      let int_val = Int.of_string int_str in
      let has_passed = Bool.of_string bool_str in
      if Int.equal int_val 0 then AbsBool.v false
      else if has_passed then AbsBool.top
      else AbsBool.v true
  | _ ->
      L.(die ExternalError) "invalid die str %s" die_str


let parse_npe_value die_str : AbsBool.t =
  match String.split die_str ~on:',' with
  | [int_str; bool_str; npe_str] ->
      let int_val = Int.of_string int_str in
      let has_passed = Bool.of_string bool_str in
      let has_nped = Bool.of_string npe_str in
      if Int.equal int_val 0 then AbsBool.v false
      else if not has_nped then AbsBool.v false
      else if has_passed then AbsBool.top
      else AbsBool.v true
  | _ ->
      L.(die ExternalError) "invalid die str %s" die_str


module NodeMap = struct
  include PrettyPrintable.MakePPMonoMap (Node) (Value)

  let add node value t =
    match find_opt node t with
    | Some value' ->
        add node (Value.join value value') t
    | None ->
        add node value t
end

type t = NodeMap.t

let pp = NodeMap.pp

let is_target_ctx test_methods ctx = Procname.Set.mem (Node.get_proc_name ctx) test_methods

let update ?(ignore_ctx = false) test_methods ctx_nodes key_nodes values t =
  Node.Set.fold
    (fun node acc ->
      if ignore_ctx then
        (* when gathering branch info, ignore the test context *)
        NodeMap.add node values acc
      else if Node.Set.exists (is_target_ctx test_methods) ctx_nodes then
        NodeMap.add node values acc
      else acc)
    key_nodes t


let cache = ref NodeMap.empty

let marshalled_path = Filename.concat Config.results_dir "dyninfo.data"

let to_marshal dyninfo =
  cache := dyninfo ;
  Utils.with_file_out marshalled_path ~f:(fun oc -> Marshal.to_channel oc dyninfo [])


let from_marshal () =
  if NodeMap.is_empty !cache then (
    let dyninfo = Utils.with_file_in marshalled_path ~f:Marshal.from_channel in
    cache := dyninfo ;
    dyninfo )
  else !cache


let get_dynamic_exprs node : Value.t =
  let dyninfo = from_marshal () in
  match NodeMap.find_opt node dyninfo with
  | Some values ->
      values
  | None ->
      (* 3 possible cases:
         1. no dynamic state here (pruning chance)
         2. failed to parse
         3. failed to trace *)
      Value.bottom


let get_br_info node = get_dynamic_exprs node |> Value.get_br_info

let get_die_info node = get_dynamic_exprs node |> Value.get_die_info

let get_npe_info node = get_dynamic_exprs node |> Value.get_npe_info

let is_die node = match get_die_info node with AbsBool.V true | AbsBool.Top -> true | _ -> false

let is_npe node = match get_npe_info node with AbsBool.V true | AbsBool.Top -> true | _ -> false

let get_test_methods program test_method_strings =
  List.fold test_method_strings ~init:Procname.Set.empty ~f:(fun acc qualified_method_name ->
      (* L.progress "[DEBUG] parse %s@." qualified_method_name ; *)
      let[@warning "-8"] [classpath; _; method_name] = String.split qualified_method_name ~on:':' in
      let klass = Typ.Name.Java.from_string classpath in
      let found =
        Program.find_methods_in_class program klass ~pred:(fun pd ->
            String.( = ) method_name (Procname.get_method (Procdesc.get_proc_name pd)))
      in
      if Procname.Set.is_empty found then
        L.(die ExternalError) "There is no method %s in captured methods" qualified_method_name
      else if Procname.Set.cardinal found > 1 then
        L.(die ExternalError)
          "There are multiple methods matched with %s: %a@." qualified_method_name Procname.Set.pp
          found
      else Procname.Set.union acc found)


let get_test_classes test_method_strings =
  List.fold test_method_strings ~init:[] ~f:(fun acc qualified_method_name ->
      (* L.progress "[DEBUG] parse %s@." qualified_method_name ; *)
      let[@warning "-8"] [classpath; _; _] = String.split qualified_method_name ~on:':' in
      let klass = Typ.Name.Java.from_string classpath in
      klass :: acc)


let parse_exn dyninfo_exns ~invo_label exn_label test_methods acc =
  List.fold dyninfo_exns ~init:acc ~f:(fun acc dyninfo_str ->
      match String.split dyninfo_str ~on:'/' with
      | [ctx_str; key_str; die_str] -> (
        try
          let ctx_nodes = parse_ctx invo_label ctx_str in
          let die_nodes = parse_exn_node exn_label key_str in
          let die_value = parse_die_value die_str in
          update test_methods ctx_nodes die_nodes {Value.bottom with die_info= die_value} acc
        with
        | Unexpected "NoLabel" ->
            acc
        | Unexpected msg ->
            L.progress "[Warning]: %s@." msg ;
            acc )
      | _ ->
          L.progress "dyninfo invokedWell %s is not splitted " dyninfo_str ;
          acc)


let parse_dyninfo_class ~test_class ~cond_label ~invo_label ~oob_label test_methods dyninfo =
  let class_name = Typ.Name.name test_class in
  let path_br = Config.aprval_trace_dir ^/ class_name ^/ Config.aprval_dyninfo_br in
  let path_die = Config.aprval_trace_dir ^/ class_name ^/ Config.aprval_dyninfo_die in
  let path_oob = Config.aprval_trace_dir ^/ class_name ^/ Config.aprval_dyninfo_oob in
  match (Utils.read_file path_br, Utils.read_file path_die, Utils.read_file path_oob) with
  | Ok dyninfo_brs, Ok dyninfo_dies, Ok dyninfo_oob ->
      let dyninfo_br =
        List.fold dyninfo_brs ~init:dyninfo ~f:(fun acc dyninfo_str ->
            match String.split dyninfo_str ~on:'/' with
            | [ctx_str; key_str; value_str] -> (
              try
                let ctx_nodes = parse_ctx invo_label ctx_str in
                let key_nodes = parse_cond_node cond_label key_str in
                let value = parse_cond_value value_str in
                update ~ignore_ctx:true test_methods ctx_nodes key_nodes
                  {Value.bottom with br_info= value}
                  acc
              with Unexpected "NoLabel" -> acc )
            | _ ->
                L.(die ExternalError) "dyninfo_str %s is not splitted by \\" dyninfo_str)
      in
      let dyninfo_exn = parse_exn dyninfo_oob ~invo_label oob_label test_methods dyninfo_br in
      List.fold dyninfo_dies ~init:dyninfo_exn ~f:(fun acc dyninfo_die_str ->
          match String.split dyninfo_die_str ~on:'/' with
          | [ctx_str; key_str; die_str] -> (
            try
              let ctx_nodes = parse_ctx invo_label ctx_str in
              let key_nodes = parse_invo_node invo_label key_str in
              let die_info, npe_info = (parse_die_value die_str, parse_npe_value die_str) in
              update test_methods ctx_nodes key_nodes {Value.bottom with die_info; npe_info} acc
            with Unexpected "NoLabel" -> acc )
          | _ ->
              L.(die ExternalError) "dyninfo_str %s is not splitted by \\" dyninfo_die_str)
  | _ ->
      L.(die ExternalError)
        "No %s or %s or %s" Config.aprval_dyninfo_br Config.aprval_dyninfo_invo
        Config.aprval_dyninfo_die


let parse_dyninfo program =
  let all_pdescs =
    Procname.Set.fold
      (fun proc acc ->
        match Program.pdesc_of_opt program proc with Some pdesc -> pdesc :: acc | _ -> acc)
      (Program.all_procs program) []
  in
  let cond_label, invo_label, oob_label =
    List.fold all_pdescs ~init:(LabelMap.empty, LabelMap.empty, LabelMap.empty) ~f:compute_label
  in
  print_to_file ~dirname:(Some Config.results_dir)
    ~msg:
      (F.asprintf "cond label: %a@.@. invo_label: %a@.@." LabelMap.pp cond_label LabelMap.pp
         invo_label)
    ~filename:"cond_invo_label_map.results" ;
  let test_classes = get_test_classes Config.aprval_test_methods in
  let test_methods_executed = get_test_methods program Config.aprval_test_methods in
  L.progress "Test methods: %a@." Procname.Set.pp test_methods_executed ;
  L.progress "Test classes executed: %a@." (Pp.seq ~sep:"\n" Typ.Name.pp) test_classes ;
  let results =
    List.fold test_classes ~init:NodeMap.empty ~f:(fun acc test_class ->
        parse_dyninfo_class ~test_class ~cond_label ~invo_label ~oob_label test_methods_executed acc)
  in
  to_marshal results ;
  results
