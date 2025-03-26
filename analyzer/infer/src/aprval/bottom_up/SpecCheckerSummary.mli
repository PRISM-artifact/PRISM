open! IStd
module Domain = SpecCheckerDomain

type t

type get_summary = Procname.t -> t option

val pp : Format.formatter -> t -> unit

val empty : t

val to_summary : Procdesc.t -> Domain.t list -> t

val get_disjuncts : t -> Domain.t list

val get_local_disjuncts : t -> Domain.t list

val resolve_callee_state :
  Domain.t -> actual_values:SymDom.Val.t list -> callee_pdesc:Procdesc.t -> t -> Domain.t list

val update_caller_by_callee :
     caller_state:Domain.t
  -> callee_state:Domain.t
  -> caller_pdesc:Procdesc.t
  -> callee_pdesc:Procdesc.t
  -> Ident.t * Typ.t
  -> Domain.t option
