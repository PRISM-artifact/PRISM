open! IStd
open! Vocab
module F = Format
module L = Logging
module Node = InstrNode
module Val = SymDom.Val
module PC = SymDom.PC
module Mem = SymDom.Mem

type kind = CALL of Procname.t | OOB | NPE | Bot [@@deriving compare]

let is_crash_call_kind kind = match kind with CALL _ -> true | _ -> false

let is_oob_kind kind = match kind with OOB -> true | _ -> false

let is_npe_kind kind = match kind with NPE -> true | _ -> false

let pp_kind fmt = function
  | CALL pname ->
      F.fprintf fmt "CALL(%a)" Procname.pp pname
  | OOB ->
      F.fprintf fmt "OOB"
  | NPE ->
      F.fprintf fmt "NPE"
  | Bot ->
      F.fprintf fmt "Bot"


module V = struct
  (*
    node : instr_node that runtime crash occurs
    crash_type : what kind of runtime crash occurs by failing test execution
      - CALL : Exception from arbitrary function calls
      - NPE : Call with null base
      - OOB : ArrayOutOfBounds 
    is_modified : flag notifying that the runtime crash modified directly (the node is included in patch nodes)
    is_affected : flag notifying that the runtime crash affected by patch (important values are dependent to patch point)
  *)

  type t = {node: Node.t; kind: kind; is_modified: bool; is_affected: bool} [@@deriving compare]

  let bottom = {node= Node.dummy; kind= Bot; is_modified= false; is_affected= false}

  let get_node {node} = node

  let get_kind {kind} = kind

  let is_crash_call {kind} = match kind with CALL _ -> true | _ -> false

  let is_oob {kind} = match kind with OOB -> true | _ -> false

  let is_npe {kind} = match kind with NPE -> true | _ -> false

  let is_modified {is_modified} = is_modified

  let is_affected {is_affected} = is_affected

  let set_modified t = {t with is_modified= true}

  let set_affected t = {t with is_affected= true}

  (* mthds that never cause runtime crash *)
  let non_target_mthds = [("java.lang.StringBuffer", "append")]

  let is_non_target_mthd {kind} =
    match kind with
    | CALL callee -> (
      match callee with
      | Procname.Java mthd ->
          List.exists non_target_mthds ~f:(fun (cls, mthd') ->
              String.equal (Procname.get_method callee) mthd'
              && String.equal (Procname.Java.get_class_type_name mthd |> Typ.Name.name) cls)
      | _ ->
          false )
    | _ ->
        false


  let check_line_match node_org node_patch =
    let patch = Patch.from_marshal () in
    try
      let file_patched = InstrNode.get_source node_patch in
      let line_patch = InstrNode.get_line node_patch in
      let line_org = InstrNode.get_line node_org in
      Int.equal line_patch
        (Patch.LineMapping.compute_patch_line file_patched line_org patch.line_mapping)
    with _ -> false


  let is_comparable_node node_org node_patch =
    match (InstrNode.get_instr node_org, InstrNode.get_instr node_patch) with
    | Sil.Call (_, Const (Cfun proc), _, _, _), Sil.Call (_, Const (Cfun proc'), _, _, _) ->
        Procname.equal proc proc' && check_line_match node_org node_patch
    (* TODO : this unprecise compare can cause false alarm => exp equality required *)
    | Sil.Load {e= Lindex (e1, e2)}, Sil.Load {e= Lindex (e1', e2')}
    | Sil.Store {e1= Lindex (e1, e2)}, Sil.Store {e1= Lindex (e1', e2')} ->
        check_line_match node_org node_patch
    | _ ->
        false


  let is_comparable t1 t2 = is_comparable_node t1.node t2.node

  let pp fmt {node; kind; is_modified; is_affected} =
    F.fprintf fmt "{node: %a;kind: %a;is_modified: %b;is_affected: %b}" Node.pp node pp_kind kind
      is_modified is_affected
end

include PrettyPrintable.MakePPSet (V)

let join = union
