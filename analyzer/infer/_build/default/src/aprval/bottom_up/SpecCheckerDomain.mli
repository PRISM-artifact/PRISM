module Loc = SymDom.Loc
module Val = SymDom.Val
module PathCond = SymDom.PathCond
module PC = SymDom.PC
module Reg = SymDom.Reg
module Mem = SymDom.Mem
module UseCase = ValueAnalysis.UseCase
open AccessAnalysis
open ValueAnalysis

module PatchInfo : sig
  include module type of AbstractDomain.Map (Procdesc.Node) (Val.Set)

  val weak_update : Procdesc.Node.t -> Val.t -> t -> t
end

module Heaps : module type of PrettyPrintable.MakePPSet (SymDom.SymHeap)

type t =
  { reg: Reg.t
  ; mem: Mem.t
  ; pc: PC.t
  ; patch_info: PatchInfo.t
  ; is_target: bool
  ; is_patched: bool
  ; patch_score: float
  ; accessed: AccessedLoc.t
  ; derefed_heaps: Val.Set.t
  ; is_exceptional: bool
  ; uncaught_npes: Val.Set.t
  ; potential_npes: Val.Set.t
  ; nullified: Val.Set.t
  ; used_val_local: ValUse.t
  ; current_proc: Procname.t
  ; runtime_crash: RuntimeCrash.t
  ; value_dependency: ValDep.t }

val pp : Format.formatter -> t -> unit

val leq : lhs:t -> rhs:t -> bool

val bottom : t

val is_bottom : t -> bool

val init : Procdesc.t -> Patch.PatchInfo.t -> t

val append_ctx : t -> int -> t

val is_unknown_loc : t -> Loc.t -> bool

val is_unknown_id : t -> Ident.t -> bool

val is_valid_pc : t -> PathCond.t -> bool

val is_target : t -> bool

val is_patched : t -> bool

val is_affected_state : t -> bool

val is_exceptional : t -> bool

val current_proc : t -> Procname.t

val get_patch_nodes : t -> Patch.NodeSet.t

val get_patch_values : t -> Val.Set.t

val unify : t -> t -> t * t

val all_values : t -> Val.Set.t

val equal_values : t -> Val.t -> Val.t list

val inequal_values : t -> Val.t -> Val.t list

val collect_summary_symbols : t -> Val.Set.t

val resolve_unknown_loc : t -> Typ.t -> Loc.t -> t

val bind_exn_extern : t -> InstrNode.t -> Pvar.t -> Procname.t -> Val.t list -> t list

val bind_extern_value : t -> InstrNode.t -> Ident.t * Typ.t -> Procname.t -> Val.t list -> t list

val eval : ?usecase:UseCase.t -> t -> InstrNode.t -> Exp.t -> t * Val.t

val eval_value : t -> InstrNode.t -> Exp.t -> Val.t

val eval_lv_sub : t -> InstrNode.t -> Exp.t -> Loc.t * Val.t list

val eval_lv : t -> InstrNode.t -> Exp.t -> Loc.t

val remove_pvar : t -> pv:Pvar.t -> t

val remove_temps : t -> Procdesc.t -> Var.t list -> t

val nullify_pvar : t -> pv:Pvar.t -> t

val remove_locals : t -> pdesc:Procdesc.t -> t

val replace_value : t -> src:Val.t -> dst:Val.t -> t

val read_loc : ?typ:Typ.t option -> t -> Loc.t -> Val.t

val read_id : t -> Ident.t -> Val.t

val store_loc : t -> Loc.t -> Val.t -> t

val store_reg : t -> Ident.t -> Val.t -> t

val access_loc : Procdesc.Node.t -> Sil.instr -> Loc.t -> t -> t

val access_loc_of_value : Procdesc.Node.t -> Sil.instr -> Val.t -> t -> t

val update_derefed_heaps : Val.t -> t -> t

val def_loc : Loc.t -> Procdesc.Node.t -> t -> t

val set_exception : t -> t

val set_patched : t -> t

val set_patch_score : t -> float -> t

val update_patch_score : t -> float -> t

val gen_error_info_by_call :
  t -> InstrNode.t -> Val.t list -> Val.Set.t -> Procname.t -> RuntimeCrash.V.t

val gen_error_info_by_access : t -> InstrNode.t -> Val.t -> Val.t -> RuntimeCrash.V.t

val gen_error_info_by_null : t -> InstrNode.t -> Val.t -> RuntimeCrash.V.t

val set_runtime_crash : t -> Procdesc.t -> RuntimeCrash.V.t -> t

val use_val : ?usecase:UseCase.t -> InstrNode.t -> Val.t -> t -> t

val update_dependency : t -> lhs:Val.t -> rhs:Val.t -> t

val add_branch_only : t -> PathCond.t -> t

val add_pc_simple : ?is_branch:bool -> t -> PathCond.t -> t

val add_pc : ?is_branch:bool -> t -> PathCond.t -> t list

val remove_unreachables_summary : ?is_local:bool -> t -> Procdesc.t -> t

val unwrap_exception : t -> t

val is_null : t -> Val.t -> bool

val is_non_null : t -> Val.t -> bool

val set_npes : Val.Set.t -> Val.t list -> Val.Set.t

val set_uncaught_npes : t -> Procdesc.t -> Val.t list -> t

val set_potential_npes : t -> Val.t list -> t

val weak_join : t -> t -> t

val merge : t list -> t list

val cardinal : t -> int
