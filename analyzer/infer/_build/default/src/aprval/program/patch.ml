open! IStd
open! Vocab
module F = Format
module Node = Procdesc.Node
module NodeSet = PrettyPrintable.MakePPSet (Node)

(* Procdesc.NodeSet *)

(************************************************)
(* Modules for patch line mapping (shared data) *)
(************************************************)
module Interval = struct
  type t = Int.t * Int.t [@@deriving compare]

  let pp fmt (s, e) = F.fprintf fmt "[%d, %d]@." s e

  (* let compare (s1, e1) (s2, e2) =
     (* -1 means the last line of the source file *)
     let comp_int i1 i2 =
       if Int.equal i1 (-1) then -1 else if Int.equal i2 (-1) then 1 else Int.compare i1 i2
     in
     let v1 = comp_int s1 s2 in
     if Int.equal v1 0 then comp_int e1 e2 else v1 *)

  let check_included line_org t =
    match t with s, -1 -> line_org >= s | s, e -> line_org >= s && line_org <= e
end

module LineMapping = struct
  module V = struct
    (* original line to patched line (unchanged lines only)
       the mapping "(s, e) -> offset" means
       patch lines corresponding to the original lines between "s" and "e" can be obtained by adding "offset" to org
    *)
    include PrettyPrintable.MakePPMonoMap (Interval) (Int)

    let compute_patch_line line_org t =
      fold
        (fun interval offset acc ->
          if Interval.check_included line_org interval then acc + offset else acc)
        t line_org


    let compute_org_line line_patch t =
      fold
        (fun interval offset acc ->
          let line_org = line_patch - offset in
          if Interval.check_included line_org interval then line_org else acc)
        t line_patch


    let merge_interval t =
      let rec iter t t' =
        if is_empty t then t'
        else
          let (s1, e1), offset1 = choose t in
          let remains = remove (s1, e1) t in
          let new_v, done_set =
            fold
              (fun (s2, e2) offset2 ((s1, e1), done_set) ->
                if Int.equal offset1 offset2 && (Int.equal (e1 + 1) s2 || Int.equal (s2 - 1) e1)
                then ((s1, e2), (s2, e2) :: done_set)
                else ((s1, e1), done_set))
              remains
              ((s1, e1), [])
          in
          L.progress "Done Set : %a@." (Pp.seq Interval.pp) done_set ;
          let remains = List.fold done_set ~init:remains ~f:(fun acc key -> remove key acc) in
          iter remains (add new_v offset1 t')
      in
      iter t empty
  end

  include PrettyPrintable.MakePPMonoMap (SourceFile) (V)

  let compute_patch_line source_file line_org t =
    try
      let mapping = find source_file t in
      V.compute_patch_line line_org mapping
    with _ -> line_org


  let compute_org_line source_file line_patch t =
    try
      let mapping = find source_file t in
      V.compute_org_line line_patch mapping
    with _ -> line_patch


  let merge_interval t = map V.merge_interval t

  let update file line_pairs t =
    (* given a pairs of line update the line mapping *)
    let line_map, cur_min, _, cur_diff =
      List.fold_left line_pairs ~init:(V.empty, 0, -1, 0)
        ~f:(fun (line_map, cur_min, cur_max, cur_diff) (line_org, line_patch) ->
          if Int.equal cur_min 0 then
            (* at first iteration, store the unpatched line info *)
            (V.add (0, line_org - 1) cur_diff line_map, line_org, line_org, line_patch - line_org)
          else
            let diff = line_patch - line_org in
            match Int.compare cur_diff diff with
            | 0 ->
                (* if the diff unchanged, increase the interval size *)
                (line_map, cur_min, line_org, diff)
            | _ ->
                (* if the diff changed, update the line map *)
                (V.add (cur_min, cur_max) cur_diff line_map, line_org, line_org, diff))
    in
    let line_map = V.add (cur_min, -1) cur_diff line_map in
    add file line_map t
end

(**************************************)
(* Modules for patch node information *)
(**************************************)
module PatchMap = struct
  module V = struct
    type t = {is_modified: AbsBool.t; pass: int; total: int}

    let pp fmt {is_modified; pass; total} =
      F.fprintf fmt "{is_modified: %a, pass: %d, total: %d}" AbsBool.pp is_modified pass total


    let init_modified = {is_modified= AbsBool.V true; pass= 0; total= 0}

    let init_affected = {is_modified= AbsBool.V false; pass= 0; total= 0}

    let is_modified {is_modified} = AbsBool.is_top is_modified || AbsBool.is_true is_modified

    let is_affected {is_modified} = AbsBool.is_top is_modified || AbsBool.is_false is_modified

    let bottom = {is_modified= AbsBool.bottom; pass= 0; total= 0}

    let join lhs rhs =
      { is_modified= AbsBool.join lhs.is_modified rhs.is_modified
      ; pass= lhs.pass + rhs.pass
      ; total= lhs.pass + rhs.pass }
  end

  include PrettyPrintable.MakePPMonoMap (Node) (V)

  let add node v t = if mem node t then add node (V.join v (find node t)) t else add node v t

  let add_modified node t = add node V.init_modified t

  let add_affected node t = add node V.init_affected t

  let get_modified_nodes t =
    fold (fun node v acc -> if V.is_modified v then NodeSet.add node acc else acc) t NodeSet.empty


  let get_affected_nodes t =
    fold (fun node v acc -> if V.is_affected v then NodeSet.add node acc else acc) t NodeSet.empty


  let get_all_patch_nodes t = NodeSet.union (get_modified_nodes t) (get_affected_nodes t)

  let update_pass_count node (t_count, f_count) ~is_true t =
    let count = if is_true then t_count else f_count in
    update node
      (function
        | Some {is_modified; pass; total} ->
            Some {is_modified; pass= pass + count; total= total + t_count + f_count}
        | None ->
            None)
      t
end

module PatchInfo = struct
  (* Target proc -> (nodes directly patched, nodes affected by patch) *)

  include PrettyPrintable.MakePPMonoMap (Procname) (PatchMap)

  let find pname t = if mem pname t then find pname t else PatchMap.empty

  let is_target_proc pname t = mem pname t

  let get_modified_nodes pname t = PatchMap.get_modified_nodes (find pname t)

  let get_affected_nodes pname t = PatchMap.get_affected_nodes (find pname t)

  let get_all_patch_nodes pname t =
    NodeSet.union (get_affected_nodes pname t) (get_modified_nodes pname t)


  let get_target_procs t = fold (fun pname _ acc -> Procname.Set.add pname acc) t Procname.Set.empty

  let update_modified_node ?(add_nodes = true) pname node t =
    let new_patch_map =
      if add_nodes then PatchMap.add_modified node (find pname t) else find pname t
    in
    add pname new_patch_map t


  let update_affected_node ?(add_nodes = true) pname node t =
    let new_patch_map =
      if add_nodes then PatchMap.add_affected node (find pname t) else find pname t
    in
    add pname new_patch_map t


  let is_modified_node node t =
    let procname = Node.get_proc_name node in
    let modified_nodes = get_modified_nodes procname t in
    NodeSet.mem node modified_nodes
end

type t = {patch_info: PatchInfo.t; line_mapping: LineMapping.t}

let marshalled_path = Filename.concat Config.results_dir "patch.data"

let pp fmt t =
  F.fprintf fmt "Node info: %a@, Line mapping : %a@." PatchInfo.pp t.patch_info LineMapping.pp
    t.line_mapping


let get_target_procs t = PatchInfo.get_target_procs t.patch_info

let to_marshal path t = Utils.with_file_out path ~f:(fun oc -> Marshal.to_channel oc t [])

let export_target_info t =
  let target_procs = get_target_procs t in
  Procname.Set.fold
    (fun procname acc ->
      match Procname.get_class_name procname with
      | Some cname ->
          let param_str =
            List.fold_left ~init:""
              ~f:(fun acc param ->
                match param with
                | Procname.Parameter.JavaParameter typ ->
                    F.asprintf "%s,%s" acc (Typ.to_string typ)
                | _ ->
                    acc)
              (Procname.get_parameters procname)
          in
          let result_str = F.asprintf "%s/%s/%s" cname (Procname.get_method procname) param_str in
          acc ^ "\n" ^ result_str
      | _ ->
          acc)
    target_procs ""


let parse_diff patch_diff =
  (* patch info : (source file, deleted lines from org, inserted lines to patch, pairs of unchanged lines) *)
  let hunks = Str.split (Str.regexp "^---.*$") patch_diff in
  (* extract patch info by iterating each hunk *)
  List.fold hunks ~init:[] ~f:(fun acc hunk ->
      let _ = L.progress "Target Hunk : %s@." hunk in
      (* get the source file name, deleted lines in org, inserted lines in patch, mapping of unchanged lines *)
      let modified = ref 0 in
      let deleted_local = ref 0 in
      let inserted_local = ref 0 in
      let source, deletions, insertions, unchanges, _ =
        List.fold
          (Str.split (Str.regexp "\n") hunk)
          ~init:(None, [], [], [], 0)
          ~f:(fun (source, deletions, insertions, unchanges, cur_line) line_str ->
            (* let _ =
              L.progress "[DEBUG] Line %d (-%d, +%d, %d): %s@." cur_line !deleted_local !inserted_local
                !modified line_str
            in *)
            if String.is_prefix line_str ~prefix:"+++" then
              (* start parsing of patch chunk *)
              let _ = L.progress "[PROGRESS] Source parsing@." in
              let source_path =
                String.concat ~sep:"/" @@ List.tl_exn
                @@ Str.split (Str.regexp "/")
                @@ List.hd_exn @@ List.tl_exn
                @@ Str.split (Str.regexp "[ \t]+") line_str
              in
              (Some source_path, deletions, insertions, unchanges, 0)
            else if String.is_prefix line_str ~prefix:"@@" then (
              (* let _ = L.progress "[DEBUG] Code hunk@." in *)
              let start_line =
                int_of_string @@ List.hd_exn @@ Str.split (Str.regexp "[-@ ,+]+") line_str
              in
              modified := !modified + !inserted_local - !deleted_local ;
              deleted_local := 0 ;
              inserted_local := 0 ;
              (source, deletions, insertions, unchanges, start_line) )
            else if String.is_prefix line_str ~prefix:"-" then (
              (* if deletion occurs, count the removed line *)
              (* let _ = L.progress "[DEBUG] Deletion Parsing@." in *)
              deleted_local := !deleted_local + 1 ;
              let line_removed = cur_line - !inserted_local in
              (source, line_removed :: deletions, insertions, unchanges, cur_line + 1) )
            else if String.is_prefix line_str ~prefix:"+" then (
              (* if insertion occurs, count the inserted line *)
              (* let _ = L.progress "[DEBUG] Insertion parsing@." in *)
              inserted_local := !inserted_local + 1 ;
              let line_inserted = cur_line + !modified - !deleted_local in
              (source, deletions, line_inserted :: insertions, unchanges, cur_line + 1) )
            else
              let line_org = cur_line - !inserted_local in
              let line_patch = cur_line + !modified - !deleted_local in
              (source, deletions, insertions, (line_org, line_patch) :: unchanges, cur_line + 1))
      in
      match source with
      | Some source ->
          (source, deletions, insertions, List.sort unchanges ~compare:Interval.compare) :: acc
      | None ->
          acc)


let from_diff program patch_diff =
  let parsed_data = parse_diff patch_diff in
  let patch_info, line_mapping =
    List.fold parsed_data ~init:(PatchInfo.empty, LineMapping.empty)
      ~f:(fun (patch_info, line_mapping) (source, deletions, insertions, unchanged) ->
        try 
          let file = source_file_from_string (Program.get_files program) source in
          L.progress
            "[PROGRESS] Parsing Info : \n\
            \          - Source File : %a@,\n\
            \          - deleted line (org) : %a@,\n\
            \          - inserted line (patch) : %a@,\n\
            \          - line mapping (unchanged) : %a@." SourceFile.pp file (Pp.seq Int.pp) deletions
            (Pp.seq Int.pp) insertions
            (Pp.seq (Pp.pair ~fst:Int.pp ~snd:Int.pp))
            unchanged ;
          (* Update line matching between original file and patched file *)
          let line_mapping = LineMapping.update file unchanged line_mapping in
          (* Add patched node info, if the one of deletion or insertion then only store the patched method *)
          let update_patch_infos ?(add_nodes = true) lines patch_info =
            let rec update_patch_infos_by_line line patch_info =
              match Program.find_node_with_location program Location.{line; file; col= -1} with
              | [] ->
                  (* L.progress "[DEBUG] Line %d, no nodes@." line ; *)
                  patch_info
              | inter_nodes ->
                  let procs = List.map ~f:fst inter_nodes |> Procname.Set.of_list in
                  let update_f = PatchInfo.update_modified_node ~add_nodes in
                  if Int.equal 1 (Procname.Set.cardinal procs) then
                    List.fold_left inter_nodes ~init:patch_info ~f:(fun acc (proc_name, node) ->
                        update_f proc_name node acc)
                  else patch_info
            in
            List.fold lines ~init:patch_info ~f:(fun acc line -> update_patch_infos_by_line line acc)
          in
          let patch_info =
            if Config.aprval_preproc_org || Config.aprval_launch_spec_inference then
              update_patch_infos deletions patch_info
              |> update_patch_infos ~add_nodes:false (List.map ~f:fst unchanged)
            else
              update_patch_infos insertions patch_info
              |> update_patch_infos ~add_nodes:false (List.map ~f:snd unchanged)
          in
          (patch_info, line_mapping)
        with NoTargetSource _ -> 
          (patch_info, line_mapping))
  in
  (patch_info, line_mapping)


let cache = ref None

(* Create Patch.t from patch diff *)
let create program =
  match Utils.read_file Config.aprval_patch_dir with
  | Ok patch_diff -> (
    match !cache with
    | None ->
        let patch_info, line_mapping = from_diff program (String.concat ~sep:"\n" patch_diff) in
        cache := Some {patch_info; line_mapping} ;
        {patch_info; line_mapping}
    | Some patch ->
        patch )
  | Error msg ->
      L.(
        die InternalError "Could not read or parse error report in %s:@\n%s@."
          Config.aprval_patch_dir msg)


let from_marshal ?(force = false) () =
  match !cache with
  | Some patch ->
      patch
  | None when force ->
      let program = Program.from_marshal () in
      let patch = create program in
      to_marshal marshalled_path patch ;
      patch
  | None ->
      let patch = Utils.with_file_in marshalled_path ~f:Marshal.from_channel in
      cache := Some patch ;
      patch


(*****************************************************************)
(* Preprocessing for deciding which nodes are in the patch flows *)
(*****************************************************************)
module NodePair = struct
  type t = Node.t * Node.t [@@deriving compare]
end

module NodePairs = Caml.Set.Make (NodePair)

let find_unpatched_nodes (pname, c1, c2) nodes_org nodes_patch =
  NodeSet.fold
    (fun node_org pairs ->
      NodeSet.fold
        (fun node_patch pairs ->
          if ASTExp.check_unpatched_node (pname, c1, c2) node_org node_patch then
            NodePairs.add (node_org, node_patch) pairs
          else pairs)
        nodes_patch pairs)
    nodes_org NodePairs.empty


let find_affected_by_nodes (pname, c1, c2) line_mapping nodes_org nodes_patch =
  (* computes nodes which are uniq (deleted or inserted) and nearby nodes *)
  List.fold nodes_org
    ~init:(NodeSet.empty, NodeSet.of_list nodes_patch)
    ~f:(fun (affected_org, affected_patch) node_org ->
      (* L.progress "[DEBUG] Target Node : %a@." Node.pp node_org ; *)
      let file = (Node.get_loc node_org).file in
      let line_org = (Node.get_loc node_org).line in
      let equal_nodes =
        NodeSet.filter
          (fun node_patch ->
            let line_patch = (Node.get_loc node_patch).line in
            Int.equal line_patch (LineMapping.compute_patch_line file line_org line_mapping)
            && ASTExp.check_equiv_node (pname, c1, c2) node_org node_patch)
          affected_patch
      in
      if NodeSet.is_empty equal_nodes then (NodeSet.add node_org affected_org, affected_patch)
      else (affected_org, NodeSet.diff affected_patch equal_nodes))


let compute_patch_impact program patch_map nodes_affected =
  let nodes_modified = PatchMap.get_modified_nodes patch_map in
  (* if the affection is determined by insertion and deletion of node, remove it since it is unmodified actually *)
  (* let nodes_inaffected =
       let is_patched_prune_node node =
         match Node.get_kind node with
         | Node.Prune_node _ ->
             NodeSet.mem node nodes_modified
         | _ ->
             false
       in
       NodeSet.fold
         (fun node acc ->
           let preds = Node.get_preds node in
           let succs = Node.get_succs node in
           if List.exists preds ~f:is_patched_prune_node && not (NodeSet.mem node nodes_modified) then
             NodeSet.add node acc
             (* if all succs of the node are patched nodes removing of this node does not matter *)
           else if List.for_all succs ~f:(fun node' -> NodeSet.mem node' nodes_modified) then
             NodeSet.add node acc
           else acc)
         nodes_affected NodeSet.empty
     in
     let patch_map =
       NodeSet.fold (fun node acc -> PatchMap.remove node acc) nodes_inaffected patch_map
     in *)

  (* if the patch is branch insertion / deletion, rescale probabilities according to frequency of branch exeuction *)
  let modified_prune_nodes =
    NodeSet.filter
      (fun node -> match Node.get_kind node with Node.Prune_node _ -> true | _ -> false)
      nodes_modified
  in
  NodeSet.fold
    (fun node acc ->
      let instrs = Node.get_instr_list node in
      List.fold_left instrs ~init:acc ~f:(fun acc instr ->
          let instr_node = InstrNode.of_pnode node instr in
          let t, f = DynInfo.get_br_info instr_node in
          match instr with
          | Sil.Prune (UnOp (Unop.LNot, _, _), _, _, _) ->
              PatchMap.update_pass_count node (t, f) ~is_true:false acc
          | Sil.Prune (_, _, _, _) ->
              PatchMap.update_pass_count node (t, f) ~is_true:true acc
          | _ ->
              acc))
    modified_prune_nodes patch_map
  (* If a node is successor of (insertion or deletion) block, it is directly affected by patch *)
  |> PatchMap.fold
       (fun node _ acc ->
         let preds = Node.get_preds node in
         let preds_modified = List.filter ~f:(fun node -> PatchMap.mem node acc) preds in
         if not (List.equal Node.equal preds preds_modified) then acc
         else if
           List.for_all preds ~f:(fun node' -> PatchMap.V.is_modified (PatchMap.find node' acc))
         then acc
         else PatchMap.add node PatchMap.V.init_modified acc)
       patch_map


(*
case24
line1 (affected)
- patchline (deletion)
line2 (affected) => modified 

case1
if (c) { (affected) => modified
  patch line(insertion or delition)
}
*)

let preproc t_org t_patch =
  let all_procs = Procname.Set.union (get_target_procs t_org) (get_target_procs t_patch) in
  let program_org =
    Utils.with_file_in (Filename.concat Config.aprval_org_dir "program.data") ~f:Marshal.from_channel
  in
  let program_patch = Program.from_marshal () in
  let patch_info_org', patch_info', line_mapping =
    Procname.Set.fold
      (fun pname (patch_info_org, patch_info, line_mapping) ->
        let pdesc_org = Program.pdesc_of_opt program_org pname in
        let pdesc_patch = Program.pdesc_of_opt program_patch pname in
        match (pdesc_org, pdesc_patch) with
        | Some pdesc_org, Some pdesc_patch ->
            let c1 = ASTExp.Converter.init_by_pdesc pdesc_org in
            let c2 = ASTExp.Converter.init_by_pdesc pdesc_patch in
            (* among the nodes determined as modified, find the nodes which are not modified actually *)
            let map_org, map_patch =
              (PatchInfo.find pname patch_info_org, PatchInfo.find pname patch_info)
            in
            let modified_org, modified_patch =
              (PatchMap.get_modified_nodes map_org, PatchMap.get_modified_nodes map_patch)
            in
            let unpatched_pairs =
              find_unpatched_nodes (pname, c1, c2) modified_org modified_patch
            in
            (* update line mapping and remove unpatched nodes from the patch info *)
            let map_org, map_patch, line_mapping' =
              NodePairs.fold
                (fun (node_org, node_patch) (map_org, map_patch, line_mapping) ->
                  let loc_org, loc_patch = (Node.get_loc node_org, Node.get_loc node_patch) in
                  let source_org, source_patch = (loc_org.file, loc_patch.file) in
                  if SourceFile.equal source_org source_patch then
                    let line_org, line_patch = (loc_org.line, loc_patch.line) in
                    let line_map = LineMapping.find source_org line_mapping in
                    let line_map' =
                      LineMapping.V.add (line_org, line_org) (line_patch - line_org) line_map
                    in
                    ( PatchMap.remove node_org map_org
                    , PatchMap.remove node_patch map_patch
                    , LineMapping.add source_org line_map' line_mapping )
                  else
                    L.(die InternalError)
                      "Patch node is buggy : %a, %a" Node.pp node_org Node.pp node_patch)
                unpatched_pairs
                (map_org, map_patch, line_mapping)
            in
            (* find the nodes affected by the modification and added them to patch info *)
            let affected_org, affected_patch =
              find_affected_by_nodes (pname, c1, c2) line_mapping' (Procdesc.get_nodes pdesc_org)
                (Procdesc.get_nodes pdesc_patch)
            in
            L.progress "ASD2F" ;
            let map_org =
              NodeSet.fold (fun node acc -> PatchMap.add_affected node acc) affected_org map_org
            in
            let map_patch =
              NodeSet.fold (fun node acc -> PatchMap.add_affected node acc) affected_patch map_patch
            in
            (* among the affected nodes calculated above, removing the unexecuted branches which are not affected actually *)
            let map_org, map_patch =
              ( compute_patch_impact program_org map_org affected_org
              , compute_patch_impact program_patch map_patch affected_patch )
            in
            ( PatchInfo.add pname map_org patch_info_org
            , PatchInfo.add pname map_patch patch_info
            , line_mapping' )
        | _ ->
            (patch_info_org, patch_info, line_mapping))
      all_procs
      (t_org.patch_info, t_patch.patch_info, t_patch.line_mapping)
  in
  let line_mapping = LineMapping.merge_interval line_mapping in
  ({patch_info= patch_info_org'; line_mapping}, {patch_info= patch_info'; line_mapping})
