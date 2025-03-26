open! IStd
open! Vocab
module F = Format
module L = Logging
module Loc = SymDom.Loc
module APSet = AccessExpr.AbsSet

module AccessState = struct
  type t = Must | May | Unused | Undef [@@deriving compare]

  let pp fmt t =
    match t with
    | Must ->
        F.fprintf fmt "Must"
    | May ->
        F.fprintf fmt "May"
    | Unused ->
        F.fprintf fmt "Unused"
    | Undef ->
        F.fprintf fmt "Undef"


  let leq ~lhs ~rhs =
    match (lhs, rhs) with
    | lhs, rhs when phys_equal lhs rhs ->
        true
    | _, May ->
        true
    | Undef, _ ->
        true
    | _ ->
        false


  let is_bottom = function Undef -> true | _ -> false

  let is_top = function May -> true | _ -> false

  let bottom = Undef

  let top = May

  let join lhs rhs =
    match (lhs, rhs) with
    | lhs, rhs when phys_equal lhs rhs ->
        lhs
    | Undef, v | v, Undef ->
        v
    | _ ->
        May


  let widen ~prev ~next ~num_iters:_ = join prev next

  let is_unused = function Unused -> true | _ -> false

  let is_accessed = function Must | May -> true | _ -> false
end

(* dummy line means untractable def point (e.g., heap)
   dummy lines are propagated to caller state by being resolved as caller def point *)
let dummy_line = -1

module LineInfo = struct
  type t = Procname.t * int [@@deriving compare]

  let pp fmt (pname, line) =
    F.fprintf fmt "%a_%d" (Procname.pp_simplified_string ~withclass:true) pname line
end

module LineInfoSet = PrettyPrintable.MakePPSet (LineInfo)

module AccessedLoc = struct
  module LocDef = struct
    type t = Loc.t * LineInfo.t [@@deriving compare]

    let pp fmt (loc, line_info) = F.fprintf fmt "%a:%a" Loc.pp loc LineInfo.pp line_info
  end

  module DUMap = struct
    (* TODO : def location of extern heap's access is not captured precisely yet *)
    include WeakMap.Make (LocDef) (AccessState)

    let access loc line_infos t =
      LineInfoSet.fold
        (fun line_info acc -> strong_update (loc, line_info) AccessState.Must acc)
        line_infos t


    let def (loc, line) t =
      (* if the loc at same line already exists -> may use (e.g., loop) *)
      weak_update (loc, line) AccessState.Unused t
      |> (* Heuristic: removing the def cite only defined before new def (may be initialize) *)
      filter (fun (loc', line') du' ->
          if
            Loc.equal loc loc'
            && Procname.equal (fst line') (fst line)
            && snd line' < snd line
            && AccessState.is_unused du'
          then false
          else true)


    let join lhs rhs =
      merge
        (fun (loc, _) v_lhs v_rhs ->
          match (v_lhs, v_rhs) with
          | Some l, Some r ->
              Some (AccessState.join l r)
          | Some v, _ | _, Some v ->
              if Loc.is_heap loc then Some (AccessState.join v AccessState.Unused) else Some v
          | _ ->
              None)
        lhs rhs
  end

  module DefMap = struct
    include PrettyPrintable.MakePPMonoMap (Loc) (LineInfoSet)

    let join lhs rhs =
      merge
        (fun l lhs_set rhs_set ->
          match (lhs_set, rhs_set) with
          | Some lv, Some rv ->
              Some (LineInfoSet.union lv rv)
          | Some v, _ | _, Some v ->
              if Loc.is_heap l then
                let dummy_infos = LineInfoSet.map (fun (pname, _) -> (pname, dummy_line)) v in
                Some (LineInfoSet.union dummy_infos v)
              else Some v
          | _ ->
              None)
        lhs rhs


    let find pname loc t =
      match find_opt loc t with
      | Some lines ->
          lines
      | None ->
          LineInfoSet.singleton (pname, dummy_line)


    let strong_update loc line_info t = add loc (LineInfoSet.singleton line_info) t
  end

  (* in analysis procedure, it maintains two component :
     1. (loc, line) -> du state
     2. loc -> last def lines
  *)
  type t = {analysis: DUMap.t; defmap: DefMap.t}

  let pp fmt {analysis; defmap} =
    F.fprintf fmt "@[<v 3>* DUMap:@, %a@,* DefMap:@, %a@]" DUMap.pp analysis DefMap.pp defmap


  let bottom = {analysis= DUMap.empty; defmap= DefMap.empty}

  let join lhs rhs =
    {analysis= DUMap.join lhs.analysis rhs.analysis; defmap= DefMap.join lhs.defmap rhs.defmap}


  let filter_by_loc ~f t =
    { analysis= DUMap.filter (fun (l, _) _ -> f l) t.analysis
    ; defmap= DefMap.filter (fun l _ -> f l) t.defmap }


  let access_loc pname loc t =
    if Loc.is_null loc || Loc.is_global loc then t
    else
      let lines = DefMap.find pname loc t.defmap in
      {analysis= DUMap.access loc lines t.analysis; defmap= t.defmap}


  let def_loc loc (pname, line) t =
    { analysis= DUMap.def (loc, (pname, line)) t.analysis
    ; defmap= DefMap.strong_update loc (pname, line) t.defmap }
end

module AccessedAP = struct
  module APDef = struct
    type t = AccessExpr.t * LineInfo.t [@@deriving compare]

    let pp fmt (loc, line_info) = F.fprintf fmt "%a:%a" AccessExpr.pp loc LineInfo.pp line_info

    let equal = [%compare.equal: t]
  end

  module APDefSet = PrettyPrintable.MakePPSet (APDef)
  include WeakMap.Make (APDef) (AccessState)

  let construct val_to_ap accessed =
    AccessedLoc.DUMap.fold
      (fun (l, line_info) state acc ->
        let ap_locs = ValToAP.find_loc l val_to_ap in
        (* If an ap represents heap instead of var or symbol(param), it may be an points-to heap *)
        APSet.fold (fun ap_loc acc -> weak_update (ap_loc, line_info) state acc) ap_locs acc)
      accessed empty


  let is_defined ap_def t =
    match find ap_def t with
    | AccessState.Undef when AccessExpr.is_var (fst ap_def) ->
        false
    | _ ->
        true


  let must_accessed ap_def t = match find ap_def t with AccessState.Must -> true | _ -> false

  let may_accessed ap_def t = match find ap_def t with AccessState.May -> true | _ -> false

  let is_used ap_def t =
    match find ap_def t with AccessState.Must | AccessState.May -> true | _ -> false


  let is_unused ap_def t =
    match find ap_def t with
    | AccessState.Unused ->
        true
    | AccessState.Undef ->
        AccessExpr.contains_field_access (fst ap_def)
    | _ ->
        false


  let is_defined ap_def t = match find ap_def t with AccessState.Undef -> false | _ -> true

  let check_gen_def before after ap_def =
    let r = (not (is_defined ap_def before)) && is_defined ap_def after in
    if r then set_msg_debugger (F.asprintf "[Gen]:def of %a @." APDef.pp ap_def) ;
    r


  let check_rm_def before after ap_def =
    let r = is_defined ap_def before && not (is_defined ap_def after) in
    if r then set_msg_debugger (F.asprintf "[Rm]:def of %a @." APDef.pp ap_def) ;
    r


  let check_remain_def before after ap_def =
    let r = is_defined ap_def before && is_defined ap_def after in
    if r then set_msg_debugger (F.asprintf "[Remain]:def of %a @." APDef.pp ap_def) ;
    r


  let check_gen_used before after ap_def =
    let r = is_unused ap_def before && is_used ap_def after in
    if r then set_msg_debugger (F.asprintf "[Gen]:use of %a @." APDef.pp ap_def) ;
    r


  let check_rm_used before after ap_def =
    let r = is_used ap_def before && is_unused ap_def after in
    if r then set_msg_debugger (F.asprintf "[Rm]:use of %a @." APDef.pp ap_def) ;
    r


  let check_remain_used before after ap_def =
    let r = is_used ap_def before && is_used ap_def after in
    if r then set_msg_debugger (F.asprintf "[Remain]:use of %a @." APDef.pp ap_def) ;
    r


  let check_gen_unused before after ap_def =
    let r = (not (is_unused ap_def before)) && is_unused ap_def after in
    if r then set_msg_debugger (F.asprintf "[Gen]:unused %a @." APDef.pp ap_def) ;
    r


  let check_rm_unused before after ap_def =
    let r = is_unused ap_def before && not (is_unused ap_def after) in
    if r then set_msg_debugger (F.asprintf "[Rm]:unused %a @." APDef.pp ap_def) ;
    r


  let check_remain_unused before after ap_def =
    let r = is_unused ap_def before && is_unused ap_def after in
    if r then set_msg_debugger (F.asprintf "[Remain]:unused %a @." APDef.pp ap_def) ;
    r
end
