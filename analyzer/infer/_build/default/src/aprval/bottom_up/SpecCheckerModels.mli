module Domain = SpecCheckerDomain

module Collection : sig
  val setIsEmpty : Domain.t -> InstrNode.t -> SymDom.Loc.t -> Domain.t list
end

type exec =
     Domain.t
  -> Procdesc.t
  -> InstrNode.t
  -> Procname.t
  -> Ident.t * Typ.t
  -> (Exp.t * Typ.t) list
  -> Domain.t list

val is_model : Procname.t -> Sil.instr -> bool

val exec_model : exec

(* module Call : sig
  val dispatch : (Tenv.t, exec, unit) ProcnameDispatcher.Call.dispatcher
end *)
