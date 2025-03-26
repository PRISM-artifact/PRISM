module Val = SymDom.Val
module APSet = AccessExpr.AbsSet

module UseCase : sig
  (* Checking use of each value
     * param: the value is used as function call arg
     * rvalue: the value is used as rhs value
     * branch: the value is used for generating branch condition
     * exn: the value is used in the exceptional flow
     * ctor: the value is used for generating a new constructor
     * other
  *)
  type t = Param | RValue | Branch | Any [@@deriving compare]

  val pp : Format.formatter -> t -> unit

  val is_top : t -> bool
end

(* Tracking the use case of each value *)
module ValUse : module type of WeakMap.Make (UseCase) (Val.Set)

(* Tracking the dependnecy of each value *)
module ValDep : sig
  include module type of WeakMap.Make (Val) (Val.Set)

  val is_dependent : src:Val.t -> dst:Val.t -> t -> bool
end

(* AP version of usage analysis *)
module APUse : sig
  include module type of WeakMap.Make (UseCase) (APSet)

  val pp : Format.formatter -> t -> unit

  val construct : ValToAP.t -> ValUse.t -> t

  val find_use : ?usecase:UseCase.t -> t -> APSet.t

  val all_values : t -> APSet.t

  val is_used : AccessExpr.t -> t -> bool
end

(* AP version of dependency analysis *)
module APDep : sig
  include module type of WeakMap.Make (AccessExpr) (APSet)

  val pp : Format.formatter -> t -> unit

  val construct : ValToAP.t -> ValDep.t -> t
end
