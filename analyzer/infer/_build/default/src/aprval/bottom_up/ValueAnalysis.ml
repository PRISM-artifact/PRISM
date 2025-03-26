open! IStd
open! Vocab
module F = Format
module L = Logging
module Val = SymDom.Val
module APSet = AccessExpr.AbsSet

(* Case of use of value *)
module UseCase = struct
  type t = Param | RValue | Branch | Any [@@deriving compare]

  let pp fmt = function
    | Param ->
        F.fprintf fmt "Param"
    | RValue ->
        F.fprintf fmt "RValue"
    | Branch ->
        F.fprintf fmt "Branch"
    | _ ->
        F.fprintf fmt "Any"


  let is_top = function Any -> true | _ -> false

  let is_important = function Param | RValue | Branch -> true | _ -> false
end

module ValUse = struct
  include WeakMap.Make (UseCase) (Val.Set)
end

module ValDep = struct
  include WeakMap.Make (Val) (Val.Set)

  let weak_update v vset t =
    (* do not update dependency about top value *)
    if Val.is_top v then t
    else
      let reachables =
        Val.Set.fold (fun v acc -> if mem v t then Val.Set.union (find v t) acc else acc) vset vset
        |> Val.Set.filter (not <<< Val.is_top)
      in
      weak_update v reachables t


  let is_dependent ~src ~dst t =
    (* checking there exist data flow from src to dst *)
    Val.equal src dst
    || match find_opt dst t with Some vset -> Val.Set.mem src vset | None -> false
end

module APUse = struct
  include WeakMap.Make (UseCase) (APSet)

  let construct val_to_ap used_val =
    ValUse.fold
      (fun use vset acc ->
        let aps =
          Val.Set.fold (fun v acc -> APSet.union (ValToAP.find v val_to_ap) acc) vset APSet.empty
        in
        weak_update use aps acc)
      used_val empty


  let find_use ?(usecase = UseCase.Any) t = try find usecase t with _ -> APSet.empty

  let all_values t = fold (fun _ aps acc -> APSet.union aps acc) t APSet.empty

  let is_used v t = APSet.mem v (all_values t)
end

module APDep = struct
  include WeakMap.Make (AccessExpr) (APSet)

  let construct val_to_ap value_dependency =
    ValDep.fold
      (fun v vset acc ->
        let aps_lhs = ValToAP.find v val_to_ap in
        let aps_rhs =
          Val.Set.fold (fun v acc -> APSet.union (ValToAP.find v val_to_ap) acc) vset APSet.empty
        in
        APSet.fold (fun ap acc -> weak_update ap aps_rhs acc) aps_lhs acc)
      value_dependency empty
end
