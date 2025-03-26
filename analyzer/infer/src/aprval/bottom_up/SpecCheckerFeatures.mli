open! IStd
open! Vocab
module Spec = StateFormula.Spec

(* denoting (gen, removal, remain) of each property *)
type change = bool * bool * bool

type exec = Spec.t -> Spec.t -> change

type model = string * exec

module DefUse : sig
  (* features about variables' def-use states *)
  val defined_local : exec

  val used_local : exec

  val unused_local : exec

  val used_param : exec

  val unused_param : exec

  val used_this : exec

  val unused_this : exec

  val used_fn : exec

  val unused_fn : exec

  val models : model list
end

module Crash : sig
  (* features about runtime crash *)
  val npe : exec

  val illegal_call : exec

  val out_of_bound : exec

  val throwable_exn : exec

  val models : model list
end

module Memory : sig
  (* features about memory state *)
  val local_null : exec

  val ret_null : exec

  val fn_null : exec

  val local_const : exec

  val ret_const : exec

  val fn_const : exec

  val models : model list
end

module Mthd : sig
  val const_mthd : exec

  val err_mthd : exec

  val models : model list
end

module Dep : sig
  val ret_dep_param : exec

  val ret_dep_local : exec

  val models : model list
end

(* module ValUse : sig
  val const_in_rhs : exec

  val const_in_cond : exec

  val const_in_param : exec

  val non_const_in_rhs : exec

  val non_const_in_cond : exec

  val non_const_in_param : exec

  val models : model list
end *)
