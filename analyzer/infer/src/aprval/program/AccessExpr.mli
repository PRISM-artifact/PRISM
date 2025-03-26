open! IStd
module F = Format

type t = base * access list [@@deriving compare]

and base = Formal of Pvar.t | Variable of Pvar.t | Primitive of Const.t | Exn of string

and access = FieldAccess of Fieldname.t | MethodCallAccess of method_call | ArrayAccess of t

and method_call = Procname.t * t list

val compare : t -> t -> int

val equal : t -> t -> bool

val equal_wo_formal : t -> t -> bool

val pp : F.formatter -> t -> unit

val of_pvar : Pvar.t -> t

val of_formal : Pvar.t -> t

val of_const : Const.t -> t

val of_exn : string -> t

val of_fn : Fieldname.t -> access

val get_deref_field : t -> string

val get_locals : Procdesc.t -> t list

val get_formals : Procdesc.t -> t list

val get_this : Procdesc.t -> t

val get_ret : Procdesc.t -> t

val is_local : Procdesc.t -> t -> bool

val is_formal : t -> bool

val is_this : t -> bool

val is_this_base : t -> bool

val is_exn : ?include_runtime:bool -> t -> bool

val is_param : Procdesc.t -> t -> bool

val is_return : Procdesc.t -> t -> bool

val is_sub_expr : sub:t -> t -> bool

val is_var : t -> bool

val contains_field_access : t -> bool

val contains_method_access : t -> bool

val contains_access : t -> bool

val replace_sub : t -> src:t -> dst:t -> t

val replace_by_map : f:(t -> t) -> t -> t

val append_access : t -> access -> t

val dummy_base : base

val dummy : t

val from_IR_exp : Procdesc.t -> Exp.t -> t

val from_IR_exp_opt : Procdesc.t -> Exp.t -> t option

val bind_pdesc : Procdesc.t -> unit

val null : t

val zero : t

val one : t

val has_duplicates : t -> bool

val equal_base : base -> base -> bool

val equal_access : access -> access -> bool

val is_abstract : t -> bool

val is_constant : t -> bool

val is_default_const : t -> bool

val is_non_default_const : t -> bool

val is_concrete : t -> bool

val is_different_type : t -> t -> bool

val is_same_type : t -> t -> bool

val is_recursive : t -> bool

val is_null : t -> bool

module Set : PrettyPrintable.PPSet with type elt = t

module Map : PrettyPrintable.PPMap with type key = t

module AbsSet : sig
  include AbstractDomain.FiniteSetS with type elt = t

  val is_uniq_const : t -> bool

  val get_uniq_const : t -> elt option

  val has_consts : t -> bool

  val get_consts : t -> t
end
