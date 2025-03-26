open! IStd
open! Vocab
module L = Logging
module Domain = SpecCheckerDomain
module SymHeap = SymDom.SymHeap
module Val = SymDom.Val
module Loc = SymDom.Loc
module Node = InstrNode
module PathCond = SymDom.PathCond

type exec =
     Domain.t
  -> Procdesc.t
  -> InstrNode.t
  -> Procname.t
  -> Ident.t * Typ.t
  -> (Exp.t * Typ.t) list
  -> Domain.t list

type model = (Procname.t -> Sil.instr -> bool) * exec

(* For debugging *)
let seql x y =
  L.d_printfln " - compare class %s and %s" x y ;
  String.equal x y


let exception_classes = ["java.lang.Throwable"]

let implements classes typename = List.exists classes ~f:(seql (Typ.Name.name typename))

let implements_interfaces interfaces typename =
  List.exists interfaces ~f:(fun interface ->
      PatternMatch.Java.implements interface (Program.tenv ()) (Typ.Name.name typename))


let is_string = function Val.Vheap (SymHeap.String _) -> true | _ -> false

let is_int = function
  | Val.Vint (IntLit i) -> (
    match IntLit.to_int i with Some _ -> true | _ -> false )
  | _ ->
      false


(** Builtin model functions *)
module BuiltIn = struct
  let cast : model =
    let is_model callee _ = String.equal "__cast" (Procname.get_method callee) in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      (* ret_typ of__cast is Boolean, but is actually pointer type *)
      let arg_exp, _ = List.hd_exn arg_typs in
      (* TODO: check the logic is correct *)
      let astate, value = Domain.eval astate instr_node arg_exp in
      (* let value = Val.make_extern instr_node Typ.void_star in *)
      [Domain.store_reg astate ret_id value]
    in
    (is_model, exec)


  let instanceof : model =
    let is_model callee _ = String.equal "__instanceof" (Procname.get_method callee) in
    let exec astate _ instr_node callee (ret_id, _) arg_typs =
      (* TODO: add type checking by using sizeof_exp and get_class_name_opt *)
      match arg_typs with
      | [(arg_exp, _); (Exp.Sizeof {typ= {desc= Typ.Tstruct name}}, _)]
        when implements_interfaces exception_classes name -> (
          (* Exception catch *)
          let astate, arg_value = Domain.eval astate instr_node arg_exp in
          match arg_value with
          | Val.Vheap (String str) when Typ.Name.equal name (Typ.Name.Java.from_string str) ->
              [Domain.store_reg astate ret_id Val.one]
          | Val.Vheap (String _) when Val.equal arg_value (Val.npe |> Val.unwrap_exn) ->
              [Domain.store_reg astate ret_id Val.zero]
          | _ ->
              (* HEURISTIC 2: ignore exception type  *)
              let typ_value = Val.exn in
              Domain.bind_extern_value astate instr_node (ret_id, Typ.int) callee
                [arg_value; typ_value]
          (*
             Domain.add_pc astate (PathCond.make_physical_equals Binop.Ne arg_value null)
             |> List.concat_map ~f:(fun astate' ->
                    Domain.bind_extern_value astate' instr_node (ret_id, Typ.int) callee
                      [arg_value; typ_value]) )
          *)
          )
      | [(arg_exp, _); (Exp.Sizeof {typ}, _)] ->
          let astate, arg_value = Domain.eval astate instr_node arg_exp in
          let typ_value = Typ.to_string typ |> Val.make_string in
          Domain.bind_extern_value astate instr_node (ret_id, Typ.int) callee [arg_value; typ_value]
          (*
          let null_cond op =
            PathCond.make_physical_equals op arg_value (Val.make_null ())
          in
          let null_states =
            Domain.add_pc astate (null_cond Binop.Eq)
            |> List.map ~f:(fun astate' -> Domain.store_reg astate' ret_id Val.zero)
          in
          let non_null_states =
            Domain.add_pc astate (null_cond Binop.Ne)
            |> List.concat_map ~f:(fun astate' ->
                   Domain.bind_extern_value astate' instr_node (ret_id, Typ.int) callee
                     [arg_value; typ_value])
          in
          null_states @ non_null_states
          *)
      | [(arg_exp, _); (typ_exp, _)] ->
          (* This case happens in lambda function, TODO: refactoring *)
          let astate, arg_value = Domain.eval astate instr_node arg_exp in
          let astate, typ_value = Domain.eval astate instr_node typ_exp in
          Domain.bind_extern_value astate instr_node (ret_id, Typ.int) callee [arg_value; typ_value]
          (*
          let null_cond op =
            PathCond.make_physical_equals op arg_value (Val.make_null ())
          in
          let null_states =
            Domain.add_pc astate (null_cond Binop.Eq)
            |> List.map ~f:(fun astate' -> Domain.store_reg astate' ret_id Val.zero)
          in
          let non_null_states =
            Domain.add_pc astate (null_cond Binop.Ne)
            |> List.concat_map ~f:(fun astate' ->
                   Domain.bind_extern_value astate' instr_node (ret_id, Typ.int) callee
                     [arg_value; typ_value])
          in
          null_states @ non_null_states
          *)
      | _ ->
          L.(die InternalError) "wrong invariant of instanceof"
    in
    (is_model, exec)


  let unwrap_exception : model =
    let is_model callee _ = String.equal "__unwrap_exception" (Procname.get_method callee) in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let arg_exp, _ = List.hd_exn arg_typs in
      try
        let astate, value = Domain.eval astate instr_node arg_exp in
        [Domain.unwrap_exception (Domain.store_reg astate ret_id (Val.unwrap_exn value))]
      with Unexpected msg ->
        L.progress "[WARNING]: ==============@.%s@." msg ;
        []
      (* L.(die InternalError) "%s@.%a@." msg Domain.pp astate *)
    in
    (is_model, exec)


  let models = [instanceof; cast; unwrap_exception]
end

let invoke : model =
  let classes = ["java.lang.reflect.Method"] in
  let is_model callee instr =
    match instr with
    | Sil.Call (_, Const (Cfun (Java mthd)), arg_typs, _, _) ->
        String.equal "invoke" (Procname.get_method callee)
        && Int.equal (List.length arg_typs) 3
        && implements classes (Procname.Java.get_class_type_name mthd)
    | _ ->
        false
  in
  let exec astate proc_desc instr_node callee (ret_id, _) arg_typs =
    let[@warning "-8"] ((mthd_exp, _) :: (this_exp, _) :: (arg_arr_exp, _) :: _) = arg_typs in
    let astate, mthd_value = Domain.eval astate instr_node mthd_exp in
    let astate, this_value = Domain.eval astate instr_node this_exp in
    let astate, arg_arr_value = Domain.eval astate instr_node arg_arr_exp in
    let arg_values =
      let arg_arr_loc = Val.to_loc arg_arr_value in
      let rec collect_arg_values acc i loc =
        let index_loc = Loc.append_index ~index:(SymDom.SymExp.of_intlit (IntLit.of_int i)) loc in
        if Domain.is_unknown_loc astate index_loc then acc
        else collect_arg_values (acc @ [Domain.read_loc astate index_loc]) (i + 1) index_loc
      in
      let arg_values = collect_arg_values [] 0 arg_arr_loc in
      mthd_value :: this_value :: arg_values
    in
    let ex_state =
      Domain.bind_exn_extern astate instr_node (Procdesc.get_ret_var proc_desc) callee arg_values
    in
    let normal_state =
      Domain.bind_extern_value astate instr_node (ret_id, Typ.void_star) callee arg_values
    in
    normal_state @ ex_state
  in
  (is_model, exec)


module Collection = struct
  let mIsEmptyField = Fieldname.make (Typ.Name.Java.from_string "Collection") "mIsEmpty"

  let classes =
    ["java.util.Iterator"; "java.util.Collection"; "java.util.Enumeration"; "java.util.Collections"]


  let is_model_class classname = implements_interfaces classes classname

  let setIsEmpty astate instr_node loc =
    let is_empty_field_loc = Loc.append_field loc ~fn:mIsEmptyField in
    let is_empty_value = Val.make_extern instr_node Typ.int in
    let astate_stored = Domain.store_loc astate is_empty_field_loc is_empty_value in
    Domain.add_pc astate_stored (PathCond.make_physical_equals Binop.Eq is_empty_value Val.one)


  let enumeration_of : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _)
        when String.equal "enumeration" (Procname.get_method callee) ->
          is_model_class (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let astate, value = Domain.eval astate instr_node this_exp in
      [Domain.store_reg astate ret_id value]
    in
    (is_model, exec)


  let emptyCollection : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [], _, _)
        when List.mem
               ["emptyEnumeration"; "emptySet"; "emptyList"; "emptyMap"]
               ~equal:String.equal (Procname.get_method callee) ->
          is_model_class (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) _ =
      let value = Val.make_allocsite instr_node in
      let astate' = Domain.store_reg astate ret_id value in
      setIsEmpty astate' instr_node (Val.to_loc value)
    in
    (is_model, exec)


  let init : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _) when Procname.Java.is_constructor mthd
        ->
          is_model_class (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ _ arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      setIsEmpty astate instr_node this_loc
    in
    (is_model, exec)


  let read_field astate field_loc =
    let astate =
      if Domain.is_unknown_loc astate field_loc then
        Domain.resolve_unknown_loc astate Typ.int field_loc
      else astate
    in
    (astate, Domain.read_loc astate field_loc)


  let isEmpty : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _)
        when String.equal (Procname.get_method callee) "isEmpty" ->
          is_model_class (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let is_empty_field_loc = Loc.append_field this_loc ~fn:mIsEmptyField in
      let astate', is_empty_value = read_field astate is_empty_field_loc in
      [Domain.store_reg astate' ret_id is_empty_value]
    in
    (is_model, exec)


  let iterator : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _)
        when String.equal (Procname.get_method callee) "iterator" ->
          is_model_class (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let is_empty_field_loc = Loc.append_field this_loc ~fn:mIsEmptyField in
      let astate', is_empty_value = read_field astate is_empty_field_loc in
      let iterator = SymDom.SymHeap.make_allocsite instr_node in
      let iterator_is_empty = Loc.append_field (Loc.SymHeap iterator) ~fn:mIsEmptyField in
      let astate_stored = Domain.store_loc astate' iterator_is_empty is_empty_value in
      [Domain.store_reg astate_stored ret_id (Val.of_symheap iterator)]
    in
    (is_model, exec)


  let hasNext : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _)
        when String.equal (Procname.get_method callee) "hasNext" ->
          is_model_class (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let is_empty_field_loc = Loc.append_field this_loc ~fn:mIsEmptyField in
      let astate', is_empty_value = read_field astate is_empty_field_loc in
      if Val.is_true is_empty_value then [Domain.store_reg astate' ret_id Val.zero]
      else if Val.is_false is_empty_value then [Domain.store_reg astate' ret_id Val.one]
      else
        let return_value = Val.neg_of is_empty_value in
        [Domain.store_reg astate ret_id return_value]
    in
    (is_model, exec)


  let add : model =
    let is_model callee _ =
      match callee with
      | Procname.Java mthd when String.is_prefix (Procname.get_method callee) ~prefix:"add" ->
          is_model_class (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let is_empty_field_loc = Loc.append_field this_loc ~fn:mIsEmptyField in
      let is_empty_value = Val.make_extern instr_node Typ.int in
      let return_value = Val.make_extern instr_node Typ.int in
      let astate_return_stored = Domain.store_reg astate ret_id return_value in
      let astate_stored = Domain.store_loc astate_return_stored is_empty_field_loc is_empty_value in
      Domain.add_pc astate_stored (PathCond.make_physical_equals Binop.Eq is_empty_value Val.zero)
    in
    (is_model, exec)


  let next : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, Typ.{desc= Tptr _})], _, _)
        when String.equal (Procname.get_method callee) "next" ->
          is_model_class (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let is_empty_field_loc = Loc.append_field this_loc ~fn:mIsEmptyField in
      (* CAUTION: do not make constraint: next_value = next(iterator) *)
      (* HEURISTIC: next always return next value other than NoSuchElement Exception *)
      let is_empty_value = Val.make_extern instr_node Typ.int in
      let next_value = Val.make_extern instr_node Typ.void_star in
      let astate = Domain.store_reg astate ret_id next_value in
      let astate = Domain.store_loc astate is_empty_field_loc is_empty_value in
      let astate_empty =
        Domain.add_pc astate (PathCond.make_physical_equals Binop.Eq is_empty_value Val.one)
      in
      let astate_non_empty =
        Domain.add_pc astate (PathCond.make_physical_equals Binop.Eq is_empty_value Val.zero)
      in
      astate_empty @ astate_non_empty
    in
    (is_model, exec)


  let models = [init; isEmpty; iterator; next; hasNext; add; enumeration_of; emptyCollection]

  let models = [init; next; hasNext]
end

module IO = struct
  let mStatus = Fieldname.make (Typ.Name.Java.from_string "Stream") "mStatus"

  let classes =
    [ "java.io.FileInputStream"
    ; "java.io.FileOutputStream"
    ; "java.io.InputStream"
    ; "java.io.OutputStream" ]


  let init : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _) when Procname.Java.is_constructor mthd
        ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate pdesc instr_node callee _ arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let astate, this_val = Domain.eval astate instr_node this_exp in
      let status_field_loc = Loc.append_field this_loc ~fn:mStatus in
      let normal_state = Domain.store_loc astate status_field_loc Val.one in
      let exceptional_state =
        Domain.bind_exn_extern astate instr_node (Procdesc.get_ret_var pdesc) callee [this_val]
      in
      normal_state :: exceptional_state
    in
    (is_model, exec)


  let close : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _)
        when String.equal (Procname.get_method callee) "close" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate pdesc instr_node callee _ arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let astate, this_val = Domain.eval astate instr_node this_exp in
      let status_field_loc = Loc.append_field this_loc ~fn:mStatus in
      let normal_state = Domain.store_loc astate status_field_loc Val.zero in
      let exceptional_state =
        Domain.bind_exn_extern astate instr_node (Procdesc.get_ret_var pdesc) callee [this_val]
      in
      normal_state :: exceptional_state
    in
    (is_model, exec)


  let read : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, _, _, _)
        when String.equal (Procname.get_method callee) "read" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate pdesc instr_node callee (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let astate, this_val = Domain.eval astate instr_node this_exp in
      (* CAUTION: do not make constraint: read_value = read(file) *)
      let read_value = Val.make_extern instr_node Typ.int in
      let normal_state = Domain.store_reg astate ret_id read_value in
      let exceptional_state =
        Domain.bind_exn_extern astate instr_node (Procdesc.get_ret_var pdesc) callee [this_val]
      in
      normal_state :: exceptional_state
    in
    (is_model, exec)


  let models = [init; close; read]
end

module Primitives = struct
  let mValue = Fieldname.make (Typ.Name.Java.from_string "Primitive") "mValue"

  let classes = ["java.lang.Boolean"; "java.lang.Double"]

  let init : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, _)], _, _)
        when Procname.Java.is_constructor mthd ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ _ arg_typs =
      let[@warning "-8"] [(this_exp, _); (arg_exp, _)] = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let value_field_loc = Loc.append_field this_loc ~fn:mValue in
      let astate, arg_val = Domain.eval astate instr_node arg_exp in
      [Domain.store_loc astate value_field_loc arg_val]
    in
    (is_model, exec)


  let booleanValue : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _)
        when String.equal (Procname.get_method callee) "booleanValue" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let value =
        match Domain.eval_value astate instr_node this_exp with
        | Val.Vheap (Symbol s) ->
            let deref_field = SymDom.Symbol.to_ap s |> AccessExpr.get_deref_field in
            if String.equal deref_field "FALSE" then Val.zero
            else if String.equal deref_field "TRUE" then Val.one
            else Val.make_extern instr_node Typ.int
        | _ ->
            Val.make_extern instr_node Typ.int
      in
      [Domain.store_reg astate ret_id value]
    in
    (is_model, exec)


  let models = [init; booleanValue]
end

module Lang = struct
  let classes = ["java.lang.String"]

  let builder_classes = ["java.lang.StringBuilder"; "java.lang.StringBuffer"]

  let valueField = Fieldname.make (Typ.Name.Java.from_string "String") "value"

  let mLengthfn = Fieldname.make (Typ.Name.Java.from_string "String") "mLength"

  let read_value astate instr_node str_exp =
    match Domain.eval_value astate instr_node str_exp with
    | Val.Vheap (SymHeap.String _) as str_value ->
        (astate, str_value)
    | Val.Vheap _ as heap ->
        (astate, heap)
        (* let str_field = Loc.append_field ~fn:valueField (Loc.SymHeap sh) in
           let astate_unknown_resolved = Domain.resolve_unknown_loc astate Typ.void_star str_field in
           let str_value = Domain.read_loc astate str_field in
           (astate_unknown_resolved, str_value) *)
    | _ as v ->
        (* L.progress "[WARNING]: %a is not allowed as string value@." Val.pp v ; *)
        let str_value = Val.make_extern instr_node Typ.void_star in
        (astate, str_value)


  let init : model =
    (* TODO: modeling new String() *)
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, _)], _, _)
        when Procname.Java.is_constructor mthd ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ _ arg_typs =
      let[@warning "-8"] ((this_exp, _) :: (str_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let value_field_loc = Loc.append_field this_loc ~fn:valueField in
      let astate, str_value = read_value astate instr_node str_exp in
      [Domain.store_loc astate value_field_loc str_value]
    in
    (is_model, exec)


  let init_default : model =
    let is_model callee instr =
      (* new StringBuilder(), new String() -> new object with empty string *)
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _) when Procname.Java.is_constructor mthd
        ->
          implements (classes @ builder_classes) (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ _ arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let this_loc = Domain.eval_lv astate instr_node this_exp in
      let value_field_loc = Loc.append_field this_loc ~fn:valueField in
      let astate, str_value = read_value astate instr_node (Exp.Const (Cstr "")) in
      [Domain.store_loc astate value_field_loc str_value]
    in
    (is_model, exec)


  let init_size : model =
    (* new StringBuilder (size) *)
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, typ)], _, _)
        when Procname.Java.is_constructor mthd ->
          implements builder_classes (Procname.Java.get_class_type_name mthd) && Typ.is_int typ
      | _ ->
          false
    in
    let exec astate proc_desc instr_node callee _ arg_typs =
      let[@warning "-8"] ((this_exp, _) :: (size_exp, _) :: _) = arg_typs in
      let astate, this_val = Domain.eval astate instr_node this_exp in
      let astate, size_val = Domain.eval astate instr_node size_exp in
      let ret_var = Procdesc.get_ret_var proc_desc in
      let minus_states =
        let minus_cond = SymDom.PathCond.make_lt_pred size_val Val.zero in
        Domain.bind_exn_extern astate instr_node ret_var callee [this_val; size_val]
        |> List.concat_map ~f:(fun astate' -> Domain.add_pc ~is_branch:true astate' minus_cond)
      in
      let plus_states =
        let plus_cond = SymDom.PathCond.make_le_pred Val.zero size_val in
        let this_loc = Domain.eval_lv astate instr_node this_exp in
        let value_field_loc = Loc.append_field this_loc ~fn:valueField in
        let astate, str_value = read_value astate instr_node (Exp.Const (Cstr "")) in
        let astate = Domain.store_loc astate value_field_loc str_value in
        Domain.add_pc ~is_branch:true astate plus_cond
      in
      minus_states @ plus_states
    in
    (is_model, exec)


  let equals : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, _)], _, _)
        when String.equal (Procname.get_method callee) "equals" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: (str_exp, _) :: _) = arg_typs in
      let astate, lhs_value = read_value astate instr_node this_exp in
      let astate, rhs_value = read_value astate instr_node str_exp in
      let equal_states =
        let equal_cond = PathCond.make_physical_equals Binop.Eq lhs_value rhs_value in
        Domain.add_pc (Domain.store_reg astate ret_id Val.one) equal_cond
      in
      let non_equal_states =
        let non_equal_cond = PathCond.make_physical_equals Binop.Ne lhs_value rhs_value in
        Domain.add_pc (Domain.store_reg astate ret_id Val.zero) non_equal_cond
      in
      equal_states @ non_equal_states
    in
    (is_model, exec)


  let isEmpty : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _)
        when String.equal (Procname.get_method callee) "isEmpty" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let astate, str_value = read_value astate instr_node this_exp in
      match str_value with
      | Val.Vheap (SymHeap.String str) when String.equal str "" ->
          [Domain.store_reg astate ret_id Val.one]
      | Val.Vheap (SymHeap.String _) ->
          [Domain.store_reg astate ret_id Val.zero]
      | _ ->
          let empty_states =
            let empty_cond =
              PathCond.make_physical_equals Binop.Eq str_value (Val.make_string "")
            in
            Domain.add_pc (Domain.store_reg astate ret_id Val.one) empty_cond
          in
          let non_empty_states =
            let empty_cond =
              PathCond.make_physical_equals Binop.Ne str_value (Val.make_string "")
            in
            Domain.add_pc (Domain.store_reg astate ret_id Val.zero) empty_cond
          in
          empty_states @ non_empty_states
    in
    (is_model, exec)


  let length : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _)
        when String.equal (Procname.get_method callee) "length" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, ret_typ) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: _) = arg_typs in
      let astate, str_value = read_value astate instr_node this_exp in
      match List.find (Domain.equal_values astate str_value) ~f:is_string with
      | Some (Val.Vheap (SymHeap.String str)) ->
          let length_value = Val.of_intlit (IntLit.of_int (String.length str)) in
          [Domain.store_reg astate ret_id length_value]
      | _ ->
          let this_loc = Domain.eval_lv astate instr_node this_exp in
          (* let length_val = Val.make_extern instr_node ret_typ in *)
          let fn_loc = Domain.Loc.append_field this_loc ~fn:mLengthfn in
          let length_val = Domain.read_loc ~typ:(Some Typ.int) astate fn_loc in
          let length_cond = SymDom.PathCond.make_le_pred Val.zero length_val in
          let astate_ret_stored = Domain.store_reg astate ret_id length_val in
          let astate_mem_stored = Domain.store_loc astate_ret_stored fn_loc length_val in
          Domain.add_pc astate_mem_stored length_cond
    in
    (is_model, exec)


  let append : model =
    (* StringBuilder.append(String) *)
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, _)], _, _)
        when String.equal (Procname.get_method callee) "append" ->
          implements builder_classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node _ (ret_id, _) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: (str_exp, _) :: _) = arg_typs in
      let this_loc_field =
        Loc.append_field (Domain.eval_lv astate instr_node this_exp) ~fn:valueField
      in
      let astate, this_value = Domain.eval astate instr_node this_exp in
      let astate, str_to_append =
        if Val.is_null (Domain.eval_value astate instr_node str_exp) then
          (astate, Val.make_string "null")
        else read_value astate instr_node str_exp
      in
      let astate, this_str = read_value astate instr_node this_exp in
      match (this_str, str_to_append) with
      | Val.Vheap (String str1), Val.Vheap (String str2) ->
          let str = String.concat [str1; str2] in
          let astate' = Domain.store_loc astate this_loc_field (Val.Vheap (String str)) in
          [Domain.store_reg astate' ret_id this_value]
      | _ ->
          let str_value = Val.make_extern instr_node Typ.void_star in
          let astate' = Domain.store_loc astate this_loc_field str_value in
          [Domain.store_reg astate' ret_id this_value]
    in
    (is_model, exec)


  let charAt : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, _)], _, _)
        when String.equal (Procname.get_method callee) "charAt" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node callee (ret_id, ret_typ) arg_typs =
      let[@warning "-8"] ((this_exp, _) :: (index_exp, _) :: _) = arg_typs in
      let astate, str_value = read_value astate instr_node this_exp in
      let astate, index_val = Domain.eval astate instr_node index_exp in
      match List.find (Domain.equal_values astate index_val) ~f:is_int with
      | Some (Val.Vint (IntLit i)) -> (
        match List.find (Domain.equal_values astate str_value) ~f:is_string with
        | Some (Val.Vheap (SymHeap.String str)) ->
            let char_val = str.[IntLit.to_int_exn i] |> Char.to_string |> Val.make_string in
            [Domain.store_reg astate ret_id char_val]
        | _ ->
            let this_loc = Domain.eval_lv astate instr_node this_exp in
            (* let length_val = Val.make_extern instr_node ret_typ in *)
            let index_loc = Domain.Loc.append_index this_loc ~index:(SymDom.SymExp.of_intlit i) in
            let char_val = Domain.read_loc ~typ:(Some ret_typ) astate index_loc in
            [Domain.store_reg astate ret_id char_val] )
      | _ ->
          Domain.bind_extern_value astate instr_node (ret_id, ret_typ) callee [str_value; index_val]
    in
    (is_model, exec)


  let models = [init; isEmpty; length; charAt; equals; append; init_size; init_default]
end

module Math = struct
  let classes = ["java.lang.Math"]

  let min : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, _)], _, _)
        when String.equal (Procname.get_method callee) "min" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node callee (ret_id, ret_typ) arg_typs =
      let[@warning "-8"] ((x, _) :: (y, _) :: _) = arg_typs in
      let astate, x_val = Domain.eval astate instr_node x in
      let astate, y_val = Domain.eval astate instr_node y in
      match (x_val, y_val) with
      | Val.Vint (IntLit x), Val.Vint (IntLit y) ->
          let v = Val.Vint (IntLit (IntLit.min x y)) in
          [Domain.store_reg astate ret_id v]
      | Val.Vint (FloatLit x), Val.Vint (FloatLit y) ->
          let v = Val.Vint (FloatLit (Float.min x y)) in
          [Domain.store_reg astate ret_id v]
      | _ ->
          Domain.bind_extern_value astate instr_node (ret_id, ret_typ) callee [x_val; y_val]
    in
    (is_model, exec)


  let max : model =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, _)], _, _)
        when String.equal (Procname.get_method callee) "max" ->
          implements classes (Procname.Java.get_class_type_name mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node callee (ret_id, ret_typ) arg_typs =
      let[@warning "-8"] ((x, _) :: (y, _) :: _) = arg_typs in
      let astate, x_val = Domain.eval astate instr_node x in
      let astate, y_val = Domain.eval astate instr_node y in
      match (x_val, y_val) with
      | Val.Vint (IntLit x), Val.Vint (IntLit y) ->
          let v = Val.Vint (IntLit (IntLit.max x y)) in
          [Domain.store_reg astate ret_id v]
      | Val.Vint (FloatLit x), Val.Vint (FloatLit y) ->
          let v = Val.Vint (FloatLit (Float.max x y)) in
          [Domain.store_reg astate ret_id v]
      | _ ->
          Domain.bind_extern_value astate instr_node (ret_id, ret_typ) callee [x_val; y_val]
    in
    (is_model, exec)


  let models = [max; min]
end

module Assert = struct
  let classes = ["org.junit.Assert"; "com.google.common.base.Preconditions"]

  let equals astate v1 v2 =
    Domain.add_pc astate (PathCond.make_physical_equals Binop.Eq v1 v2) |> List.is_empty |> not


  let check_equals ?(neg = fun x -> x) astate expected_value actual_value =
    if equals astate expected_value actual_value |> neg then [astate]
    else (
      L.d_printfln "Assertion failed: %a and %a are not equal" Val.pp expected_value Val.pp
        actual_value ;
      [] )


  let assertEquals : model =
    (* assertArrayEquals not supported *)
    let names = ["assertEquals"; "assertSame"; "assertNotSame"] in
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _); (_, _)], _, _) ->
          implements classes (Procname.Java.get_class_type_name mthd)
          && List.mem names ~equal:String.equal (Procname.Java.get_method mthd)
      | Procname.Java mthd, Sil.Call (_, _, [(_, msg_typ); (_, _); (_, _)], _, _)
        when is_string_typ msg_typ ->
          implements classes (Procname.Java.get_class_type_name mthd)
          && List.mem names ~equal:String.equal (Procname.Java.get_method mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node callee _ arg_typs =
      let[@warning "-8"] e1, e2 =
        match arg_typs with
        | [(expected, _); (actual, _)] ->
            (expected, actual)
        | [(_, _); (expected, _); (actual, _)] ->
            (expected, actual)
      in
      let astate, v1 = Domain.eval astate instr_node e1 in
      let astate, v2 = Domain.eval astate instr_node e2 in
      if String.equal (Procname.get_method callee) "assertEquals" then check_equals astate v1 v2
      else
        let is_same =
          if String.equal (Procname.get_method callee) "assertSame" then fun x -> x else not
        in
        if List.mem (Domain.equal_values astate v2) ~equal:Val.equal v1 |> is_same then [astate]
        else []
    in
    (is_model, exec)


  let assertEqualsConst : model =
    (* assertArrayEquals not supported *)
    let names = ["assertTrue"; "assertFalse"; "assertNull"; "assertNotNull"; "checkState"] in
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, [(_, _)], _, _) ->
          implements classes (Procname.Java.get_class_type_name mthd)
          && List.mem names ~equal:String.equal (Procname.Java.get_method mthd)
      | Procname.Java mthd, Sil.Call (_, _, [(_, msg_typ); (_, _)], _, _) when is_string_typ msg_typ
        ->
          implements classes (Procname.Java.get_class_type_name mthd)
          && List.mem names ~equal:String.equal (Procname.Java.get_method mthd)
      | _ ->
          false
    in
    let exec astate _ instr_node callee _ arg_typs =
      let method_name = Procname.get_method callee in
      let[@warning "-8"] exp =
        match arg_typs with [(actual, _)] -> actual | [(_, _); (actual, _)] -> actual
      in
      let[@warning "-8"] const =
        match method_name with
        | "assertTrue" | "checkState" ->
            Val.one
        | "assertFalse" ->
            Val.zero
        | "assertNull" ->
            Val.make_null ()
        | "assertNotNull" ->
            Val.make_null ()
      in
      let astate, value = Domain.eval astate instr_node exp in
      if String.equal "assertNotNull" method_name then check_equals astate const value ~neg:not
      else check_equals astate const value
    in
    (is_model, exec)


  let fail =
    let is_model callee instr =
      match (callee, instr) with
      | Procname.Java mthd, Sil.Call (_, _, _, _, _) ->
          implements classes (Procname.Java.get_class_type_name mthd)
          && String.equal (Procname.Java.get_method mthd) "fail"
      | _ ->
          false
    in
    let exec _ _ _ _ _ _ =
      L.d_printfln "the state is invalidated because of fail" ;
      []
    in
    (is_model, exec)


  let models = [assertEquals; assertEqualsConst; fail]
end

let models : model list =
  BuiltIn.models @ [invoke] @ Collection.models @ IO.models @ Lang.models @ Primitives.models
  @ Assert.models @ Math.models


let find_model_opt callee instr = List.find models ~f:(fun (is_model, _) -> is_model callee instr)

let is_model callee instr = find_model_opt callee instr |> Option.is_some

let exec_model : exec =
 fun astate proc_desc instr_node callee (ret_id, ret_typ) arg_typs ->
  let instr = InstrNode.get_instr instr_node in
  match find_model_opt callee instr with
  | Some (_, exec) ->
      exec astate proc_desc instr_node callee (ret_id, ret_typ) arg_typs
  | None ->
      []

(* let cast = snd cast

   let instanceof = snd instanceof

   let unwrap_exception = snd unwrap_exception

   let invoke = snd invoke

   let getter_matcher _ callee_name =

   module Call = struct
     let dispatch : (Tenv.t, exec, unit) ProcnameDispatcher.Call.dispatcher =
       let open ProcnameDispatcher.Call in
       let match_builtin builtin _ s = String.equal s (Procname.get_method builtin) in
       make_dispatcher
         [ +match_builtin BuiltinDecl.__cast <>--> cast
         ; +match_builtin BuiltinDecl.__instanceof <>--> instanceof
         ; +match_builtin BuiltinDecl.__unwrap_exception <>--> unwrap_exception
         ; +PatternMatch.Java.implements "java.lang.reflect.Method" &:: "invoke" <>--> invoke
         ; +PatternMatch.Java.implements "java.lang.reflect.Method" &:: "invoke" <>--> invoke
         ]
   end *)
