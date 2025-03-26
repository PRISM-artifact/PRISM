
(* The type of tokens. *)

type token = 
  | YIELD
  | WHILE
  | VOID
  | VAR
  | TRY
  | TRUE
  | TILDE
  | THROWS
  | THROW
  | THREEDOTS
  | THIS
  | SYNCHRONIZED
  | STRING of (string)
  | SEMICOLON
  | RSBRACKET
  | RPAREN
  | RETURN
  | RBRACKET
  | RANGLE
  | QMARK
  | PRIMTYPE
  | PIPE
  | PACKAGE
  | NULL
  | NEW
  | LSBRACKET
  | LPAREN
  | LBRACKET
  | LANGLE
  | INTERFACE
  | INTEGER of (string)
  | INSTANCEOF
  | INCR_DECR
  | IMPORT
  | IMPLEMENTS
  | IF
  | IDENT of (string)
  | FOR
  | FLOATINGPOINT of (string)
  | FINALLY
  | FALSE
  | EXTENDS
  | EQ
  | EOF
  | ENUM
  | ELSE
  | DOT
  | DO
  | CONTINUE
  | COMMA
  | COLON
  | CLASS
  | CHAR of (string)
  | CATCH
  | BREAK
  | BINOP
  | BANG
  | ASSIGNOP
  | ASSERT

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (JSourceAST.file_content)
