open! IStd
open! Vocab
module F = Format
module L = Logging

module S = struct
  exception UnconvertibleExpr of Exp.t

  (* Infer IntLit's compare does not distinguish pointernesses *)
  type literal_with_pointerness = IntLit.t * pointerness [@@deriving compare]

  and pointerness = bool

  type base = Formal of Pvar.t | Variable of Pvar.t | Primitive of Const.t | Exn of string
  [@@deriving compare]

  let compare_base x y =
    match (x, y) with
    | Primitive (Cint i), Primitive (Cint j) when IntLit.isnull i || IntLit.isnull j ->
        compare_literal_with_pointerness (i, IntLit.isnull i) (j, IntLit.isnull j)
    | _ ->
        compare_base x y


  type t = base * access list [@@deriving compare]

  and access = FieldAccess of Fieldname.t | MethodCallAccess of method_call | ArrayAccess of t
  [@@deriving compare]

  and method_call = Procname.t * t list

  let of_pvar pv : t = (Variable pv, [])

  let of_formal pv : t = (Formal pv, [])

  let of_const const : t = (Primitive const, [])

  let of_exn typ : t = (Exn typ, [])

  let of_fn fn = FieldAccess fn

  let dummy_base = Variable (Pvar.mk_tmp "" (Procname.from_string_c_fun "FL4APR_DUMMY"))

  let dummy = (dummy_base, [])

  let equal_base = [%compare.equal: base]

  let equal = [%compare.equal: t]

  let equal_access = [%compare.equal: access]

  let equal_base_wo_formal lhs rhs =
    match (lhs, rhs) with
    | Formal pv, Formal pv'
    | Formal pv, Variable pv'
    | Variable pv, Formal pv'
    | Variable pv, Variable pv' ->
        Pvar.equal pv pv'
    | _ ->
        equal_base lhs rhs


  let equal_wo_formal (lhs_base, lhs_accs) (rhs_base, rhs_accs) =
    equal_base_wo_formal lhs_base rhs_base && List.equal equal_access lhs_accs rhs_accs


  let rec pp fmt = function
    | base, accesses when equal_base base dummy_base ->
        (Pp.seq pp_access) fmt accesses
    | base, [] ->
        F.fprintf fmt "%a" pp_base base
    | base, accesses ->
        F.fprintf fmt "%a%a" pp_base base (Pp.seq ~sep:"" pp_access) accesses


  and pp_base fmt = function
    | Formal pv ->
        F.fprintf fmt "$(%s)" (Pvar.get_simplified_name pv)
    | Variable pv ->
        F.fprintf fmt "%s" (Pvar.get_simplified_name pv)
    | Primitive const ->
        (Const.pp Pp.text) fmt const
    | Exn typ ->
        F.fprintf fmt "Exn (%s)" typ


  and pp_access fmt = function
    | FieldAccess fld ->
        F.fprintf fmt ".%s" (Fieldname.to_full_string fld)
    | MethodCallAccess (method_name, args) ->
        F.fprintf fmt ".%s(%a)" (Procname.get_method method_name) (Pp.seq ~sep:", " pp) args
        (* F.fprintf fmt ".%s(%a)" (Procname.get_method method_name) (Pp.seq ~sep:", " pp) args *)
    | ArrayAccess index ->
        F.fprintf fmt "[%a]" pp index


  let to_string t = F.asprintf "%a" pp t

  let get_deref_field (base, accesses) =
    match (base, List.rev accesses) with
    | Formal pv, [] | Variable pv, [] ->
        Pvar.get_simplified_name pv
    | Primitive const, [] ->
        (* null *)
        F.asprintf "%a" (Const.pp Pp.text) const
    | Exn typ, [] ->
        F.asprintf "Exn (%s)" typ
    | _, FieldAccess fld :: _ ->
        (* Some fieldname has "access$", so drop it *)
        Fieldname.get_field_name fld |> String.split_on_chars ~on:['$'] |> List.rev |> List.hd_exn
    | _, MethodCallAccess (method_name, _) :: _ ->
        Procname.get_method method_name
    | _, ArrayAccess _ :: _ ->
        to_string (base, accesses)


  let get_locals pdesc =
    let procname = Procdesc.get_proc_name pdesc in
    Procdesc.get_locals pdesc
    |> List.map ~f:(fun ProcAttributes.{name} ->
           let pv = Pvar.mk name procname in
           of_pvar pv)


  let get_formals pdesc =
    Procdesc.get_pvar_formals pdesc
    |> List.map ~f:(fun (pv, typ) ->
           if Typ.is_java_primitive_type typ then of_pvar pv else of_formal pv)


  let get_this pdesc = List.hd_exn (get_formals pdesc)

  let get_ret pdesc = of_formal (Procdesc.get_ret_var pdesc)

  let is_var (base, accesses) =
    match base with (Formal _ | Variable _) when List.is_empty accesses -> true | _ -> false


  let is_formal (base, _) = match base with Formal _ -> true | _ -> false

  let is_this (base, accesses) =
    match (base, List.rev accesses) with
    | Formal pv, [] | Variable pv, [] ->
        Pvar.is_this pv
    | _ ->
        false


  let is_this_base (base, _) =
    match base with Formal pv | Variable pv -> Pvar.is_this pv | _ -> false


  let is_exn ?(include_runtime = false) (base, _) =
    match base with
    | Exn s ->
        if include_runtime then true
        else
          (not (String.is_prefix s ~prefix:"APRVAL_RUNTIME_"))
          (* this case only occurs when exn handliing fail *)
          && not (String.is_prefix s ~prefix:"java.lang.Object*")
    | _ ->
        false


  let is_local pdesc (base, accesses) =
    let locals =
      Procdesc.get_locals pdesc
      |> List.map ~f:(fun ProcAttributes.{name} -> Pvar.mk name (Procdesc.get_proc_name pdesc))
    in
    match base with
    | Variable pv when List.mem locals ~equal:Pvar.equal pv ->
        List.is_empty accesses
    | Variable _ ->
        false
    | _ ->
        false


  let is_param pdesc (base, accesses) =
    let formals = Procdesc.get_pvar_formals pdesc |> List.map ~f:fst in
    match base with
    | Formal _ ->
        false
    | Variable pv when List.mem formals ~equal:Pvar.equal pv ->
        List.is_empty accesses
    | Variable _ ->
        false
    | Primitive _ ->
        false
    | Exn _ ->
        false


  let is_return pdesc (base, accesses) =
    match (base, accesses) with Formal pv, [] when Pvar.is_return pv -> true | _ -> false


  let is_field_access = function FieldAccess _ -> true | _ -> false

  let contains_field_access (_, accesses) = List.exists accesses ~f:is_field_access

  let is_method_access = function MethodCallAccess _ -> true | _ -> false

  let contains_method_access (_, accesses) = List.exists accesses ~f:is_method_access

  let contains_access (_, accesses) = match accesses with [] -> false | _ -> true

  let rec chop_sub_aexpr ~sub access =
    match (sub, access) with
    | [], remaining ->
        Some remaining
    | sub_base :: sub_accesses, org_base :: org_accesses when equal_access sub_base org_base ->
        chop_sub_aexpr ~sub:sub_accesses org_accesses
    | _ ->
        None


  let replace_by_map ~f x = f x

  let replace_sub original ~src ~dst =
    let (src_base, src_access), (dst_base, dst_access), (org_base, org_access) =
      (src, dst, original)
    in
    if equal_base src_base org_base then
      (* src:p.f1.f2, dst:q, original: p.f1.f2.f3 
       * output: q.f3, remaining: [f3] *)
      match chop_sub_aexpr ~sub:src_access org_access with
      | Some remaining when List.contains_dup (dst_access @ remaining) ~compare:compare_access ->
          original
      | Some remaining ->
          (dst_base, dst_access @ remaining)
      | None ->
          original
    else original


  let is_sub_expr ~(sub : t) aexpr =
    if equal aexpr (replace_sub ~src:sub ~dst:dummy aexpr) then false else true


  let append_access (base, accs) access = (base, accs @ [access])

  module Cache = struct
    let cache = ref ProcVar.Map.empty

    open IOption.Let_syntax

    let rec find_opt pdesc : Exp.t -> t option = function
      | Var id ->
          ProcVar.Map.find_opt (ProcVar.of_id (id, Procdesc.get_proc_name pdesc)) !cache
      | Cast (_, e) ->
          find_opt pdesc e
      | Sizeof _ ->
          Some (of_const (Cint IntLit.one))
      | Lvar pv when Pvar.is_frontend_tmp pv ->
          ProcVar.Map.find_opt (ProcVar.of_pvar pv) !cache
      | Lvar pv ->
          let formals = List.map ~f:fst (Procdesc.get_pvar_formals pdesc) in
          if List.mem formals pv ~equal:Pvar.equal then Some (of_formal pv) else Some (of_pvar pv)
      | Lfield (e, fn, _) ->
          let+ base_aexpr = find_opt pdesc e in
          append_access base_aexpr (FieldAccess fn)
      | Const const ->
          Some (of_const const)
      | Lindex (e1, e2) ->
          let+ base_aexpr = find_opt pdesc e1 and+ index_aexpr = find_opt pdesc e2 in
          append_access base_aexpr (ArrayAccess index_aexpr)
      | _ ->
          None


    let pp = ProcVar.Map.pp ~pp_value:pp

    let find pdesc e =
      match find_opt pdesc e with
      | Some aexpr ->
          aexpr
      | None ->
          (* L.progress "Could not convert %a at %a" Exp.pp e Procname.pp
             (Procdesc.get_proc_name pdesc) ; *)
          raise (UnconvertibleExpr e)


    let add_pv _ pv aexpr = cache := ProcVar.Map.add (ProcVar.of_pvar pv) aexpr !cache

    let add_id pdesc id aexpr =
      cache := ProcVar.Map.add (ProcVar.of_id (id, Procdesc.get_proc_name pdesc)) aexpr !cache
  end

  let do_instr pdesc instr =
    try
      match instr with
      | Sil.Load {id; e} ->
          Cache.add_id pdesc id (Cache.find pdesc e)
      | Sil.Store {e1= Lvar pv; e2} when Pvar.is_frontend_tmp pv ->
          Cache.add_pv pdesc pv (Cache.find pdesc e2)
      | Sil.Call ((ret, _), Const (Cfun mthd), (Var this, _) :: _, _, _)
        when Procname.equal BuiltinDecl.__cast mthd ->
          (* ret = __cast(this, _) => ap(ret) = ap(this) *)
          Cache.add_id pdesc ret (Cache.find pdesc (Var this))
      | Sil.Call
          ((ret, _), Const (Cfun mthd), (Var this, _) :: args, _, CallFlags.{cf_virtual= true}) ->
          let arg_exprs = List.map args ~f:(fun (arg, _) -> Cache.find pdesc arg) in
          let ae =
            append_access (Cache.find pdesc (Var this)) (MethodCallAccess (mthd, arg_exprs))
          in
          Cache.add_id pdesc ret ae
      | Sil.Call ((ret, _), Const (Cfun mthd), (Var this, _) :: args, _, _) ->
          (* this.mthd(...) is not virtual invocation *)
          let this_aexpr = Cache.find pdesc (Var this) in
          if String.equal (to_string this_aexpr) "this" then
            let arg_exprs = List.map args ~f:(fun (arg, _) -> Cache.find pdesc arg) in
            let ae = append_access this_aexpr (MethodCallAccess (mthd, arg_exprs)) in
            Cache.add_id pdesc ret ae
          else ()
      | Sil.Call ((ret, _), Const (Cfun mthd), args, _, _) ->
          (* static invocation A.foo() *)
          let arg_exprs = List.map args ~f:(fun (arg, _) -> Cache.find pdesc arg) in
          let ae = append_access dummy (MethodCallAccess (mthd, arg_exprs)) in
          Cache.add_id pdesc ret ae
      | _ ->
          ()
    with _ -> ()


  let bind_pdesc pdesc =
    let entry = InstrNode.of_pnode (Procdesc.get_start_node pdesc) Sil.skip_instr in
    let rec do_worklist worklist doneset =
      if InstrNode.Set.is_empty worklist then ()
      else
        let work = InstrNode.Set.choose worklist in
        let rest = InstrNode.Set.remove work worklist in
        ignore (do_instr pdesc (InstrNode.get_instr work)) ;
        let next =
          let succs = InstrNode.get_succs work in
          let exns = InstrNode.get_exn work in
          InstrNode.Set.of_list (succs @ exns) |> InstrNode.Set.union rest
        in
        let new_worklist = InstrNode.Set.diff next doneset in
        let new_doneset = InstrNode.Set.add work doneset in
        do_worklist new_worklist new_doneset
    in
    do_worklist (InstrNode.Set.singleton entry) InstrNode.Set.empty


  let from_IR_exp_opt pdesc exp =
    match Cache.find_opt pdesc exp with
    | Some aexpr ->
        Some aexpr
    | None -> (
        bind_pdesc pdesc ;
        (* Cache.find pdesc exp *)
        match Cache.find_opt pdesc exp with Some aexpr -> Some aexpr | None -> None )


  let from_IR_exp pdesc exp =
    match from_IR_exp_opt pdesc exp with
    | Some aexpr ->
        aexpr
    | None ->
        L.(die InternalError) "Cannot convert %a@.AexprMap: %a@." Exp.pp exp Cache.pp !Cache.cache


  let null = of_const (Cint IntLit.null)

  let zero = of_const (Cint IntLit.zero)

  let one = of_const (Cint IntLit.one)
end

include S

let rec is_abstract (base, accesses) =
  is_abstract_base base || List.exists accesses ~f:is_abstract_access


and is_abstract_base _ = false

and is_abstract_access = function
  | FieldAccess _ ->
      false
  | ArrayAccess index ->
      is_abstract index
  | MethodCallAccess (callee, args) ->
      Procname.is_infer_undefined callee || List.exists args ~f:is_abstract


let rec is_constant (base, accesses) = is_constant_base base && List.is_empty accesses

and is_default_const (base, accesses) =
  is_constant (base, accesses)
  &&
  match base with
  | Primitive (Cint i) when IntLit.isnull i ->
      false
  | Primitive (Cint i) ->
      IntLit.iszero i || IntLit.isone i
  | Primitive (Cfloat 0.0) | Primitive (Cfloat 1.0) ->
      true
  | _ ->
      false


and is_non_default_const (base, accesses) =
  is_constant (base, accesses)
  &&
  match base with
  | Primitive (Cint i) ->
      (not (IntLit.iszero i)) && not (IntLit.isone i)
  | Primitive (Cfloat 0.0) | Primitive (Cfloat 1.0) ->
      false
  | _ ->
      true


and is_constant_base = function Primitive _ -> true | _ -> false

let rec is_concrete (base, accesses) = is_concrete_base base && List.is_empty accesses

and is_concrete_base = function Primitive _ | Exn _ -> true | _ -> false

let is_different_type _ _ = false

let is_same_type (base1, _) (base2, _) =
  match (base1, base2) with
  | Primitive (Const.Cint n1), Primitive (Const.Cint n2) ->
      Bool.equal (IntLit.isnull n1) (IntLit.isnull n2)
  | Primitive c1, Primitive c2 ->
      Const.kind_equal c1 c2
  | _ ->
      false


let is_recursive _ = false

let has_duplicates (_, accesses) = List.contains_dup accesses ~compare:compare_access

let is_null (base, _) =
  match base with Primitive (Cint i) when IntLit.isnull i -> true | _ -> false


module Set = PrettyPrintable.MakePPSet (S)
module Map = PrettyPrintable.MakePPMap (S)

module AbsSet = struct
  include AbstractDomain.FiniteSet (S)

  let is_uniq_const t = Int.equal (cardinal t) 1 && for_all is_constant t

  let get_uniq_const t = if is_uniq_const t then choose_opt t else None

  let has_consts t = exists is_constant t

  let get_consts t = filter is_constant t
end
