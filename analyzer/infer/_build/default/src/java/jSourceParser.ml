
module MenhirBasics = struct
  
  exception Error
  
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
    | STRING of (
# 81 "src/java/jSourceParser.mly"
       (string)
# 23 "src/java/jSourceParser.ml"
  )
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
    | INTEGER of (
# 79 "src/java/jSourceParser.mly"
       (string)
# 45 "src/java/jSourceParser.ml"
  )
    | INSTANCEOF
    | INCR_DECR
    | IMPORT
    | IMPLEMENTS
    | IF
    | IDENT of (
# 78 "src/java/jSourceParser.mly"
       (string)
# 55 "src/java/jSourceParser.ml"
  )
    | FOR
    | FLOATINGPOINT of (
# 80 "src/java/jSourceParser.mly"
       (string)
# 61 "src/java/jSourceParser.ml"
  )
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
    | CHAR of (
# 82 "src/java/jSourceParser.mly"
       (string)
# 79 "src/java/jSourceParser.ml"
  )
    | CATCH
    | BREAK
    | BINOP
    | BANG
    | ASSIGNOP
    | ASSERT
  
end

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState470
  | MenhirState464
  | MenhirState456
  | MenhirState453
  | MenhirState450
  | MenhirState447
  | MenhirState441
  | MenhirState434
  | MenhirState429
  | MenhirState427
  | MenhirState425
  | MenhirState424
  | MenhirState420
  | MenhirState419
  | MenhirState418
  | MenhirState415
  | MenhirState408
  | MenhirState401
  | MenhirState395
  | MenhirState388
  | MenhirState386
  | MenhirState377
  | MenhirState376
  | MenhirState369
  | MenhirState365
  | MenhirState358
  | MenhirState355
  | MenhirState353
  | MenhirState351
  | MenhirState340
  | MenhirState337
  | MenhirState336
  | MenhirState332
  | MenhirState330
  | MenhirState327
  | MenhirState300
  | MenhirState297
  | MenhirState294
  | MenhirState290
  | MenhirState289
  | MenhirState287
  | MenhirState285
  | MenhirState283
  | MenhirState281
  | MenhirState280
  | MenhirState277
  | MenhirState275
  | MenhirState267
  | MenhirState262
  | MenhirState260
  | MenhirState258
  | MenhirState256
  | MenhirState254
  | MenhirState252
  | MenhirState250
  | MenhirState247
  | MenhirState244
  | MenhirState240
  | MenhirState237
  | MenhirState235
  | MenhirState231
  | MenhirState227
  | MenhirState226
  | MenhirState222
  | MenhirState219
  | MenhirState216
  | MenhirState214
  | MenhirState211
  | MenhirState209
  | MenhirState208
  | MenhirState207
  | MenhirState205
  | MenhirState201
  | MenhirState200
  | MenhirState198
  | MenhirState193
  | MenhirState191
  | MenhirState184
  | MenhirState182
  | MenhirState180
  | MenhirState178
  | MenhirState175
  | MenhirState174
  | MenhirState161
  | MenhirState157
  | MenhirState156
  | MenhirState154
  | MenhirState150
  | MenhirState149
  | MenhirState146
  | MenhirState140
  | MenhirState138
  | MenhirState136
  | MenhirState132
  | MenhirState131
  | MenhirState127
  | MenhirState126
  | MenhirState124
  | MenhirState123
  | MenhirState120
  | MenhirState115
  | MenhirState112
  | MenhirState111
  | MenhirState106
  | MenhirState104
  | MenhirState100
  | MenhirState96
  | MenhirState95
  | MenhirState91
  | MenhirState89
  | MenhirState88
  | MenhirState86
  | MenhirState84
  | MenhirState82
  | MenhirState81
  | MenhirState80
  | MenhirState79
  | MenhirState75
  | MenhirState73
  | MenhirState72
  | MenhirState71
  | MenhirState67
  | MenhirState64
  | MenhirState63
  | MenhirState57
  | MenhirState53
  | MenhirState52
  | MenhirState50
  | MenhirState48
  | MenhirState45
  | MenhirState36
  | MenhirState33
  | MenhirState28
  | MenhirState27
  | MenhirState26
  | MenhirState25
  | MenhirState24
  | MenhirState23
  | MenhirState22
  | MenhirState18
  | MenhirState12
  | MenhirState10
  | MenhirState8
  | MenhirState3
  | MenhirState1

# 7 "src/java/jSourceParser.mly"
  
    open JSourceAST

    let location_of_pos pos =
      let line = pos.Lexing.pos_lnum in
      let col = pos.Lexing.pos_cnum - pos.Lexing.pos_bol in
      { line; col }


# 259 "src/java/jSourceParser.ml"

let rec _menhir_goto_app_list_block_statement_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_list_block_statement_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState377 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1931 * _menhir_state * 'tv_block_statement) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_list_block_statement_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1929 * _menhir_state * 'tv_block_statement) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_list_block_statement_) : 'tv_app_list_block_statement_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_block_statement)) = _menhir_stack in
        let _v : 'tv_app_list_block_statement_ = 
# 739 "src/java/jSourceParser.mly"
    ( x@xs )
# 277 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_list_block_statement_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1930)) : 'freshtv1932)
    | MenhirState376 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1947 * _menhir_state * 'tv_block_statement) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_list_block_statement_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1945 * _menhir_state * 'tv_block_statement) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_list_block_statement_) : 'tv_app_list_block_statement_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_block_statement)) = _menhir_stack in
        let _v : 'tv_app_non_empty_list_block_statement_ = 
# 743 "src/java/jSourceParser.mly"
    ( x@xs )
# 293 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1943) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_non_empty_list_block_statement_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1941) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_non_empty_list_block_statement_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1939) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_app_non_empty_list_block_statement_) : 'tv_app_non_empty_list_block_statement_) = _v in
        ((let _v : 'tv_block_statements = 
# 279 "src/java/jSourceParser.mly"
    ( _1 )
# 310 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1937) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_block_statements) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1935) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_block_statements) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1933) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_block_statements) : 'tv_block_statements) = _v in
        ((let _v : 'tv_loption_block_statements_ = 
# 144 "<standard.mly>"
    ( x )
# 327 "src/java/jSourceParser.ml"
         in
        _menhir_goto_loption_block_statements_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1934)) : 'freshtv1936)) : 'freshtv1938)) : 'freshtv1940)) : 'freshtv1942)) : 'freshtv1944)) : 'freshtv1946)) : 'freshtv1948)
    | _ ->
        _menhir_fail ()

and _menhir_reduce1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_app_list_block_statement_ = 
# 737 "src/java/jSourceParser.mly"
    ( [] )
# 338 "src/java/jSourceParser.ml"
     in
    _menhir_goto_app_list_block_statement_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_array_initializer_end : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_array_initializer_end -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState140 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1923 * _menhir_state) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_array_initializer_end) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1921 * _menhir_state) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_array_initializer_end) : 'tv_array_initializer_end) = _v in
        ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_variable_initializer)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_array_initializer_end = 
# 519 "src/java/jSourceParser.mly"
    ( _2 @ _3 )
# 359 "src/java/jSourceParser.ml"
         in
        _menhir_goto_array_initializer_end _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1922)) : 'freshtv1924)
    | MenhirState136 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1927 * _menhir_state * Lexing.position) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_array_initializer_end) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1925 * _menhir_state * Lexing.position) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_array_initializer_end) : 'tv_array_initializer_end) = _v in
        ((let ((_menhir_stack, _menhir_s, _startpos__1_), _, (_2 : 'tv_variable_initializer)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_array_initializer = 
# 512 "src/java/jSourceParser.mly"
    ( _2 @ _3 )
# 376 "src/java/jSourceParser.ml"
         in
        _menhir_goto_array_initializer _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1926)) : 'freshtv1928)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_enum_constant_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_enum_constant_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1915) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_enum_constant_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1913) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_separated_nonempty_list_COMMA_enum_constant_) : 'tv_separated_nonempty_list_COMMA_enum_constant_) = _v in
        ((let _v : 'tv_enum_constant_list = 
# 160 "src/java/jSourceParser.mly"
    ()
# 397 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1911) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_enum_constant_list) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1909 * Lexing.position) * _menhir_state * 'tv_enum_constant_list) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1903 * Lexing.position) * _menhir_state * 'tv_enum_constant_list) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1901 * Lexing.position) * _menhir_state * 'tv_enum_constant_list) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _startpos__1_), _, (_2 : 'tv_enum_constant_list)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_enum_body = 
# 154 "src/java/jSourceParser.mly"
    ( [] )
# 421 "src/java/jSourceParser.ml"
             in
            _menhir_goto_enum_body _menhir_env _menhir_stack _v) : 'freshtv1902)) : 'freshtv1904)
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1905) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | CLASS ->
                _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState441
            | ENUM ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState441
            | IDENT _v ->
                _menhir_run114 _menhir_env (Obj.magic _menhir_stack) MenhirState441 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTERFACE ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState441
            | PRIMTYPE ->
                _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState441
            | SEMICOLON ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState441
            | VOID ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState441
            | RBRACKET ->
                _menhir_reduce5 _menhir_env (Obj.magic _menhir_stack) MenhirState441
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState441) : 'freshtv1906)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1907 * Lexing.position) * _menhir_state * 'tv_enum_constant_list) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1908)) : 'freshtv1910)) : 'freshtv1912)) : 'freshtv1914)) : 'freshtv1916)
    | MenhirState447 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1919 * _menhir_state * 'tv_enum_constant)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_enum_constant_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1917 * _menhir_state * 'tv_enum_constant)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_enum_constant_) : 'tv_separated_nonempty_list_COMMA_enum_constant_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_enum_constant)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_enum_constant_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 471 "src/java/jSourceParser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_enum_constant_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1918)) : 'freshtv1920)
    | _ ->
        _menhir_fail ()

and _menhir_goto_block_statement : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_block_statement -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState388 | MenhirState200 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1897 * _menhir_state * 'tv_block_statement) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ASSERT ->
            _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | BREAK ->
            _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState376 _v
        | CLASS ->
            _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | CONTINUE ->
            _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | DO ->
            _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | ENUM ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState376 _v
        | FOR ->
            _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState376 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IF ->
            _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | INCR_DECR ->
            _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState376 _v
        | LBRACKET ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState376 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LPAREN ->
            _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | PRIMTYPE ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | RETURN ->
            _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | SEMICOLON ->
            _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState376 _v
        | SYNCHRONIZED ->
            _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | THROW ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | TRY ->
            _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | VAR ->
            _menhir_run263 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | WHILE ->
            _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | YIELD ->
            _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | RBRACKET ->
            _menhir_reduce1 _menhir_env (Obj.magic _menhir_stack) MenhirState376
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState376) : 'freshtv1898)
    | MenhirState377 | MenhirState376 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1899 * _menhir_state * 'tv_block_statement) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ASSERT ->
            _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | BREAK ->
            _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState377 _v
        | CLASS ->
            _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | CONTINUE ->
            _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | DO ->
            _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | ENUM ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState377 _v
        | FOR ->
            _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState377 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IF ->
            _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | INCR_DECR ->
            _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState377 _v
        | LBRACKET ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState377 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LPAREN ->
            _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | PRIMTYPE ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | RETURN ->
            _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | SEMICOLON ->
            _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState377 _v
        | SYNCHRONIZED ->
            _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | THROW ->
            _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | TRY ->
            _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | VAR ->
            _menhir_run263 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | WHILE ->
            _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | YIELD ->
            _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | RBRACKET ->
            _menhir_reduce1 _menhir_env (Obj.magic _menhir_stack) MenhirState377
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState377) : 'freshtv1900)
    | _ ->
        _menhir_fail ()

and _menhir_goto_for_statement : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_for_statement -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1895) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_for_statement) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1893) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_for_statement) : 'tv_for_statement) = _v in
    ((let _v : 'tv_statement = 
# 308 "src/java/jSourceParser.mly"
    ( _1 )
# 641 "src/java/jSourceParser.ml"
     in
    _menhir_goto_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1894)) : 'freshtv1896)

and _menhir_goto_app_list_dim_expr_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_list_dim_expr_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState420 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1871 * _menhir_state * 'tv_dim_expr) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_list_dim_expr_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1869 * _menhir_state * 'tv_dim_expr) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_list_dim_expr_) : 'tv_app_list_dim_expr_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_dim_expr)) = _menhir_stack in
        let _v : 'tv_app_list_dim_expr_ = 
# 739 "src/java/jSourceParser.mly"
    ( x@xs )
# 661 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_list_dim_expr_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1870)) : 'freshtv1872)
    | MenhirState418 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1891 * _menhir_state * 'tv_dim_expr) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_list_dim_expr_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1889 * _menhir_state * 'tv_dim_expr) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_list_dim_expr_) : 'tv_app_list_dim_expr_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_dim_expr)) = _menhir_stack in
        let _v : 'tv_app_non_empty_list_dim_expr_ = 
# 743 "src/java/jSourceParser.mly"
    ( x@xs )
# 677 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1887) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_non_empty_list_dim_expr_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1885) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_non_empty_list_dim_expr_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1883) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_app_non_empty_list_dim_expr_) : 'tv_app_non_empty_list_dim_expr_) = _v in
        ((let _v : 'tv_dim_exprs = 
# 614 "src/java/jSourceParser.mly"
    ( _1 )
# 694 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1881) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_dim_exprs) = _v in
        ((match _menhir_s with
        | MenhirState80 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1875 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_dim_exprs) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1873 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_ : _menhir_state) = _menhir_s in
            let ((_3 : 'tv_dim_exprs) : 'tv_dim_exprs) = _v in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            let _2 = () in
            let _1 = () in
            let _v : 'tv_array_creation_expression = 
# 607 "src/java/jSourceParser.mly"
    ( _3 )
# 716 "src/java/jSourceParser.ml"
             in
            _menhir_goto_array_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1874)) : 'freshtv1876)
        | MenhirState424 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1879 * _menhir_state) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_dim_exprs) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1877 * _menhir_state) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            let (_ : _menhir_state) = _menhir_s in
            let ((_3 : 'tv_dim_exprs) : 'tv_dim_exprs) = _v in
            ((let ((_menhir_stack, _menhir_s), _, (_1_inlined1 : 'tv_dotted_name)) = _menhir_stack in
            let _1 = () in
            let _v : 'tv_array_creation_expression = let _2 =
              let _1 = _1_inlined1 in
              
# 544 "src/java/jSourceParser.mly"
                ( _1 )
# 735 "src/java/jSourceParser.ml"
              
            in
            
# 607 "src/java/jSourceParser.mly"
    ( _3 )
# 741 "src/java/jSourceParser.ml"
             in
            _menhir_goto_array_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1878)) : 'freshtv1880)
        | _ ->
            _menhir_fail ()) : 'freshtv1882)) : 'freshtv1884)) : 'freshtv1886)) : 'freshtv1888)) : 'freshtv1890)) : 'freshtv1892)
    | _ ->
        _menhir_fail ()

and _menhir_reduce203 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_array_access -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_array_access)) = _menhir_stack in
    let _v : 'tv_primary_no_new_array = 
# 631 "src/java/jSourceParser.mly"
    ( _1 )
# 755 "src/java/jSourceParser.ml"
     in
    _menhir_goto_primary_no_new_array _menhir_env _menhir_stack _menhir_s _v

and _menhir_run137 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1867) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_array_initializer_end = 
# 517 "src/java/jSourceParser.mly"
    ( [] )
# 769 "src/java/jSourceParser.ml"
     in
    _menhir_goto_array_initializer_end _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1868)

and _menhir_run138 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v
    | LBRACKET ->
        _menhir_run132 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | RBRACKET ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1865 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState138 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1863 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_array_initializer_end = 
# 517 "src/java/jSourceParser.mly"
    ( [] )
# 817 "src/java/jSourceParser.ml"
         in
        _menhir_goto_array_initializer_end _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1864)) : 'freshtv1866)
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState138

and _menhir_goto_app_separated_non_empty_list_COMMA_variable_declarator_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_separated_non_empty_list_COMMA_variable_declarator_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState191 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1803 * _menhir_state * 'tv_variable_declarator)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_separated_non_empty_list_COMMA_variable_declarator_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1801 * _menhir_state * 'tv_variable_declarator)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_separated_non_empty_list_COMMA_variable_declarator_) : 'tv_app_separated_non_empty_list_COMMA_variable_declarator_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_variable_declarator)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_app_separated_non_empty_list_COMMA_variable_declarator_ = 
# 753 "src/java/jSourceParser.mly"
    ( x@xs )
# 850 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_separated_non_empty_list_COMMA_variable_declarator_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1802)) : 'freshtv1804)
    | MenhirState450 | MenhirState369 | MenhirState351 | MenhirState327 | MenhirState126 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1861) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_separated_non_empty_list_COMMA_variable_declarator_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1859) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_app_separated_non_empty_list_COMMA_variable_declarator_) : 'tv_app_separated_non_empty_list_COMMA_variable_declarator_) = _v in
        ((let _v : 'tv_variable_declarator_list = 
# 490 "src/java/jSourceParser.mly"
    ( _1 )
# 865 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1857) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_variable_declarator_list) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        match _menhir_s with
        | MenhirState126 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1817 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1813 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1811 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_unann_type)), _, (_2 : 'tv_variable_declarator_list)) = _menhir_stack in
                let _3 = () in
                let _v : 'tv_field_declaration = 
# 486 "src/java/jSourceParser.mly"
    ( _2 )
# 890 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1809) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_field_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1807) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_field_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1805) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_field_declaration) : 'tv_field_declaration) = _v in
                ((let _v : 'tv_class_member_declaration = 
# 203 "src/java/jSourceParser.mly"
    ( _1 )
# 907 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1806)) : 'freshtv1808)) : 'freshtv1810)) : 'freshtv1812)) : 'freshtv1814)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1815 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1816)) : 'freshtv1818)
        | MenhirState369 | MenhirState351 | MenhirState327 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1841 * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1839 * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_local_variable_type)), _, (_2 : 'tv_variable_declarator_list)) = _menhir_stack in
            let _v : 'tv_local_variable_declaration = 
# 294 "src/java/jSourceParser.mly"
    ( _2 )
# 926 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1837) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_local_variable_declaration) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            match _menhir_s with
            | MenhirState262 | MenhirState283 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1821 * _menhir_state * 'tv_local_variable_declaration) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1819 * _menhir_state * 'tv_local_variable_declaration) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, (_1 : 'tv_local_variable_declaration)) = _menhir_stack in
                let _v : 'tv_for_init = 
# 339 "src/java/jSourceParser.mly"
    ( _1 )
# 943 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_for_init _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1820)) : 'freshtv1822)
            | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1835 * _menhir_state * 'tv_local_variable_declaration) = Obj.magic _menhir_stack in
                ((assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | SEMICOLON ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1831 * _menhir_state * 'tv_local_variable_declaration) = Obj.magic _menhir_stack in
                    ((let _menhir_env = _menhir_discard _menhir_env in
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1829 * _menhir_state * 'tv_local_variable_declaration) = Obj.magic _menhir_stack in
                    ((let (_menhir_stack, _menhir_s, (_1 : 'tv_local_variable_declaration)) = _menhir_stack in
                    let _2 = () in
                    let _v : 'tv_local_variable_declaration_statement = 
# 290 "src/java/jSourceParser.mly"
    ( _1 )
# 963 "src/java/jSourceParser.ml"
                     in
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1827) = _menhir_stack in
                    let (_menhir_s : _menhir_state) = _menhir_s in
                    let (_v : 'tv_local_variable_declaration_statement) = _v in
                    ((let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1825) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = _menhir_s in
                    let (_v : 'tv_local_variable_declaration_statement) = _v in
                    ((let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1823) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = _menhir_s in
                    let ((_1 : 'tv_local_variable_declaration_statement) : 'tv_local_variable_declaration_statement) = _v in
                    ((let _v : 'tv_block_statement = 
# 286 "src/java/jSourceParser.mly"
    ( _1 )
# 980 "src/java/jSourceParser.ml"
                     in
                    _menhir_goto_block_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1824)) : 'freshtv1826)) : 'freshtv1828)) : 'freshtv1830)) : 'freshtv1832)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1833 * _menhir_state * 'tv_local_variable_declaration) = Obj.magic _menhir_stack in
                    ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1834)) : 'freshtv1836)
            | _ ->
                _menhir_fail ()) : 'freshtv1838)) : 'freshtv1840)) : 'freshtv1842)
        | MenhirState450 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1855 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1851 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1849 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_unann_type)), _, (_2 : 'tv_variable_declarator_list)) = _menhir_stack in
                let _3 = () in
                let _v : 'tv_constant_declaration = 
# 482 "src/java/jSourceParser.mly"
    ( _2 )
# 1009 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1847) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_constant_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1845) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_constant_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1843) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_constant_declaration) : 'tv_constant_declaration) = _v in
                ((let _v : 'tv_interface_member_declaration = 
# 231 "src/java/jSourceParser.mly"
    ( [] )
# 1026 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_interface_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1844)) : 'freshtv1846)) : 'freshtv1848)) : 'freshtv1850)) : 'freshtv1852)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1853 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_list) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1854)) : 'freshtv1856)
        | _ ->
            _menhir_fail ()) : 'freshtv1858)) : 'freshtv1860)) : 'freshtv1862)
    | _ ->
        _menhir_fail ()

and _menhir_goto_enum_body : _menhir_env -> 'ttv_tail -> 'tv_enum_body -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv1799 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1047 "src/java/jSourceParser.ml"
    ) * Lexing.position) * _menhir_state * 'tv_option_superinterfaces_) = Obj.magic _menhir_stack in
    let (_v : 'tv_enum_body) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv1797 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1054 "src/java/jSourceParser.ml"
    ) * Lexing.position) * _menhir_state * 'tv_option_superinterfaces_) = Obj.magic _menhir_stack in
    let ((inner : 'tv_enum_body) : 'tv_enum_body) = _v in
    ((let (((_menhir_stack, _menhir_s), (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1060 "src/java/jSourceParser.ml"
    )), _startpos_id_), _, (_3 : 'tv_option_superinterfaces_)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_enum_declaration = let id = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 1066 "src/java/jSourceParser.ml"
     in
    
# 137 "src/java/jSourceParser.mly"
    ( {
        location = location_of_pos _startpos_id_;
        kind = Enum id;
        inner_elements = inner;
      }
    )
# 1076 "src/java/jSourceParser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1795) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_enum_declaration) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1793) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_enum_declaration) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1791) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_enum_declaration) : 'tv_enum_declaration) = _v in
    ((let _v : 'tv_class_declaration = 
# 124 "src/java/jSourceParser.mly"
    ( _1 )
# 1093 "src/java/jSourceParser.ml"
     in
    _menhir_goto_class_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1792)) : 'freshtv1794)) : 'freshtv1796)) : 'freshtv1798)) : 'freshtv1800)

and _menhir_goto_class_declaration : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_class_declaration -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1777) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_class_declaration) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1775) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_class_declaration) : 'tv_class_declaration) = _v in
        ((let _v : 'tv_block_statement = 
# 283 "src/java/jSourceParser.mly"
    ( [_1] )
# 1112 "src/java/jSourceParser.ml"
         in
        _menhir_goto_block_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1776)) : 'freshtv1778)
    | MenhirState441 | MenhirState395 | MenhirState112 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1781) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_class_declaration) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1779) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_class_declaration) : 'tv_class_declaration) = _v in
        ((let _v : 'tv_class_member_declaration = 
# 200 "src/java/jSourceParser.mly"
    ( [_1] )
# 1127 "src/java/jSourceParser.ml"
         in
        _menhir_goto_class_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1780)) : 'freshtv1782)
    | MenhirState22 | MenhirState456 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1785) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_class_declaration) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1783) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_class_declaration) : 'tv_class_declaration) = _v in
        ((let _v : 'tv_interface_member_declaration = 
# 234 "src/java/jSourceParser.mly"
    ( [_1] )
# 1142 "src/java/jSourceParser.ml"
         in
        _menhir_goto_interface_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1784)) : 'freshtv1786)
    | MenhirState18 | MenhirState464 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1789) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_class_declaration) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1787) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_class_declaration) : 'tv_class_declaration) = _v in
        ((let _v : 'tv_type_declaration = 
# 117 "src/java/jSourceParser.mly"
    ( [_1] )
# 1157 "src/java/jSourceParser.ml"
         in
        _menhir_goto_type_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1788)) : 'freshtv1790)
    | _ ->
        _menhir_fail ()

and _menhir_goto_enum_constant : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_enum_constant -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1773 * _menhir_state * 'tv_enum_constant) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1767 * _menhir_state * 'tv_enum_constant) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState447 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState447) : 'freshtv1768)
    | RBRACKET | SEMICOLON ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1769 * _menhir_state * 'tv_enum_constant) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_enum_constant)) = _menhir_stack in
        let _v : 'tv_separated_nonempty_list_COMMA_enum_constant_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 1190 "src/java/jSourceParser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_enum_constant_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1770)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1771 * _menhir_state * 'tv_enum_constant) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1772)) : 'freshtv1774)

and _menhir_goto_app_list_catch_clause_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_list_catch_clause_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState227 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1745 * _menhir_state * 'tv_catch_clause) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_list_catch_clause_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1743 * _menhir_state * 'tv_catch_clause) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_list_catch_clause_) : 'tv_app_list_catch_clause_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_catch_clause)) = _menhir_stack in
        let _v : 'tv_app_list_catch_clause_ = 
# 739 "src/java/jSourceParser.mly"
    ( x@xs )
# 1217 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_list_catch_clause_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1744)) : 'freshtv1746)
    | MenhirState226 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1765 * _menhir_state * 'tv_catch_clause) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_list_catch_clause_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1763 * _menhir_state * 'tv_catch_clause) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_list_catch_clause_) : 'tv_app_list_catch_clause_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_catch_clause)) = _menhir_stack in
        let _v : 'tv_app_non_empty_list_catch_clause_ = 
# 743 "src/java/jSourceParser.mly"
    ( x@xs )
# 1233 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1761) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_non_empty_list_catch_clause_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1759) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_non_empty_list_catch_clause_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1757) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_app_non_empty_list_catch_clause_) : 'tv_app_non_empty_list_catch_clause_) = _v in
        ((let _v : 'tv_catches = 
# 442 "src/java/jSourceParser.mly"
    ( _1 )
# 1250 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1755) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_catches) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1753 * _menhir_state) * _menhir_state * 'tv_block) * _menhir_state * 'tv_catches) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ASSERT | BREAK | CHAR _ | CLASS | CONTINUE | DO | ELSE | ENUM | FALSE | FLOATINGPOINT _ | FOR | IDENT _ | IF | INCR_DECR | INTEGER _ | LBRACKET | LPAREN | NEW | NULL | PRIMTYPE | RBRACKET | RETURN | SEMICOLON | STRING _ | SYNCHRONIZED | THIS | THROW | TRUE | TRY | VAR | WHILE | YIELD ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1747 * _menhir_state) * _menhir_state * 'tv_block) * _menhir_state * 'tv_catches) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_block)), _, (_3 : 'tv_catches)) = _menhir_stack in
            let _1 = () in
            let _v : 'tv_try_statement = 
# 436 "src/java/jSourceParser.mly"
    ( _2 @ _3 )
# 1270 "src/java/jSourceParser.ml"
             in
            _menhir_goto_try_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1748)
        | FINALLY ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1749 * _menhir_state * 'tv_catches) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_catches)) = _menhir_stack in
            let _v : 'tv_loption_catches_ = 
# 144 "<standard.mly>"
    ( x )
# 1280 "src/java/jSourceParser.ml"
             in
            _menhir_goto_loption_catches_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1750)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1751 * _menhir_state) * _menhir_state * 'tv_block) * _menhir_state * 'tv_catches) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1752)) : 'freshtv1754)) : 'freshtv1756)) : 'freshtv1758)) : 'freshtv1760)) : 'freshtv1762)) : 'freshtv1764)) : 'freshtv1766)
    | _ ->
        _menhir_fail ()

and _menhir_goto_for_statement_no_short_if : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_for_statement_no_short_if -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1741) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_for_statement_no_short_if) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1739) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_for_statement_no_short_if) : 'tv_for_statement_no_short_if) = _v in
    ((let _v : 'tv_statement_no_short_if = 
# 366 "src/java/jSourceParser.mly"
    ( _1 )
# 1306 "src/java/jSourceParser.ml"
     in
    _menhir_goto_statement_no_short_if _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1740)) : 'freshtv1742)

and _menhir_goto_statement : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_statement -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState280 | MenhirState289 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((((('freshtv1683 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((((('freshtv1681 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (((((_menhir_stack, _menhir_s), _, (_3 : 'tv_loption_for_init_)), _, (_5 : 'tv_loption_expression_)), _, (_7 : 'tv_loption_for_update_)), _, (_9 : 'tv_statement)) = _menhir_stack in
        let _8 = () in
        let _6 = () in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_basic_for_statement = 
# 322 "src/java/jSourceParser.mly"
    ( _3 @ _5 @ _7 @ _9 )
# 1328 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1679) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_basic_for_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1677) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_basic_for_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1675) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_basic_for_statement) : 'tv_basic_for_statement) = _v in
        ((let _v : 'tv_for_statement = 
# 313 "src/java/jSourceParser.mly"
    ( _1 )
# 1345 "src/java/jSourceParser.ml"
         in
        _menhir_goto_for_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1676)) : 'freshtv1678)) : 'freshtv1680)) : 'freshtv1682)) : 'freshtv1684)
    | MenhirState355 | MenhirState332 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((((('freshtv1693 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((((('freshtv1691 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (((((_menhir_stack, _menhir_s), _, (_3 : 'tv_local_variable_type)), _, (_4 : 'tv_variable_declarator_id)), _, (_6 : 'tv_expression)), _, (_8 : 'tv_statement)) = _menhir_stack in
        let _7 = () in
        let _5 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_enhanced_for_statement = 
# 326 "src/java/jSourceParser.mly"
    ( _6 @ _8 )
# 1361 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1689) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_enhanced_for_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1687) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_enhanced_for_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1685) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_enhanced_for_statement) : 'tv_enhanced_for_statement) = _v in
        ((let _v : 'tv_for_statement = 
# 313 "src/java/jSourceParser.mly"
    ( _1 )
# 1378 "src/java/jSourceParser.ml"
         in
        _menhir_goto_for_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1686)) : 'freshtv1688)) : 'freshtv1690)) : 'freshtv1692)) : 'freshtv1694)
    | MenhirState281 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1703 * _menhir_state) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | WHILE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1699 * _menhir_state) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LPAREN ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv1695 * _menhir_state) * _menhir_state * 'tv_statement)) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | BANG ->
                    _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | BINOP ->
                    _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | CHAR _v ->
                    _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState340 _v
                | FALSE ->
                    _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | FLOATINGPOINT _v ->
                    _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState340 _v
                | IDENT _v ->
                    _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState340 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INCR_DECR ->
                    _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | INTEGER _v ->
                    _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState340 _v
                | LPAREN ->
                    _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | NEW ->
                    _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | NULL ->
                    _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | STRING _v ->
                    _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState340 _v
                | THIS ->
                    _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | TILDE ->
                    _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | TRUE ->
                    _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState340
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState340) : 'freshtv1696)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv1697 * _menhir_state) * _menhir_state * 'tv_statement)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1698)) : 'freshtv1700)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1701 * _menhir_state) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1702)) : 'freshtv1704)
    | MenhirState365 | MenhirState358 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv1713 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv1711 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let ((((_menhir_stack, _menhir_s), _, (_3 : 'tv_expression)), _, (_5 : 'tv_statement_no_short_if)), _, (_7 : 'tv_statement)) = _menhir_stack in
        let _6 = () in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_if_then_else_statement = 
# 355 "src/java/jSourceParser.mly"
    ( _3 @ _5 @ _7 )
# 1460 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1709) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_if_then_else_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1707) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_if_then_else_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1705) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_if_then_else_statement) : 'tv_if_then_else_statement) = _v in
        ((let _v : 'tv_statement = 
# 308 "src/java/jSourceParser.mly"
    ( _1 )
# 1477 "src/java/jSourceParser.ml"
         in
        _menhir_goto_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1706)) : 'freshtv1708)) : 'freshtv1710)) : 'freshtv1712)) : 'freshtv1714)
    | MenhirState252 | MenhirState260 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1723 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1721 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _, (_3 : 'tv_expression)), _, (_5 : 'tv_statement)) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_if_then_statement = 
# 351 "src/java/jSourceParser.mly"
    ( _3 @ _5 )
# 1492 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1719) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_if_then_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1717) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_if_then_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1715) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_if_then_statement) : 'tv_if_then_statement) = _v in
        ((let _v : 'tv_statement = 
# 308 "src/java/jSourceParser.mly"
    ( _1 )
# 1509 "src/java/jSourceParser.ml"
         in
        _menhir_goto_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1716)) : 'freshtv1718)) : 'freshtv1720)) : 'freshtv1722)) : 'freshtv1724)
    | MenhirState207 | MenhirState256 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1733 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1731 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _, (_3 : 'tv_expression)), _, (_5 : 'tv_statement)) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_while_statement = 
# 370 "src/java/jSourceParser.mly"
    ( _3 @ _5 )
# 1524 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1729) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_while_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1727) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_while_statement) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1725) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_while_statement) : 'tv_while_statement) = _v in
        ((let _v : 'tv_statement = 
# 308 "src/java/jSourceParser.mly"
    ( _1 )
# 1541 "src/java/jSourceParser.ml"
         in
        _menhir_goto_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1726)) : 'freshtv1728)) : 'freshtv1730)) : 'freshtv1732)) : 'freshtv1734)
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1737 * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1735 * _menhir_state * 'tv_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_statement)) = _menhir_stack in
        let _v : 'tv_block_statement = 
# 286 "src/java/jSourceParser.mly"
    ( _1 )
# 1553 "src/java/jSourceParser.ml"
         in
        _menhir_goto_block_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1736)) : 'freshtv1738)
    | _ ->
        _menhir_fail ()

and _menhir_reduce158 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_loption_for_update_ = 
# 142 "<standard.mly>"
    ( [] )
# 1564 "src/java/jSourceParser.ml"
     in
    _menhir_goto_loption_for_update_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce7 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_app_list_dim_expr_ = 
# 737 "src/java/jSourceParser.mly"
    ( [] )
# 1573 "src/java/jSourceParser.ml"
     in
    _menhir_goto_app_list_dim_expr_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run419 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState419 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState419 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState419 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState419 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState419 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState419
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState419

and _menhir_goto_assert_statement : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_assert_statement -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1673) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_assert_statement) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1671) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_assert_statement) : 'tv_assert_statement) = _v in
    ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 1631 "src/java/jSourceParser.ml"
     in
    _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1672)) : 'freshtv1674)

and _menhir_run253 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1667 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BANG ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | BINOP ->
            _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _v
        | LPAREN ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState254 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | TILDE ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState254
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState254) : 'freshtv1668)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1669 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1670)

and _menhir_run257 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1663 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BANG ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | BINOP ->
            _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState258 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState258 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState258 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState258 _v
        | LPAREN ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState258 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | TILDE ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState258
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState258) : 'freshtv1664)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1665 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1666)

and _menhir_run261 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1659 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState262 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState262 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState262 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState262 _v
        | LPAREN ->
            _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | PRIMTYPE ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState262 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | VAR ->
            _menhir_run263 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | SEMICOLON ->
            _menhir_reduce156 _menhir_env (Obj.magic _menhir_stack) MenhirState262
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState262) : 'freshtv1660)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1661 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1662)

and _menhir_goto_app_separated_non_empty_list_COMMA_expression_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_separated_non_empty_list_COMMA_expression_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState161 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1643 * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_separated_non_empty_list_COMMA_expression_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1641 * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_separated_non_empty_list_COMMA_expression_) : 'tv_app_separated_non_empty_list_COMMA_expression_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_expression)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_app_separated_non_empty_list_COMMA_expression_ = 
# 753 "src/java/jSourceParser.mly"
    ( x@xs )
# 1814 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_separated_non_empty_list_COMMA_expression_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1642)) : 'freshtv1644)
    | MenhirState73 | MenhirState425 | MenhirState91 | MenhirState401 | MenhirState106 | MenhirState157 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1657) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_separated_non_empty_list_COMMA_expression_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1655) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_app_separated_non_empty_list_COMMA_expression_) : 'tv_app_separated_non_empty_list_COMMA_expression_) = _v in
        ((let _v : 'tv_argument_list = 
# 195 "src/java/jSourceParser.mly"
    ( _1 )
# 1829 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1653) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_argument_list) = _v in
        ((match _menhir_s with
        | MenhirState425 | MenhirState91 | MenhirState401 | MenhirState106 | MenhirState157 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1647) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_argument_list) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1645) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((x : 'tv_argument_list) : 'tv_argument_list) = _v in
            ((let _v : 'tv_loption_argument_list_ = 
# 144 "<standard.mly>"
    ( x )
# 1848 "src/java/jSourceParser.ml"
             in
            _menhir_goto_loption_argument_list_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1646)) : 'freshtv1648)
        | MenhirState73 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1651) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_argument_list) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1649) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((x : 'tv_argument_list) : 'tv_argument_list) = _v in
            ((let _v : 'tv_option_argument_list_ = 
# 116 "<standard.mly>"
    ( Some x )
# 1863 "src/java/jSourceParser.ml"
             in
            _menhir_goto_option_argument_list_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1650)) : 'freshtv1652)
        | _ ->
            _menhir_fail ()) : 'freshtv1654)) : 'freshtv1656)) : 'freshtv1658)
    | _ ->
        _menhir_fail ()

and _menhir_goto_array_access : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_array_access -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState73 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState91 | MenhirState100 | MenhirState401 | MenhirState106 | MenhirState388 | MenhirState200 | MenhirState376 | MenhirState377 | MenhirState205 | MenhirState207 | MenhirState250 | MenhirState252 | MenhirState365 | MenhirState254 | MenhirState256 | MenhirState258 | MenhirState260 | MenhirState358 | MenhirState262 | MenhirState353 | MenhirState355 | MenhirState275 | MenhirState277 | MenhirState280 | MenhirState281 | MenhirState340 | MenhirState283 | MenhirState337 | MenhirState330 | MenhirState332 | MenhirState285 | MenhirState287 | MenhirState289 | MenhirState297 | MenhirState300 | MenhirState267 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState138 | MenhirState146 | MenhirState150 | MenhirState178 | MenhirState157 | MenhirState161 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1637 * _menhir_state * 'tv_array_access) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BINOP | COLON | COMMA | DOT | INCR_DECR | INSTANCEOF | LANGLE | LSBRACKET | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
            _menhir_reduce203 _menhir_env (Obj.magic _menhir_stack)
        | ASSIGNOP | EQ ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1633 * _menhir_state * 'tv_array_access) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_array_access)) = _menhir_stack in
            let _v : 'tv_left_hand_side = 
# 587 "src/java/jSourceParser.mly"
    ( _1 )
# 1890 "src/java/jSourceParser.ml"
             in
            _menhir_goto_left_hand_side _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1634)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1635 * _menhir_state * 'tv_array_access) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1636)) : 'freshtv1638)
    | MenhirState75 | MenhirState84 | MenhirState86 | MenhirState95 | MenhirState96 | MenhirState247 | MenhirState184 | MenhirState182 | MenhirState180 | MenhirState154 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1639 * _menhir_state * 'tv_array_access) = Obj.magic _menhir_stack in
        (_menhir_reduce203 _menhir_env (Obj.magic _menhir_stack) : 'freshtv1640)
    | _ ->
        _menhir_fail ()

and _menhir_goto_loption_separated_nonempty_list_COMMA_formal_parameter__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_COMMA_formal_parameter__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1631) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_loption_separated_nonempty_list_COMMA_formal_parameter__) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1629) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((xs : 'tv_loption_separated_nonempty_list_COMMA_formal_parameter__) : 'tv_loption_separated_nonempty_list_COMMA_formal_parameter__) = _v in
    ((let _v : 'tv_formal_parameter_list = let _1 = 
# 232 "<standard.mly>"
    ( xs )
# 1920 "src/java/jSourceParser.ml"
     in
    
# 256 "src/java/jSourceParser.mly"
    ()
# 1925 "src/java/jSourceParser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1627) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_formal_parameter_list) = _v in
    ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1613 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1938 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_formal_parameter_list) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1609 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1948 "src/java/jSourceParser.ml"
            ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_formal_parameter_list) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LSBRACKET ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState45
            | LBRACKET | SEMICOLON | THROWS ->
                _menhir_reduce179 _menhir_env (Obj.magic _menhir_stack) MenhirState45
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState45) : 'freshtv1610)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1611 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1968 "src/java/jSourceParser.ml"
            ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_formal_parameter_list) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1612)) : 'freshtv1614)
    | MenhirState115 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1625 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1977 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state * 'tv_formal_parameter_list) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1621 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1987 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state * 'tv_formal_parameter_list) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1619 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1994 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state * 'tv_formal_parameter_list) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 1999 "src/java/jSourceParser.ml"
            )), _startpos_id_), _, (_3 : 'tv_formal_parameter_list)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _v : 'tv_constructor_declarator = let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 2006 "src/java/jSourceParser.ml"
             in
            
# 187 "src/java/jSourceParser.mly"
    ()
# 2011 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1617) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_constructor_declarator) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1615 * _menhir_state * 'tv_constructor_declarator) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | THROWS ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState386
            | LBRACKET ->
                _menhir_reduce189 _menhir_env (Obj.magic _menhir_stack) MenhirState386
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState386) : 'freshtv1616)) : 'freshtv1618)) : 'freshtv1620)) : 'freshtv1622)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1623 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2038 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state * 'tv_formal_parameter_list) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1624)) : 'freshtv1626)
    | _ ->
        _menhir_fail ()) : 'freshtv1628)) : 'freshtv1630)) : 'freshtv1632)

and _menhir_goto_array_creation_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_array_creation_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1607) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_array_creation_expression) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1605) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_array_creation_expression) : 'tv_array_creation_expression) = _v in
    ((let _v : 'tv_primary = 
# 602 "src/java/jSourceParser.mly"
    ( _1 )
# 2058 "src/java/jSourceParser.ml"
     in
    _menhir_goto_primary _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1606)) : 'freshtv1608)

and _menhir_goto_variable_initializer : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_variable_initializer -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState132 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1597 * _menhir_state * Lexing.position) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack) MenhirState136
        | RBRACKET ->
            _menhir_run137 _menhir_env (Obj.magic _menhir_stack) MenhirState136
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState136) : 'freshtv1598)
    | MenhirState138 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1599 * _menhir_state) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack) MenhirState140
        | RBRACKET ->
            _menhir_run137 _menhir_env (Obj.magic _menhir_stack) MenhirState140
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState140) : 'freshtv1600)
    | MenhirState131 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1603 * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1601 * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_variable_declarator_id)), _, (_3 : 'tv_variable_initializer)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_variable_declarator = 
# 496 "src/java/jSourceParser.mly"
    ( _3 )
# 2104 "src/java/jSourceParser.ml"
         in
        _menhir_goto_variable_declarator _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1602)) : 'freshtv1604)
    | _ ->
        _menhir_fail ()

and _menhir_goto_variable_declarator : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_variable_declarator -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1595 * _menhir_state * 'tv_variable_declarator) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1589 * _menhir_state * 'tv_variable_declarator) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run36 _menhir_env (Obj.magic _menhir_stack) MenhirState191 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState191) : 'freshtv1590)
    | SEMICOLON ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1591 * _menhir_state * 'tv_variable_declarator) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_variable_declarator)) = _menhir_stack in
        let _v : 'tv_app_separated_non_empty_list_COMMA_variable_declarator_ = 
# 751 "src/java/jSourceParser.mly"
    ( x )
# 2137 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_separated_non_empty_list_COMMA_variable_declarator_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1592)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1593 * _menhir_state * 'tv_variable_declarator) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1594)) : 'freshtv1596)

and _menhir_goto_loption_for_update_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_for_update_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState277 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv1581 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((((('freshtv1577 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _v
            | FOR ->
                _menhir_run261 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run257 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState280 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | WHILE ->
                _menhir_run253 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState280
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState280) : 'freshtv1578)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((((('freshtv1579 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1580)) : 'freshtv1582)
    | MenhirState287 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv1587 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((((('freshtv1583 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _v
            | FOR ->
                _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState289 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | WHILE ->
                _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState289
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState289) : 'freshtv1584)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((((('freshtv1585 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1586)) : 'freshtv1588)
    | _ ->
        _menhir_fail ()

and _menhir_goto_for_init : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_for_init -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1575) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_for_init) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1573) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((x : 'tv_for_init) : 'tv_for_init) = _v in
    ((let _v : 'tv_loption_for_init_ = 
# 144 "<standard.mly>"
    ( x )
# 2318 "src/java/jSourceParser.ml"
     in
    _menhir_goto_loption_for_init_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1574)) : 'freshtv1576)

and _menhir_goto_app_list_class_body_declaration_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_list_class_body_declaration_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState395 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1521 * _menhir_state * 'tv_class_body_declaration) * _menhir_state * 'tv_app_list_class_body_declaration_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1519 * _menhir_state * 'tv_class_body_declaration) * _menhir_state * 'tv_app_list_class_body_declaration_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_class_body_declaration)), _, (xs : 'tv_app_list_class_body_declaration_)) = _menhir_stack in
        let _v : 'tv_app_list_class_body_declaration_ = 
# 739 "src/java/jSourceParser.mly"
    ( x@xs )
# 2335 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_list_class_body_declaration_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1520)) : 'freshtv1522)
    | MenhirState112 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1557 * _menhir_state * Lexing.position) * _menhir_state * 'tv_app_list_class_body_declaration_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1553 * _menhir_state * Lexing.position) * _menhir_state * 'tv_app_list_class_body_declaration_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1551 * _menhir_state * Lexing.position) * _menhir_state * 'tv_app_list_class_body_declaration_) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, _startpos__1_), _, (_2 : 'tv_app_list_class_body_declaration_)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _v : 'tv_class_body = 
# 173 "src/java/jSourceParser.mly"
    ( _2 )
# 2357 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1549) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_class_body) = _v in
            let (_startpos : Lexing.position) = _startpos in
            ((match _menhir_s with
            | MenhirState124 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv1531 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2370 "src/java/jSourceParser.ml"
                ) * Lexing.position) * 'tv_option_superclass_) * _menhir_state * 'tv_option_superinterfaces_) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_class_body) = _v in
                let (_startpos : Lexing.position) = _startpos in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv1529 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2379 "src/java/jSourceParser.ml"
                ) * Lexing.position) * 'tv_option_superclass_) * _menhir_state * 'tv_option_superinterfaces_) = Obj.magic _menhir_stack in
                let (_ : _menhir_state) = _menhir_s in
                let ((inner : 'tv_class_body) : 'tv_class_body) = _v in
                let (_startpos_inner_ : Lexing.position) = _startpos in
                ((let ((((_menhir_stack, _menhir_s), (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2387 "src/java/jSourceParser.ml"
                )), _startpos_id_), (_3 : 'tv_option_superclass_)), _, (_4 : 'tv_option_superinterfaces_)) = _menhir_stack in
                let _1 = () in
                let _v : 'tv_normal_class_declaration = let id = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 2393 "src/java/jSourceParser.ml"
                 in
                
# 128 "src/java/jSourceParser.mly"
    ( {
        location = location_of_pos _startpos_id_;
        kind = Class id;
        inner_elements = inner;
      }
    )
# 2403 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1527) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_normal_class_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1525) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_normal_class_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1523) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_normal_class_declaration) : 'tv_normal_class_declaration) = _v in
                ((let _v : 'tv_class_declaration = 
# 124 "src/java/jSourceParser.mly"
    ( _1 )
# 2420 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1524)) : 'freshtv1526)) : 'freshtv1528)) : 'freshtv1530)) : 'freshtv1532)
            | MenhirState111 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv1535 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_class_body) = _v in
                let (_startpos : Lexing.position) = _startpos in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv1533 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                let (_ : _menhir_state) = _menhir_s in
                let ((inner : 'tv_class_body) : 'tv_class_body) = _v in
                let (_startpos_inner_ : Lexing.position) = _startpos in
                ((let (((_menhir_stack, _menhir_s, (_1 : 'tv_primary)), _, (_1_inlined2 : 'tv_dotted_name)), _, (args : 'tv_loption_argument_list_)) = _menhir_stack in
                let _5 = () in
                let _3 = () in
                let _1_inlined1 = () in
                let _2 = () in
                let _v : 'tv_class_instance_creation_expression = let _3 =
                  let (_1_inlined1, _1) = (_1_inlined2, _1_inlined1) in
                  let _2 =
                    let _1 = _1_inlined1 in
                    
# 547 "src/java/jSourceParser.mly"
                ( _1 )
# 2446 "src/java/jSourceParser.ml"
                    
                  in
                  
# 679 "src/java/jSourceParser.mly"
    (  args @
         [{
             location = location_of_pos _startpos_inner_;
             kind = AnonymousClass;
             inner_elements = inner;
         }]
    )
# 2458 "src/java/jSourceParser.ml"
                  
                in
                
# 672 "src/java/jSourceParser.mly"
    ( _1 @ _3 )
# 2464 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_instance_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1534)) : 'freshtv1536)
            | MenhirState408 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv1539 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2472 "src/java/jSourceParser.ml"
                ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_class_body) = _v in
                let (_startpos : Lexing.position) = _startpos in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv1537 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2481 "src/java/jSourceParser.ml"
                ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                let (_ : _menhir_state) = _menhir_s in
                let ((inner : 'tv_class_body) : 'tv_class_body) = _v in
                let (_startpos_inner_ : Lexing.position) = _startpos in
                ((let ((((_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2489 "src/java/jSourceParser.ml"
                )), _startpos_id_), _), _, (_1_inlined1 : 'tv_dotted_name)), _, (args : 'tv_loption_argument_list_)) = _menhir_stack in
                let _5 = () in
                let _3 = () in
                let _1 = () in
                let _2 = () in
                let _v : 'tv_class_instance_creation_expression = let _3 =
                  let _2 =
                    let _1 = _1_inlined1 in
                    
# 547 "src/java/jSourceParser.mly"
                ( _1 )
# 2501 "src/java/jSourceParser.ml"
                    
                  in
                  
# 679 "src/java/jSourceParser.mly"
    (  args @
         [{
             location = location_of_pos _startpos_inner_;
             kind = AnonymousClass;
             inner_elements = inner;
         }]
    )
# 2513 "src/java/jSourceParser.ml"
                  
                in
                let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 2519 "src/java/jSourceParser.ml"
                 in
                
# 670 "src/java/jSourceParser.mly"
    ( _3 )
# 2524 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_instance_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1538)) : 'freshtv1540)
            | MenhirState427 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv1543 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_class_body) = _v in
                let (_startpos : Lexing.position) = _startpos in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv1541 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                let (_ : _menhir_state) = _menhir_s in
                let ((inner : 'tv_class_body) : 'tv_class_body) = _v in
                let (_startpos_inner_ : Lexing.position) = _startpos in
                ((let ((((_menhir_stack, _menhir_s), _, (_1_inlined1 : 'tv_dotted_name)), _), _, (args : 'tv_loption_argument_list_)) = _menhir_stack in
                let _5 = () in
                let _3 = () in
                let _1 = () in
                let _v : 'tv_class_instance_creation_expression = let _1 =
                  let _2 =
                    let _1 = _1_inlined1 in
                    
# 547 "src/java/jSourceParser.mly"
                ( _1 )
# 2548 "src/java/jSourceParser.ml"
                    
                  in
                  
# 679 "src/java/jSourceParser.mly"
    (  args @
         [{
             location = location_of_pos _startpos_inner_;
             kind = AnonymousClass;
             inner_elements = inner;
         }]
    )
# 2560 "src/java/jSourceParser.ml"
                  
                in
                
# 668 "src/java/jSourceParser.mly"
    ( _1 )
# 2566 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_instance_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1542)) : 'freshtv1544)
            | MenhirState72 | MenhirState434 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1547) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_class_body) = _v in
                let (_startpos : Lexing.position) = _startpos in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1545) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((x : 'tv_class_body) : 'tv_class_body) = _v in
                let (_startpos_x_ : Lexing.position) = _startpos in
                ((let _v : 'tv_option_class_body_ = 
# 116 "<standard.mly>"
    ( Some x )
# 2583 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_option_class_body_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1546)) : 'freshtv1548)
            | _ ->
                _menhir_fail ()) : 'freshtv1550)) : 'freshtv1552)) : 'freshtv1554)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1555 * _menhir_state * Lexing.position) * _menhir_state * 'tv_app_list_class_body_declaration_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1556)) : 'freshtv1558)
    | MenhirState441 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1571) * _menhir_state * 'tv_app_list_class_body_declaration_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1569) * _menhir_state * 'tv_app_list_class_body_declaration_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _, (_2 : 'tv_app_list_class_body_declaration_)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_enum_body_declarations = 
# 169 "src/java/jSourceParser.mly"
    ( _2 )
# 2605 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1567) = _menhir_stack in
        let (_v : 'tv_enum_body_declarations) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1565 * Lexing.position) * _menhir_state * 'tv_enum_constant_list) * 'tv_enum_body_declarations) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1561 * Lexing.position) * _menhir_state * 'tv_enum_constant_list) * 'tv_enum_body_declarations) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1559 * Lexing.position) * _menhir_state * 'tv_enum_constant_list) * 'tv_enum_body_declarations) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _startpos__1_), _, (_2 : 'tv_enum_constant_list)), (inner : 'tv_enum_body_declarations)) = _menhir_stack in
            let _4 = () in
            let _1 = () in
            let _v : 'tv_enum_body = 
# 156 "src/java/jSourceParser.mly"
    ( inner )
# 2628 "src/java/jSourceParser.ml"
             in
            _menhir_goto_enum_body _menhir_env _menhir_stack _v) : 'freshtv1560)) : 'freshtv1562)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1563 * Lexing.position) * _menhir_state * 'tv_enum_constant_list) * 'tv_enum_body_declarations) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1564)) : 'freshtv1566)) : 'freshtv1568)) : 'freshtv1570)) : 'freshtv1572)
    | _ ->
        _menhir_fail ()

and _menhir_goto_option_class_body_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_class_body_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState434 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv1513 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2649 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_option_argument_list_)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_option_class_body_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv1511 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2657 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_option_argument_list_)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_5 : 'tv_option_class_body_) : 'tv_option_class_body_) = _v in
        ((let (((_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2664 "src/java/jSourceParser.ml"
        )), _startpos_id_), _), _, (_3 : 'tv_option_argument_list_)) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _v : 'tv_enum_constant = let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 2671 "src/java/jSourceParser.ml"
         in
        
# 165 "src/java/jSourceParser.mly"
    ()
# 2676 "src/java/jSourceParser.ml"
         in
        _menhir_goto_enum_constant _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1512)) : 'freshtv1514)
    | MenhirState72 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1517 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2684 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_option_class_body_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1515 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2692 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_option_class_body_) : 'tv_option_class_body_) = _v in
        ((let (_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 2699 "src/java/jSourceParser.ml"
        )), _startpos_id_) = _menhir_stack in
        let _v : 'tv_enum_constant = let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 2704 "src/java/jSourceParser.ml"
         in
        
# 165 "src/java/jSourceParser.mly"
    ()
# 2709 "src/java/jSourceParser.ml"
         in
        _menhir_goto_enum_constant _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1516)) : 'freshtv1518)
    | _ ->
        _menhir_fail ()

and _menhir_goto_class_body_declaration : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_class_body_declaration -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1509 * _menhir_state * 'tv_class_body_declaration) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CLASS ->
        _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState395
    | ENUM ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState395
    | IDENT _v ->
        _menhir_run114 _menhir_env (Obj.magic _menhir_stack) MenhirState395 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTERFACE ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState395
    | PRIMTYPE ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState395
    | SEMICOLON ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState395
    | VOID ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState395
    | RBRACKET ->
        _menhir_reduce5 _menhir_env (Obj.magic _menhir_stack) MenhirState395
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState395) : 'freshtv1510)

and _menhir_goto_try_statement : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_try_statement -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1507) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_try_statement) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1505) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_try_statement) : 'tv_try_statement) = _v in
    ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 2757 "src/java/jSourceParser.ml"
     in
    _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1506)) : 'freshtv1508)

and _menhir_reduce3 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_app_list_catch_clause_ = 
# 737 "src/java/jSourceParser.mly"
    ( [] )
# 2766 "src/java/jSourceParser.ml"
     in
    _menhir_goto_app_list_catch_clause_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_loption_catches_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_catches_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv1503 * _menhir_state) * _menhir_state * 'tv_block) * _menhir_state * 'tv_loption_catches_) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FINALLY ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1499) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACKET ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState222 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState222) : 'freshtv1500)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1501 * _menhir_state) * _menhir_state * 'tv_block) * _menhir_state * 'tv_loption_catches_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1502)) : 'freshtv1504)

and _menhir_run210 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1495 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState211 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState211) : 'freshtv1496)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1497 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1498)

and _menhir_goto_statement_no_short_if : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_statement_no_short_if -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState280 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((((('freshtv1451 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((((('freshtv1449 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((let (((((_menhir_stack, _menhir_s), _, (_3 : 'tv_loption_for_init_)), _, (_5 : 'tv_loption_expression_)), _, (_7 : 'tv_loption_for_update_)), _, (_9 : 'tv_statement_no_short_if)) = _menhir_stack in
        let _8 = () in
        let _6 = () in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_basic_for_statement_no_short_if = 
# 334 "src/java/jSourceParser.mly"
    ( _3 @ _5 @ _7 @ _9 )
# 2842 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1447) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_basic_for_statement_no_short_if) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1445) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_basic_for_statement_no_short_if) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1443) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_basic_for_statement_no_short_if) : 'tv_basic_for_statement_no_short_if) = _v in
        ((let _v : 'tv_for_statement_no_short_if = 
# 318 "src/java/jSourceParser.mly"
    ( _1 )
# 2859 "src/java/jSourceParser.ml"
         in
        _menhir_goto_for_statement_no_short_if _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1444)) : 'freshtv1446)) : 'freshtv1448)) : 'freshtv1450)) : 'freshtv1452)
    | MenhirState355 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((((('freshtv1461 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((((('freshtv1459 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((let (((((_menhir_stack, _menhir_s), _, (_3 : 'tv_local_variable_type)), _, (_4 : 'tv_variable_declarator_id)), _, (_6 : 'tv_expression)), _, (_8 : 'tv_statement_no_short_if)) = _menhir_stack in
        let _7 = () in
        let _5 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_enhanced_for_statement_no_short_if = 
# 330 "src/java/jSourceParser.mly"
    ( _6 @ _8 )
# 2875 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1457) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_enhanced_for_statement_no_short_if) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1455) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_enhanced_for_statement_no_short_if) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1453) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_enhanced_for_statement_no_short_if) : 'tv_enhanced_for_statement_no_short_if) = _v in
        ((let _v : 'tv_for_statement_no_short_if = 
# 318 "src/java/jSourceParser.mly"
    ( _1 )
# 2892 "src/java/jSourceParser.ml"
         in
        _menhir_goto_for_statement_no_short_if _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1454)) : 'freshtv1456)) : 'freshtv1458)) : 'freshtv1460)) : 'freshtv1462)
    | MenhirState260 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1467 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ELSE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1463 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState358 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState358 _v
            | FOR ->
                _menhir_run261 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState358 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run257 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState358 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState358 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState358 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | WHILE ->
                _menhir_run253 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState358
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState358) : 'freshtv1464)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1465 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1466)) : 'freshtv1468)
    | MenhirState358 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv1477 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv1475 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((let ((((_menhir_stack, _menhir_s), _, (_3 : 'tv_expression)), _, (_5 : 'tv_statement_no_short_if)), _, (_7 : 'tv_statement_no_short_if)) = _menhir_stack in
        let _6 = () in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_if_then_else_statement_no_short_if = 
# 359 "src/java/jSourceParser.mly"
    ( _3 @ _5 @ _7 )
# 2983 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1473) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_if_then_else_statement_no_short_if) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1471) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_if_then_else_statement_no_short_if) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1469) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_if_then_else_statement_no_short_if) : 'tv_if_then_else_statement_no_short_if) = _v in
        ((let _v : 'tv_statement_no_short_if = 
# 366 "src/java/jSourceParser.mly"
    ( _1 )
# 3000 "src/java/jSourceParser.ml"
         in
        _menhir_goto_statement_no_short_if _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1470)) : 'freshtv1472)) : 'freshtv1474)) : 'freshtv1476)) : 'freshtv1478)
    | MenhirState256 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1487 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1485 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _, (_3 : 'tv_expression)), _, (_5 : 'tv_statement_no_short_if)) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_while_statement_no_short_if = 
# 374 "src/java/jSourceParser.mly"
    ( _3 @ _5 )
# 3015 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1483) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_while_statement_no_short_if) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1481) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_while_statement_no_short_if) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1479) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_while_statement_no_short_if) : 'tv_while_statement_no_short_if) = _v in
        ((let _v : 'tv_statement_no_short_if = 
# 366 "src/java/jSourceParser.mly"
    ( _1 )
# 3032 "src/java/jSourceParser.ml"
         in
        _menhir_goto_statement_no_short_if _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1480)) : 'freshtv1482)) : 'freshtv1484)) : 'freshtv1486)) : 'freshtv1488)
    | MenhirState252 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1493 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ELSE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1489 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _v
            | FOR ->
                _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState365 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | WHILE ->
                _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState365
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState365) : 'freshtv1490)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1491 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1492)) : 'freshtv1494)
    | _ ->
        _menhir_fail ()

and _menhir_reduce216 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_statement_without_trailing_substatement -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_statement_without_trailing_substatement)) = _menhir_stack in
    let _v : 'tv_statement = 
# 308 "src/java/jSourceParser.mly"
    ( _1 )
# 3119 "src/java/jSourceParser.ml"
     in
    _menhir_goto_statement _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_loption_expression_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_expression_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState240 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1429 * _menhir_state) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1425 * _menhir_state) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1423 * _menhir_state) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_loption_expression_)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_return_statement = 
# 428 "src/java/jSourceParser.mly"
    ( _2 )
# 3145 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1421) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_return_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1419) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_return_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1417) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_return_statement) : 'tv_return_statement) = _v in
            ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 3162 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1418)) : 'freshtv1420)) : 'freshtv1422)) : 'freshtv1424)) : 'freshtv1426)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1427 * _menhir_state) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1428)) : 'freshtv1430)
    | MenhirState275 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1435 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1431 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState277 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState277
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState277 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState277 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState277
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState277 _v
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState277
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState277
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState277
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState277 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState277
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState277
            | RPAREN ->
                _menhir_reduce158 _menhir_env (Obj.magic _menhir_stack) MenhirState277
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState277) : 'freshtv1432)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1433 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1434)) : 'freshtv1436)
    | MenhirState285 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1441 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1437 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState287
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState287
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _v
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState287
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState287
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState287
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState287
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState287
            | RPAREN ->
                _menhir_reduce158 _menhir_env (Obj.magic _menhir_stack) MenhirState287
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState287) : 'freshtv1438)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1439 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1440)) : 'freshtv1442)
    | _ ->
        _menhir_fail ()

and _menhir_goto_loption_for_init_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_for_init_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState262 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1409 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1405 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState275 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState275 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState275 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState275 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState275 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | SEMICOLON ->
                _menhir_reduce154 _menhir_env (Obj.magic _menhir_stack) MenhirState275
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState275) : 'freshtv1406)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1407 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1408)) : 'freshtv1410)
    | MenhirState283 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1415 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1411 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState285 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState285 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState285 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState285 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState285 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | SEMICOLON ->
                _menhir_reduce154 _menhir_env (Obj.magic _menhir_stack) MenhirState285
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState285) : 'freshtv1412)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1413 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1414)) : 'freshtv1416)
    | _ ->
        _menhir_fail ()

and _menhir_goto_option_identifier_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_identifier_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState290 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1389 * _menhir_state) * _menhir_state * 'tv_option_identifier_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1385 * _menhir_state) * _menhir_state * 'tv_option_identifier_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1383 * _menhir_state) * _menhir_state * 'tv_option_identifier_) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_option_identifier_)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_continue_statement = 
# 424 "src/java/jSourceParser.mly"
    ( [] )
# 3412 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1381) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_continue_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1379) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_continue_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1377) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_continue_statement) : 'tv_continue_statement) = _v in
            ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 3429 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1378)) : 'freshtv1380)) : 'freshtv1382)) : 'freshtv1384)) : 'freshtv1386)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1387 * _menhir_state) * _menhir_state * 'tv_option_identifier_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1388)) : 'freshtv1390)
    | MenhirState294 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1403 * _menhir_state) * _menhir_state * 'tv_option_identifier_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1399 * _menhir_state) * _menhir_state * 'tv_option_identifier_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1397 * _menhir_state) * _menhir_state * 'tv_option_identifier_) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_option_identifier_)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_break_statement = 
# 420 "src/java/jSourceParser.mly"
    ( [] )
# 3457 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1395) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_break_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1393) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_break_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1391) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_break_statement) : 'tv_break_statement) = _v in
            ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 3474 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1392)) : 'freshtv1394)) : 'freshtv1396)) : 'freshtv1398)) : 'freshtv1400)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1401 * _menhir_state) * _menhir_state * 'tv_option_identifier_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1402)) : 'freshtv1404)
    | _ ->
        _menhir_fail ()

and _menhir_goto_method_body : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_method_body -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState198 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1365 * _menhir_state * 'tv_method_header) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_method_body) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1363 * _menhir_state * 'tv_method_header) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_method_body) : 'tv_method_body) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_method_header)) = _menhir_stack in
        let _v : 'tv_method_declaration = 
# 209 "src/java/jSourceParser.mly"
    ( _2 )
# 3503 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1361) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_method_declaration) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1359) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_method_declaration) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1357) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_method_declaration) : 'tv_method_declaration) = _v in
        ((let _v : 'tv_class_member_declaration = 
# 203 "src/java/jSourceParser.mly"
    ( _1 )
# 3520 "src/java/jSourceParser.ml"
         in
        _menhir_goto_class_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1358)) : 'freshtv1360)) : 'freshtv1362)) : 'freshtv1364)) : 'freshtv1366)
    | MenhirState453 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1375 * _menhir_state * 'tv_method_header) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_method_body) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1373 * _menhir_state * 'tv_method_header) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_method_body) : 'tv_method_body) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_method_header)) = _menhir_stack in
        let _v : 'tv_interface_method_declaration = 
# 238 "src/java/jSourceParser.mly"
    ()
# 3536 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1371) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_interface_method_declaration) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1369) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_interface_method_declaration) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1367) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_interface_method_declaration) : 'tv_interface_method_declaration) = _v in
        ((let _v : 'tv_interface_member_declaration = 
# 231 "src/java/jSourceParser.mly"
    ( [] )
# 3553 "src/java/jSourceParser.ml"
         in
        _menhir_goto_interface_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1368)) : 'freshtv1370)) : 'freshtv1372)) : 'freshtv1374)) : 'freshtv1376)
    | _ ->
        _menhir_fail ()

and _menhir_goto_assignment_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_assignment_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1355) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_assignment_expression) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1353) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_assignment_expression) : 'tv_assignment_expression) = _v in
    ((let _v : 'tv_expression = 
# 566 "src/java/jSourceParser.mly"
    ( _1 )
# 3572 "src/java/jSourceParser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1351) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_expression) = _v in
    ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState146 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1183 * _menhir_state * 'tv_left_hand_side) * 'tv_assignment_operator) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1181 * _menhir_state * 'tv_left_hand_side) * 'tv_assignment_operator) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s, (_1 : 'tv_left_hand_side)), (_2 : 'tv_assignment_operator)), _, (_3 : 'tv_expression)) = _menhir_stack in
        let _v : 'tv_assignment = 
# 575 "src/java/jSourceParser.mly"
    ( _1 @ _3 )
# 3589 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1179) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_assignment) = _v in
        ((match _menhir_s with
        | MenhirState73 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState91 | MenhirState100 | MenhirState401 | MenhirState106 | MenhirState205 | MenhirState250 | MenhirState254 | MenhirState258 | MenhirState353 | MenhirState275 | MenhirState340 | MenhirState337 | MenhirState330 | MenhirState285 | MenhirState297 | MenhirState300 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState138 | MenhirState146 | MenhirState150 | MenhirState178 | MenhirState157 | MenhirState161 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1173) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_assignment) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1171) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_assignment) : 'tv_assignment) = _v in
            ((let _v : 'tv_assignment_expression = 
# 571 "src/java/jSourceParser.mly"
    ( _1 )
# 3608 "src/java/jSourceParser.ml"
             in
            _menhir_goto_assignment_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1172)) : 'freshtv1174)
        | MenhirState388 | MenhirState200 | MenhirState376 | MenhirState377 | MenhirState207 | MenhirState252 | MenhirState365 | MenhirState256 | MenhirState260 | MenhirState358 | MenhirState262 | MenhirState355 | MenhirState277 | MenhirState280 | MenhirState281 | MenhirState283 | MenhirState332 | MenhirState287 | MenhirState289 | MenhirState267 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1177) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_assignment) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1175) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_assignment) : 'tv_assignment) = _v in
            ((let _v : 'tv_statement_expression = 
# 406 "src/java/jSourceParser.mly"
    ( _1 )
# 3623 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1176)) : 'freshtv1178)
        | _ ->
            _menhir_fail ()) : 'freshtv1180)) : 'freshtv1182)) : 'freshtv1184)
    | MenhirState337 | MenhirState150 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1191 * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RSBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1187 * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1185 * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)), _), _, (_3 : 'tv_expression)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _v : 'tv_array_access = let _1 = 
# 550 "src/java/jSourceParser.mly"
                ( _1 )
# 3646 "src/java/jSourceParser.ml"
             in
            
# 595 "src/java/jSourceParser.mly"
    ( _3 )
# 3651 "src/java/jSourceParser.ml"
             in
            _menhir_goto_array_access _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1186)) : 'freshtv1188)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1189 * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1190)) : 'freshtv1192)
    | MenhirState73 | MenhirState425 | MenhirState91 | MenhirState401 | MenhirState106 | MenhirState161 | MenhirState157 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1199 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1193 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState161 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState161 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState161 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState161 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState161 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState161
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState161) : 'freshtv1194)
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1195 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_expression)) = _menhir_stack in
            let _v : 'tv_app_separated_non_empty_list_COMMA_expression_ = 
# 751 "src/java/jSourceParser.mly"
    ( x )
# 3714 "src/java/jSourceParser.ml"
             in
            _menhir_goto_app_separated_non_empty_list_COMMA_expression_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1196)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1197 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1198)) : 'freshtv1200)
    | MenhirState178 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1205 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1201 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState180
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState180) : 'freshtv1202)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1203 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1204)) : 'freshtv1206)
    | MenhirState131 | MenhirState132 | MenhirState138 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1209 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1207 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_expression)) = _menhir_stack in
        let _v : 'tv_variable_initializer = 
# 505 "src/java/jSourceParser.mly"
    ( _1 )
# 3786 "src/java/jSourceParser.ml"
         in
        _menhir_goto_variable_initializer _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1208)) : 'freshtv1210)
    | MenhirState201 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1223 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1219 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1217 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_expression)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_yield_statement = 
# 462 "src/java/jSourceParser.mly"
    ( _2 )
# 3807 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1215) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_yield_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1213) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_yield_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1211) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_yield_statement) : 'tv_yield_statement) = _v in
            ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 3824 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1212)) : 'freshtv1214)) : 'freshtv1216)) : 'freshtv1218)) : 'freshtv1220)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1221 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1222)) : 'freshtv1224)
    | MenhirState205 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1229 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1225 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState207 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState207 _v
            | FOR ->
                _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState207 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState207 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState207 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState207 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | WHILE ->
                _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState207
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState207) : 'freshtv1226)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1227 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1228)) : 'freshtv1230)
    | MenhirState231 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1243 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1239 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1237 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_expression)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_throw_statement = 
# 466 "src/java/jSourceParser.mly"
    ( _2 )
# 3927 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1235) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_throw_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1233) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_throw_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1231) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_throw_statement) : 'tv_throw_statement) = _v in
            ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 3944 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1232)) : 'freshtv1234)) : 'freshtv1236)) : 'freshtv1238)) : 'freshtv1240)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1241 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1242)) : 'freshtv1244)
    | MenhirState235 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1249 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1245 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState237 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState237) : 'freshtv1246)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1247 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1248)) : 'freshtv1250)
    | MenhirState275 | MenhirState285 | MenhirState240 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1253 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1251 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_expression)) = _menhir_stack in
        let _v : 'tv_loption_expression_ = 
# 144 "<standard.mly>"
    ( x )
# 3988 "src/java/jSourceParser.ml"
         in
        _menhir_goto_loption_expression_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1252)) : 'freshtv1254)
    | MenhirState82 | MenhirState244 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1261 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1257 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1255 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_expression)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_primary_no_new_array = 
# 622 "src/java/jSourceParser.mly"
    ( _2 )
# 4009 "src/java/jSourceParser.ml"
             in
            _menhir_goto_primary_no_new_array _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1256)) : 'freshtv1258)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1259 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1260)) : 'freshtv1262)
    | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1267 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1263 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState252 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState252 _v
            | FOR ->
                _menhir_run261 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState252 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run257 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState252 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState252 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState252 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | WHILE ->
                _menhir_run253 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState252
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState252) : 'freshtv1264)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1265 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1266)) : 'freshtv1268)
    | MenhirState254 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1273 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1269 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
            | FOR ->
                _menhir_run261 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run257 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState256 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | WHILE ->
                _menhir_run253 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState256
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState256) : 'freshtv1270)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1271 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1272)) : 'freshtv1274)
    | MenhirState258 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1279 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1275 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState260 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState260 _v
            | FOR ->
                _menhir_run261 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState260 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run257 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState260 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState260 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState260 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | WHILE ->
                _menhir_run253 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState260
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState260) : 'freshtv1276)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1277 * _menhir_state)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1278)) : 'freshtv1280)
    | MenhirState297 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1289 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1281 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState300 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState300 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState300 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState300 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState300 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState300
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState300) : 'freshtv1282)
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1285 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1283 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_expression)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_assert_statement = 
# 410 "src/java/jSourceParser.mly"
    ( _2 )
# 4302 "src/java/jSourceParser.ml"
             in
            _menhir_goto_assert_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1284)) : 'freshtv1286)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1287 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1288)) : 'freshtv1290)
    | MenhirState300 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv1297 * _menhir_state) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv1293 * _menhir_state) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv1291 * _menhir_state) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_expression)), _, (_4 : 'tv_expression)) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_assert_statement = 
# 412 "src/java/jSourceParser.mly"
    ( _2 @ _4 )
# 4331 "src/java/jSourceParser.ml"
             in
            _menhir_goto_assert_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1292)) : 'freshtv1294)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv1295 * _menhir_state) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1296)) : 'freshtv1298)
    | MenhirState330 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv1303 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv1299 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _v
            | FOR ->
                _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | WHILE ->
                _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState332
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState332) : 'freshtv1300)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv1301 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1302)) : 'freshtv1304)
    | MenhirState340 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv1321 * _menhir_state) * _menhir_state * 'tv_statement))) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1317 * _menhir_state) * _menhir_state * 'tv_statement))) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((((('freshtv1313 * _menhir_state) * _menhir_state * 'tv_statement))) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((((('freshtv1311 * _menhir_state) * _menhir_state * 'tv_statement))) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
                ((let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_statement)), _, (_5 : 'tv_expression)) = _menhir_stack in
                let _7 = () in
                let _6 = () in
                let _4 = () in
                let _3 = () in
                let _1 = () in
                let _v : 'tv_do_statement = 
# 416 "src/java/jSourceParser.mly"
    ( _2 @ _5 )
# 4443 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1309) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_do_statement) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1307) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_do_statement) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1305) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_do_statement) : 'tv_do_statement) = _v in
                ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 4460 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1306)) : 'freshtv1308)) : 'freshtv1310)) : 'freshtv1312)) : 'freshtv1314)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((((('freshtv1315 * _menhir_state) * _menhir_state * 'tv_statement))) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1316)) : 'freshtv1318)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv1319 * _menhir_state) * _menhir_state * 'tv_statement))) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1320)) : 'freshtv1322)
    | MenhirState353 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv1327 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv1323 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState355 _v
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState355 _v
            | FOR ->
                _menhir_run261 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState355 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run257 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState355 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState355 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState355 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | WHILE ->
                _menhir_run253 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState355
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState355) : 'freshtv1324)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv1325 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1326)) : 'freshtv1328)
    | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1335 * _menhir_state * 'tv_primary_no_new_array)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RSBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1331 * _menhir_state * 'tv_primary_no_new_array)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1329 * _menhir_state * 'tv_primary_no_new_array)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_primary_no_new_array)), _, (_3 : 'tv_expression)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _v : 'tv_array_access = 
# 597 "src/java/jSourceParser.mly"
    ( _1 @ _3 )
# 4570 "src/java/jSourceParser.ml"
             in
            _menhir_goto_array_access _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1330)) : 'freshtv1332)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv1333 * _menhir_state * 'tv_primary_no_new_array)) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1334)) : 'freshtv1336)
    | MenhirState419 | MenhirState81 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1349 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RSBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1345 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1343 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_expression)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_dim_expr = 
# 618 "src/java/jSourceParser.mly"
    ( _2 )
# 4598 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1341) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_dim_expr) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            match _menhir_s with
            | MenhirState424 | MenhirState80 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1337 * _menhir_state * 'tv_dim_expr) = Obj.magic _menhir_stack in
                ((assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | LSBRACKET ->
                    _menhir_run419 _menhir_env (Obj.magic _menhir_stack) MenhirState418
                | BINOP | COLON | COMMA | DOT | INCR_DECR | INSTANCEOF | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
                    _menhir_reduce7 _menhir_env (Obj.magic _menhir_stack) MenhirState418
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState418) : 'freshtv1338)
            | MenhirState420 | MenhirState418 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1339 * _menhir_state * 'tv_dim_expr) = Obj.magic _menhir_stack in
                ((assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | LSBRACKET ->
                    _menhir_run419 _menhir_env (Obj.magic _menhir_stack) MenhirState420
                | BINOP | COLON | COMMA | DOT | INCR_DECR | INSTANCEOF | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
                    _menhir_reduce7 _menhir_env (Obj.magic _menhir_stack) MenhirState420
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState420) : 'freshtv1340)
            | _ ->
                _menhir_fail ()) : 'freshtv1342)) : 'freshtv1344)) : 'freshtv1346)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1347 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1348)) : 'freshtv1350)
    | _ ->
        _menhir_fail ()) : 'freshtv1352)) : 'freshtv1354)) : 'freshtv1356)

and _menhir_goto_separated_nonempty_list_COMMA_formal_parameter_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_formal_parameter_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState115 | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1165) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_formal_parameter_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1163) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_COMMA_formal_parameter_) : 'tv_separated_nonempty_list_COMMA_formal_parameter_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_formal_parameter__ = 
# 144 "<standard.mly>"
    ( x )
# 4661 "src/java/jSourceParser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_formal_parameter__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1164)) : 'freshtv1166)
    | MenhirState48 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1169 * _menhir_state * 'tv_formal_parameter)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_formal_parameter_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1167 * _menhir_state * 'tv_formal_parameter)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_formal_parameter_) : 'tv_separated_nonempty_list_COMMA_formal_parameter_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_formal_parameter)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_formal_parameter_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 4678 "src/java/jSourceParser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_formal_parameter_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1168)) : 'freshtv1170)
    | _ ->
        _menhir_fail ()

and _menhir_goto_interface_member_declaration : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_interface_member_declaration -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1161 * _menhir_state * 'tv_interface_member_declaration) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CLASS ->
        _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState456
    | ENUM ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState456
    | IDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState456 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTERFACE ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState456
    | PRIMTYPE ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState456
    | VOID ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState456
    | RBRACKET ->
        _menhir_reduce9 _menhir_env (Obj.magic _menhir_stack) MenhirState456
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState456) : 'freshtv1162)

and _menhir_goto_class_member_declaration : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_class_member_declaration -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1159) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_class_member_declaration) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1157) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_class_member_declaration) : 'tv_class_member_declaration) = _v in
    ((let _v : 'tv_class_body_declaration = 
# 177 "src/java/jSourceParser.mly"
    ( _1 )
# 4724 "src/java/jSourceParser.ml"
     in
    _menhir_goto_class_body_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1158)) : 'freshtv1160)

and _menhir_reduce160 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_loption_separated_nonempty_list_COMMA_formal_parameter__ = 
# 142 "<standard.mly>"
    ( [] )
# 4733 "src/java/jSourceParser.ml"
     in
    _menhir_goto_loption_separated_nonempty_list_COMMA_formal_parameter__ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_array_initializer : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_array_initializer -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState131 | MenhirState132 | MenhirState138 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1147) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_array_initializer) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1145) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_array_initializer) : 'tv_array_initializer) = _v in
        ((let _v : 'tv_variable_initializer = 
# 505 "src/java/jSourceParser.mly"
    ( _1 )
# 4752 "src/java/jSourceParser.ml"
         in
        _menhir_goto_variable_initializer _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1146)) : 'freshtv1148)
    | MenhirState415 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1151 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_array_initializer) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1149 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_4 : 'tv_array_initializer) : 'tv_array_initializer) = _v in
        ((let (((_menhir_stack, _menhir_s), _), _, (_3 : 'tv_dims)) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_array_creation_expression = 
# 610 "src/java/jSourceParser.mly"
    ( _4 )
# 4770 "src/java/jSourceParser.ml"
         in
        _menhir_goto_array_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1150)) : 'freshtv1152)
    | MenhirState429 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1155 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_array_initializer) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1153 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_4 : 'tv_array_initializer) : 'tv_array_initializer) = _v in
        ((let (((_menhir_stack, _menhir_s), _, (_1_inlined1 : 'tv_dotted_name)), _, (_3 : 'tv_dims)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_array_creation_expression = let _2 =
          let _1 = _1_inlined1 in
          
# 544 "src/java/jSourceParser.mly"
                ( _1 )
# 4789 "src/java/jSourceParser.ml"
          
        in
        
# 610 "src/java/jSourceParser.mly"
    ( _4 )
# 4795 "src/java/jSourceParser.ml"
         in
        _menhir_goto_array_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1154)) : 'freshtv1156)
    | _ ->
        _menhir_fail ()

and _menhir_reduce189 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_option_throws_ = 
# 114 "<standard.mly>"
    ( None )
# 4806 "src/java/jSourceParser.ml"
     in
    _menhir_goto_option_throws_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run53 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState53

and _menhir_reduce267 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_variable_declarator_id -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_variable_declarator_id)) = _menhir_stack in
    let _v : 'tv_variable_declarator = 
# 494 "src/java/jSourceParser.mly"
    ( [] )
# 4829 "src/java/jSourceParser.ml"
     in
    _menhir_goto_variable_declarator _menhir_env _menhir_stack _menhir_s _v

and _menhir_run131 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_variable_declarator_id -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState131 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState131 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState131 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState131 _v
    | LBRACKET ->
        _menhir_run132 _menhir_env (Obj.magic _menhir_stack) MenhirState131 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState131 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState131
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState131

and _menhir_goto_app_separated_non_empty_list_COMMA_statement_expression_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_separated_non_empty_list_COMMA_statement_expression_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState267 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1123 * _menhir_state * 'tv_statement_expression)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_separated_non_empty_list_COMMA_statement_expression_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1121 * _menhir_state * 'tv_statement_expression)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_app_separated_non_empty_list_COMMA_statement_expression_) : 'tv_app_separated_non_empty_list_COMMA_statement_expression_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_statement_expression)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_app_separated_non_empty_list_COMMA_statement_expression_ = 
# 753 "src/java/jSourceParser.mly"
    ( x@xs )
# 4892 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_separated_non_empty_list_COMMA_statement_expression_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1122)) : 'freshtv1124)
    | MenhirState262 | MenhirState277 | MenhirState283 | MenhirState287 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1143) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_app_separated_non_empty_list_COMMA_statement_expression_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1141) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_app_separated_non_empty_list_COMMA_statement_expression_) : 'tv_app_separated_non_empty_list_COMMA_statement_expression_) = _v in
        ((let _v : 'tv_statement_expression_list = 
# 347 "src/java/jSourceParser.mly"
    ( _1 )
# 4907 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1139) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_statement_expression_list) = _v in
        ((match _menhir_s with
        | MenhirState283 | MenhirState262 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1127) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_statement_expression_list) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1125) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_statement_expression_list) : 'tv_statement_expression_list) = _v in
            ((let _v : 'tv_for_init = 
# 339 "src/java/jSourceParser.mly"
    ( _1 )
# 4926 "src/java/jSourceParser.ml"
             in
            _menhir_goto_for_init _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1126)) : 'freshtv1128)
        | MenhirState287 | MenhirState277 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1137) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_statement_expression_list) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1135) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_statement_expression_list) : 'tv_statement_expression_list) = _v in
            ((let _v : 'tv_for_update = 
# 343 "src/java/jSourceParser.mly"
    ( _1 )
# 4941 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1133) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_for_update) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1131) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_for_update) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1129) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((x : 'tv_for_update) : 'tv_for_update) = _v in
            ((let _v : 'tv_loption_for_update_ = 
# 144 "<standard.mly>"
    ( x )
# 4958 "src/java/jSourceParser.ml"
             in
            _menhir_goto_loption_for_update_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1130)) : 'freshtv1132)) : 'freshtv1134)) : 'freshtv1136)) : 'freshtv1138)
        | _ ->
            _menhir_fail ()) : 'freshtv1140)) : 'freshtv1142)) : 'freshtv1144)
    | _ ->
        _menhir_fail ()

and _menhir_goto_unary_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_unary_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1095 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unary_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1093 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_unary_expression) : 'tv_unary_expression) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_unary_expression_not_plus_minus = 
# 720 "src/java/jSourceParser.mly"
    ( _2 )
# 4983 "src/java/jSourceParser.ml"
         in
        _menhir_goto_unary_expression_not_plus_minus _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1094)) : 'freshtv1096)
    | MenhirState73 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState91 | MenhirState401 | MenhirState353 | MenhirState340 | MenhirState337 | MenhirState330 | MenhirState300 | MenhirState297 | MenhirState285 | MenhirState275 | MenhirState258 | MenhirState254 | MenhirState250 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState205 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState184 | MenhirState182 | MenhirState180 | MenhirState178 | MenhirState161 | MenhirState157 | MenhirState154 | MenhirState150 | MenhirState146 | MenhirState138 | MenhirState106 | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1099) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unary_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1097) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_unary_expression) : 'tv_unary_expression) = _v in
        ((let _v : 'tv_conditional_or_expression = 
# 699 "src/java/jSourceParser.mly"
    ( _1 )
# 4998 "src/java/jSourceParser.ml"
         in
        _menhir_goto_conditional_or_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1098)) : 'freshtv1100)
    | MenhirState247 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1103 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unary_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1101 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_unary_expression) : 'tv_unary_expression) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_statement_expression = 
# 401 "src/java/jSourceParser.mly"
    ( _2 )
# 5015 "src/java/jSourceParser.ml"
         in
        _menhir_goto_statement_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1102)) : 'freshtv1104)
    | MenhirState95 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1107 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unary_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1105 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_unary_expression) : 'tv_unary_expression) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_unary_expression = 
# 709 "src/java/jSourceParser.mly"
    ( _2 )
# 5032 "src/java/jSourceParser.ml"
         in
        _menhir_goto_unary_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1106)) : 'freshtv1108)
    | MenhirState86 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1111 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unary_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1109 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_unary_expression) : 'tv_unary_expression) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_unary_expression = 
# 709 "src/java/jSourceParser.mly"
    ( _2 )
# 5049 "src/java/jSourceParser.ml"
         in
        _menhir_goto_unary_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1110)) : 'freshtv1112)
    | MenhirState84 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1115 * _menhir_state) * _menhir_state)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unary_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1113 * _menhir_state) * _menhir_state)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_4 : 'tv_unary_expression) : 'tv_unary_expression) = _v in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        let _3 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_unary_expression_not_plus_minus = let _1 = 
# 725 "src/java/jSourceParser.mly"
    ( _4 )
# 5068 "src/java/jSourceParser.ml"
         in
        
# 717 "src/java/jSourceParser.mly"
    ( _1 )
# 5073 "src/java/jSourceParser.ml"
         in
        _menhir_goto_unary_expression_not_plus_minus _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1114)) : 'freshtv1116)
    | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1119 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unary_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1117 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_unary_expression) : 'tv_unary_expression) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_unary_expression_not_plus_minus = 
# 720 "src/java/jSourceParser.mly"
    ( _2 )
# 5090 "src/java/jSourceParser.ml"
         in
        _menhir_goto_unary_expression_not_plus_minus _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1118)) : 'freshtv1120)
    | _ ->
        _menhir_fail ()

and _menhir_reduce204 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_method_invocation -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_method_invocation)) = _menhir_stack in
    let _v : 'tv_primary_no_new_array = 
# 631 "src/java/jSourceParser.mly"
    ( _1 )
# 5102 "src/java/jSourceParser.ml"
     in
    _menhir_goto_primary_no_new_array _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce201 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_class_instance_creation_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_class_instance_creation_expression)) = _menhir_stack in
    let _v : 'tv_primary_no_new_array = 
# 631 "src/java/jSourceParser.mly"
    ( _1 )
# 5112 "src/java/jSourceParser.ml"
     in
    _menhir_goto_primary_no_new_array _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce202 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_field_access -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_field_access)) = _menhir_stack in
    let _v : 'tv_primary_no_new_array = 
# 631 "src/java/jSourceParser.mly"
    ( _1 )
# 5122 "src/java/jSourceParser.ml"
     in
    _menhir_goto_primary_no_new_array _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce5 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_app_list_class_body_declaration_ = 
# 737 "src/java/jSourceParser.mly"
    ( [] )
# 5131 "src/java/jSourceParser.ml"
     in
    _menhir_goto_app_list_class_body_declaration_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run113 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1091) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_class_member_declaration = 
# 205 "src/java/jSourceParser.mly"
    ( [] )
# 5145 "src/java/jSourceParser.ml"
     in
    _menhir_goto_class_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1092)

and _menhir_run114 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5152 "src/java/jSourceParser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack)
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1087 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5166 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState115 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PRIMTYPE ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState115
        | RPAREN ->
            _menhir_reduce160 _menhir_env (Obj.magic _menhir_stack) MenhirState115
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState115) : 'freshtv1088)
    | IDENT _ | LSBRACKET ->
        _menhir_reduce89 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1089 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5190 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1090)

and _menhir_reduce177 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_option_class_body_ = 
# 114 "<standard.mly>"
    ( None )
# 5200 "src/java/jSourceParser.ml"
     in
    _menhir_goto_option_class_body_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_option_argument_list_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_argument_list_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv1085 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5211 "src/java/jSourceParser.ml"
    ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_option_argument_list_) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1081 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5221 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_option_argument_list_) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACKET ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState434 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COMMA | RBRACKET | SEMICOLON ->
            _menhir_reduce177 _menhir_env (Obj.magic _menhir_stack) MenhirState434
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState434) : 'freshtv1082)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv1083 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5241 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_option_argument_list_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1084)) : 'freshtv1086)

and _menhir_goto_loption_block_statements_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_block_statements_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState200 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1059 * _menhir_state * Lexing.position) * _menhir_state * 'tv_loption_block_statements_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1055 * _menhir_state * Lexing.position) * _menhir_state * 'tv_loption_block_statements_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1053 * _menhir_state * Lexing.position) * _menhir_state * 'tv_loption_block_statements_) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, _startpos__1_), _, (_2 : 'tv_loption_block_statements_)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_block = 
# 275 "src/java/jSourceParser.mly"
    ( _2 )
# 5268 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1051) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_block) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            match _menhir_s with
            | MenhirState208 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1011 * _menhir_state) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | CATCH ->
                    _menhir_run210 _menhir_env (Obj.magic _menhir_stack) MenhirState209
                | FINALLY ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1009) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = MenhirState209 in
                    ((let _v : 'tv_loption_catches_ = 
# 142 "<standard.mly>"
    ( [] )
# 5291 "src/java/jSourceParser.ml"
                     in
                    _menhir_goto_loption_catches_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1010)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState209) : 'freshtv1012)
            | MenhirState219 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv1021 * _menhir_state)) * _menhir_state * 'tv_catch_formal_parameter)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv1019 * _menhir_state)) * _menhir_state * 'tv_catch_formal_parameter)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (((_menhir_stack, _menhir_s), _, (_3 : 'tv_catch_formal_parameter)), _, (_5 : 'tv_block)) = _menhir_stack in
                let _4 = () in
                let _2 = () in
                let _1 = () in
                let _v : 'tv_catch_clause = 
# 446 "src/java/jSourceParser.mly"
    ( _5 )
# 5310 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1017) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_catch_clause) = _v in
                ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
                match _menhir_s with
                | MenhirState209 ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1013 * _menhir_state * 'tv_catch_clause) = Obj.magic _menhir_stack in
                    ((assert (not _menhir_env._menhir_error);
                    let _tok = _menhir_env._menhir_token in
                    match _tok with
                    | CATCH ->
                        _menhir_run210 _menhir_env (Obj.magic _menhir_stack) MenhirState226
                    | ASSERT | BREAK | CHAR _ | CLASS | CONTINUE | DO | ELSE | ENUM | FALSE | FINALLY | FLOATINGPOINT _ | FOR | IDENT _ | IF | INCR_DECR | INTEGER _ | LBRACKET | LPAREN | NEW | NULL | PRIMTYPE | RBRACKET | RETURN | SEMICOLON | STRING _ | SYNCHRONIZED | THIS | THROW | TRUE | TRY | VAR | WHILE | YIELD ->
                        _menhir_reduce3 _menhir_env (Obj.magic _menhir_stack) MenhirState226
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState226) : 'freshtv1014)
                | MenhirState227 | MenhirState226 ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv1015 * _menhir_state * 'tv_catch_clause) = Obj.magic _menhir_stack in
                    ((assert (not _menhir_env._menhir_error);
                    let _tok = _menhir_env._menhir_token in
                    match _tok with
                    | CATCH ->
                        _menhir_run210 _menhir_env (Obj.magic _menhir_stack) MenhirState227
                    | ASSERT | BREAK | CHAR _ | CLASS | CONTINUE | DO | ELSE | ENUM | FALSE | FINALLY | FLOATINGPOINT _ | FOR | IDENT _ | IF | INCR_DECR | INTEGER _ | LBRACKET | LPAREN | NEW | NULL | PRIMTYPE | RBRACKET | RETURN | SEMICOLON | STRING _ | SYNCHRONIZED | THIS | THROW | TRUE | TRY | VAR | WHILE | YIELD ->
                        _menhir_reduce3 _menhir_env (Obj.magic _menhir_stack) MenhirState227
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState227) : 'freshtv1016)
                | _ ->
                    _menhir_fail ()) : 'freshtv1018)) : 'freshtv1020)) : 'freshtv1022)
            | MenhirState222 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1031) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1029) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _, (_2 : 'tv_block)) = _menhir_stack in
                let _1 = () in
                let _v : 'tv_finally = 
# 458 "src/java/jSourceParser.mly"
    ( _2 )
# 5358 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1027) = _menhir_stack in
                let (_v : 'tv_finally) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv1025 * _menhir_state) * _menhir_state * 'tv_block) * _menhir_state * 'tv_loption_catches_) = Obj.magic _menhir_stack in
                let (_v : 'tv_finally) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv1023 * _menhir_state) * _menhir_state * 'tv_block) * _menhir_state * 'tv_loption_catches_) = Obj.magic _menhir_stack in
                let ((_4 : 'tv_finally) : 'tv_finally) = _v in
                ((let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_block)), _, (_3 : 'tv_loption_catches_)) = _menhir_stack in
                let _1 = () in
                let _v : 'tv_try_statement = 
# 438 "src/java/jSourceParser.mly"
    ( _2 @ _3 @ _4 )
# 5374 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_try_statement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1024)) : 'freshtv1026)) : 'freshtv1028)) : 'freshtv1030)) : 'freshtv1032)
            | MenhirState237 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv1041 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv1039 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (((_menhir_stack, _menhir_s), _, (_3 : 'tv_expression)), _, (_5 : 'tv_block)) = _menhir_stack in
                let _4 = () in
                let _2 = () in
                let _1 = () in
                let _v : 'tv_synchronized_statement = 
# 432 "src/java/jSourceParser.mly"
    ( _3 )
# 5389 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1037) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_synchronized_statement) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1035) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_synchronized_statement) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1033) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_synchronized_statement) : 'tv_synchronized_statement) = _v in
                ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 5406 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1034)) : 'freshtv1036)) : 'freshtv1038)) : 'freshtv1040)) : 'freshtv1042)
            | MenhirState388 | MenhirState200 | MenhirState376 | MenhirState377 | MenhirState207 | MenhirState252 | MenhirState365 | MenhirState256 | MenhirState260 | MenhirState358 | MenhirState355 | MenhirState280 | MenhirState281 | MenhirState332 | MenhirState289 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1045 * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1043 * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, (_1 : 'tv_block)) = _menhir_stack in
                let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 5418 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1044)) : 'freshtv1046)
            | MenhirState453 | MenhirState198 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1049 * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv1047 * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, (_1 : 'tv_block)) = _menhir_stack in
                let _v : 'tv_method_body = 
# 269 "src/java/jSourceParser.mly"
    ( _1 )
# 5430 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_method_body _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1048)) : 'freshtv1050)
            | _ ->
                _menhir_fail ()) : 'freshtv1052)) : 'freshtv1054)) : 'freshtv1056)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1057 * _menhir_state * Lexing.position) * _menhir_state * 'tv_loption_block_statements_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1058)) : 'freshtv1060)
    | MenhirState388 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv1079 * Lexing.position) * _menhir_state * 'tv_loption_block_statements_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1075 * Lexing.position) * _menhir_state * 'tv_loption_block_statements_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1073 * Lexing.position) * _menhir_state * 'tv_loption_block_statements_) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _startpos__1_), _, (inner : 'tv_loption_block_statements_)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_constructor_body = 
# 191 "src/java/jSourceParser.mly"
    ( inner )
# 5460 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1071) = _menhir_stack in
            let (_v : 'tv_constructor_body) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1069 * _menhir_state * 'tv_constructor_declarator) * _menhir_state * 'tv_option_throws_) = Obj.magic _menhir_stack in
            let (_v : 'tv_constructor_body) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1067 * _menhir_state * 'tv_constructor_declarator) * _menhir_state * 'tv_option_throws_) = Obj.magic _menhir_stack in
            let ((inner : 'tv_constructor_body) : 'tv_constructor_body) = _v in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_constructor_declarator)), _, (_2 : 'tv_option_throws_)) = _menhir_stack in
            let _v : 'tv_constructor_declaration = 
# 183 "src/java/jSourceParser.mly"
    ( inner )
# 5475 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1065) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_constructor_declaration) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1063) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_constructor_declaration) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1061) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_constructor_declaration) : 'tv_constructor_declaration) = _v in
            ((let _v : 'tv_class_body_declaration = 
# 179 "src/java/jSourceParser.mly"
    ( _1 )
# 5492 "src/java/jSourceParser.ml"
             in
            _menhir_goto_class_body_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1062)) : 'freshtv1064)) : 'freshtv1066)) : 'freshtv1068)) : 'freshtv1070)) : 'freshtv1072)) : 'freshtv1074)) : 'freshtv1076)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv1077 * Lexing.position) * _menhir_state * 'tv_loption_block_statements_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1078)) : 'freshtv1080)
    | _ ->
        _menhir_fail ()

and _menhir_goto_statement_without_trailing_substatement : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_statement_without_trailing_substatement -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState207 | MenhirState365 | MenhirState281 | MenhirState332 | MenhirState289 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1001 * _menhir_state * 'tv_statement_without_trailing_substatement) = Obj.magic _menhir_stack in
        (_menhir_reduce216 _menhir_env (Obj.magic _menhir_stack) : 'freshtv1002)
    | MenhirState252 | MenhirState256 | MenhirState358 | MenhirState260 | MenhirState355 | MenhirState280 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1007 * _menhir_state * 'tv_statement_without_trailing_substatement) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ELSE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1003 * _menhir_state * 'tv_statement_without_trailing_substatement) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_statement_without_trailing_substatement)) = _menhir_stack in
            let _v : 'tv_statement_no_short_if = 
# 366 "src/java/jSourceParser.mly"
    ( _1 )
# 5526 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_no_short_if _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1004)
        | ASSERT | BREAK | CHAR _ | CLASS | CONTINUE | DO | ENUM | FALSE | FLOATINGPOINT _ | FOR | IDENT _ | IF | INCR_DECR | INTEGER _ | LBRACKET | LPAREN | NEW | NULL | PRIMTYPE | RBRACKET | RETURN | SEMICOLON | STRING _ | SYNCHRONIZED | THIS | THROW | TRUE | TRY | VAR | WHILE | YIELD ->
            _menhir_reduce216 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1005 * _menhir_state * 'tv_statement_without_trailing_substatement) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv1006)) : 'freshtv1008)
    | _ ->
        _menhir_fail ()

and _menhir_reduce154 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_loption_expression_ = 
# 142 "<standard.mly>"
    ( [] )
# 5546 "src/java/jSourceParser.ml"
     in
    _menhir_goto_loption_expression_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce156 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_loption_for_init_ = 
# 142 "<standard.mly>"
    ( [] )
# 5555 "src/java/jSourceParser.ml"
     in
    _menhir_goto_loption_for_init_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce181 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_option_identifier_ = 
# 114 "<standard.mly>"
    ( None )
# 5564 "src/java/jSourceParser.ml"
     in
    _menhir_goto_option_identifier_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run291 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5571 "src/java/jSourceParser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv999) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5581 "src/java/jSourceParser.ml"
    )) : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5585 "src/java/jSourceParser.ml"
    )) = _v in
    let (_startpos_id_ : Lexing.position) = _startpos in
    ((let _v : 'tv_option_identifier_ = let x = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 5591 "src/java/jSourceParser.ml"
     in
    
# 116 "<standard.mly>"
    ( Some x )
# 5596 "src/java/jSourceParser.ml"
     in
    _menhir_goto_option_identifier_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv1000)

and _menhir_run199 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv997) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_method_body = 
# 271 "src/java/jSourceParser.mly"
    ( [] )
# 5610 "src/java/jSourceParser.ml"
     in
    _menhir_goto_method_body _menhir_env _menhir_stack _menhir_s _v) : 'freshtv998)

and _menhir_goto_conditional_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_conditional_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState73 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState91 | MenhirState100 | MenhirState401 | MenhirState106 | MenhirState205 | MenhirState250 | MenhirState254 | MenhirState258 | MenhirState353 | MenhirState275 | MenhirState340 | MenhirState337 | MenhirState330 | MenhirState285 | MenhirState297 | MenhirState300 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState138 | MenhirState146 | MenhirState150 | MenhirState178 | MenhirState157 | MenhirState161 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv991) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_conditional_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv989) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_conditional_expression) : 'tv_conditional_expression) = _v in
        ((let _v : 'tv_assignment_expression = 
# 571 "src/java/jSourceParser.mly"
    ( _1 )
# 5629 "src/java/jSourceParser.ml"
         in
        _menhir_goto_assignment_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv990)) : 'freshtv992)
    | MenhirState180 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv995 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_conditional_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv993 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_5 : 'tv_conditional_expression) : 'tv_conditional_expression) = _v in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_conditional_or_expression)), _, (_3 : 'tv_expression)) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _v : 'tv_conditional_expression = 
# 691 "src/java/jSourceParser.mly"
    ( _1 @ _3 @ _5 )
# 5647 "src/java/jSourceParser.ml"
         in
        _menhir_goto_conditional_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv994)) : 'freshtv996)
    | _ ->
        _menhir_fail ()

and _menhir_run174 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_conditional_or_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState174 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | PRIMTYPE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv987) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState174 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LSBRACKET ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState175
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState175) : 'freshtv988)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState174

and _menhir_goto_local_variable_type : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_local_variable_type -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState283 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv981 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run36 _menhir_env (Obj.magic _menhir_stack) MenhirState327 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState327) : 'freshtv982)
    | MenhirState262 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv983 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run36 _menhir_env (Obj.magic _menhir_stack) MenhirState351 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState351) : 'freshtv984)
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv985 * _menhir_state * 'tv_local_variable_type) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run36 _menhir_env (Obj.magic _menhir_stack) MenhirState369 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState369) : 'freshtv986)
    | _ ->
        _menhir_fail ()

and _menhir_run127 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5725 "src/java/jSourceParser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState127
    | LSBRACKET ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState127
    | COMMA | EQ | SEMICOLON ->
        _menhir_reduce179 _menhir_env (Obj.magic _menhir_stack) MenhirState127
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState127

and _menhir_goto_formal_parameter : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_formal_parameter -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv979 * _menhir_state * 'tv_formal_parameter) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv973 * _menhir_state * 'tv_formal_parameter) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState48 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PRIMTYPE ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState48
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState48) : 'freshtv974)
    | RPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv975 * _menhir_state * 'tv_formal_parameter) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_formal_parameter)) = _menhir_stack in
        let _v : 'tv_separated_nonempty_list_COMMA_formal_parameter_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 5772 "src/java/jSourceParser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_formal_parameter_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv976)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv977 * _menhir_state * 'tv_formal_parameter) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv978)) : 'freshtv980)

and _menhir_goto_app_list_interface_member_declaration_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_list_interface_member_declaration_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState456 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv937 * _menhir_state * 'tv_interface_member_declaration) * _menhir_state * 'tv_app_list_interface_member_declaration_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv935 * _menhir_state * 'tv_interface_member_declaration) * _menhir_state * 'tv_app_list_interface_member_declaration_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_interface_member_declaration)), _, (xs : 'tv_app_list_interface_member_declaration_)) = _menhir_stack in
        let _v : 'tv_app_list_interface_member_declaration_ = 
# 739 "src/java/jSourceParser.mly"
    ( x@xs )
# 5796 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_list_interface_member_declaration_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv936)) : 'freshtv938)
    | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv971 * Lexing.position) * _menhir_state * 'tv_app_list_interface_member_declaration_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv967 * Lexing.position) * _menhir_state * 'tv_app_list_interface_member_declaration_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv965 * Lexing.position) * _menhir_state * 'tv_app_list_interface_member_declaration_) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _startpos__1_), _, (_2 : 'tv_app_list_interface_member_declaration_)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_interface_body = 
# 226 "src/java/jSourceParser.mly"
    ( _2 )
# 5817 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv963) = _menhir_stack in
            let (_v : 'tv_interface_body) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv961 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5826 "src/java/jSourceParser.ml"
            ) * Lexing.position) = Obj.magic _menhir_stack in
            let (_v : 'tv_interface_body) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv959 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5833 "src/java/jSourceParser.ml"
            ) * Lexing.position) = Obj.magic _menhir_stack in
            let ((inner : 'tv_interface_body) : 'tv_interface_body) = _v in
            ((let ((_menhir_stack, _menhir_s), (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5839 "src/java/jSourceParser.ml"
            )), _startpos_id_) = _menhir_stack in
            let _1 = () in
            let _v : 'tv_normal_interface_declaration = let id = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 5845 "src/java/jSourceParser.ml"
             in
            
# 217 "src/java/jSourceParser.mly"
    ( {
        location = location_of_pos _startpos_id_;
        kind = Interface id;
        inner_elements = inner;
      }
    )
# 5855 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv957) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_normal_interface_declaration) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv955) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_normal_interface_declaration) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv953) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_normal_interface_declaration) : 'tv_normal_interface_declaration) = _v in
            ((let _v : 'tv_interface_declaration = 
# 213 "src/java/jSourceParser.mly"
    ( _1 )
# 5872 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv951) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_interface_declaration) = _v in
            ((match _menhir_s with
            | MenhirState441 | MenhirState395 | MenhirState112 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv941) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_interface_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv939) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_interface_declaration) : 'tv_interface_declaration) = _v in
                ((let _v : 'tv_class_member_declaration = 
# 200 "src/java/jSourceParser.mly"
    ( [_1] )
# 5891 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv940)) : 'freshtv942)
            | MenhirState22 | MenhirState456 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv945) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_interface_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv943) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_interface_declaration) : 'tv_interface_declaration) = _v in
                ((let _v : 'tv_interface_member_declaration = 
# 234 "src/java/jSourceParser.mly"
    ( [_1] )
# 5906 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_interface_member_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv944)) : 'freshtv946)
            | MenhirState18 | MenhirState464 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv949) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_interface_declaration) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv947) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_interface_declaration) : 'tv_interface_declaration) = _v in
                ((let _v : 'tv_type_declaration = 
# 117 "src/java/jSourceParser.mly"
    ( [_1] )
# 5921 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_type_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv948)) : 'freshtv950)
            | _ ->
                _menhir_fail ()) : 'freshtv952)) : 'freshtv954)) : 'freshtv956)) : 'freshtv958)) : 'freshtv960)) : 'freshtv962)) : 'freshtv964)) : 'freshtv966)) : 'freshtv968)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv969 * Lexing.position) * _menhir_state * 'tv_app_list_interface_member_declaration_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv970)) : 'freshtv972)
    | _ ->
        _menhir_fail ()

and _menhir_run25 : _menhir_env -> 'ttv_tail * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 5939 "src/java/jSourceParser.ml"
) * Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | PRIMTYPE ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | RPAREN ->
        _menhir_reduce160 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState25

and _menhir_run132 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState132 _v
    | COMMA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv929 * _menhir_state * Lexing.position) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState132 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv925 * _menhir_state * Lexing.position) * _menhir_state) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv923 * _menhir_state * Lexing.position) * _menhir_state) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, _startpos__1_), _) = _menhir_stack in
            let _3 = () in
            let _2 = () in
            let _1 = () in
            let _v : 'tv_array_initializer = 
# 510 "src/java/jSourceParser.mly"
    ( [] )
# 5990 "src/java/jSourceParser.ml"
             in
            _menhir_goto_array_initializer _menhir_env _menhir_stack _menhir_s _v) : 'freshtv924)) : 'freshtv926)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv927 * _menhir_state * Lexing.position) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv928)) : 'freshtv930)
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState132 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState132 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState132 _v
    | LBRACKET ->
        _menhir_run132 _menhir_env (Obj.magic _menhir_stack) MenhirState132 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | RBRACKET ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv933 * _menhir_state * Lexing.position) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState132 in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv931 * _menhir_state * Lexing.position) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        ((let (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_array_initializer = 
# 510 "src/java/jSourceParser.mly"
    ( [] )
# 6032 "src/java/jSourceParser.ml"
         in
        _menhir_goto_array_initializer _menhir_env _menhir_stack _menhir_s _v) : 'freshtv932)) : 'freshtv934)
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState132 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState132
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState132

and _menhir_goto_option_dims_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_dims_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState127 | MenhirState36 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv911 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6056 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_option_dims_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv909 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6064 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_option_dims_) : 'tv_option_dims_) = _v in
        ((let (_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6071 "src/java/jSourceParser.ml"
        )), _startpos_id_) = _menhir_stack in
        let _v : 'tv_variable_declarator_id = let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 6076 "src/java/jSourceParser.ml"
         in
        
# 500 "src/java/jSourceParser.mly"
    ()
# 6081 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv907) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_variable_declarator_id) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        match _menhir_s with
        | MenhirState33 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv877 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv875 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_unann_type)), _, (_2 : 'tv_variable_declarator_id)) = _menhir_stack in
            let _v : 'tv_formal_parameter = 
# 261 "src/java/jSourceParser.mly"
    ()
# 6098 "src/java/jSourceParser.ml"
             in
            _menhir_goto_formal_parameter _menhir_env _menhir_stack _menhir_s _v) : 'freshtv876)) : 'freshtv878)
        | MenhirState450 | MenhirState369 | MenhirState191 | MenhirState126 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv881 * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | EQ ->
                _menhir_run131 _menhir_env (Obj.magic _menhir_stack)
            | COMMA | SEMICOLON ->
                _menhir_reduce267 _menhir_env (Obj.magic _menhir_stack)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv879 * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv880)) : 'freshtv882)
        | MenhirState216 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv893 * _menhir_state * 'tv_catch_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv891 * _menhir_state * 'tv_catch_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_catch_type)), _, (_2 : 'tv_variable_declarator_id)) = _menhir_stack in
            let _v : 'tv_catch_formal_parameter = 
# 450 "src/java/jSourceParser.mly"
    ()
# 6127 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv889) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_catch_formal_parameter) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv887 * _menhir_state)) * _menhir_state * 'tv_catch_formal_parameter) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | RPAREN ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv883 * _menhir_state)) * _menhir_state * 'tv_catch_formal_parameter) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | LBRACKET ->
                    _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState219 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState219) : 'freshtv884)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv885 * _menhir_state)) * _menhir_state * 'tv_catch_formal_parameter) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv886)) : 'freshtv888)) : 'freshtv890)) : 'freshtv892)) : 'freshtv894)
        | MenhirState327 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv899 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | COLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv895 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | BANG ->
                    _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | BINOP ->
                    _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | CHAR _v ->
                    _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState330 _v
                | FALSE ->
                    _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | FLOATINGPOINT _v ->
                    _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState330 _v
                | IDENT _v ->
                    _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState330 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INCR_DECR ->
                    _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | INTEGER _v ->
                    _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState330 _v
                | LPAREN ->
                    _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | NEW ->
                    _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | NULL ->
                    _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | STRING _v ->
                    _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState330 _v
                | THIS ->
                    _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | TILDE ->
                    _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | TRUE ->
                    _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState330) : 'freshtv896)
            | EQ ->
                _menhir_run131 _menhir_env (Obj.magic _menhir_stack)
            | COMMA | SEMICOLON ->
                _menhir_reduce267 _menhir_env (Obj.magic _menhir_stack)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv897 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv898)) : 'freshtv900)
        | MenhirState351 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv905 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | COLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv901 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | BANG ->
                    _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | BINOP ->
                    _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | CHAR _v ->
                    _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState353 _v
                | FALSE ->
                    _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | FLOATINGPOINT _v ->
                    _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState353 _v
                | IDENT _v ->
                    _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState353 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INCR_DECR ->
                    _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | INTEGER _v ->
                    _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState353 _v
                | LPAREN ->
                    _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | NEW ->
                    _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | NULL ->
                    _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | STRING _v ->
                    _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState353 _v
                | THIS ->
                    _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | TILDE ->
                    _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | TRUE ->
                    _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState353
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState353) : 'freshtv902)
            | EQ ->
                _menhir_run131 _menhir_env (Obj.magic _menhir_stack)
            | COMMA | SEMICOLON ->
                _menhir_reduce267 _menhir_env (Obj.magic _menhir_stack)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv903 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv904)) : 'freshtv906)
        | _ ->
            _menhir_fail ()) : 'freshtv908)) : 'freshtv910)) : 'freshtv912)
    | MenhirState45 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv921 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6279 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_formal_parameter_list)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_option_dims_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv919 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6287 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_formal_parameter_list)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_5 : 'tv_option_dims_) : 'tv_option_dims_) = _v in
        ((let (((_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6294 "src/java/jSourceParser.ml"
        )), _startpos_id_), _), _, (_3 : 'tv_formal_parameter_list)) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _v : 'tv_method_declarator = let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 6301 "src/java/jSourceParser.ml"
         in
        
# 252 "src/java/jSourceParser.mly"
    ()
# 6306 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv917) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_method_declarator) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        match _menhir_s with
        | MenhirState23 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv913 * _menhir_state) * _menhir_state * 'tv_method_declarator) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | THROWS ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | LBRACKET | SEMICOLON ->
                _menhir_reduce189 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState52) : 'freshtv914)
        | MenhirState450 | MenhirState126 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv915 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_method_declarator) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | THROWS ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState193
            | LBRACKET | SEMICOLON ->
                _menhir_reduce189 _menhir_env (Obj.magic _menhir_stack) MenhirState193
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState193) : 'freshtv916)
        | _ ->
            _menhir_fail ()) : 'freshtv918)) : 'freshtv920)) : 'freshtv922)
    | _ ->
        _menhir_fail ()

and _menhir_goto_unann_array_type : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_unann_array_type -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv873) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_unann_array_type) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv871) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_unann_array_type) : 'tv_unann_array_type) = _v in
    ((let _v : 'tv_unann_reference_type = 
# 529 "src/java/jSourceParser.mly"
    ()
# 6360 "src/java/jSourceParser.ml"
     in
    _menhir_goto_unann_reference_type _menhir_env _menhir_stack _menhir_s _v) : 'freshtv872)) : 'freshtv874)

and _menhir_reduce179 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_option_dims_ = 
# 114 "<standard.mly>"
    ( None )
# 6369 "src/java/jSourceParser.ml"
     in
    _menhir_goto_option_dims_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_assignment_operator : _menhir_env -> 'ttv_tail -> 'tv_assignment_operator -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv869 * _menhir_state * 'tv_left_hand_side) * 'tv_assignment_operator) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState146
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState146) : 'freshtv870)

and _menhir_goto_statement_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_statement_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState287 | MenhirState283 | MenhirState277 | MenhirState267 | MenhirState262 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv853 * _menhir_state * 'tv_statement_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv847 * _menhir_state * 'tv_statement_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState267 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState267
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState267 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState267 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState267
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState267 _v
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState267
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState267
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState267
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState267 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState267
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState267
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState267) : 'freshtv848)
        | RPAREN | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv849 * _menhir_state * 'tv_statement_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_statement_expression)) = _menhir_stack in
            let _v : 'tv_app_separated_non_empty_list_COMMA_statement_expression_ = 
# 751 "src/java/jSourceParser.mly"
    ( x )
# 6467 "src/java/jSourceParser.ml"
             in
            _menhir_goto_app_separated_non_empty_list_COMMA_statement_expression_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv850)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv851 * _menhir_state * 'tv_statement_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv852)) : 'freshtv854)
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState207 | MenhirState252 | MenhirState365 | MenhirState256 | MenhirState260 | MenhirState358 | MenhirState355 | MenhirState280 | MenhirState281 | MenhirState332 | MenhirState289 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv867 * _menhir_state * 'tv_statement_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv863 * _menhir_state * 'tv_statement_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv861 * _menhir_state * 'tv_statement_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_statement_expression)) = _menhir_stack in
            let _2 = () in
            let _v : 'tv_expression_statement = 
# 397 "src/java/jSourceParser.mly"
    ( _1 )
# 6494 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv859) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_expression_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv857) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_expression_statement) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv855) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_expression_statement) : 'tv_expression_statement) = _v in
            ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 6511 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv856)) : 'freshtv858)) : 'freshtv860)) : 'freshtv862)) : 'freshtv864)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv865 * _menhir_state * 'tv_statement_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv866)) : 'freshtv868)
    | _ ->
        _menhir_fail ()

and _menhir_goto_unary_expression_not_plus_minus : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_unary_expression_not_plus_minus -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv845) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_unary_expression_not_plus_minus) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv843) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_unary_expression_not_plus_minus) : 'tv_unary_expression_not_plus_minus) = _v in
    ((let _v : 'tv_unary_expression = 
# 711 "src/java/jSourceParser.mly"
    ( _1 )
# 6537 "src/java/jSourceParser.ml"
     in
    _menhir_goto_unary_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv844)) : 'freshtv846)

and _menhir_reduce194 : _menhir_env -> ('ttv_tail * _menhir_state * 'tv_postfix_expression) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_postfix_expression)) = _menhir_stack in
    let _2 = () in
    let _v : 'tv_postfix_expression = 
# 733 "src/java/jSourceParser.mly"
    ( _1 )
# 6548 "src/java/jSourceParser.ml"
     in
    _menhir_goto_postfix_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_method_invocation : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_method_invocation -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState73 | MenhirState75 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState84 | MenhirState86 | MenhirState91 | MenhirState95 | MenhirState96 | MenhirState100 | MenhirState401 | MenhirState353 | MenhirState340 | MenhirState337 | MenhirState330 | MenhirState300 | MenhirState297 | MenhirState285 | MenhirState275 | MenhirState258 | MenhirState254 | MenhirState250 | MenhirState247 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState205 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState184 | MenhirState182 | MenhirState180 | MenhirState178 | MenhirState161 | MenhirState157 | MenhirState154 | MenhirState150 | MenhirState146 | MenhirState138 | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv835 * _menhir_state * 'tv_method_invocation) = Obj.magic _menhir_stack in
        (_menhir_reduce204 _menhir_env (Obj.magic _menhir_stack) : 'freshtv836)
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState207 | MenhirState252 | MenhirState365 | MenhirState256 | MenhirState260 | MenhirState358 | MenhirState355 | MenhirState280 | MenhirState281 | MenhirState332 | MenhirState289 | MenhirState287 | MenhirState283 | MenhirState277 | MenhirState262 | MenhirState267 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv841 * _menhir_state * 'tv_method_invocation) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA | RPAREN | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv837 * _menhir_state * 'tv_method_invocation) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_method_invocation)) = _menhir_stack in
            let _v : 'tv_statement_expression = 
# 406 "src/java/jSourceParser.mly"
    ( _1 )
# 6573 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv838)
        | DOT | INCR_DECR | LSBRACKET ->
            _menhir_reduce204 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv839 * _menhir_state * 'tv_method_invocation) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv840)) : 'freshtv842)
    | _ ->
        _menhir_fail ()

and _menhir_goto_class_instance_creation_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_class_instance_creation_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState73 | MenhirState75 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState84 | MenhirState86 | MenhirState91 | MenhirState95 | MenhirState96 | MenhirState100 | MenhirState401 | MenhirState106 | MenhirState205 | MenhirState250 | MenhirState254 | MenhirState258 | MenhirState353 | MenhirState275 | MenhirState340 | MenhirState337 | MenhirState330 | MenhirState285 | MenhirState297 | MenhirState300 | MenhirState247 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState138 | MenhirState146 | MenhirState150 | MenhirState184 | MenhirState182 | MenhirState178 | MenhirState180 | MenhirState154 | MenhirState157 | MenhirState161 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv827 * _menhir_state * 'tv_class_instance_creation_expression) = Obj.magic _menhir_stack in
        (_menhir_reduce201 _menhir_env (Obj.magic _menhir_stack) : 'freshtv828)
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState207 | MenhirState252 | MenhirState365 | MenhirState256 | MenhirState260 | MenhirState358 | MenhirState262 | MenhirState355 | MenhirState277 | MenhirState280 | MenhirState281 | MenhirState283 | MenhirState332 | MenhirState287 | MenhirState289 | MenhirState267 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv833 * _menhir_state * 'tv_class_instance_creation_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA | RPAREN | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv829 * _menhir_state * 'tv_class_instance_creation_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_class_instance_creation_expression)) = _menhir_stack in
            let _v : 'tv_statement_expression = 
# 406 "src/java/jSourceParser.mly"
    ( _1 )
# 6609 "src/java/jSourceParser.ml"
             in
            _menhir_goto_statement_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv830)
        | DOT | INCR_DECR | LSBRACKET ->
            _menhir_reduce201 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv831 * _menhir_state * 'tv_class_instance_creation_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv832)) : 'freshtv834)
    | _ ->
        _menhir_fail ()

and _menhir_goto_primary : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_primary -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv825 * _menhir_state * 'tv_primary) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv819 * _menhir_state * 'tv_primary) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv813 * _menhir_state * 'tv_primary)) = Obj.magic _menhir_stack in
            let (_v : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6644 "src/java/jSourceParser.ml"
            )) = _v in
            let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            ((let _menhir_stack = (_menhir_stack, _v, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LPAREN ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv797 * _menhir_state * 'tv_primary)) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6656 "src/java/jSourceParser.ml"
                ) * Lexing.position) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | BANG ->
                    _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | BINOP ->
                    _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | CHAR _v ->
                    _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState401 _v
                | FALSE ->
                    _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | FLOATINGPOINT _v ->
                    _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState401 _v
                | IDENT _v ->
                    _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState401 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INCR_DECR ->
                    _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | INTEGER _v ->
                    _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState401 _v
                | LPAREN ->
                    _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | NEW ->
                    _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | NULL ->
                    _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | STRING _v ->
                    _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState401 _v
                | THIS ->
                    _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | TILDE ->
                    _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | TRUE ->
                    _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | RPAREN ->
                    _menhir_reduce148 _menhir_env (Obj.magic _menhir_stack) MenhirState401
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState401) : 'freshtv798)
            | ASSIGNOP | BINOP | COLON | COMMA | DOT | EQ | INCR_DECR | INSTANCEOF | LANGLE | LSBRACKET | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv809 * _menhir_state * 'tv_primary)) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6702 "src/java/jSourceParser.ml"
                ) * Lexing.position) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_primary)), (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6707 "src/java/jSourceParser.ml"
                )), _startpos_id_) = _menhir_stack in
                let _2 = () in
                let _v : 'tv_field_access = let _3 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 6713 "src/java/jSourceParser.ml"
                 in
                
# 591 "src/java/jSourceParser.mly"
    ( _1 )
# 6718 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv807) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_field_access) = _v in
                ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
                match _menhir_s with
                | MenhirState73 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState91 | MenhirState100 | MenhirState401 | MenhirState106 | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState207 | MenhirState252 | MenhirState365 | MenhirState256 | MenhirState260 | MenhirState358 | MenhirState262 | MenhirState355 | MenhirState353 | MenhirState275 | MenhirState277 | MenhirState280 | MenhirState281 | MenhirState340 | MenhirState337 | MenhirState283 | MenhirState332 | MenhirState330 | MenhirState285 | MenhirState287 | MenhirState289 | MenhirState300 | MenhirState297 | MenhirState267 | MenhirState258 | MenhirState254 | MenhirState250 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState205 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState138 | MenhirState178 | MenhirState161 | MenhirState157 | MenhirState150 | MenhirState146 ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv803 * _menhir_state * 'tv_field_access) = Obj.magic _menhir_stack in
                    ((assert (not _menhir_env._menhir_error);
                    let _tok = _menhir_env._menhir_token in
                    match _tok with
                    | BINOP | COLON | COMMA | DOT | INCR_DECR | INSTANCEOF | LANGLE | LSBRACKET | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
                        _menhir_reduce202 _menhir_env (Obj.magic _menhir_stack)
                    | ASSIGNOP | EQ ->
                        let (_menhir_env : _menhir_env) = _menhir_env in
                        let (_menhir_stack : 'freshtv799 * _menhir_state * 'tv_field_access) = Obj.magic _menhir_stack in
                        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_field_access)) = _menhir_stack in
                        let _v : 'tv_left_hand_side = 
# 587 "src/java/jSourceParser.mly"
    ( _1 )
# 6741 "src/java/jSourceParser.ml"
                         in
                        _menhir_goto_left_hand_side _menhir_env _menhir_stack _menhir_s _v) : 'freshtv800)
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        let (_menhir_env : _menhir_env) = _menhir_env in
                        let (_menhir_stack : 'freshtv801 * _menhir_state * 'tv_field_access) = Obj.magic _menhir_stack in
                        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv802)) : 'freshtv804)
                | MenhirState75 | MenhirState84 | MenhirState86 | MenhirState95 | MenhirState96 | MenhirState247 | MenhirState184 | MenhirState182 | MenhirState180 | MenhirState154 ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv805 * _menhir_state * 'tv_field_access) = Obj.magic _menhir_stack in
                    (_menhir_reduce202 _menhir_env (Obj.magic _menhir_stack) : 'freshtv806)
                | _ ->
                    _menhir_fail ()) : 'freshtv808)) : 'freshtv810)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv811 * _menhir_state * 'tv_primary)) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6764 "src/java/jSourceParser.ml"
                ) * Lexing.position) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, _menhir_s, _), _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv812)) : 'freshtv814)
        | NEW ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv815 * _menhir_state * 'tv_primary)) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState104 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState104) : 'freshtv816)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv817 * _menhir_state * 'tv_primary)) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv818)) : 'freshtv820)
    | BINOP | COLON | COMMA | INCR_DECR | INSTANCEOF | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv821 * _menhir_state * 'tv_primary) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_primary)) = _menhir_stack in
        let _v : 'tv_postfix_expression = 
# 729 "src/java/jSourceParser.mly"
    ( _1 )
# 6794 "src/java/jSourceParser.ml"
         in
        _menhir_goto_postfix_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv822)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv823 * _menhir_state * 'tv_primary) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv824)) : 'freshtv826)

and _menhir_run112 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CLASS ->
        _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | ENUM ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | IDENT _v ->
        _menhir_run114 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTERFACE ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | PRIMTYPE ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | SEMICOLON ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | VOID ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | RBRACKET ->
        _menhir_reduce5 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112

and _menhir_run72 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6835 "src/java/jSourceParser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LBRACKET ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv795 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 6849 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState72 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BANG ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | BINOP ->
            _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
        | LPAREN ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | TILDE ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState73
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv793) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState73 in
            ((let _v : 'tv_option_argument_list_ = 
# 114 "<standard.mly>"
    ( None )
# 6893 "src/java/jSourceParser.ml"
             in
            _menhir_goto_option_argument_list_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv794)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState73) : 'freshtv796)
    | COMMA | RBRACKET | SEMICOLON ->
        _menhir_reduce177 _menhir_env (Obj.magic _menhir_stack) MenhirState72
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState72

and _menhir_reduce150 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_loption_block_statements_ = 
# 142 "<standard.mly>"
    ( [] )
# 6912 "src/java/jSourceParser.ml"
     in
    _menhir_goto_loption_block_statements_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run201 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState201 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState201 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState201 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState201 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState201 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState201
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState201

and _menhir_run204 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv789 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BANG ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | BINOP ->
            _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _v
        | LPAREN ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState205 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | TILDE ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState205
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState205) : 'freshtv790)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv791 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv792)

and _menhir_run263 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv787) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_local_variable_type = 
# 299 "src/java/jSourceParser.mly"
    ()
# 7021 "src/java/jSourceParser.ml"
     in
    _menhir_goto_local_variable_type _menhir_env _menhir_stack _menhir_s _v) : 'freshtv788)

and _menhir_run208 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LBRACKET ->
        _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState208 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState208

and _menhir_run231 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState231 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState231
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState231

and _menhir_run234 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv783 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BANG ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | BINOP ->
            _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _v
        | LPAREN ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | TILDE ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState235
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState235) : 'freshtv784)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv785 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv786)

and _menhir_run239 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv781) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_empty_statement = 
# 393 "src/java/jSourceParser.mly"
    ( [] )
# 7143 "src/java/jSourceParser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv779) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_empty_statement) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv777) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_empty_statement) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv775) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_empty_statement) : 'tv_empty_statement) = _v in
    ((let _v : 'tv_statement_without_trailing_substatement = 
# 389 "src/java/jSourceParser.mly"
    ( _1 )
# 7160 "src/java/jSourceParser.ml"
     in
    _menhir_goto_statement_without_trailing_substatement _menhir_env _menhir_stack _menhir_s _v) : 'freshtv776)) : 'freshtv778)) : 'freshtv780)) : 'freshtv782)

and _menhir_run240 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState240 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState240 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState240 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState240 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState240 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | SEMICOLON ->
        _menhir_reduce154 _menhir_env (Obj.magic _menhir_stack) MenhirState240
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState240

and _menhir_run244 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState244 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState244 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState244 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState244 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState244 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState244
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState244

and _menhir_run200 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSERT ->
        _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | BREAK ->
        _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _v
    | CLASS ->
        _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | CONTINUE ->
        _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | DO ->
        _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | ENUM ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _v
    | FOR ->
        _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | INCR_DECR ->
        _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _v
    | LBRACKET ->
        _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LPAREN ->
        _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | PRIMTYPE ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | RETURN ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | SEMICOLON ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _v
    | SYNCHRONIZED ->
        _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | THROW ->
        _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | TRY ->
        _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | VAR ->
        _menhir_run263 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | WHILE ->
        _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | YIELD ->
        _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | RBRACKET ->
        _menhir_reduce150 _menhir_env (Obj.magic _menhir_stack) MenhirState200
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState200

and _menhir_run247 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState247
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState247

and _menhir_run249 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv771 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BANG ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | BINOP ->
            _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
        | LPAREN ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState250 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | TILDE ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState250
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState250) : 'freshtv772)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv773 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv774)

and _menhir_run282 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv767 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState283 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState283 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState283 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState283 _v
        | LPAREN ->
            _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | PRIMTYPE ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState283 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | VAR ->
            _menhir_run263 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | SEMICOLON ->
            _menhir_reduce156 _menhir_env (Obj.magic _menhir_stack) MenhirState283
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState283) : 'freshtv768)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv769 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv770)

and _menhir_run281 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSERT ->
        _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | BREAK ->
        _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState281 _v
    | CONTINUE ->
        _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | DO ->
        _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState281 _v
    | FOR ->
        _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState281 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | INCR_DECR ->
        _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState281 _v
    | LBRACKET ->
        _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState281 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LPAREN ->
        _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | RETURN ->
        _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | SEMICOLON ->
        _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState281 _v
    | SYNCHRONIZED ->
        _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | THROW ->
        _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | TRY ->
        _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | WHILE ->
        _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | YIELD ->
        _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState281
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState281

and _menhir_run290 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run291 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | SEMICOLON ->
        _menhir_reduce181 _menhir_env (Obj.magic _menhir_stack) MenhirState290
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState290

and _menhir_run294 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run291 _menhir_env (Obj.magic _menhir_stack) MenhirState294 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | SEMICOLON ->
        _menhir_reduce181 _menhir_env (Obj.magic _menhir_stack) MenhirState294
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState294

and _menhir_run297 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState297 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState297 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState297 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState297 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState297 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState297
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState297

and _menhir_goto_method_header : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_method_header -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState441 | MenhirState395 | MenhirState112 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv763 * _menhir_state * 'tv_method_header) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACKET ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState198 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | SEMICOLON ->
            _menhir_run199 _menhir_env (Obj.magic _menhir_stack) MenhirState198
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState198) : 'freshtv764)
    | MenhirState456 | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv765 * _menhir_state * 'tv_method_header) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACKET ->
            _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState453 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | SEMICOLON ->
            _menhir_run199 _menhir_env (Obj.magic _menhir_stack) MenhirState453
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState453) : 'freshtv766)
    | _ ->
        _menhir_fail ()

and _menhir_goto_conditional_or_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_conditional_or_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState73 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState91 | MenhirState100 | MenhirState401 | MenhirState106 | MenhirState205 | MenhirState250 | MenhirState254 | MenhirState258 | MenhirState353 | MenhirState275 | MenhirState340 | MenhirState337 | MenhirState330 | MenhirState285 | MenhirState297 | MenhirState300 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState138 | MenhirState146 | MenhirState178 | MenhirState180 | MenhirState157 | MenhirState161 | MenhirState150 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv743 * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BINOP ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv731 * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState184 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState184 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState184 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState184 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState184 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState184
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState184) : 'freshtv732)
        | INSTANCEOF ->
            _menhir_run174 _menhir_env (Obj.magic _menhir_stack)
        | LANGLE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv733 * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState182 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState182 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState182 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState182 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState182 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState182
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState182) : 'freshtv734)
        | QMARK ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv735 * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState178 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState178
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState178) : 'freshtv736)
        | RANGLE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv737 * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState154
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState154) : 'freshtv738)
        | COLON | COMMA | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv739 * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_conditional_or_expression)) = _menhir_stack in
            let _v : 'tv_conditional_expression = 
# 689 "src/java/jSourceParser.mly"
    ( _1 )
# 7818 "src/java/jSourceParser.ml"
             in
            _menhir_goto_conditional_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv740)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv741 * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv742)) : 'freshtv744)
    | MenhirState154 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv749 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | INSTANCEOF ->
            _menhir_run174 _menhir_env (Obj.magic _menhir_stack)
        | BINOP | COLON | COMMA | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv745 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_conditional_or_expression)), _, (_3 : 'tv_conditional_or_expression)) = _menhir_stack in
            let _1_inlined1 = () in
            let _v : 'tv_conditional_or_expression = let _2 =
              let _1 = _1_inlined1 in
              
# 704 "src/java/jSourceParser.mly"
    ()
# 7846 "src/java/jSourceParser.ml"
              
            in
            
# 696 "src/java/jSourceParser.mly"
    ( _1 @ _3 )
# 7852 "src/java/jSourceParser.ml"
             in
            _menhir_goto_conditional_or_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv746)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv747 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv748)) : 'freshtv750)
    | MenhirState182 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv755 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | INSTANCEOF ->
            _menhir_run174 _menhir_env (Obj.magic _menhir_stack)
        | BINOP | COLON | COMMA | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv751 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_conditional_or_expression)), _, (_3 : 'tv_conditional_or_expression)) = _menhir_stack in
            let _1_inlined1 = () in
            let _v : 'tv_conditional_or_expression = let _2 =
              let _1 = _1_inlined1 in
              
# 704 "src/java/jSourceParser.mly"
    ()
# 7880 "src/java/jSourceParser.ml"
              
            in
            
# 696 "src/java/jSourceParser.mly"
    ( _1 @ _3 )
# 7886 "src/java/jSourceParser.ml"
             in
            _menhir_goto_conditional_or_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv752)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv753 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv754)) : 'freshtv756)
    | MenhirState184 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv761 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | INSTANCEOF ->
            _menhir_run174 _menhir_env (Obj.magic _menhir_stack)
        | BINOP | COLON | COMMA | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv757 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_conditional_or_expression)), _, (_3 : 'tv_conditional_or_expression)) = _menhir_stack in
            let _1_inlined1 = () in
            let _v : 'tv_conditional_or_expression = let _2 =
              let _1 = _1_inlined1 in
              
# 704 "src/java/jSourceParser.mly"
    ()
# 7914 "src/java/jSourceParser.ml"
              
            in
            
# 696 "src/java/jSourceParser.mly"
    ( _1 @ _3 )
# 7920 "src/java/jSourceParser.ml"
             in
            _menhir_goto_conditional_or_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv758)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv759 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_conditional_or_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv760)) : 'freshtv762)
    | _ ->
        _menhir_fail ()

and _menhir_goto_unann_type : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_unann_type -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState115 | MenhirState48 | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv721 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run36 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | THREEDOTS ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv719 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState33 in
            ((let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv715 * _menhir_state * 'tv_unann_type) * _menhir_state) = Obj.magic _menhir_stack in
                let (_v : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 7959 "src/java/jSourceParser.ml"
                )) = _v in
                let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv713 * _menhir_state * 'tv_unann_type) * _menhir_state) = Obj.magic _menhir_stack in
                let ((id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 7968 "src/java/jSourceParser.ml"
                )) : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 7972 "src/java/jSourceParser.ml"
                )) = _v in
                let (_startpos_id_ : Lexing.position) = _startpos in
                ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_unann_type)), _) = _menhir_stack in
                let _2 = () in
                let _v : 'tv_variable_arity_parameter = let _3 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 7980 "src/java/jSourceParser.ml"
                 in
                
# 265 "src/java/jSourceParser.mly"
    ()
# 7985 "src/java/jSourceParser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv711) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_variable_arity_parameter) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv709) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_variable_arity_parameter) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv707) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_variable_arity_parameter) : 'tv_variable_arity_parameter) = _v in
                ((let _v : 'tv_formal_parameter = 
# 261 "src/java/jSourceParser.mly"
    ()
# 8002 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_formal_parameter _menhir_env _menhir_stack _menhir_s _v) : 'freshtv708)) : 'freshtv710)) : 'freshtv712)) : 'freshtv714)) : 'freshtv716)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv717 * _menhir_state * 'tv_unann_type) * _menhir_state) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv718)) : 'freshtv720)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState33) : 'freshtv722)
    | MenhirState441 | MenhirState395 | MenhirState112 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv723 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run127 _menhir_env (Obj.magic _menhir_stack) MenhirState126 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState126) : 'freshtv724)
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState283 | MenhirState262 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv727 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv725 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_unann_type)) = _menhir_stack in
        let _v : 'tv_local_variable_type = 
# 299 "src/java/jSourceParser.mly"
    ()
# 8037 "src/java/jSourceParser.ml"
         in
        _menhir_goto_local_variable_type _menhir_env _menhir_stack _menhir_s _v) : 'freshtv726)) : 'freshtv728)
    | MenhirState456 | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv729 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run127 _menhir_env (Obj.magic _menhir_stack) MenhirState450 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState450) : 'freshtv730)
    | _ ->
        _menhir_fail ()

and _menhir_goto_app_list_type_declaration_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_app_list_type_declaration_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState464 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv691 * _menhir_state * 'tv_type_declaration) * _menhir_state * 'tv_app_list_type_declaration_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv689 * _menhir_state * 'tv_type_declaration) * _menhir_state * 'tv_app_list_type_declaration_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_type_declaration)), _, (xs : 'tv_app_list_type_declaration_)) = _menhir_stack in
        let _v : 'tv_app_list_type_declaration_ = 
# 739 "src/java/jSourceParser.mly"
    ( x@xs )
# 8068 "src/java/jSourceParser.ml"
         in
        _menhir_goto_app_list_type_declaration_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv690)) : 'freshtv692)
    | MenhirState18 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv705 * 'tv_option_package_declaration_) * _menhir_state * 'tv_list_import_declaration_) * _menhir_state * 'tv_app_list_type_declaration_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | EOF ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv701 * 'tv_option_package_declaration_) * _menhir_state * 'tv_list_import_declaration_) * _menhir_state * 'tv_app_list_type_declaration_) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv699 * 'tv_option_package_declaration_) * _menhir_state * 'tv_list_import_declaration_) * _menhir_state * 'tv_app_list_type_declaration_) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, (_1 : 'tv_option_package_declaration_)), _, (_2 : 'tv_list_import_declaration_)), _, (_3 : 'tv_app_list_type_declaration_)) = _menhir_stack in
            let _4 = () in
            let _v : (
# 89 "src/java/jSourceParser.mly"
       (JSourceAST.file_content)
# 8087 "src/java/jSourceParser.ml"
            ) = 
# 95 "src/java/jSourceParser.mly"
    ( { package = _1; classes = _3 } )
# 8091 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv697) = _menhir_stack in
            let (_v : (
# 89 "src/java/jSourceParser.mly"
       (JSourceAST.file_content)
# 8098 "src/java/jSourceParser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv695) = Obj.magic _menhir_stack in
            let (_v : (
# 89 "src/java/jSourceParser.mly"
       (JSourceAST.file_content)
# 8105 "src/java/jSourceParser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv693) = Obj.magic _menhir_stack in
            let ((_1 : (
# 89 "src/java/jSourceParser.mly"
       (JSourceAST.file_content)
# 8112 "src/java/jSourceParser.ml"
            )) : (
# 89 "src/java/jSourceParser.mly"
       (JSourceAST.file_content)
# 8116 "src/java/jSourceParser.ml"
            )) = _v in
            (Obj.magic _1 : 'freshtv694)) : 'freshtv696)) : 'freshtv698)) : 'freshtv700)) : 'freshtv702)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv703 * 'tv_option_package_declaration_) * _menhir_state * 'tv_list_import_declaration_) * _menhir_state * 'tv_app_list_type_declaration_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv704)) : 'freshtv706)
    | _ ->
        _menhir_fail ()

and _menhir_goto_type_declaration : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_type_declaration -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv687 * _menhir_state * 'tv_type_declaration) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CLASS ->
        _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState464
    | ENUM ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState464
    | INTERFACE ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState464
    | SEMICOLON ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState464
    | EOF ->
        _menhir_reduce11 _menhir_env (Obj.magic _menhir_stack) MenhirState464
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState464) : 'freshtv688)

and _menhir_reduce9 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_app_list_interface_member_declaration_ = 
# 737 "src/java/jSourceParser.mly"
    ( [] )
# 8157 "src/java/jSourceParser.ml"
     in
    _menhir_goto_app_list_interface_member_declaration_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run23 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv685) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState23 in
        let (_v : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8174 "src/java/jSourceParser.ml"
        )) = _v in
        let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAREN ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState24
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState24) : 'freshtv686)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState23

and _menhir_run26 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LSBRACKET ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | IDENT _ | THREEDOTS ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv683 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_unann_type = 
# 524 "src/java/jSourceParser.mly"
    ()
# 8208 "src/java/jSourceParser.ml"
         in
        _menhir_goto_unann_type _menhir_env _menhir_stack _menhir_s _v) : 'freshtv684)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState26

and _menhir_goto_nonempty_list_dim_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_nonempty_list_dim_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv659 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_nonempty_list_dim_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv657 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_nonempty_list_dim_) : 'tv_nonempty_list_dim_) = _v in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_nonempty_list_dim_ = let x = 
# 559 "src/java/jSourceParser.mly"
    ()
# 8234 "src/java/jSourceParser.ml"
         in
        
# 223 "<standard.mly>"
    ( x :: xs )
# 8239 "src/java/jSourceParser.ml"
         in
        _menhir_goto_nonempty_list_dim_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv658)) : 'freshtv660)
    | MenhirState424 | MenhirState80 | MenhirState336 | MenhirState175 | MenhirState127 | MenhirState50 | MenhirState45 | MenhirState36 | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv681) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_nonempty_list_dim_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv679) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_nonempty_list_dim_) : 'tv_nonempty_list_dim_) = _v in
        ((let _v : 'tv_dims = 
# 562 "src/java/jSourceParser.mly"
    ()
# 8254 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv677) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_dims) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        match _menhir_s with
        | MenhirState175 | MenhirState26 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv663 * _menhir_state) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv661 * _menhir_state) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (_2 : 'tv_dims)) = _menhir_stack in
            let _1 = () in
            let _v : 'tv_unann_array_type = 
# 555 "src/java/jSourceParser.mly"
    ()
# 8272 "src/java/jSourceParser.ml"
             in
            _menhir_goto_unann_array_type _menhir_env _menhir_stack _menhir_s _v) : 'freshtv662)) : 'freshtv664)
        | MenhirState127 | MenhirState45 | MenhirState36 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv667 * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv665 * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_dims)) = _menhir_stack in
            let _v : 'tv_option_dims_ = 
# 116 "<standard.mly>"
    ( Some x )
# 8284 "src/java/jSourceParser.ml"
             in
            _menhir_goto_option_dims_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv666)) : 'freshtv668)
        | MenhirState336 | MenhirState50 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv671 * _menhir_state * 'tv_dotted_name) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv669 * _menhir_state * 'tv_dotted_name) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)), _, (_2 : 'tv_dims)) = _menhir_stack in
            let _v : 'tv_unann_array_type = let _1 = 
# 541 "src/java/jSourceParser.mly"
                ( _1 )
# 8296 "src/java/jSourceParser.ml"
             in
            
# 555 "src/java/jSourceParser.mly"
    ()
# 8301 "src/java/jSourceParser.ml"
             in
            _menhir_goto_unann_array_type _menhir_env _menhir_stack _menhir_s _v) : 'freshtv670)) : 'freshtv672)
        | MenhirState80 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv673 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LBRACKET ->
                _menhir_run132 _menhir_env (Obj.magic _menhir_stack) MenhirState415 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState415) : 'freshtv674)
        | MenhirState424 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv675 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LBRACKET ->
                _menhir_run132 _menhir_env (Obj.magic _menhir_stack) MenhirState429 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState429) : 'freshtv676)
        | _ ->
            _menhir_fail ()) : 'freshtv678)) : 'freshtv680)) : 'freshtv682)
    | _ ->
        _menhir_fail ()

and _menhir_run36 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8336 "src/java/jSourceParser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LSBRACKET ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState36
    | COLON | COMMA | EQ | RPAREN | SEMICOLON ->
        _menhir_reduce179 _menhir_env (Obj.magic _menhir_stack) MenhirState36
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState36

and _menhir_goto_left_hand_side : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_left_hand_side -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv655 * _menhir_state * 'tv_left_hand_side) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSIGNOP ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv647) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv645) = Obj.magic _menhir_stack in
        ((let _1 = () in
        let _v : 'tv_assignment_operator = 
# 580 "src/java/jSourceParser.mly"
    ()
# 8370 "src/java/jSourceParser.ml"
         in
        _menhir_goto_assignment_operator _menhir_env _menhir_stack _v) : 'freshtv646)) : 'freshtv648)
    | EQ ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv651) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv649) = Obj.magic _menhir_stack in
        ((let _1 = () in
        let _v : 'tv_assignment_operator = 
# 580 "src/java/jSourceParser.mly"
    ()
# 8383 "src/java/jSourceParser.ml"
         in
        _menhir_goto_assignment_operator _menhir_env _menhir_stack _v) : 'freshtv650)) : 'freshtv652)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv653 * _menhir_state * 'tv_left_hand_side) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv654)) : 'freshtv656)

and _menhir_goto_postfix_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_postfix_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState73 | MenhirState75 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState84 | MenhirState86 | MenhirState91 | MenhirState95 | MenhirState96 | MenhirState100 | MenhirState401 | MenhirState353 | MenhirState340 | MenhirState337 | MenhirState330 | MenhirState300 | MenhirState297 | MenhirState285 | MenhirState275 | MenhirState258 | MenhirState254 | MenhirState250 | MenhirState247 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState205 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState184 | MenhirState182 | MenhirState180 | MenhirState178 | MenhirState161 | MenhirState157 | MenhirState154 | MenhirState150 | MenhirState146 | MenhirState138 | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv633 * _menhir_state * 'tv_postfix_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | INCR_DECR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv627 * _menhir_state * 'tv_postfix_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            _menhir_reduce194 _menhir_env (Obj.magic _menhir_stack)) : 'freshtv628)
        | BINOP | COLON | COMMA | INSTANCEOF | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv629 * _menhir_state * 'tv_postfix_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_postfix_expression)) = _menhir_stack in
            let _v : 'tv_unary_expression_not_plus_minus = 
# 717 "src/java/jSourceParser.mly"
    ( _1 )
# 8416 "src/java/jSourceParser.ml"
             in
            _menhir_goto_unary_expression_not_plus_minus _menhir_env _menhir_stack _menhir_s _v) : 'freshtv630)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv631 * _menhir_state * 'tv_postfix_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv632)) : 'freshtv634)
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState207 | MenhirState252 | MenhirState365 | MenhirState256 | MenhirState260 | MenhirState358 | MenhirState355 | MenhirState280 | MenhirState281 | MenhirState332 | MenhirState289 | MenhirState287 | MenhirState283 | MenhirState277 | MenhirState262 | MenhirState267 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv643 * _menhir_state * 'tv_postfix_expression) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | INCR_DECR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv639 * _menhir_state * 'tv_postfix_expression) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | COMMA | RPAREN | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv635 * _menhir_state * 'tv_postfix_expression)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, (_1 : 'tv_postfix_expression)) = _menhir_stack in
                let _2 = () in
                let _v : 'tv_statement_expression = 
# 406 "src/java/jSourceParser.mly"
    ( _1 )
# 8446 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_statement_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv636)
            | INCR_DECR ->
                _menhir_reduce194 _menhir_env (Obj.magic _menhir_stack)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv637 * _menhir_state * 'tv_postfix_expression)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv638)) : 'freshtv640)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv641 * _menhir_state * 'tv_postfix_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv642)) : 'freshtv644)
    | _ ->
        _menhir_fail ()

and _menhir_reduce187 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_option_superinterfaces_ = 
# 114 "<standard.mly>"
    ( None )
# 8473 "src/java/jSourceParser.ml"
     in
    _menhir_goto_option_superinterfaces_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run64 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64

and _menhir_goto_loption_argument_list_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_argument_list_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv593 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv589 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LBRACKET ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | BINOP | COLON | COMMA | DOT | INCR_DECR | INSTANCEOF | LANGLE | LSBRACKET | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv587 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                ((let (((_menhir_stack, _menhir_s, (_1 : 'tv_primary)), _, (_1_inlined2 : 'tv_dotted_name)), _, (_4 : 'tv_loption_argument_list_)) = _menhir_stack in
                let _5 = () in
                let _3 = () in
                let _1_inlined1 = () in
                let _2 = () in
                let _v : 'tv_class_instance_creation_expression = let _3 =
                  let (_1_inlined1, _1) = (_1_inlined2, _1_inlined1) in
                  let _2 =
                    let _1 = _1_inlined1 in
                    
# 547 "src/java/jSourceParser.mly"
                ( _1 )
# 8523 "src/java/jSourceParser.ml"
                    
                  in
                  
# 677 "src/java/jSourceParser.mly"
    ( _4 )
# 8529 "src/java/jSourceParser.ml"
                  
                in
                
# 672 "src/java/jSourceParser.mly"
    ( _1 @ _3 )
# 8535 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_instance_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv588)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState111) : 'freshtv590)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv591 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv592)) : 'freshtv594)
    | MenhirState157 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv601 * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv597 * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv595 * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)), _), _, (_3 : 'tv_loption_argument_list_)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _v : 'tv_method_invocation = let _1 = 
# 550 "src/java/jSourceParser.mly"
                ( _1 )
# 8567 "src/java/jSourceParser.ml"
             in
            
# 635 "src/java/jSourceParser.mly"
    ( _3 )
# 8572 "src/java/jSourceParser.ml"
             in
            _menhir_goto_method_invocation _menhir_env _menhir_stack _menhir_s _v) : 'freshtv596)) : 'freshtv598)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv599 * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv600)) : 'freshtv602)
    | MenhirState401 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv609 * _menhir_state * 'tv_primary)) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8587 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv605 * _menhir_state * 'tv_primary)) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8597 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv603 * _menhir_state * 'tv_primary)) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8604 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s, (_1 : 'tv_primary)), (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8609 "src/java/jSourceParser.ml"
            )), _startpos_id_), _, (_5 : 'tv_loption_argument_list_)) = _menhir_stack in
            let _6 = () in
            let _4 = () in
            let _2 = () in
            let _v : 'tv_method_invocation = let _3 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 8617 "src/java/jSourceParser.ml"
             in
            
# 637 "src/java/jSourceParser.mly"
    ( _1 @ _5 )
# 8622 "src/java/jSourceParser.ml"
             in
            _menhir_goto_method_invocation _menhir_env _menhir_stack _menhir_s _v) : 'freshtv604)) : 'freshtv606)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv607 * _menhir_state * 'tv_primary)) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8632 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv608)) : 'freshtv610)
    | MenhirState91 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv617 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8641 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv613 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8651 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LBRACKET ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState408 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | BINOP | COLON | COMMA | DOT | INCR_DECR | INSTANCEOF | LANGLE | LSBRACKET | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv611 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8663 "src/java/jSourceParser.ml"
                ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                ((let ((((_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8668 "src/java/jSourceParser.ml"
                )), _startpos_id_), _), _, (_1_inlined1 : 'tv_dotted_name)), _, (_4 : 'tv_loption_argument_list_)) = _menhir_stack in
                let _5 = () in
                let _3 = () in
                let _1 = () in
                let _2 = () in
                let _v : 'tv_class_instance_creation_expression = let _3 =
                  let _2 =
                    let _1 = _1_inlined1 in
                    
# 547 "src/java/jSourceParser.mly"
                ( _1 )
# 8680 "src/java/jSourceParser.ml"
                    
                  in
                  
# 677 "src/java/jSourceParser.mly"
    ( _4 )
# 8686 "src/java/jSourceParser.ml"
                  
                in
                let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 8692 "src/java/jSourceParser.ml"
                 in
                
# 670 "src/java/jSourceParser.mly"
    ( _3 )
# 8697 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_instance_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv612)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState408) : 'freshtv614)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv615 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8711 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv616)) : 'freshtv618)
    | MenhirState425 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv625 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv621 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LBRACKET ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState427 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | BINOP | COLON | COMMA | DOT | INCR_DECR | INSTANCEOF | LANGLE | LSBRACKET | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv619 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
                ((let ((((_menhir_stack, _menhir_s), _, (_1_inlined1 : 'tv_dotted_name)), _), _, (_4 : 'tv_loption_argument_list_)) = _menhir_stack in
                let _5 = () in
                let _3 = () in
                let _1 = () in
                let _v : 'tv_class_instance_creation_expression = let _1 =
                  let _2 =
                    let _1 = _1_inlined1 in
                    
# 547 "src/java/jSourceParser.mly"
                ( _1 )
# 8742 "src/java/jSourceParser.ml"
                    
                  in
                  
# 677 "src/java/jSourceParser.mly"
    ( _4 )
# 8748 "src/java/jSourceParser.ml"
                  
                in
                
# 668 "src/java/jSourceParser.mly"
    ( _1 )
# 8754 "src/java/jSourceParser.ml"
                 in
                _menhir_goto_class_instance_creation_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv620)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState427) : 'freshtv622)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv623 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv624)) : 'freshtv626)
    | _ ->
        _menhir_fail ()

and _menhir_goto_primary_no_new_array : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_primary_no_new_array -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv585 * _menhir_state * 'tv_primary_no_new_array) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LSBRACKET ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv579 * _menhir_state * 'tv_primary_no_new_array) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BANG ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | BINOP ->
            _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | CHAR _v ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | FALSE ->
            _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | FLOATINGPOINT _v ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | IDENT _v ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INCR_DECR ->
            _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | INTEGER _v ->
            _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | LPAREN ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | NEW ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | NULL ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | STRING _v ->
            _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | THIS ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | TILDE ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | TRUE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState100) : 'freshtv580)
    | BINOP | COLON | COMMA | DOT | INCR_DECR | INSTANCEOF | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv581 * _menhir_state * 'tv_primary_no_new_array) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_primary_no_new_array)) = _menhir_stack in
        let _v : 'tv_primary = 
# 602 "src/java/jSourceParser.mly"
    ( _1 )
# 8826 "src/java/jSourceParser.ml"
         in
        _menhir_goto_primary _menhir_env _menhir_stack _menhir_s _v) : 'freshtv582)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv583 * _menhir_state * 'tv_primary_no_new_array) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv584)) : 'freshtv586)

and _menhir_goto_boolean : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_boolean -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv577) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_boolean) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv575) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_boolean) : 'tv_boolean) = _v in
    ((let _v : 'tv_literal = 
# 646 "src/java/jSourceParser.mly"
    ()
# 8850 "src/java/jSourceParser.ml"
     in
    _menhir_goto_literal _menhir_env _menhir_stack _menhir_s _v) : 'freshtv576)) : 'freshtv578)

and _menhir_goto_literal : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_literal -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv573) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_literal) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv571) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : 'tv_literal) : 'tv_literal) = _v in
    ((let _v : 'tv_primary_no_new_array = 
# 626 "src/java/jSourceParser.mly"
    ( [] )
# 8867 "src/java/jSourceParser.ml"
     in
    _menhir_goto_primary_no_new_array _menhir_env _menhir_stack _menhir_s _v) : 'freshtv572)) : 'freshtv574)

and _menhir_goto_option_superinterfaces_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_superinterfaces_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState63 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv567 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8880 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state * 'tv_option_superinterfaces_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv563) = Obj.magic _menhir_stack in
            let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            ((let _menhir_stack = (_menhir_stack, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState71) : 'freshtv564)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv565 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8906 "src/java/jSourceParser.ml"
            ) * Lexing.position) * _menhir_state * 'tv_option_superinterfaces_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv566)) : 'freshtv568)
    | MenhirState123 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv569 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 8915 "src/java/jSourceParser.ml"
        ) * Lexing.position) * 'tv_option_superclass_) * _menhir_state * 'tv_option_superinterfaces_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACKET ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState124) : 'freshtv570)
    | _ ->
        _menhir_fail ()

and _menhir_goto_option_throws_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_throws_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState52 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv551 * _menhir_state) * _menhir_state * 'tv_method_declarator) * _menhir_state * 'tv_option_throws_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv549 * _menhir_state) * _menhir_state * 'tv_method_declarator) * _menhir_state * 'tv_option_throws_) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_method_declarator)), _, (_3 : 'tv_option_throws_)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_method_header = let _1 = 
# 248 "src/java/jSourceParser.mly"
    ()
# 8943 "src/java/jSourceParser.ml"
         in
        
# 242 "src/java/jSourceParser.mly"
    ()
# 8948 "src/java/jSourceParser.ml"
         in
        _menhir_goto_method_header _menhir_env _menhir_stack _menhir_s _v) : 'freshtv550)) : 'freshtv552)
    | MenhirState193 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv555 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_method_declarator) * _menhir_state * 'tv_option_throws_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv553 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_method_declarator) * _menhir_state * 'tv_option_throws_) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s, (_1 : 'tv_unann_type)), _, (_2 : 'tv_method_declarator)), _, (_3 : 'tv_option_throws_)) = _menhir_stack in
        let _v : 'tv_method_header = let _1 = 
# 248 "src/java/jSourceParser.mly"
    ()
# 8960 "src/java/jSourceParser.ml"
         in
        
# 242 "src/java/jSourceParser.mly"
    ()
# 8965 "src/java/jSourceParser.ml"
         in
        _menhir_goto_method_header _menhir_env _menhir_stack _menhir_s _v) : 'freshtv554)) : 'freshtv556)
    | MenhirState386 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv561 * _menhir_state * 'tv_constructor_declarator) * _menhir_state * 'tv_option_throws_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv557) = Obj.magic _menhir_stack in
            let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            ((let _menhir_stack = (_menhir_stack, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ASSERT ->
                _menhir_run297 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | BREAK ->
                _menhir_run294 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState388 _v
            | CLASS ->
                _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | CONTINUE ->
                _menhir_run290 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | DO ->
                _menhir_run281 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | ENUM ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState388 _v
            | FOR ->
                _menhir_run282 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState388 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run249 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | INCR_DECR ->
                _menhir_run247 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState388 _v
            | LBRACKET ->
                _menhir_run200 _menhir_env (Obj.magic _menhir_stack) MenhirState388 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LPAREN ->
                _menhir_run244 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | PRIMTYPE ->
                _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | RETURN ->
                _menhir_run240 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | SEMICOLON ->
                _menhir_run239 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState388 _v
            | SYNCHRONIZED ->
                _menhir_run234 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | THROW ->
                _menhir_run231 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | TRY ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | VAR ->
                _menhir_run263 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | WHILE ->
                _menhir_run204 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | YIELD ->
                _menhir_run201 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | RBRACKET ->
                _menhir_reduce150 _menhir_env (Obj.magic _menhir_stack) MenhirState388
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState388) : 'freshtv558)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv559 * _menhir_state * 'tv_constructor_declarator) * _menhir_state * 'tv_option_throws_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv560)) : 'freshtv562)
    | _ ->
        _menhir_fail ()

and _menhir_goto_unann_reference_type : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_unann_reference_type -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState456 | MenhirState22 | MenhirState441 | MenhirState395 | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState283 | MenhirState262 | MenhirState112 | MenhirState115 | MenhirState48 | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv543) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unann_reference_type) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv541) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_unann_reference_type) : 'tv_unann_reference_type) = _v in
        ((let _v : 'tv_unann_type = 
# 524 "src/java/jSourceParser.mly"
    ()
# 9073 "src/java/jSourceParser.ml"
         in
        _menhir_goto_unann_type _menhir_env _menhir_stack _menhir_s _v) : 'freshtv542)) : 'freshtv544)
    | MenhirState174 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv547 * _menhir_state * 'tv_conditional_or_expression)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_unann_reference_type) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv545 * _menhir_state * 'tv_conditional_or_expression)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_unann_reference_type) : 'tv_unann_reference_type) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_conditional_or_expression)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_conditional_or_expression = 
# 699 "src/java/jSourceParser.mly"
    ( _1 )
# 9090 "src/java/jSourceParser.ml"
         in
        _menhir_goto_conditional_or_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv546)) : 'freshtv548)
    | _ ->
        _menhir_fail ()

and _menhir_reduce11 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_app_list_type_declaration_ = 
# 737 "src/java/jSourceParser.mly"
    ( [] )
# 9101 "src/java/jSourceParser.ml"
     in
    _menhir_goto_app_list_type_declaration_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run19 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv539) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_type_declaration = 
# 119 "src/java/jSourceParser.mly"
    ( [] )
# 9115 "src/java/jSourceParser.ml"
     in
    _menhir_goto_type_declaration _menhir_env _menhir_stack _menhir_s _v) : 'freshtv540)

and _menhir_run20 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv535 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9131 "src/java/jSourceParser.ml"
        )) = _v in
        let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        ((let _menhir_stack = (_menhir_stack, _v, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv531) = Obj.magic _menhir_stack in
            let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            ((let _menhir_stack = (_menhir_stack, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | CLASS ->
                _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState22
            | ENUM ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState22
            | IDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTERFACE ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState22
            | PRIMTYPE ->
                _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState22
            | VOID ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState22
            | RBRACKET ->
                _menhir_reduce9 _menhir_env (Obj.magic _menhir_stack) MenhirState22
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState22) : 'freshtv532)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv533 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9171 "src/java/jSourceParser.ml"
            ) * Lexing.position) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv534)) : 'freshtv536)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv537 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv538)

and _menhir_run62 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv527 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9195 "src/java/jSourceParser.ml"
        )) = _v in
        let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        ((let _menhir_stack = (_menhir_stack, _v, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IMPLEMENTS ->
            _menhir_run64 _menhir_env (Obj.magic _menhir_stack) MenhirState63
        | LBRACKET ->
            _menhir_reduce187 _menhir_env (Obj.magic _menhir_stack) MenhirState63
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState63) : 'freshtv528)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv529 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv530)

and _menhir_run118 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv523 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9230 "src/java/jSourceParser.ml"
        )) = _v in
        let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        ((let _menhir_stack = (_menhir_stack, _v, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | EXTENDS ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv517) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState120) : 'freshtv518)
        | IMPLEMENTS | LBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv519) = Obj.magic _menhir_stack in
            ((let _v : 'tv_option_superclass_ = 
# 114 "<standard.mly>"
    ( None )
# 9255 "src/java/jSourceParser.ml"
             in
            _menhir_goto_option_superclass_ _menhir_env _menhir_stack _v) : 'freshtv520)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv521 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9265 "src/java/jSourceParser.ml"
            ) * Lexing.position) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv522)) : 'freshtv524)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv525 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv526)

and _menhir_goto_import_name_end : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_import_name_end -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState12 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv497 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9285 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_import_name_end) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv495 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9293 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_3 : 'tv_import_name_end) : 'tv_import_name_end) = _v in
        ((let ((_menhir_stack, _menhir_s), (_2 : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9300 "src/java/jSourceParser.ml"
        )), _startpos__2_) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_import_name_end = 
# 108 "src/java/jSourceParser.mly"
    ()
# 9306 "src/java/jSourceParser.ml"
         in
        _menhir_goto_import_name_end _menhir_env _menhir_stack _menhir_s _v) : 'freshtv496)) : 'freshtv498)
    | MenhirState10 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv515 * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9314 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_import_name_end) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv513 * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9322 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_import_name_end) : 'tv_import_name_end) = _v in
        ((let (_menhir_stack, (_1 : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9329 "src/java/jSourceParser.ml"
        )), _startpos__1_) = _menhir_stack in
        let _v : 'tv_import_name = 
# 103 "src/java/jSourceParser.mly"
    ()
# 9334 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv511) = _menhir_stack in
        let (_v : 'tv_import_name) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv509 * _menhir_state) * 'tv_import_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv505 * _menhir_state) * 'tv_import_name) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv503 * _menhir_state) * 'tv_import_name) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), (_2 : 'tv_import_name)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_import_declaration = 
# 99 "src/java/jSourceParser.mly"
    ()
# 9357 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv501) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_import_declaration) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv499 * _menhir_state * 'tv_import_declaration) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IMPORT ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState470
            | CLASS | ENUM | EOF | INTERFACE | SEMICOLON ->
                _menhir_reduce136 _menhir_env (Obj.magic _menhir_stack) MenhirState470
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState470) : 'freshtv500)) : 'freshtv502)) : 'freshtv504)) : 'freshtv506)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv507 * _menhir_state) * 'tv_import_name) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv508)) : 'freshtv510)) : 'freshtv512)) : 'freshtv514)) : 'freshtv516)
    | _ ->
        _menhir_fail ()

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_run81 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | RSBRACKET ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState81
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState81

and _menhir_run28 : _menhir_env -> 'ttv_tail * _menhir_state -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LSBRACKET ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | BINOP | COLON | COMMA | EQ | IDENT _ | INSTANCEOF | LANGLE | LBRACKET | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON | THREEDOTS | THROWS ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv493 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_nonempty_list_dim_ = let x = 
# 559 "src/java/jSourceParser.mly"
    ()
# 9452 "src/java/jSourceParser.ml"
         in
        
# 221 "<standard.mly>"
    ( [ x ] )
# 9457 "src/java/jSourceParser.ml"
         in
        _menhir_goto_nonempty_list_dim_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv494)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState28

and _menhir_goto_separated_nonempty_list_PIPE_unann_class_or_interface_type_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState211 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv487) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv485) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_) : 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_) = _v in
        ((let _v : 'tv_catch_type = 
# 454 "src/java/jSourceParser.mly"
    ()
# 9480 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv483) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_catch_type) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv481 * _menhir_state * 'tv_catch_type) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run36 _menhir_env (Obj.magic _menhir_stack) MenhirState216 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState216) : 'freshtv482)) : 'freshtv484)) : 'freshtv486)) : 'freshtv488)
    | MenhirState214 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv491 * _menhir_state * 'tv_dotted_name)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv489 * _menhir_state * 'tv_dotted_name)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_) : 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_ = let x = 
# 541 "src/java/jSourceParser.mly"
                ( _1 )
# 9512 "src/java/jSourceParser.ml"
         in
        
# 243 "<standard.mly>"
    ( x :: xs )
# 9517 "src/java/jSourceParser.ml"
         in
        _menhir_goto_separated_nonempty_list_PIPE_unann_class_or_interface_type_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv490)) : 'freshtv492)
    | _ ->
        _menhir_fail ()

and _menhir_reduce133 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_dotted_name -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)) = _menhir_stack in
    let _v : 'tv_left_hand_side = let _1 = 
# 550 "src/java/jSourceParser.mly"
                ( _1 )
# 9529 "src/java/jSourceParser.ml"
     in
    
# 584 "src/java/jSourceParser.mly"
    ( [] )
# 9534 "src/java/jSourceParser.ml"
     in
    _menhir_goto_left_hand_side _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce193 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_dotted_name -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)) = _menhir_stack in
    let _v : 'tv_postfix_expression = let _1 = 
# 550 "src/java/jSourceParser.mly"
                ( _1 )
# 9544 "src/java/jSourceParser.ml"
     in
    
# 731 "src/java/jSourceParser.mly"
    ( [] )
# 9549 "src/java/jSourceParser.ml"
     in
    _menhir_goto_postfix_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run150 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_dotted_name -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState150
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState150

and _menhir_run157 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_dotted_name -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState157 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState157 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState157 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState157 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState157 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | RPAREN ->
        _menhir_reduce148 _menhir_env (Obj.magic _menhir_stack) MenhirState157
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState157

and _menhir_goto_option_superclass_ : _menhir_env -> 'ttv_tail -> 'tv_option_superclass_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv479 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9644 "src/java/jSourceParser.ml"
    ) * Lexing.position) * 'tv_option_superclass_) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMPLEMENTS ->
        _menhir_run64 _menhir_env (Obj.magic _menhir_stack) MenhirState123
    | LBRACKET ->
        _menhir_reduce187 _menhir_env (Obj.magic _menhir_stack) MenhirState123
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState123) : 'freshtv480)

and _menhir_reduce148 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_loption_argument_list_ = 
# 142 "<standard.mly>"
    ( [] )
# 9663 "src/java/jSourceParser.ml"
     in
    _menhir_goto_loption_argument_list_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run74 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv477) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_boolean = 
# 651 "src/java/jSourceParser.mly"
    ()
# 9677 "src/java/jSourceParser.ml"
     in
    _menhir_goto_boolean _menhir_env _menhir_stack _menhir_s _v) : 'freshtv478)

and _menhir_run75 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState75
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState75

and _menhir_run76 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv475) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_primary_no_new_array = 
# 626 "src/java/jSourceParser.mly"
    ( [] )
# 9732 "src/java/jSourceParser.ml"
     in
    _menhir_goto_primary_no_new_array _menhir_env _menhir_stack _menhir_s _v) : 'freshtv476)

and _menhir_run77 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 81 "src/java/jSourceParser.mly"
       (string)
# 9739 "src/java/jSourceParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv473) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : (
# 81 "src/java/jSourceParser.mly"
       (string)
# 9749 "src/java/jSourceParser.ml"
    )) : (
# 81 "src/java/jSourceParser.mly"
       (string)
# 9753 "src/java/jSourceParser.ml"
    )) = _v in
    ((let _v : 'tv_literal = 
# 646 "src/java/jSourceParser.mly"
    ()
# 9758 "src/java/jSourceParser.ml"
     in
    _menhir_goto_literal _menhir_env _menhir_stack _menhir_s _v) : 'freshtv474)

and _menhir_run78 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv471) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_literal = 
# 646 "src/java/jSourceParser.mly"
    ()
# 9772 "src/java/jSourceParser.ml"
     in
    _menhir_goto_literal _menhir_env _menhir_stack _menhir_s _v) : 'freshtv472)

and _menhir_run79 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState79 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | PRIMTYPE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv469 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState79 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LSBRACKET ->
            _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState80
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState80) : 'freshtv470)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState79

and _menhir_run82 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | PRIMTYPE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv467 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState82 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv463 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState84) : 'freshtv464)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv465 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv466)) : 'freshtv468)
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState82
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState82

and _menhir_run85 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 79 "src/java/jSourceParser.mly"
       (string)
# 9902 "src/java/jSourceParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv461) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : (
# 79 "src/java/jSourceParser.mly"
       (string)
# 9912 "src/java/jSourceParser.ml"
    )) : (
# 79 "src/java/jSourceParser.mly"
       (string)
# 9916 "src/java/jSourceParser.ml"
    )) = _v in
    ((let _v : 'tv_literal = 
# 646 "src/java/jSourceParser.mly"
    ()
# 9921 "src/java/jSourceParser.ml"
     in
    _menhir_goto_literal _menhir_env _menhir_stack _menhir_s _v) : 'freshtv462)

and _menhir_run86 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState86 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState86 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState86 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState86 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState86 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState86
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState86

and _menhir_run87 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9969 "src/java/jSourceParser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv457 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9981 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | CLASS ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv453 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9991 "src/java/jSourceParser.ml"
            ) * Lexing.position)) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState88 in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv451 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 9999 "src/java/jSourceParser.ml"
            ) * Lexing.position)) = Obj.magic _menhir_stack in
            let (_ : _menhir_state) = _menhir_s in
            ((let (_menhir_stack, _menhir_s, (_1 : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10005 "src/java/jSourceParser.ml"
            )), _startpos__1_) = _menhir_stack in
            let _3 = () in
            let _2 = () in
            let _v : 'tv_class_literal = let _1 = 
# 664 "src/java/jSourceParser.mly"
    ()
# 10012 "src/java/jSourceParser.ml"
             in
            
# 655 "src/java/jSourceParser.mly"
    ()
# 10017 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv449) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_class_literal) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv447) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_class_literal) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv445) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : 'tv_class_literal) : 'tv_class_literal) = _v in
            ((let _v : 'tv_primary_no_new_array = 
# 626 "src/java/jSourceParser.mly"
    ( [] )
# 10034 "src/java/jSourceParser.ml"
             in
            _menhir_goto_primary_no_new_array _menhir_env _menhir_stack _menhir_s _v) : 'freshtv446)) : 'freshtv448)) : 'freshtv450)) : 'freshtv452)) : 'freshtv454)
        | IDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NEW ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv455 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10044 "src/java/jSourceParser.ml"
            ) * Lexing.position)) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState88 in
            ((let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState89) : 'freshtv456)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState88) : 'freshtv458)
    | ASSIGNOP | BINOP | COLON | COMMA | EQ | IDENT _ | INCR_DECR | INSTANCEOF | LANGLE | LPAREN | LSBRACKET | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
        _menhir_reduce89 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv459 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10070 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv460)

and _menhir_run92 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 80 "src/java/jSourceParser.mly"
       (string)
# 10078 "src/java/jSourceParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv443) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : (
# 80 "src/java/jSourceParser.mly"
       (string)
# 10088 "src/java/jSourceParser.ml"
    )) : (
# 80 "src/java/jSourceParser.mly"
       (string)
# 10092 "src/java/jSourceParser.ml"
    )) = _v in
    ((let _v : 'tv_literal = 
# 646 "src/java/jSourceParser.mly"
    ()
# 10097 "src/java/jSourceParser.ml"
     in
    _menhir_goto_literal _menhir_env _menhir_stack _menhir_s _v) : 'freshtv444)

and _menhir_run93 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv441) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_boolean = 
# 651 "src/java/jSourceParser.mly"
    ()
# 10111 "src/java/jSourceParser.ml"
     in
    _menhir_goto_boolean _menhir_env _menhir_stack _menhir_s _v) : 'freshtv442)

and _menhir_run94 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 82 "src/java/jSourceParser.mly"
       (string)
# 10118 "src/java/jSourceParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv439) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((_1 : (
# 82 "src/java/jSourceParser.mly"
       (string)
# 10128 "src/java/jSourceParser.ml"
    )) : (
# 82 "src/java/jSourceParser.mly"
       (string)
# 10132 "src/java/jSourceParser.ml"
    )) = _v in
    ((let _v : 'tv_literal = 
# 646 "src/java/jSourceParser.mly"
    ()
# 10137 "src/java/jSourceParser.ml"
     in
    _menhir_goto_literal _menhir_env _menhir_stack _menhir_s _v) : 'freshtv440)

and _menhir_run95 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState95 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState95 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState95 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState95 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState95 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState95
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState95

and _menhir_run96 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BANG ->
        _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | BINOP ->
        _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | CHAR _v ->
        _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
    | FALSE ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | FLOATINGPOINT _v ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
    | IDENT _v ->
        _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INCR_DECR ->
        _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | INTEGER _v ->
        _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
    | LPAREN ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | NEW ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | NULL ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | STRING _v ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
    | THIS ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | TILDE ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | TRUE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState96

and _menhir_goto_separated_nonempty_list_COMMA_class_type_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_class_type_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv433 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_class_type_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv431 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_separated_nonempty_list_COMMA_class_type_) : 'tv_separated_nonempty_list_COMMA_class_type_) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_superinterfaces = 
# 150 "src/java/jSourceParser.mly"
    ()
# 10240 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv429) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_superinterfaces) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv427) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_superinterfaces) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv425) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_superinterfaces) : 'tv_superinterfaces) = _v in
        ((let _v : 'tv_option_superinterfaces_ = 
# 116 "<standard.mly>"
    ( Some x )
# 10257 "src/java/jSourceParser.ml"
         in
        _menhir_goto_option_superinterfaces_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv426)) : 'freshtv428)) : 'freshtv430)) : 'freshtv432)) : 'freshtv434)
    | MenhirState67 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv437 * _menhir_state * 'tv_dotted_name)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_class_type_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv435 * _menhir_state * 'tv_dotted_name)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_class_type_) : 'tv_separated_nonempty_list_COMMA_class_type_) = _v in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_class_type_ = let x = 
# 544 "src/java/jSourceParser.mly"
                ( _1 )
# 10274 "src/java/jSourceParser.ml"
         in
        
# 243 "<standard.mly>"
    ( x :: xs )
# 10279 "src/java/jSourceParser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_class_type_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv436)) : 'freshtv438)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_exception_type_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_exception_type_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState53 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv419) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_exception_type_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv417) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : 'tv_separated_nonempty_list_COMMA_exception_type_) : 'tv_separated_nonempty_list_COMMA_exception_type_) = _v in
        ((let _v : 'tv_exception_type_list = 
# 474 "src/java/jSourceParser.mly"
    ( [] )
# 10300 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv415) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_exception_type_list) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv413 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_exception_type_list) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv411 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((_2 : 'tv_exception_type_list) : 'tv_exception_type_list) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_throws = 
# 470 "src/java/jSourceParser.mly"
    ( _2 )
# 10319 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv409) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_throws) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv407) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_throws) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv405) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_throws) : 'tv_throws) = _v in
        ((let _v : 'tv_option_throws_ = 
# 116 "<standard.mly>"
    ( Some x )
# 10336 "src/java/jSourceParser.ml"
         in
        _menhir_goto_option_throws_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv406)) : 'freshtv408)) : 'freshtv410)) : 'freshtv412)) : 'freshtv414)) : 'freshtv416)) : 'freshtv418)) : 'freshtv420)
    | MenhirState57 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv423 * _menhir_state * 'tv_exception_type)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_exception_type_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv421 * _menhir_state * 'tv_exception_type)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_exception_type_) : 'tv_separated_nonempty_list_COMMA_exception_type_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_exception_type)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_exception_type_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 10353 "src/java/jSourceParser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_exception_type_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv422)) : 'freshtv424)
    | _ ->
        _menhir_fail ()

and _menhir_reduce255 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_dotted_name -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)) = _menhir_stack in
    let _v : 'tv_unann_reference_type = let _1 = 
# 541 "src/java/jSourceParser.mly"
                ( _1 )
# 10365 "src/java/jSourceParser.ml"
     in
    
# 529 "src/java/jSourceParser.mly"
    ()
# 10370 "src/java/jSourceParser.ml"
     in
    _menhir_goto_unann_reference_type _menhir_env _menhir_stack _menhir_s _v

and _menhir_run27 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RSBRACKET ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState27

and _menhir_goto_list_import_declaration_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_list_import_declaration_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState8 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv399 * 'tv_option_package_declaration_) * _menhir_state * 'tv_list_import_declaration_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | CLASS ->
            _menhir_run118 _menhir_env (Obj.magic _menhir_stack) MenhirState18
        | ENUM ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState18
        | INTERFACE ->
            _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState18
        | SEMICOLON ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState18
        | EOF ->
            _menhir_reduce11 _menhir_env (Obj.magic _menhir_stack) MenhirState18
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState18) : 'freshtv400)
    | MenhirState470 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv403 * _menhir_state * 'tv_import_declaration) * _menhir_state * 'tv_list_import_declaration_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv401 * _menhir_state * 'tv_import_declaration) * _menhir_state * 'tv_list_import_declaration_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_import_declaration)), _, (xs : 'tv_list_import_declaration_)) = _menhir_stack in
        let _v : 'tv_list_import_declaration_ = 
# 213 "<standard.mly>"
    ( x :: xs )
# 10420 "src/java/jSourceParser.ml"
         in
        _menhir_goto_list_import_declaration_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv402)) : 'freshtv404)
    | _ ->
        _menhir_fail ()

and _menhir_reduce123 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_import_name_end = 
# 108 "src/java/jSourceParser.mly"
    ()
# 10431 "src/java/jSourceParser.ml"
     in
    _menhir_goto_import_name_end _menhir_env _menhir_stack _menhir_s _v

and _menhir_run11 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BINOP ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv393 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv391 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_import_name_end = 
# 108 "src/java/jSourceParser.mly"
    ()
# 10453 "src/java/jSourceParser.ml"
         in
        _menhir_goto_import_name_end _menhir_env _menhir_stack _menhir_s _v) : 'freshtv392)) : 'freshtv394)
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv395 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10462 "src/java/jSourceParser.ml"
        )) = _v in
        let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        ((let _menhir_stack = (_menhir_stack, _v, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState12
        | SEMICOLON ->
            _menhir_reduce123 _menhir_env (Obj.magic _menhir_stack) MenhirState12
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState12) : 'freshtv396)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv397 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv398)

and _menhir_goto_dotted_name : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_dotted_name -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState88 | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv309 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10494 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv307 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10500 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10505 "src/java/jSourceParser.ml"
        )), _startpos_id_), _, (_3 : 'tv_dotted_name)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_dotted_name = let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 10511 "src/java/jSourceParser.ml"
         in
        
# 535 "src/java/jSourceParser.mly"
    ( _1 ^ "." ^ _3 )
# 10516 "src/java/jSourceParser.ml"
         in
        _menhir_goto_dotted_name _menhir_env _menhir_stack _menhir_s _v) : 'freshtv308)) : 'freshtv310)
    | MenhirState1 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv323) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv319) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv317) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _, (_1_inlined1 : 'tv_dotted_name)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_package_declaration = let _2 =
              let _1 = _1_inlined1 in
              
# 541 "src/java/jSourceParser.mly"
                ( _1 )
# 10539 "src/java/jSourceParser.ml"
              
            in
            
# 112 "src/java/jSourceParser.mly"
    ( _2 )
# 10545 "src/java/jSourceParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv315) = _menhir_stack in
            let (_v : 'tv_package_declaration) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv313) = Obj.magic _menhir_stack in
            let (_v : 'tv_package_declaration) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv311) = Obj.magic _menhir_stack in
            let ((x : 'tv_package_declaration) : 'tv_package_declaration) = _v in
            ((let _v : 'tv_option_package_declaration_ = 
# 116 "<standard.mly>"
    ( Some x )
# 10559 "src/java/jSourceParser.ml"
             in
            _menhir_goto_option_package_declaration_ _menhir_env _menhir_stack _v) : 'freshtv312)) : 'freshtv314)) : 'freshtv316)) : 'freshtv318)) : 'freshtv320)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv321) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv322)) : 'freshtv324)
    | MenhirState22 | MenhirState456 | MenhirState441 | MenhirState395 | MenhirState112 | MenhirState174 | MenhirState115 | MenhirState25 | MenhirState48 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv325 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LSBRACKET ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState50
        | BINOP | COLON | COMMA | IDENT _ | INSTANCEOF | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON | THREEDOTS ->
            _menhir_reduce255 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState50) : 'freshtv326)
    | MenhirState53 | MenhirState57 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv339 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv337 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)) = _menhir_stack in
        let _v : 'tv_exception_type = let _1 = 
# 541 "src/java/jSourceParser.mly"
                ( _1 )
# 10592 "src/java/jSourceParser.ml"
         in
        
# 478 "src/java/jSourceParser.mly"
    ( [] )
# 10597 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv335) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_exception_type) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv333 * _menhir_state * 'tv_exception_type) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv327 * _menhir_state * 'tv_exception_type) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState57) : 'freshtv328)
        | LBRACKET | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv329 * _menhir_state * 'tv_exception_type) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_exception_type)) = _menhir_stack in
            let _v : 'tv_separated_nonempty_list_COMMA_exception_type_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 10628 "src/java/jSourceParser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_exception_type_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv330)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv331 * _menhir_state * 'tv_exception_type) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv332)) : 'freshtv334)) : 'freshtv336)) : 'freshtv338)) : 'freshtv340)
    | MenhirState67 | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv347 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv341 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState67 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState67) : 'freshtv342)
        | LBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv343 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)) = _menhir_stack in
            let _v : 'tv_separated_nonempty_list_COMMA_class_type_ = let x = 
# 544 "src/java/jSourceParser.mly"
                ( _1 )
# 10663 "src/java/jSourceParser.ml"
             in
            
# 241 "<standard.mly>"
    ( [ x ] )
# 10668 "src/java/jSourceParser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_class_type_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv344)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv345 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv346)) : 'freshtv348)
    | MenhirState89 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv353 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10683 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv349 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10693 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | RPAREN ->
                _menhir_reduce148 _menhir_env (Obj.magic _menhir_stack) MenhirState91
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState91) : 'freshtv350)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv351 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 10741 "src/java/jSourceParser.ml"
            ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv352)) : 'freshtv354)
    | MenhirState104 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv359 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv355 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | RPAREN ->
                _menhir_reduce148 _menhir_env (Obj.magic _menhir_stack) MenhirState106
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState106) : 'freshtv356)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv357 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv358)) : 'freshtv360)
    | MenhirState120 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv369) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv367) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _, (_1_inlined1 : 'tv_dotted_name)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_superclass = let _2 =
          let _1 = _1_inlined1 in
          
# 544 "src/java/jSourceParser.mly"
                ( _1 )
# 10812 "src/java/jSourceParser.ml"
          
        in
        
# 146 "src/java/jSourceParser.mly"
    ()
# 10818 "src/java/jSourceParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv365) = _menhir_stack in
        let (_v : 'tv_superclass) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv363) = Obj.magic _menhir_stack in
        let (_v : 'tv_superclass) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv361) = Obj.magic _menhir_stack in
        let ((x : 'tv_superclass) : 'tv_superclass) = _v in
        ((let _v : 'tv_option_superclass_ = 
# 116 "<standard.mly>"
    ( Some x )
# 10832 "src/java/jSourceParser.ml"
         in
        _menhir_goto_option_superclass_ _menhir_env _menhir_stack _v) : 'freshtv362)) : 'freshtv364)) : 'freshtv366)) : 'freshtv368)) : 'freshtv370)
    | MenhirState73 | MenhirState425 | MenhirState419 | MenhirState81 | MenhirState82 | MenhirState91 | MenhirState100 | MenhirState401 | MenhirState106 | MenhirState205 | MenhirState207 | MenhirState250 | MenhirState252 | MenhirState365 | MenhirState254 | MenhirState256 | MenhirState258 | MenhirState260 | MenhirState358 | MenhirState353 | MenhirState355 | MenhirState275 | MenhirState277 | MenhirState280 | MenhirState281 | MenhirState340 | MenhirState337 | MenhirState330 | MenhirState332 | MenhirState285 | MenhirState287 | MenhirState289 | MenhirState297 | MenhirState300 | MenhirState267 | MenhirState244 | MenhirState240 | MenhirState235 | MenhirState231 | MenhirState201 | MenhirState131 | MenhirState132 | MenhirState138 | MenhirState178 | MenhirState157 | MenhirState161 | MenhirState150 | MenhirState146 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv371 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAREN ->
            _menhir_run157 _menhir_env (Obj.magic _menhir_stack) MenhirState149
        | LSBRACKET ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack) MenhirState149
        | BINOP | COLON | COMMA | INCR_DECR | INSTANCEOF | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
            _menhir_reduce193 _menhir_env (Obj.magic _menhir_stack)
        | ASSIGNOP | EQ ->
            _menhir_reduce133 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState149) : 'freshtv372)
    | MenhirState75 | MenhirState84 | MenhirState86 | MenhirState95 | MenhirState96 | MenhirState247 | MenhirState184 | MenhirState182 | MenhirState180 | MenhirState154 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv373 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAREN ->
            _menhir_run157 _menhir_env (Obj.magic _menhir_stack) MenhirState156
        | LSBRACKET ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack) MenhirState156
        | BINOP | COLON | COMMA | INCR_DECR | INSTANCEOF | LANGLE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON ->
            _menhir_reduce193 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState156) : 'freshtv374)
    | MenhirState214 | MenhirState211 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv381 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | PIPE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv375 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState214 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState214) : 'freshtv376)
        | IDENT _ ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv377 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (_1 : 'tv_dotted_name)) = _menhir_stack in
            let _v : 'tv_separated_nonempty_list_PIPE_unann_class_or_interface_type_ = let x = 
# 541 "src/java/jSourceParser.mly"
                ( _1 )
# 10894 "src/java/jSourceParser.ml"
             in
            
# 241 "<standard.mly>"
    ( [ x ] )
# 10899 "src/java/jSourceParser.ml"
             in
            _menhir_goto_separated_nonempty_list_PIPE_unann_class_or_interface_type_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv378)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv379 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv380)) : 'freshtv382)
    | MenhirState388 | MenhirState377 | MenhirState376 | MenhirState200 | MenhirState262 | MenhirState283 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv385 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAREN ->
            _menhir_run157 _menhir_env (Obj.magic _menhir_stack) MenhirState336
        | LSBRACKET ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv383 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState336 in
            ((let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | RSBRACKET ->
                _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState337
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState337) : 'freshtv384)
        | IDENT _ ->
            _menhir_reduce255 _menhir_env (Obj.magic _menhir_stack)
        | INCR_DECR ->
            _menhir_reduce193 _menhir_env (Obj.magic _menhir_stack)
        | ASSIGNOP | EQ ->
            _menhir_reduce133 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState336) : 'freshtv386)
    | MenhirState79 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv389 * _menhir_state) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv387 * _menhir_state) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState424 in
            ((let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | BANG ->
                _menhir_run96 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | BINOP ->
                _menhir_run95 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | CHAR _v ->
                _menhir_run94 _menhir_env (Obj.magic _menhir_stack) MenhirState425 _v
            | FALSE ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | FLOATINGPOINT _v ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState425 _v
            | IDENT _v ->
                _menhir_run87 _menhir_env (Obj.magic _menhir_stack) MenhirState425 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INCR_DECR ->
                _menhir_run86 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | INTEGER _v ->
                _menhir_run85 _menhir_env (Obj.magic _menhir_stack) MenhirState425 _v
            | LPAREN ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | NEW ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | NULL ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | STRING _v ->
                _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState425 _v
            | THIS ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | TILDE ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | TRUE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | RPAREN ->
                _menhir_reduce148 _menhir_env (Obj.magic _menhir_stack) MenhirState425
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState425) : 'freshtv388)
        | LSBRACKET ->
            _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState424
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState424) : 'freshtv390)
    | _ ->
        _menhir_fail ()

and _menhir_reduce136 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_list_import_declaration_ = 
# 211 "<standard.mly>"
    ( [] )
# 11035 "src/java/jSourceParser.ml"
     in
    _menhir_goto_list_import_declaration_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run9 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv303) = Obj.magic _menhir_stack in
        let (_v : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11051 "src/java/jSourceParser.ml"
        )) = _v in
        let (_startpos : Lexing.position) = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        ((let _menhir_stack = (_menhir_stack, _v, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState10
        | SEMICOLON ->
            _menhir_reduce123 _menhir_env (Obj.magic _menhir_stack) MenhirState10
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState10) : 'freshtv304)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv305 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv306)

and _menhir_reduce89 : _menhir_env -> 'ttv_tail * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11077 "src/java/jSourceParser.ml"
) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (id : (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11083 "src/java/jSourceParser.ml"
    )), _startpos_id_) = _menhir_stack in
    let _v : 'tv_dotted_name = let _1 = 
# 659 "src/java/jSourceParser.mly"
             ( id )
# 11088 "src/java/jSourceParser.ml"
     in
    
# 533 "src/java/jSourceParser.mly"
    ( _1 )
# 11093 "src/java/jSourceParser.ml"
     in
    _menhir_goto_dotted_name _menhir_env _menhir_stack _menhir_s _v

and _menhir_run3 : _menhir_env -> 'ttv_tail * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11100 "src/java/jSourceParser.ml"
) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState3

and _menhir_goto_option_package_declaration_ : _menhir_env -> 'ttv_tail -> 'tv_option_package_declaration_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv301 * 'tv_option_package_declaration_) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMPORT ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | CLASS | ENUM | EOF | INTERFACE | SEMICOLON ->
        _menhir_reduce136 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState8) : 'freshtv302)

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState470 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv11 * _menhir_state * 'tv_import_declaration) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv12)
    | MenhirState464 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv13 * _menhir_state * 'tv_type_declaration) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv14)
    | MenhirState456 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv15 * _menhir_state * 'tv_interface_member_declaration) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv16)
    | MenhirState453 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv17 * _menhir_state * 'tv_method_header) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv18)
    | MenhirState450 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv19 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv20)
    | MenhirState447 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv21 * _menhir_state * 'tv_enum_constant)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv22)
    | MenhirState441 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv23) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv24)
    | MenhirState434 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv25 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11172 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_option_argument_list_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv26)
    | MenhirState429 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv27 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv28)
    | MenhirState427 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv29 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv30)
    | MenhirState425 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv31 * _menhir_state) * _menhir_state * 'tv_dotted_name) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv32)
    | MenhirState424 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv33 * _menhir_state) * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv34)
    | MenhirState420 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv35 * _menhir_state * 'tv_dim_expr) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv36)
    | MenhirState419 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv37 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv38)
    | MenhirState418 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv39 * _menhir_state * 'tv_dim_expr) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv40)
    | MenhirState415 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv41 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_dims) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv42)
    | MenhirState408 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv43 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11221 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv44)
    | MenhirState401 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv45 * _menhir_state * 'tv_primary)) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11230 "src/java/jSourceParser.ml"
        ) * Lexing.position)) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv46)
    | MenhirState395 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv47 * _menhir_state * 'tv_class_body_declaration) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv48)
    | MenhirState388 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv49 * Lexing.position) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv50)
    | MenhirState386 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv51 * _menhir_state * 'tv_constructor_declarator) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv52)
    | MenhirState377 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv53 * _menhir_state * 'tv_block_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv54)
    | MenhirState376 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv55 * _menhir_state * 'tv_block_statement) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv56)
    | MenhirState369 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv57 * _menhir_state * 'tv_local_variable_type) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv58)
    | MenhirState365 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv59 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv60)
    | MenhirState358 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv61 * _menhir_state)) * _menhir_state * 'tv_expression)) * _menhir_state * 'tv_statement_no_short_if)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv62)
    | MenhirState355 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv63 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv64)
    | MenhirState353 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv65 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv66)
    | MenhirState351 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv67 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv68)
    | MenhirState340 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv69 * _menhir_state) * _menhir_state * 'tv_statement))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv70)
    | MenhirState337 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv71 * _menhir_state * 'tv_dotted_name) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv72)
    | MenhirState336 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv73 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv74)
    | MenhirState332 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv75 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv76)
    | MenhirState330 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv77 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) * _menhir_state * 'tv_variable_declarator_id)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv78)
    | MenhirState327 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv79 * _menhir_state)) * _menhir_state * 'tv_local_variable_type) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv80)
    | MenhirState300 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv81 * _menhir_state) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv82)
    | MenhirState297 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv83 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv84)
    | MenhirState294 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv85 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv86)
    | MenhirState290 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv87 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv88)
    | MenhirState289 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((((('freshtv89 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv90)
    | MenhirState287 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv91 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv92)
    | MenhirState285 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv93 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv94)
    | MenhirState283 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv95 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv96)
    | MenhirState281 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv97 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv98)
    | MenhirState280 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((((('freshtv99 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) * _menhir_state * 'tv_loption_for_update_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv100)
    | MenhirState277 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv101 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) * _menhir_state * 'tv_loption_expression_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv102)
    | MenhirState275 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv103 * _menhir_state)) * _menhir_state * 'tv_loption_for_init_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv104)
    | MenhirState267 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv105 * _menhir_state * 'tv_statement_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv106)
    | MenhirState262 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv107 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv108)
    | MenhirState260 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv109 * _menhir_state)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv110)
    | MenhirState258 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv111 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv112)
    | MenhirState256 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv113 * _menhir_state)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv114)
    | MenhirState254 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv115 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv116)
    | MenhirState252 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv117 * _menhir_state)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv118)
    | MenhirState250 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv119 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv120)
    | MenhirState247 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv121 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv122)
    | MenhirState244 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv123 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv124)
    | MenhirState240 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv125 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv126)
    | MenhirState237 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv127 * _menhir_state)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv128)
    | MenhirState235 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv129 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv130)
    | MenhirState231 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv131 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv132)
    | MenhirState227 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv133 * _menhir_state * 'tv_catch_clause) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv134)
    | MenhirState226 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv135 * _menhir_state * 'tv_catch_clause) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv136)
    | MenhirState222 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv137) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv138)
    | MenhirState219 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv139 * _menhir_state)) * _menhir_state * 'tv_catch_formal_parameter)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv140)
    | MenhirState216 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv141 * _menhir_state * 'tv_catch_type) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv142)
    | MenhirState214 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv143 * _menhir_state * 'tv_dotted_name)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv144)
    | MenhirState211 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv145 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv146)
    | MenhirState209 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv147 * _menhir_state) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv148)
    | MenhirState208 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv149 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv150)
    | MenhirState207 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv151 * _menhir_state)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv152)
    | MenhirState205 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv153 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv154)
    | MenhirState201 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv155 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv156)
    | MenhirState200 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv157 * _menhir_state * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv158)
    | MenhirState198 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv159 * _menhir_state * 'tv_method_header) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv160)
    | MenhirState193 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv161 * _menhir_state * 'tv_unann_type) * _menhir_state * 'tv_method_declarator) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv162)
    | MenhirState191 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv163 * _menhir_state * 'tv_variable_declarator)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv164)
    | MenhirState184 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv165 * _menhir_state * 'tv_conditional_or_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv166)
    | MenhirState182 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv167 * _menhir_state * 'tv_conditional_or_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv168)
    | MenhirState180 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv169 * _menhir_state * 'tv_conditional_or_expression)) * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv170)
    | MenhirState178 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv171 * _menhir_state * 'tv_conditional_or_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv172)
    | MenhirState175 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv173 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv174)
    | MenhirState174 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv175 * _menhir_state * 'tv_conditional_or_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv176)
    | MenhirState161 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv177 * _menhir_state * 'tv_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv178)
    | MenhirState157 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv179 * _menhir_state * 'tv_dotted_name) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv180)
    | MenhirState156 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv181 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv182)
    | MenhirState154 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv183 * _menhir_state * 'tv_conditional_or_expression)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv184)
    | MenhirState150 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv185 * _menhir_state * 'tv_dotted_name) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv186)
    | MenhirState149 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv187 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv188)
    | MenhirState146 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv189 * _menhir_state * 'tv_left_hand_side) * 'tv_assignment_operator) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv190)
    | MenhirState140 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv191 * _menhir_state) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv192)
    | MenhirState138 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv193 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv194)
    | MenhirState136 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv195 * _menhir_state * Lexing.position) * _menhir_state * 'tv_variable_initializer) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv196)
    | MenhirState132 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv197 * _menhir_state * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv198)
    | MenhirState131 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv199 * _menhir_state * 'tv_variable_declarator_id)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv200)
    | MenhirState127 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv201 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11622 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv202)
    | MenhirState126 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv203 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv204)
    | MenhirState124 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv205 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11636 "src/java/jSourceParser.ml"
        ) * Lexing.position) * 'tv_option_superclass_) * _menhir_state * 'tv_option_superinterfaces_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv206)
    | MenhirState123 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv207 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11645 "src/java/jSourceParser.ml"
        ) * Lexing.position) * 'tv_option_superclass_) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv208)
    | MenhirState120 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv209) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv210)
    | MenhirState115 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv211 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11658 "src/java/jSourceParser.ml"
        ) * Lexing.position)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv212)
    | MenhirState112 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv213 * _menhir_state * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv214)
    | MenhirState111 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv215 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name)) * _menhir_state * 'tv_loption_argument_list_)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv216)
    | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv217 * _menhir_state * 'tv_primary))) * _menhir_state * 'tv_dotted_name)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv218)
    | MenhirState104 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv219 * _menhir_state * 'tv_primary))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv220)
    | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv221 * _menhir_state * 'tv_primary_no_new_array)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv222)
    | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv223 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv224)
    | MenhirState95 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv225 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv226)
    | MenhirState91 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv227 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11702 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state) * _menhir_state * 'tv_dotted_name)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv228)
    | MenhirState89 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv229 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11711 "src/java/jSourceParser.ml"
        ) * Lexing.position)) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv230)
    | MenhirState88 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv231 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11720 "src/java/jSourceParser.ml"
        ) * Lexing.position)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv232)
    | MenhirState86 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv233 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv234)
    | MenhirState84 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv235 * _menhir_state) * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv236)
    | MenhirState82 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv237 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv238)
    | MenhirState81 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv239 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv240)
    | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv241 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv242)
    | MenhirState79 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv243 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv244)
    | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv245 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv246)
    | MenhirState73 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv247 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11764 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv248)
    | MenhirState72 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv249 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11773 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv250)
    | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv251 * Lexing.position) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv252)
    | MenhirState67 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv253 * _menhir_state * 'tv_dotted_name)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv254)
    | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv255 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv256)
    | MenhirState63 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv257 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11796 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv258)
    | MenhirState57 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv259 * _menhir_state * 'tv_exception_type)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv260)
    | MenhirState53 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv261 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv262)
    | MenhirState52 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv263 * _menhir_state) * _menhir_state * 'tv_method_declarator) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv264)
    | MenhirState50 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv265 * _menhir_state * 'tv_dotted_name) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv266)
    | MenhirState48 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv267 * _menhir_state * 'tv_formal_parameter)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv268)
    | MenhirState45 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv269 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11830 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) * _menhir_state * 'tv_formal_parameter_list)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv270)
    | MenhirState36 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv271 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11839 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv272)
    | MenhirState33 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv273 * _menhir_state * 'tv_unann_type) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv274)
    | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv275 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv276)
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv277 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv278)
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv279 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv280)
    | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv281 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11868 "src/java/jSourceParser.ml"
        ) * Lexing.position) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv282)
    | MenhirState24 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv283 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11877 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv284)
    | MenhirState23 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv285 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv286)
    | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv287 * Lexing.position) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv288)
    | MenhirState18 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv289 * 'tv_option_package_declaration_) * _menhir_state * 'tv_list_import_declaration_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv290)
    | MenhirState12 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv291 * _menhir_state) * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11900 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv292)
    | MenhirState10 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv293 * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11909 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv294)
    | MenhirState8 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv295 * 'tv_option_package_declaration_) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv296)
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv297 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11921 "src/java/jSourceParser.ml"
        ) * Lexing.position)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv298)
    | MenhirState1 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv299) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv300)

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11933 "src/java/jSourceParser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DOT ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack)
    | ASSIGNOP | BINOP | COLON | COMMA | EQ | IDENT _ | IMPLEMENTS | INCR_DECR | INSTANCEOF | LANGLE | LBRACKET | LPAREN | LSBRACKET | PIPE | QMARK | RANGLE | RBRACKET | RPAREN | RSBRACKET | SEMICOLON | THREEDOTS ->
        _menhir_reduce89 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv9 * _menhir_state * (
# 78 "src/java/jSourceParser.mly"
       (string)
# 11951 "src/java/jSourceParser.ml"
        ) * Lexing.position) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv10)

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 89 "src/java/jSourceParser.mly"
       (JSourceAST.file_content)
# 11971 "src/java/jSourceParser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env =
      let (lexer : Lexing.lexbuf -> token) = lexer in
      let (lexbuf : Lexing.lexbuf) = lexbuf in
      ((let _tok = Obj.magic () in
      {
        _menhir_lexer = lexer;
        _menhir_lexbuf = lexbuf;
        _menhir_token = _tok;
        _menhir_error = false;
      }) : _menhir_env)
    in
    Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv7) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | PACKAGE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv1) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState1) : 'freshtv2)
    | CLASS | ENUM | EOF | IMPORT | INTERFACE | SEMICOLON ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv3) = Obj.magic _menhir_stack in
        ((let _v : 'tv_option_package_declaration_ = 
# 114 "<standard.mly>"
    ( None )
# 12008 "src/java/jSourceParser.ml"
         in
        _menhir_goto_option_package_declaration_ _menhir_env _menhir_stack _v) : 'freshtv4)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv5) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv6)) : 'freshtv8))

# 269 "<standard.mly>"
  

# 12021 "src/java/jSourceParser.ml"
