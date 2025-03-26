module Jbuild_plugin : sig
(** API for jbuild plugins *)

(* CR-someday amokhov: rename to [dune_plugin]. *)

module V1 : sig
  (** Current build context *)
  val context : string

  (** OCaml version for the current build context. It might not be the same as
      [Sys.ocaml_version] *)
  val ocaml_version : string

  (** Output of [ocamlc -config] for this context *)
  val ocamlc_config : (string * string) list

  (** [send s] send [s] to Dune. [s] should be the contents of a [dune] file
      following the specification described in the manual. *)
  val send : string -> unit

  (** Execute a command and read its output *)
  val run_and_read_lines : string -> string list
end

end = struct

let () =
  Hashtbl.add Toploop.directive_table "require"
    (Toploop.Directive_string ignore);
  Hashtbl.add Toploop.directive_table "use"
    (Toploop.Directive_string
       (fun _ ->
         failwith "#use is not allowed inside a dune file in OCaml syntax"));
  Hashtbl.add Toploop.directive_table "use_mod"
    (Toploop.Directive_string
       (fun _ ->
         failwith "#use is not allowed inside a dune file in OCaml syntax"))

module V1 = struct
  let context = "default"
        let ocaml_version = "4.11.1"
        let send_target = "../_build/.dune/default/src/dune"
        let ocamlc_config = [ "version"                   , "4.11.1"
      ; "standard_library_default"  , "/home/dowon/.opam/ocaml-variants.4.11.1+flambda/lib/ocaml"
      ; "standard_library"          , "/home/dowon/.opam/ocaml-variants.4.11.1+flambda/lib/ocaml"
      ; "standard_runtime"          , "the_standard_runtime_variable_was_deleted"
      ; "ccomp_type"                , "cc"
      ; "c_compiler"                , "gcc"
      ; "ocamlc_cflags"             , "-O2 -fno-strict-aliasing -fwrapv -fPIC"
      ; "ocamlc_cppflags"           , "-D_FILE_OFFSET_BITS=64 -D_REENTRANT"
      ; "ocamlopt_cflags"           , "-O2 -fno-strict-aliasing -fwrapv -fPIC"
      ; "ocamlopt_cppflags"         , "-D_FILE_OFFSET_BITS=64 -D_REENTRANT"
      ; "bytecomp_c_compiler"       , "gcc -O2 -fno-strict-aliasing -fwrapv -fPIC -D_FILE_OFFSET_BITS=64 -D_REENTRANT"
      ; "bytecomp_c_libraries"      , "-lm -lpthread"
      ; "native_c_compiler"         , "gcc -O2 -fno-strict-aliasing -fwrapv -fPIC -D_FILE_OFFSET_BITS=64 -D_REENTRANT"
      ; "native_c_libraries"        , "-lm"
      ; "cc_profile"                , ""
      ; "architecture"              , "amd64"
      ; "model"                     , "default"
      ; "int_size"                  , "63"
      ; "word_size"                 , "64"
      ; "system"                    , "linux"
      ; "asm"                       , "as"
      ; "asm_cfi_supported"         , "true"
      ; "with_frame_pointers"       , "false"
      ; "ext_exe"                   , ""
      ; "ext_obj"                   , ".o"
      ; "ext_asm"                   , ".s"
      ; "ext_lib"                   , ".a"
      ; "ext_dll"                   , ".so"
      ; "os_type"                   , "Unix"
      ; "default_executable_name"   , "a.out"
      ; "systhread_supported"       , "true"
      ; "host"                      , "x86_64-pc-linux-gnu"
      ; "target"                    , "x86_64-pc-linux-gnu"
      ; "profiling"                 , "false"
      ; "flambda"                   , "true"
      ; "spacetime"                 , "false"
      ; "safe_string"               , "true"
      ; "exec_magic_number"         , "Caml1999X028"
      ; "cmi_magic_number"          , "Caml1999I028"
      ; "cmo_magic_number"          , "Caml1999O028"
      ; "cma_magic_number"          , "Caml1999A028"
      ; "cmx_magic_number"          , "Caml1999y028"
      ; "cmxa_magic_number"         , "Caml1999z028"
      ; "ast_impl_magic_number"     , "Caml1999M028"
      ; "ast_intf_magic_number"     , "Caml1999N028"
      ; "cmxs_magic_number"         , "Caml1999D028"
      ; "cmt_magic_number"          , "Caml1999T028"
      ; "natdynlink_supported"      , "true"
      ; "supports_shared_libraries" , "true"
      ; "windows_unicode"           , "false" ]
        

  let send s =
    let oc = open_out_bin send_target in
    output_string oc s;
    close_out oc

  let run_and_read_lines cmd =
    let tmp_fname = Filename.temp_file "dune" ".output" in
    at_exit (fun () -> Sys.remove tmp_fname);
    let n =
      Printf.ksprintf Sys.command "%s > %s" cmd (Filename.quote tmp_fname)
    in
    let rec loop ic acc =
      match input_line ic with
      | exception End_of_file ->
        close_in ic;
        List.rev acc
      | line -> loop ic (line :: acc)
    in
    let output = loop (open_in tmp_fname) [] in
    if n = 0 then
      output
    else
      Printf.ksprintf failwith
        "Command failed: %%s\nExit code: %%d\nOutput:\n%%s" cmd n
        (String.concat "\n" output)
end

end
# 1 "src/dune"
(* -*- tuareg -*- *)
(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)
(* use strings so that it looks like OCaml even before substituting, e.g. to use ocamlformat *)

let is_yes = String.equal "yes"

let is_empty = String.equal ""

let clang = is_yes "no"

let java = is_yes "yes"

let facebook = is_yes "no"

let extra_cflags = if is_empty "" then [] else [""]
(* -*- tuareg -*- *)
(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)
(* NOTE: prepend dune.common to this file! *)

(*
 * A known issue: At the moment of writing warning 14 (illegal backslash
 * escape in string) does not manifest as an error, presumably due to
 * peculiarities in communication between preprocessor and compiler.
 * Still leave it for visibility and in hope that the issue will be
 * fixed one day.
 *)
let fatal_warnings =
  "+3+5+6+8+10+11+12+14+18+19+20+21+23+26+29+27+28+32+33+34+35+37+38+39+50+52+57+60"


let warnings = fatal_warnings ^ "-4-9-40-41-42-45-48"

let ocamlc_flags =
  [ "-g"
  ; "-short-paths"
  ; "-safe-string"
  ; "-principal"
  ; "-strict-formats"
  ; "-strict-sequence"
  ; "-bin-annot" ]


let lenient_flags = ocamlc_flags @ ["-w"; warnings] |> String.concat " "

let strict_flags =
  ocamlc_flags @ ["-w"; warnings; "-warn-error"; fatal_warnings] |> String.concat " "


let env_stanza =
  Format.sprintf
    {|
(env
  (dev
    (flags %s)
    (inline_tests enabled))
  (opt
    (flags %s)
    (ocamlopt_flags (:standard -O3)))
  (dev-noerror
    (flags %s)
    (inline_tests enabled))
  )
|}
    lenient_flags lenient_flags lenient_flags


(** Put this *first* in (libraries) specifications to prevent a clash between extlib's and base64's
    versions of Base64. Only Javalib depends on extlib so do it conditionally to avoid introducing a
    new dependency in the clang-only build. *)
let extlib_if_java = if java then "extlib" else ""

let infer_exe_stanza =
  Printf.sprintf
    {|(executable
 (name infer)
 (modes byte_complete exe)
 (modules Infer)
 (flags (:standard -open Core -open IStdlib -open IStd -open IBase -open IR -open Backend -open Integration -open Biabduction -open TestDeterminators -open ClangFrontend -open ASTLanguage %s -open JavaFrontend %s -open APRVAL -open Iprogram -open Botup -open BasicDom))
 (libraries %s core IStdlib IBase IR Backend Integration Biabduction TestDeterminators ClangFrontend ASTLanguage APRVAL Iprogram Botup BasicDom)
 (preprocess (pps ppx_compare))
 (promote (until-clean) (into ../bin))
)|}
    (if clang then "" else "-open ClangFrontendStubs")
    (if java then "" else "-open JavaFrontendStubs")
    extlib_if_java


let inferunit_stanza =
  Printf.sprintf
    {|(executable
 (name inferunit)
 (modes byte_complete exe)
 (modules Inferunit)
 (flags (:standard -open Core -open IStdlib -open IStd -open IBase -open Backend -open Integration -open UnitTests -open NullsafeUnitTests -open ClangFrontend %s))
 (libraries %s oUnit core IStdlib IBase Backend Integration UnitTests NullsafeUnitTests %s)
 (preprocess (pps ppx_compare))
 (promote (until-clean) (into ../bin))
)|}
    (if clang then "-open ClangUnitTests" else "-open ClangFrontendStubs")
    extlib_if_java
    (if clang then "ClangUnitTests" else "")


let infertop_stanza =
  Format.sprintf
    {|
(executable
 (name infertop)
 (modes byte_complete)
 (modules Infertop)
 (flags (:standard -open Core -open IStdlib -open IStd))
 (libraries %s utop Absint ASTLanguage ATDGenerated Backend IBase Biabduction BO Checkers Concurrency Costlib CStubs IR IStdlib Labs Nullsafe Pulselib Quandary Integration TestDeterminators TOPLlib UnitTests)
 (link_flags (-linkall -warn-error -31))
 (preprocess (pps ppx_compare))
 (promote (until-clean) (into ../bin))
)
|}
    extlib_if_java


let inferCreateTraceViewLinks_stanza =
  {|(executable
 (name InferCreateTraceViewLinks)
 (modes byte_complete exe)
 (modules InferCreateTraceViewLinks)
 (flags (:standard -open Core -open IStdlib -open IStd -open ATDGenerated -open IBase))
 (libraries core async IStdlib ATDGenerated IBase)
 (preprocess (pps ppx_compare))
 (promote (until-clean) (into ../bin))
)|}


(** The build stanzas to be passed to dune *)
let stanzas =
  [env_stanza; infer_exe_stanza; inferunit_stanza; infertop_stanza]
  @ if facebook then [inferCreateTraceViewLinks_stanza] else []


;;
Jbuild_plugin.V1.send (String.concat "\n" stanzas)
