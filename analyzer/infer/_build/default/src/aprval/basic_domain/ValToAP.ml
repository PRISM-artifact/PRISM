open! IStd
open! Vocab
module F = Format
module L = Logging
module Loc = SymDom.Loc

module Val = struct
  include SymDom.Val

  let compare v1 v2 =
    (* this is for identifying each null source *)
    match (v1, v2) with
    | Vheap (Null n1), Vheap (Null n2) ->
        Int.compare n1 n2
    | Vheap (Null _), _ ->
        1
    | _, Vheap (Null _) ->
        -1
    | _ ->
        compare v1 v2
end

module Mem = SymDom.Mem
module PC = SymDom.PC
module PathCondVal = SymDom.PathCond
module SymExp = SymDom.SymExp
module SymHeap = SymDom.SymHeap
module APSet = AccessExpr.AbsSet

module ValToAP = struct
  include WeakMap.Make (Val) (APSet)

  (* Module for converting each symbolic value to access expression *)
  let find v t =
    let rec resolve v =
      let sub_aps =
        match v with
        | Val.Vextern (callee, args) ->
            let make_ap_call callee arg_aps =
              let method_call_access = AccessExpr.MethodCallAccess (callee, arg_aps) in
              AccessExpr.append_access AccessExpr.dummy method_call_access
            in
            let aps_args_list =
              List.map args ~f:(fun arg_value ->
                  (* this recursive is ok because function value does not contain function value *)
                  let arg_aps = resolve arg_value in
                  APSet.filter (not <<< AccessExpr.contains_method_access) arg_aps |> APSet.elements)
            in
            let arg_aps_list =
              (* [v1, v2]: args
               * [[ap11, ap12], [ap21, ap22]]: aps_args_list
               * [ap11, ap21], [ap11, ap22], [ap12, ap21], [ap12, ap22]: arg_aps_list *)
              List.fold aps_args_list ~init:[[]]
                ~f:(fun
                     (acc : AccessExpr.t list list)
                     (aps : AccessExpr.t list)
                     :
                     AccessExpr.t list list
                   ->
                  List.concat_map acc ~f:(fun arg_list ->
                      List.map aps ~f:(fun ap -> arg_list @ [ap])))
              (* [ap11], [ap12] 
               * [ap11, ap21], [ap11, ap21] | [ap12, ap21], [ap12, ap22] *)
            in
            List.map arg_aps_list ~f:(make_ap_call callee) |> APSet.of_list
        | v -> (
          match Val.to_ap v with Some ap -> APSet.singleton ap | None -> APSet.empty )
      in
      APSet.union sub_aps (find v t)
    in
    resolve v


  let find_only_const v t =
    let aps = find v t in
    if APSet.exists AccessExpr.is_concrete aps then APSet.filter AccessExpr.is_concrete aps else aps


  let find_loc l t =
    match l with
    | Loc.SymHeap sh ->
        find (Val.Vheap sh) t
    | Loc.Field (Loc.SymHeap sh, fn) ->
        let base_aps = find (Val.Vheap sh) t in
        APSet.map
          (fun base_ap -> AccessExpr.append_access base_ap (AccessExpr.FieldAccess fn))
          base_aps
    | Loc.Index (Loc.Var pv, index) ->
        let index_aps = find (Val.Vint index) t in
        APSet.fold
          (fun index_ap ->
            AccessExpr.append_access (AccessExpr.of_pvar pv) (AccessExpr.ArrayAccess index_ap)
            |> APSet.add)
          index_aps APSet.empty
    | Loc.Index (Loc.SymHeap sh, index) ->
        let base_aps = find (Val.Vheap sh) t in
        let index_aps = find (Val.Vint index) t in
        let append_index base_ap index_ap =
          AccessExpr.append_access base_ap (AccessExpr.ArrayAccess index_ap) |> APSet.add
        in
        APSet.fold (fun base_ap -> APSet.fold (append_index base_ap) index_aps) base_aps APSet.empty
    | l -> (
      match Loc.to_ap l with Some ap -> APSet.singleton ap | None -> APSet.empty )


  let weak_update v aps t =
    let aps = if not (mem v t) then APSet.union aps (find v t) else aps in
    let aps = APSet.filter (not <<< AccessExpr.has_duplicates) aps in
    weak_update v aps t


  (* if Val.is_constant v then weak_update v (find v t) t else weak_update v aps t *)

  (* Update val to ap based on the memory and constraints *)
  let update_by_mem mem t =
    let check_param : Loc.t -> Val.t -> bool =
     fun l v ->
      match l with
      | Loc.Var pv -> (
        (* when the parameter symbol is unchanged => remain ap as symbol*)
        match v with
        | Val.Vint (SymExp.Symbol (Param pv', [])) | Val.Vheap (SymHeap.Symbol (Param pv', [])) ->
            Pvar.equal pv pv'
        | _ ->
            false )
      | _ ->
          false
    in
    Mem.fold
      (fun l v acc ->
        if Val.is_abstract v || Val.is_const_extern v then acc
        else if check_param l v then weak_update v (find v t) acc
        else
          let aps_loc = find_loc l t in
          weak_update v aps_loc acc)
      mem t


  let update_by_pc PC.{const_map; pc_set} t =
    PC.ConstMap.fold (fun v c -> weak_update v (find_only_const c t)) const_map t
    |> PC.PCSet.fold
         (fun pc acc ->
           match pc with
           | PathCondVal.Eq (v1, v2) ->
               weak_update v1 (find_only_const v2 t) acc |> weak_update v2 (find_only_const v1 t)
           | _ ->
               acc)
         pc_set
end

(* AP version of basicr domain element (mem, pc) *)
module APMem = struct
  include WeakMap.Make (AccessExpr) (APSet)

  let construct val_to_ap mem =
    Mem.fold
      (fun l v acc ->
        if Loc.is_temp l then acc
        else
          let ap_locs = ValToAP.find_loc l val_to_ap in
          (* if the loc points to constants, remove uninformative values  *)
          let aps =
            if Val.is_concrete v then ValToAP.find_only_const v val_to_ap
            else ValToAP.find v val_to_ap
          in
          (* L.debug_dev "from (%a -> %a) to (%a = %a)@." Loc.pp l Val.pp v APSet.pp aps_loc APSet.pp aps_val ; *)
          (* Scalability issue *)
          APSet.fold
            (fun ap_loc acc ->
              if APSet.is_empty aps then add ap_loc (APSet.singleton ap_loc) acc
              else add ap_loc aps acc)
            ap_locs acc)
      mem empty


  let is_uniq_const ap t = APSet.is_uniq_const (find ap t)

  let get_uniq_const ap t = APSet.get_uniq_const (find ap t)

  let has_consts ap t = APSet.has_consts (find ap t)

  let get_consts ap t = APSet.get_consts (find ap t)
end

module Formula = struct
  module Predicate = Constraint.Make (AccessExpr)
  include Constraint.MakePC (AccessExpr)

  let make_formula binop ap_set1 ap_set2 =
    let ap_pairs = List.cartesian_product (APSet.elements ap_set1) (APSet.elements ap_set2) in
    List.fold ~init:PCSet.empty ap_pairs ~f:(fun acc (ap1, ap2) ->
        match binop with
        | Binop.Eq | Binop.Ne ->
            PCSet.add (Predicate.make_physical_equals binop ap1 ap2) acc
        | Binop.Lt ->
            PCSet.add (Predicate.make_lt_pred ap1 ap2) acc
        | Binop.Le ->
            PCSet.add (Predicate.make_le_pred ap1 ap2) acc
        | _ ->
            L.(die InternalError) "%a is not allowed for formula@." Binop.pp binop)


  let construct val_to_ap pc =
    let pathcond_to_formula = function
      | SymDom.PathCond.Eq (v1, v2) ->
          let ap_set1, ap_set2 =
            (ValToAP.find_only_const v1 val_to_ap, ValToAP.find_only_const v2 val_to_ap)
          in
          (* L.debug_dev "from (%a = %a) to (%a = %a)@." Val.pp v1 Val.pp v2 APSet.pp ap_set1 APSet.pp
             ap_set2 ; *)
          make_formula Binop.Eq ap_set1 ap_set2
      | SymDom.PathCond.Lt (v1, v2) | SymDom.PathCond.Neg (Le (v2, v1)) ->
          let ap_set1, ap_set2 =
            (ValToAP.find_only_const v1 val_to_ap, ValToAP.find_only_const v2 val_to_ap)
          in
          make_formula Binop.Lt ap_set1 ap_set2
      | SymDom.PathCond.Le (v1, v2) | SymDom.PathCond.Neg (Lt (v2, v1)) ->
          let ap_set1, ap_set2 =
            (ValToAP.find_only_const v1 val_to_ap, ValToAP.find_only_const v2 val_to_ap)
          in
          make_formula Binop.Le ap_set1 ap_set2
      | SymDom.PathCond.Neg (SymDom.PathCond.Eq (v1, v2)) ->
          let ap_set1, ap_set2 =
            (ValToAP.find_only_const v1 val_to_ap, ValToAP.find_only_const v2 val_to_ap)
          in
          make_formula Binop.Ne ap_set1 ap_set2
      | _ ->
          (* TODO: *)
          PCSet.empty
    in
    let pc' =
      PC.PCSet.fold
        (fun pc acc ->
          let pcset = pathcond_to_formula pc in
          PCSet.fold (fun pc' acc -> add pc' acc) pcset acc)
        (PC.to_pc_set pc) empty
    in
    let branches' =
      PC.PCSet.fold
        (fun pc acc ->
          let pc' = pathcond_to_formula pc in
          PCSet.union pc' acc)
        PC.(pc.branches)
        PCSet.empty
    in
    {pc' with branches= branches'}
end

include ValToAP
