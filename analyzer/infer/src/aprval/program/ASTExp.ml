open! IStd
open! Vocab
module Method = Procname.Java
module Node = Procdesc.Node
module NodeSet = Procdesc.NodeSet

module Literal = struct
  type t =
    | Integer of IntLit.t
    | NULL
    | Boolean of bool
    | Float of float
    | String of string
    | Class of Ident.name
  [@@deriving equal, compare]

  (** boolean-ness of an integer cannot be decided only with given constant type. *)
  let of_const c =
    match (c : Const.t) with
    | Cint il when IntLit.isnull il ->
        NULL
    | Cint il ->
        Integer il
    | Cfloat f ->
        Float f
    | Cstr s ->
        String s
    | Cclass cls ->
        Class cls
    | Cfun _ ->
        L.die InternalError "Not supported literal type: %a@." (Const.pp Pp.text) c


  let pp fmt = function
    | Integer il ->
        F.fprintf fmt "%a" IntLit.pp il
    | NULL ->
        F.fprintf fmt "null"
    | Boolean b ->
        F.fprintf fmt "%b" b
    | Float f ->
        F.fprintf fmt "%a" F.pp_print_float f
    | String str ->
        F.fprintf fmt "\"%s\"" str
    | Class cls ->
        F.fprintf fmt "%a" Ident.pp_name cls


  let null = NULL

  let lit_true = Boolean true

  let lit_false = Boolean false

  let typeof = function
    | Integer _ ->
        Typ.int
    | NULL ->
        Typ.mk_struct (Typ.Name.Java.from_string "fl4apr.null_type")
    | Boolean _ ->
        Typ.boolean
    | Float _ ->
        Typ.float
    | String _ ->
        Typ.pointer_to_java_lang_string
    | Class _ ->
        Typ.mk_struct (Typ.Name.Java.from_string "java.lang.Class")
end

module ASTExp = struct
  type t =
    | Var of Pvar.t
    | Cast of Typ.t * t
    | Literal of Literal.t
    | Unary of Unop.t * t
    | Binary of Binop.t * t * t
    | NewArray of {elt_typ: Typ.t; length: t}
    | FieldAccess of {base: base; field: Fieldname.t}
    | ArrayAccess of {arrexp: t; index: t}
    | MethodCall of {base: base; mthd: Method.t; args: t list}
  [@@deriving compare]

  and base = StaticAccess of Typ.Name.t | DynamicAccess of t

  let rec get_leafs = function
    | Cast (_, t) | Unary (_, t) ->
        get_leafs t
    | Binary (_, t1, t2) ->
        get_leafs t1 @ get_leafs t2
    | NewArray {length} ->
        get_leafs length
    | MethodCall {base; args} ->
        get_leafs_base base @ List.fold_left args ~init:[] ~f:(fun acc t -> acc @ get_leafs t)
    | t ->
        [t]


  and get_leafs_base = function DynamicAccess t -> get_leafs t | _ -> []

  let sort = function
    | Binary (binop, ae1, ae2) ->
        let[@warning "-8"] [ae1; ae2] = List.sort [ae1; ae2] ~compare in
        Binary (binop, ae1, ae2)
    | x ->
        x


  let compare (x : t) (y : t) = compare (sort x) (sort y)

  let rec pp fmt = function
    | Var pvar ->
        F.fprintf fmt "%a" Pvar.pp_value_non_verbose pvar
    | Literal lit ->
        Literal.pp fmt lit
    | Cast (ty, e) ->
        F.fprintf fmt "(%s) %a" (Typ.to_string ty) pp e
    | NewArray {elt_typ; length} ->
        F.fprintf fmt "new %s[%a]" (Typ.to_string elt_typ) pp length
    | FieldAccess {base; field} ->
        F.fprintf fmt "%a.%s" pp_base base (Fieldname.get_field_name field)
    | ArrayAccess {arrexp: t; index: t} ->
        F.fprintf fmt "%a[%a]" pp arrexp pp index
    | MethodCall {mthd; args} when Procname.Java.is_constructor mthd ->
        F.fprintf fmt "new %s(%a)" (Procname.Java.get_class_name mthd) pp_args args
    | MethodCall {base; mthd; args} ->
        F.fprintf fmt "%a.%a(%a)" pp_base base pp_method mthd pp_args args
    | Unary (unop, e) ->
        F.fprintf fmt "%s(%a)" (Unop.to_string unop) pp e
    | Binary (bop, x, y) ->
        F.fprintf fmt "%a %s %a" pp x (Binop.str Pp.text bop) pp y


  and pp_base fmt = function
    | StaticAccess klass ->
        F.fprintf fmt "%a"
          (JavaClassName.pp_with_verbosity ~verbose:false)
          (Typ.Name.Java.get_java_class_name_exn klass)
    | DynamicAccess base ->
        pp fmt base


  and pp_method fmt mthd = F.fprintf fmt "%s" (Procname.get_method (Procname.Java mthd))

  and pp_args fmt args = F.fprintf fmt "%a" (Pp.seq pp ~sep:",") args

  let to_string = F.asprintf "%a" pp

  let to_yojson e = `String (to_string e)

  let equal = [%compare.equal: t]

  let null = Literal Literal.null

  let of_var pv = Var pv

  let of_const c = Literal (Literal.of_const c)
end

include ASTExp
module Set = PrettyPrintable.MakePPSet (ASTExp)

module Converter = struct
  module IdMap = Caml.Map.Make (ProcVar)
  module ArgMap = Caml.Map.Make (ASTExp)

  exception UnconvertibleExpr of Exp.t

  type converter = {id_table: t IdMap.t; varargs: t Array.t ArgMap.t}

  let empty = {id_table= IdMap.empty; varargs= ArgMap.empty}

  let rec find_opt t procname : Exp.t -> t option =
   fun e ->
    let open IOption.Let_syntax in
    match e with
    | Var id ->
        IdMap.find_opt (ProcVar.of_id (id, procname)) t.id_table
    | UnOp (unop, e, _) ->
        let+ ae = find_opt t procname e in
        Unary (unop, ae)
    | BinOp (bop, e1, e2) ->
        let+ ae1 = find_opt t procname e1 and+ ae2 = find_opt t procname e2 in
        Binary (bop, ae1, ae2)
    | Cast (ty, e') ->
        let+ ae = find_opt t procname e' in
        Cast (ty, ae)
    | Exn _ | Closure _ ->
        None
    | Sizeof {dynamic_length} ->
        Option.bind dynamic_length ~f:(find_opt t procname)
    | Lvar pv ->
        if Pvar.is_frontend_tmp pv then IdMap.find_opt (ProcVar.of_pvar pv) t.id_table
        else if not (Pvar.is_global pv) then Some (of_var pv)
        else None
    | Lfield (Lvar class_var, fn, _) when Pvar.is_global class_var ->
        (* This is the only case where global pvar appears *)
        let base_class =
          Typ.Name.Java.from_string
            (List.last_exn (String.split (Pvar.to_string class_var) ~on:'$'))
        in
        Some (FieldAccess {base= StaticAccess base_class; field= fn})
    | Lfield (e, fn, _) ->
        let+ base_aexpr = find_opt t procname e in
        FieldAccess {base= DynamicAccess base_aexpr; field= fn}
    | Const const -> (
      try Some (of_const const) with _ -> None )
    | Lindex (e1, e2) ->
        let+ base_aexpr = find_opt t procname e1 and+ index_aexpr = find_opt t procname e2 in
        ArrayAccess {arrexp= base_aexpr; index= index_aexpr}


  let find t procname e =
    match find_opt t procname e with
    | Some aexpr ->
        aexpr
    | None ->
        (* L.progress "Could not convert %a at %a" Exp.pp e Procname.pp procname ; *)
        raise (UnconvertibleExpr e)


  let add_id procname id aexpr t =
    {t with id_table= IdMap.add (ProcVar.of_id (id, procname)) aexpr t.id_table}


  let rec do_instr t procname instr =
    try
      match instr with
      | Sil.Load {id; e} ->
          add_id procname id (find t procname e) t
      | Sil.Store {e1= Lindex (Var id, Const (Cint idx)); e2} ->
          (* Cache.get here may fail if the array is not synthesized exp for varargs. *)
          let varargs_arr = ArgMap.find (find t procname (Var id)) t.varargs in
          varargs_arr.(IntLit.to_int_exn idx) <- find t procname e2 ;
          t
      | Sil.Store {e1= Lvar pv; e2} when Pvar.is_frontend_tmp pv -> (
        match find t procname e2 with
        | NewArray {length= Literal (Integer len)} as astexp ->
            (* loading newarr followed by ir-var store indicates var-args assignment *)
            { id_table= IdMap.add (ProcVar.of_pvar pv) astexp t.id_table
            ; varargs= ArgMap.add astexp (Array.create ~len:(IntLit.to_int_exn len) null) t.varargs
            }
        | astexp ->
            {t with id_table= IdMap.add (ProcVar.of_pvar pv) astexp t.id_table} )
      | Sil.Call ((ret, _), Const (Cfun pname), (e, _) :: (Sizeof {typ}, _) :: _, _, _)
        when Procname.equal pname BuiltinDecl.__cast ->
          add_id procname ret (Cast (typ, find t procname e)) t
      | Sil.Call ((ret, _), Const (Cfun pname), [(arr, _)], _, _)
        when Procname.equal pname BuiltinDecl.__get_array_length ->
          add_id procname ret
            (FieldAccess
               { base= DynamicAccess (find t procname arr)
               ; field=
                   Fieldname.make (Typ.Name.Java.from_string "java.lang.reflect.Array") "length" })
            t
      | Sil.Call
          ( (ret, _)
          , Const (Cfun pname)
          , (Sizeof {typ= {desc= Tarray {elt}}; dynamic_length= Some length_exp}, _) :: _
          , _
          , _ )
        when Procname.equal pname BuiltinDecl.__new_array ->
          add_id procname ret (NewArray {elt_typ= elt; length= find t procname length_exp}) t
      | Sil.Call (_, Const (Cfun (Procname.Java mthd)), (Var this, _) :: args, _, _)
        when Procname.Java.is_constructor mthd ->
          let arg_exprs = convert_method_args t procname args in
          let ae =
            MethodCall
              {base= StaticAccess (Procname.Java.get_class_type_name mthd); mthd; args= arg_exprs}
          in
          add_id procname this ae t
      | Sil.Call ((ret, _), Const (Cfun mthd), (Var this, _) :: _, _, _)
        when Procname.equal BuiltinDecl.__cast mthd ->
          (* ret = __cast(this, _) => ap(ret) = ap(this) *)
          add_id procname ret (find t procname (Var this)) t
      | Sil.Call ((ret, _), Const (Cfun (Procname.Java mthd)), (Var this, _) :: _, _, _)
        when String.equal (Procname.Java.get_method mthd) "append"
             && String.equal "java.lang.StringBuilder" (Procname.Java.get_class_name mthd) ->
          (* ret = append(this, _) => ap(ret) = ap(this) *)
          add_id procname ret (find t procname (Var this)) t
      | Sil.Call ((ret, _), Const (Cfun (Java mthd)), args, _, _) when Procname.Java.is_static mthd
        ->
          let arg_exprs = convert_method_args t procname args in
          let ae =
            let base_class = Procname.Java.get_class_type_name mthd in
            MethodCall {base= StaticAccess base_class; mthd; args= arg_exprs}
          in
          add_id procname ret ae t
      | Sil.Call ((ret, _), Const (Cfun (Procname.Java mthd)), (Var this, _) :: args, _, _) ->
          let arg_exprs = convert_method_args t procname args in
          let ae =
            MethodCall {base= DynamicAccess (find t procname (Var this)); mthd; args= arg_exprs}
          in
          add_id procname ret ae t
      | _ ->
          t
    with _ -> t


  and convert_method_args t procname args =
    let f arg =
      let resolved = find t procname arg in
      if ArgMap.mem resolved t.varargs then Array.to_list (ArgMap.find resolved t.varargs)
      else [resolved]
    in
    List.concat_map args ~f:(fun (arg, _) -> f arg)


  let update_by_node t procname node =
    let instrs = Node.get_instr_list node in
    List.fold instrs ~init:t ~f:(fun acc instr -> do_instr acc procname instr)


  let init_by_nodes procname nodes =
    NodeSet.fold (fun node acc -> update_by_node acc procname node) nodes empty


  let init_by_pdesc pdesc =
    let entry = InstrNode.get_first_from (Procdesc.get_start_node pdesc) in
    let procname = Procdesc.get_proc_name pdesc in
    let rec do_worklist t worklist doneset =
      if InstrNode.Set.is_empty worklist then t
      else
        let work = InstrNode.Set.choose worklist in
        let rest = InstrNode.Set.remove work worklist in
        let t' = do_instr t procname (InstrNode.get_instr work) in
        let next =
          let succs = InstrNode.get_succs work in
          let exns = InstrNode.get_exn work in
          InstrNode.Set.of_list (succs @ exns) |> InstrNode.Set.union rest
        in
        let new_worklist = InstrNode.Set.diff next doneset in
        let new_doneset = InstrNode.Set.add work doneset in
        do_worklist t' new_worklist new_doneset
    in
    do_worklist empty (InstrNode.Set.singleton entry) InstrNode.Set.empty


  let from_IR_exp_opt t procname exp = find_opt t procname exp

  let from_IR_exp t procname exp =
    match from_IR_exp_opt t procname exp with
    | Some ae ->
        ae
    | None ->
        L.progress "-- Conversion fails for IR-exp %a in %a@." Exp.pp exp Procname.pp procname ;
        raise (UnconvertibleExpr exp)
end

let rec from_IR_exp = Converter.from_IR_exp

let rec from_IR_exp_opt = Converter.from_IR_exp_opt

let check_ast_equal_exp (pname, c1, c2) e1 e2 =
  (* L.progress "- Exp origin: %a, %a@." Exp.pp e1 Exp.pp e2 ; *)
  match (from_IR_exp_opt c1 pname e1, from_IR_exp_opt c2 pname e2) with
  | Some aexp1, Some aexp2 ->
      (* L.progress "- Exp after: %a, %a@,- Result: %b@." ASTExp.pp aexp1 ASTExp.pp aexp2
         (ASTExp.equal aexp1 aexp2) ; *)
      ASTExp.equal aexp1 aexp2
  | Some _, None | None, Some _ ->
      false
  | _ ->
      true


let check_ast_equal_instr (pname, c1, c2) instr1 instr2 =
  (* L.progress "Compare instr %a, %a@."
     (Sil.pp_instr ~print_types:true Pp.text)
     instr1
     (Sil.pp_instr ~print_types:true Pp.text)
     instr2 ; *)
  match (instr1, instr2) with
  | Sil.Load {e= e1}, Sil.Load {e= e2} | Sil.Prune (e1, _, _, _), Sil.Prune (e2, _, _, _) ->
      check_ast_equal_exp (pname, c1, c2) e1 e2
  | Sil.Store {e1; e2}, Sil.Store {e1= e1'; e2= e2'} ->
      check_ast_equal_exp (pname, c1, c2) e1 e1' && check_ast_equal_exp (pname, c1, c2) e2 e2'
  | Sil.Call (_, Const (Cfun proc1), args1, _, _), Sil.Call (_, Const (Cfun proc2), args2, _, _) ->
      let args_equal =
        try
          List.for_all2_exn args1 args2 ~f:(fun (e1, _) (e2, _) ->
              check_ast_equal_exp (pname, c1, c2) e1 e2)
        with _ -> false
      in
      args_equal && Procname.equal proc1 proc2
  | _ ->
      (* ignore other exp such as meta instr*)
      true


let check_ast_equal_node (pname, c1, c2) node1 node2 =
  (* two pnode is equal in ast level if there type and instructions are equals*)
  if Node.equal_nodekind (Node.get_kind node1) (Node.get_kind node2) then
    let instrs1, instrs2 = (Node.get_instr_list node1, Node.get_instr_list node2) in
    try List.for_all2_exn instrs1 instrs2 ~f:(check_ast_equal_instr (pname, c1, c2))
    with _ -> false
  else false


let rec check_unpatched_node (pname, c1, c2) node1 node2 =
  (* two pnode are unpatched:
     1. two nodes are prune node : all instrs are equal and also the successors are equals
     2. otherwise: all instrs of the node are equal in ast level *)
  match (Node.get_kind node1, Node.get_kind node2) with
  (* | Node.Prune_node _, Node.Prune_node _ -> (
      let succs1, succs2 = (Node.get_succs node1, Node.get_succs node2) in
      L.progress "Compare node %a, %a@." Node.pp node1 Node.pp node2 ;
      L.progress "Succs %a, %a@." (Pp.seq Node.pp) succs1 (Pp.seq Node.pp) succs2 ;
      let instrs1, instrs2 = (Node.get_instr_list node1, Node.get_instr_list node2) in
      try
        List.for_all2_exn succs1 succs2 ~f:(check_ast_equal_node (pname, c1, c2))
        && List.for_all2_exn instrs1 instrs2 ~f:(check_ast_equal_instr (pname, c1, c2))
      with _ -> false ) *)
  | _ ->
      check_ast_equal_node (pname, c1, c2) node1 node2


let rec check_equiv_node (pname, c1, c2) node1 node2 =
  let succs1, succs2 = (Node.get_succs node1, Node.get_succs node2) in
  let preds1, preds2 = (Node.get_preds node1, Node.get_preds node2) in
  (* L.progress "Compare node %a, %a@." Node.pp node1 Node.pp node2 ;
     L.progress "Succs* %a, %a@." (Pp.seq Node.pp) succs1 (Pp.seq Node.pp) succs2 ;
     L.progress "Preds* %a, %a@." (Pp.seq Node.pp) preds1 (Pp.seq Node.pp) preds2 ; *)
  match (Node.get_kind node1, Node.get_kind node2) with
  | Node.Stmt_node _, Node.Stmt_node _ | Node.Join_node, Node.Join_node -> (
    try
      (* case of normal node checking its pred (checking the patch affected before the node ) *)
      check_ast_equal_node (pname, c1, c2) node1 node2
      && List.for_all2_exn succs1 succs2 ~f:(check_ast_equal_node (pname, c1, c2))
      && List.for_all2_exn preds1 preds2 ~f:(check_ast_equal_node (pname, c1, c2))
    with _ -> false )
  | Node.Prune_node _, Node.Prune_node _ | Node.Start_node, Node.Start_node -> (
    try
      check_ast_equal_node (pname, c1, c2) node1 node2
      && List.for_all2_exn succs1 succs2 ~f:(check_ast_equal_node (pname, c1, c2))
      && List.for_all2_exn preds1 preds2 ~f:(check_ast_equal_node (pname, c1, c2))
    with _ -> false )
  | Node.Exit_node, Node.Exit_node | Node.Skip_node _, Node.Skip_node _ ->
      true
  | _ ->
      false
