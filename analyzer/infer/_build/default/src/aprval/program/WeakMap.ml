open! IStd

module Make (Key : PrettyPrintable.PrintableOrderedType) (Value : AbstractDomain.WithBottom) =
struct
  include AbstractDomain.Map (Key) (Value)

  let compare t1 t2 =
    let _compare t1 t2 =
      compare
        (fun v1 v2 -> if phys_equal v1 v2 then 0 else if Value.leq ~lhs:v1 ~rhs:v2 then -1 else 1)
        t1 t2
    in
    if cardinal t1 < cardinal t2 then -1
    else if cardinal t1 > cardinal t2 then 1
    else _compare t1 t2


  let find loc m = try find loc m with _ -> Value.bottom

  let weak_update loc v reg =
    if Value.is_bottom v then reg else add loc (Value.join v (find loc reg)) reg


  let strong_update loc v reg = add loc v reg
end
