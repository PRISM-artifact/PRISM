
(* The type of tokens. *)

type token = 
  | WHEN
  | UID of (string)
  | STRING of (string)
  | STAR
  | SEMI
  | RP
  | RC
  | PROPERTY
  | PREFIX
  | NE
  | MESSAGE
  | LT
  | LP
  | LID of (string)
  | LE
  | LC
  | INTEGER of (int)
  | INDENT of (int)
  | GT
  | GE
  | EQ
  | EOF
  | COMMA
  | COLONEQ
  | COLON
  | ARROWARROW
  | ARROW
  | ARRAYWRITE
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val properties: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (ToplAst.t list)
