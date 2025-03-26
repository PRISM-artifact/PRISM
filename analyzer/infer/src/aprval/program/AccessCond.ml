open! IStd
open! Vocab
module F = Format
module L = Logging
module Node = InstrNode

module S = struct
  type cond = Leaf of AccessExpr.t | Neg of cond | Comp of (Binop.t * cond * cond)
  [@@deriving compare]

  type t = cond * Node.t * AbsBool.t [@@deriving compare]

  let rec equal_cond t1 t2 =
    match (t1, t2) with
    | Leaf ap1, Leaf ap2 ->
        AccessExpr.equal ap1 ap2
    | Neg ac1, Neg ac2 ->
        equal_cond ac1 ac2
    | Comp (op1, x1, y1), Comp (op2, x2, y2) ->
        Binop.equal op1 op2 && equal_cond x1 x2 && equal_cond y1 y2
    | _ ->
        false


  let rec pp_cond fmt = function
    | Leaf ap ->
        AccessExpr.pp fmt ap
    | Neg ac ->
        F.fprintf fmt "!(%a)" pp_cond ac
    | Comp (op, x, y) ->
        F.fprintf fmt "(%a %a %a)" pp_cond x Binop.pp op pp_cond y


  let pp fmt (cond, node, b) = F.fprintf fmt "(%a):%a,%a" pp_cond cond Node.pp node AbsBool.pp b

  let rec from_IR_exp_opt pdesc exp =
    match exp with
    | Exp.BinOp (bop, e1, e2) -> (
      match (from_IR_exp_opt pdesc e1, from_IR_exp_opt pdesc e2) with
      | Some ac1, Some ac2 ->
          Some (Comp (bop, ac1, ac2))
      | _ ->
          None )
    | Exp.UnOp (Unop.LNot, e, _) -> (
      match from_IR_exp_opt pdesc e with Some ac -> Some (Neg ac) | None -> None )
    | e -> (
      match AccessExpr.from_IR_exp_opt pdesc e with Some ap -> Some (Leaf ap) | _ -> None )


  let rec sub_aps = function
    | Leaf ap ->
        [ap]
    | Neg ac ->
        sub_aps ac
    | Comp (_, x, y) ->
        sub_aps x @ sub_aps y


  let rec is_unary_boolean = function
    | Neg ac ->
        is_unary_boolean ac
    | Comp (Binop.Ne, Leaf _, Leaf (AccessExpr.Primitive (Cint i), [])) when IntLit.iszero i ->
        not (IntLit.isnull i)
    | _ ->
        false
end

include S
module Set = PrettyPrintable.MakePPSet (S)
