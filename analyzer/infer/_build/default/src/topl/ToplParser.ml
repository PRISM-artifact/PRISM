
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | WHEN
    | UID of (
# 15 "src/topl/ToplParser.mly"
       (string)
# 12 "src/topl/ToplParser.ml"
  )
    | STRING of (
# 14 "src/topl/ToplParser.mly"
       (string)
# 17 "src/topl/ToplParser.ml"
  )
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
    | LID of (
# 13 "src/topl/ToplParser.mly"
       (string)
# 32 "src/topl/ToplParser.ml"
  )
    | LE
    | LC
    | INTEGER of (
# 12 "src/topl/ToplParser.mly"
       (int)
# 39 "src/topl/ToplParser.ml"
  )
    | INDENT of (
# 11 "src/topl/ToplParser.mly"
       (int)
# 44 "src/topl/ToplParser.ml"
  )
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
  | MenhirState81
  | MenhirState70
  | MenhirState69
  | MenhirState64
  | MenhirState62
  | MenhirState56
  | MenhirState50
  | MenhirState49
  | MenhirState46
  | MenhirState43
  | MenhirState42
  | MenhirState39
  | MenhirState27
  | MenhirState26
  | MenhirState18
  | MenhirState16
  | MenhirState14
  | MenhirState13
  | MenhirState11
  | MenhirState8
  | MenhirState1
  | MenhirState0

# 7 "src/topl/ToplParser.mly"
  
  open !IStd

# 100 "src/topl/ToplParser.ml"

let rec _menhir_goto_list_and_predicate_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_list_and_predicate_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState42 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv351 * _menhir_state * 'tv_predicate) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_list_and_predicate_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv349 * _menhir_state * 'tv_predicate) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((ps : 'tv_list_and_predicate_) : 'tv_list_and_predicate_) = _v in
        ((let (_menhir_stack, _menhir_s, (p : 'tv_predicate)) = _menhir_stack in
        let _v : 'tv_condition_expression = 
# 78 "src/topl/ToplParser.mly"
                                                    ( p :: ps )
# 118 "src/topl/ToplParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv347) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_condition_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv345 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_condition_expression) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv343 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((ps : 'tv_condition_expression) : 'tv_condition_expression) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_condition = 
# 76 "src/topl/ToplParser.mly"
                                        ( ps )
# 137 "src/topl/ToplParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv341) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_condition) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv339) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_condition) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv337) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_condition) : 'tv_condition) = _v in
        ((let _v : 'tv_option_condition_ = 
# 116 "<standard.mly>"
    ( Some x )
# 154 "src/topl/ToplParser.ml"
         in
        _menhir_goto_option_condition_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv338)) : 'freshtv340)) : 'freshtv342)) : 'freshtv344)) : 'freshtv346)) : 'freshtv348)) : 'freshtv350)) : 'freshtv352)
    | MenhirState46 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv355 * _menhir_state * 'tv_and_predicate) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_list_and_predicate_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv353 * _menhir_state * 'tv_and_predicate) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_list_and_predicate_) : 'tv_list_and_predicate_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_and_predicate)) = _menhir_stack in
        let _v : 'tv_list_and_predicate_ = 
# 213 "<standard.mly>"
    ( x :: xs )
# 170 "src/topl/ToplParser.ml"
         in
        _menhir_goto_list_and_predicate_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv354)) : 'freshtv356)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_SEMI_assignment_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_SEMI_assignment_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState50 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv331 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_SEMI_assignment_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv329 * _menhir_state) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((a : 'tv_separated_nonempty_list_SEMI_assignment_) : 'tv_separated_nonempty_list_SEMI_assignment_) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_action = 
# 110 "src/topl/ToplParser.mly"
                                                           ( a )
# 193 "src/topl/ToplParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv327) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_action) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv325) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_action) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv323) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_action) : 'tv_action) = _v in
        ((let _v : 'tv_option_action_ = 
# 116 "<standard.mly>"
    ( Some x )
# 210 "src/topl/ToplParser.ml"
         in
        _menhir_goto_option_action_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv324)) : 'freshtv326)) : 'freshtv328)) : 'freshtv330)) : 'freshtv332)
    | MenhirState56 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv335 * _menhir_state * 'tv_assignment)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_SEMI_assignment_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv333 * _menhir_state * 'tv_assignment)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_SEMI_assignment_) : 'tv_separated_nonempty_list_SEMI_assignment_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_assignment)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_SEMI_assignment_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 227 "src/topl/ToplParser.ml"
         in
        _menhir_goto_separated_nonempty_list_SEMI_assignment_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv334)) : 'freshtv336)
    | _ ->
        _menhir_fail ()

and _menhir_reduce12 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_list_and_predicate_ = 
# 211 "<standard.mly>"
    ( [] )
# 238 "src/topl/ToplParser.ml"
     in
    _menhir_goto_list_and_predicate_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run43 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | INTEGER _v ->
        _menhir_run30 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
    | LID _v ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
    | UID _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState43

and _menhir_goto_option_action_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_action_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState49 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv317 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 267 "src/topl/ToplParser.ml"
        ))) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 271 "src/topl/ToplParser.ml"
        ))) * _menhir_state * 'tv_option_condition_) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_option_action_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv315 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 279 "src/topl/ToplParser.ml"
        ))) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 283 "src/topl/ToplParser.ml"
        ))) * _menhir_state * 'tv_option_condition_) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((action : 'tv_option_action_) : 'tv_option_action_) = _v in
        ((let ((((_menhir_stack, _menhir_s), (arr : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 290 "src/topl/ToplParser.ml"
        ))), (index : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 294 "src/topl/ToplParser.ml"
        ))), _, (condition : 'tv_option_condition_)) = _menhir_stack in
        let _6 = () in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_label = 
# 71 "src/topl/ToplParser.mly"
    ( let arguments = Some [arr; index] in
      let condition = Option.value ~default:[] condition in
      let action = Option.value ~default:[] action in
      Some ToplAst.{ arguments; condition; action; pattern= ToplAst.ArrayWritePattern } )
# 306 "src/topl/ToplParser.ml"
         in
        _menhir_goto_label _menhir_env _menhir_stack _menhir_s _v) : 'freshtv316)) : 'freshtv318)
    | MenhirState70 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv321 * _menhir_state * 'tv_procedure_pattern) * 'tv_option_arguments_pattern_) * _menhir_state * 'tv_option_condition_) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_option_action_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv319 * _menhir_state * 'tv_procedure_pattern) * 'tv_option_arguments_pattern_) * _menhir_state * 'tv_option_condition_) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((action : 'tv_option_action_) : 'tv_option_action_) = _v in
        ((let (((_menhir_stack, _menhir_s, (pattern : 'tv_procedure_pattern)), (arguments : 'tv_option_arguments_pattern_)), _, (condition : 'tv_option_condition_)) = _menhir_stack in
        let _v : 'tv_label = 
# 66 "src/topl/ToplParser.mly"
    ( let condition = Option.value ~default:[] condition in
      let action = Option.value ~default:[] action in
      Some ToplAst.{ arguments; condition; action; pattern } )
# 324 "src/topl/ToplParser.ml"
         in
        _menhir_goto_label _menhir_env _menhir_stack _menhir_s _v) : 'freshtv320)) : 'freshtv322)
    | _ ->
        _menhir_fail ()

and _menhir_run51 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 13 "src/topl/ToplParser.mly"
       (string)
# 333 "src/topl/ToplParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COLONEQ ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv311 * _menhir_state * (
# 13 "src/topl/ToplParser.mly"
       (string)
# 345 "src/topl/ToplParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UID _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv307 * _menhir_state * (
# 13 "src/topl/ToplParser.mly"
       (string)
# 355 "src/topl/ToplParser.ml"
            ))) = Obj.magic _menhir_stack in
            let (_v : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 360 "src/topl/ToplParser.ml"
            )) = _v in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv305 * _menhir_state * (
# 13 "src/topl/ToplParser.mly"
       (string)
# 367 "src/topl/ToplParser.ml"
            ))) = Obj.magic _menhir_stack in
            let ((v : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 372 "src/topl/ToplParser.ml"
            )) : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 376 "src/topl/ToplParser.ml"
            )) = _v in
            ((let (_menhir_stack, _menhir_s, (r : (
# 13 "src/topl/ToplParser.mly"
       (string)
# 381 "src/topl/ToplParser.ml"
            ))) = _menhir_stack in
            let _2 = () in
            let _v : 'tv_assignment = 
# 113 "src/topl/ToplParser.mly"
                        ( (r, v) )
# 387 "src/topl/ToplParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv303) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_assignment) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv301 * _menhir_state * 'tv_assignment) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | SEMI ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv295 * _menhir_state * 'tv_assignment) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | LID _v ->
                    _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState56 _v
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState56) : 'freshtv296)
            | LID _ | RC | UID _ ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv297 * _menhir_state * 'tv_assignment) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, (x : 'tv_assignment)) = _menhir_stack in
                let _v : 'tv_separated_nonempty_list_SEMI_assignment_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 418 "src/topl/ToplParser.ml"
                 in
                _menhir_goto_separated_nonempty_list_SEMI_assignment_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv298)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv299 * _menhir_state * 'tv_assignment) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv300)) : 'freshtv302)) : 'freshtv304)) : 'freshtv306)) : 'freshtv308)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv309 * _menhir_state * (
# 13 "src/topl/ToplParser.mly"
       (string)
# 435 "src/topl/ToplParser.ml"
            ))) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv310)) : 'freshtv312)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv313 * _menhir_state * (
# 13 "src/topl/ToplParser.mly"
       (string)
# 446 "src/topl/ToplParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv314)

and _menhir_goto_option_predop_value_ : _menhir_env -> 'ttv_tail -> 'tv_option_predop_value_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv293 * _menhir_state * 'tv_value) = Obj.magic _menhir_stack in
    let (_v : 'tv_option_predop_value_) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv291 * _menhir_state * 'tv_value) = Obj.magic _menhir_stack in
    let ((ov2 : 'tv_option_predop_value_) : 'tv_option_predop_value_) = _v in
    ((let (_menhir_stack, _menhir_s, (v1 : 'tv_value)) = _menhir_stack in
    let _v : 'tv_predicate = 
# 82 "src/topl/ToplParser.mly"
    ( let f (o, v2) = ToplAst.Binop (o, v1, v2) in
      Option.value_map ~default:(ToplAst.Value v1) ~f ov2 )
# 464 "src/topl/ToplParser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv289) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_predicate) = _v in
    ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv279 * _menhir_state * 'tv_predicate) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | AND ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | ARROWARROW | LID _ | RC | UID _ ->
            _menhir_reduce12 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState42) : 'freshtv280)
    | MenhirState43 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv287 * _menhir_state) * _menhir_state * 'tv_predicate) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv285 * _menhir_state) * _menhir_state * 'tv_predicate) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, (p : 'tv_predicate)) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_and_predicate = 
# 101 "src/topl/ToplParser.mly"
                               ( p )
# 496 "src/topl/ToplParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv283) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_and_predicate) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv281 * _menhir_state * 'tv_and_predicate) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | AND ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState46
        | ARROWARROW | LID _ | RC | UID _ ->
            _menhir_reduce12 _menhir_env (Obj.magic _menhir_stack) MenhirState46
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState46) : 'freshtv282)) : 'freshtv284)) : 'freshtv286)) : 'freshtv288)
    | _ ->
        _menhir_fail ()) : 'freshtv290)) : 'freshtv292)) : 'freshtv294)

and _menhir_goto_predop : _menhir_env -> 'ttv_tail -> 'tv_predop -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv277 * 'tv_predop) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | INTEGER _v ->
        _menhir_run30 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
    | LID _v ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
    | UID _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState39) : 'freshtv278)

and _menhir_goto_list_transition_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_list_transition_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState14 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv263 * _menhir_state * 'tv_transition) * _menhir_state * 'tv_list_transition_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv261 * _menhir_state * 'tv_transition) * _menhir_state * 'tv_list_transition_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_transition)), _, (xs : 'tv_list_transition_)) = _menhir_stack in
        let _v : 'tv_list_transition_ = 
# 213 "<standard.mly>"
    ( x :: xs )
# 551 "src/topl/ToplParser.ml"
         in
        _menhir_goto_list_transition_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv262)) : 'freshtv264)
    | MenhirState13 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv275 * _menhir_state) * _menhir_state * 'tv_identifier)) * 'tv_option_message_) * _menhir_state * 'tv_list_prefix_) * _menhir_state * 'tv_list_transition_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RC ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv271 * _menhir_state) * _menhir_state * 'tv_identifier)) * 'tv_option_message_) * _menhir_state * 'tv_list_prefix_) * _menhir_state * 'tv_list_transition_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv269 * _menhir_state) * _menhir_state * 'tv_identifier)) * 'tv_option_message_) * _menhir_state * 'tv_list_prefix_) * _menhir_state * 'tv_list_transition_) = Obj.magic _menhir_stack in
            ((let (((((_menhir_stack, _menhir_s), _, (name : 'tv_identifier)), (message : 'tv_option_message_)), _, (prefixes : 'tv_list_prefix_)), _, (transitions : 'tv_list_transition_)) = _menhir_stack in
            let _7 = () in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_one_property = 
# 50 "src/topl/ToplParser.mly"
    ( ToplAst.{name; message; prefixes; transitions} )
# 573 "src/topl/ToplParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv267) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_one_property) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv265 * _menhir_state * 'tv_one_property) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | PROPERTY ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | EOF ->
                _menhir_reduce14 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState81) : 'freshtv266)) : 'freshtv268)) : 'freshtv270)) : 'freshtv272)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv273 * _menhir_state) * _menhir_state * 'tv_identifier)) * 'tv_option_message_) * _menhir_state * 'tv_list_prefix_) * _menhir_state * 'tv_list_transition_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv274)) : 'freshtv276)
    | _ ->
        _menhir_fail ()

and _menhir_reduce24 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_option_action_ = 
# 114 "<standard.mly>"
    ( None )
# 608 "src/topl/ToplParser.ml"
     in
    _menhir_goto_option_action_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run50 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LID _v ->
        _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState50

and _menhir_goto_value : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_value -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState43 | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv249 * _menhir_state * 'tv_value) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | EQ ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv223) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv221) = Obj.magic _menhir_stack in
            ((let _1 = () in
            let _v : 'tv_predop = 
# 94 "src/topl/ToplParser.mly"
       ( ToplAst.OpEq )
# 645 "src/topl/ToplParser.ml"
             in
            _menhir_goto_predop _menhir_env _menhir_stack _v) : 'freshtv222)) : 'freshtv224)
        | GE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv227) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv225) = Obj.magic _menhir_stack in
            ((let _1 = () in
            let _v : 'tv_predop = 
# 99 "src/topl/ToplParser.mly"
       ( ToplAst.OpGe )
# 658 "src/topl/ToplParser.ml"
             in
            _menhir_goto_predop _menhir_env _menhir_stack _v) : 'freshtv226)) : 'freshtv228)
        | GT ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv231) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv229) = Obj.magic _menhir_stack in
            ((let _1 = () in
            let _v : 'tv_predop = 
# 98 "src/topl/ToplParser.mly"
       ( ToplAst.OpGt )
# 671 "src/topl/ToplParser.ml"
             in
            _menhir_goto_predop _menhir_env _menhir_stack _v) : 'freshtv230)) : 'freshtv232)
        | LE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv235) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv233) = Obj.magic _menhir_stack in
            ((let _1 = () in
            let _v : 'tv_predop = 
# 97 "src/topl/ToplParser.mly"
       ( ToplAst.OpLe )
# 684 "src/topl/ToplParser.ml"
             in
            _menhir_goto_predop _menhir_env _menhir_stack _v) : 'freshtv234)) : 'freshtv236)
        | LT ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv239) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv237) = Obj.magic _menhir_stack in
            ((let _1 = () in
            let _v : 'tv_predop = 
# 96 "src/topl/ToplParser.mly"
       ( ToplAst.OpLt )
# 697 "src/topl/ToplParser.ml"
             in
            _menhir_goto_predop _menhir_env _menhir_stack _v) : 'freshtv238)) : 'freshtv240)
        | NE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv243) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv241) = Obj.magic _menhir_stack in
            ((let _1 = () in
            let _v : 'tv_predop = 
# 95 "src/topl/ToplParser.mly"
       ( ToplAst.OpNe )
# 710 "src/topl/ToplParser.ml"
             in
            _menhir_goto_predop _menhir_env _menhir_stack _v) : 'freshtv242)) : 'freshtv244)
        | AND | ARROWARROW | LID _ | RC | UID _ ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv245) = Obj.magic _menhir_stack in
            ((let _v : 'tv_option_predop_value_ = 
# 114 "<standard.mly>"
    ( None )
# 719 "src/topl/ToplParser.ml"
             in
            _menhir_goto_option_predop_value_ _menhir_env _menhir_stack _v) : 'freshtv246)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv247 * _menhir_state * 'tv_value) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv248)) : 'freshtv250)
    | MenhirState39 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv259 * 'tv_predop) * _menhir_state * 'tv_value) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv257 * 'tv_predop) * _menhir_state * 'tv_value) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, (o : 'tv_predop)), _, (v : 'tv_value)) = _menhir_stack in
        let _v : 'tv_predop_value = 
# 91 "src/topl/ToplParser.mly"
                               ( (o, v) )
# 738 "src/topl/ToplParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv255) = _menhir_stack in
        let (_v : 'tv_predop_value) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv253) = Obj.magic _menhir_stack in
        let (_v : 'tv_predop_value) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv251) = Obj.magic _menhir_stack in
        let ((x : 'tv_predop_value) : 'tv_predop_value) = _v in
        ((let _v : 'tv_option_predop_value_ = 
# 116 "<standard.mly>"
    ( Some x )
# 752 "src/topl/ToplParser.ml"
         in
        _menhir_goto_option_predop_value_ _menhir_env _menhir_stack _v) : 'freshtv252)) : 'freshtv254)) : 'freshtv256)) : 'freshtv258)) : 'freshtv260)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_UID_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_UID_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv215 * _menhir_state * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 766 "src/topl/ToplParser.ml"
        ))) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_UID_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv213 * _menhir_state * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 774 "src/topl/ToplParser.ml"
        ))) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_UID_) : 'tv_separated_nonempty_list_COMMA_UID_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 781 "src/topl/ToplParser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_UID_ = 
# 243 "<standard.mly>"
    ( x :: xs )
# 787 "src/topl/ToplParser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_UID_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv214)) : 'freshtv216)
    | MenhirState62 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv219) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_UID_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv217) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_COMMA_UID_) : 'tv_separated_nonempty_list_COMMA_UID_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_UID__ = 
# 144 "<standard.mly>"
    ( x )
# 802 "src/topl/ToplParser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_UID__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv218)) : 'freshtv220)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list_prefix_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_list_prefix_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState11 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv209 * _menhir_state * 'tv_prefix) * _menhir_state * 'tv_list_prefix_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv207 * _menhir_state * 'tv_prefix) * _menhir_state * 'tv_list_prefix_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_prefix)), _, (xs : 'tv_list_prefix_)) = _menhir_stack in
        let _v : 'tv_list_prefix_ = 
# 213 "<standard.mly>"
    ( x :: xs )
# 821 "src/topl/ToplParser.ml"
         in
        _menhir_goto_list_prefix_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv208)) : 'freshtv210)
    | MenhirState8 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv211 * _menhir_state) * _menhir_state * 'tv_identifier)) * 'tv_option_message_) * _menhir_state * 'tv_list_prefix_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
        | UID _v ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
        | RC ->
            _menhir_reduce18 _menhir_env (Obj.magic _menhir_stack) MenhirState13
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13) : 'freshtv212)
    | _ ->
        _menhir_fail ()

and _menhir_reduce18 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_list_transition_ = 
# 211 "<standard.mly>"
    ( [] )
# 848 "src/topl/ToplParser.ml"
     in
    _menhir_goto_list_transition_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_option_condition_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_condition_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv203 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 861 "src/topl/ToplParser.ml"
        ))) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 865 "src/topl/ToplParser.ml"
        ))) * _menhir_state * 'tv_option_condition_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ARROWARROW ->
            _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | LID _ | RC | UID _ ->
            _menhir_reduce24 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState49) : 'freshtv204)
    | MenhirState69 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv205 * _menhir_state * 'tv_procedure_pattern) * 'tv_option_arguments_pattern_) * _menhir_state * 'tv_option_condition_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ARROWARROW ->
            _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState70
        | LID _ | RC | UID _ ->
            _menhir_reduce24 _menhir_env (Obj.magic _menhir_stack) MenhirState70
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState70) : 'freshtv206)
    | _ ->
        _menhir_fail ()

and _menhir_run28 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 15 "src/topl/ToplParser.mly"
       (string)
# 898 "src/topl/ToplParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv201) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((id : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 908 "src/topl/ToplParser.ml"
    )) : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 912 "src/topl/ToplParser.ml"
    )) = _v in
    ((let _v : 'tv_value = 
# 87 "src/topl/ToplParser.mly"
           ( ToplAst.Binding id )
# 917 "src/topl/ToplParser.ml"
     in
    _menhir_goto_value _menhir_env _menhir_stack _menhir_s _v) : 'freshtv202)

and _menhir_run29 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 13 "src/topl/ToplParser.mly"
       (string)
# 924 "src/topl/ToplParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv199) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((id : (
# 13 "src/topl/ToplParser.mly"
       (string)
# 934 "src/topl/ToplParser.ml"
    )) : (
# 13 "src/topl/ToplParser.mly"
       (string)
# 938 "src/topl/ToplParser.ml"
    )) = _v in
    ((let _v : 'tv_value = 
# 86 "src/topl/ToplParser.mly"
           ( ToplAst.Register id )
# 943 "src/topl/ToplParser.ml"
     in
    _menhir_goto_value _menhir_env _menhir_stack _menhir_s _v) : 'freshtv200)

and _menhir_run30 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 12 "src/topl/ToplParser.mly"
       (int)
# 950 "src/topl/ToplParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv197) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((x : (
# 12 "src/topl/ToplParser.mly"
       (int)
# 960 "src/topl/ToplParser.ml"
    )) : (
# 12 "src/topl/ToplParser.mly"
       (int)
# 964 "src/topl/ToplParser.ml"
    )) = _v in
    ((let _v : 'tv_value = 
# 88 "src/topl/ToplParser.mly"
              ( ToplAst.Constant (LiteralInt x) (* (Exp.Const (Const.Cint (IntLit.of_int x)))*) )
# 969 "src/topl/ToplParser.ml"
     in
    _menhir_goto_value _menhir_env _menhir_stack _menhir_s _v) : 'freshtv198)

and _menhir_goto_option_arguments_pattern_ : _menhir_env -> 'ttv_tail -> 'tv_option_arguments_pattern_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv195 * _menhir_state * 'tv_procedure_pattern) * 'tv_option_arguments_pattern_) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | WHEN ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | ARROWARROW | LID _ | RC | UID _ ->
        _menhir_reduce28 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState69) : 'freshtv196)

and _menhir_goto_loption_separated_nonempty_list_COMMA_UID__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_COMMA_UID__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv193) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_UID__) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RP ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv189) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_UID__) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv187) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_UID__) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _, (xs : 'tv_loption_separated_nonempty_list_COMMA_UID__)) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : 'tv_arguments_pattern = let a = 
# 232 "<standard.mly>"
    ( xs )
# 1010 "src/topl/ToplParser.ml"
         in
        
# 107 "src/topl/ToplParser.mly"
                                                      ( a )
# 1015 "src/topl/ToplParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv185) = _menhir_stack in
        let (_v : 'tv_arguments_pattern) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv183) = Obj.magic _menhir_stack in
        let (_v : 'tv_arguments_pattern) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv181) = Obj.magic _menhir_stack in
        let ((x : 'tv_arguments_pattern) : 'tv_arguments_pattern) = _v in
        ((let _v : 'tv_option_arguments_pattern_ = 
# 116 "<standard.mly>"
    ( Some x )
# 1029 "src/topl/ToplParser.ml"
         in
        _menhir_goto_option_arguments_pattern_ _menhir_env _menhir_stack _v) : 'freshtv182)) : 'freshtv184)) : 'freshtv186)) : 'freshtv188)) : 'freshtv190)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv191) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_UID__) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv192)) : 'freshtv194)

and _menhir_run63 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1043 "src/topl/ToplParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv175 * _menhir_state * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1055 "src/topl/ToplParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UID _v ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64) : 'freshtv176)
    | RP ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv177 * _menhir_state * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1071 "src/topl/ToplParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (x : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1076 "src/topl/ToplParser.ml"
        ))) = _menhir_stack in
        let _v : 'tv_separated_nonempty_list_COMMA_UID_ = 
# 241 "<standard.mly>"
    ( [ x ] )
# 1081 "src/topl/ToplParser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_UID_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv178)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv179 * _menhir_state * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1091 "src/topl/ToplParser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv180)

and _menhir_reduce16 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_list_prefix_ = 
# 211 "<standard.mly>"
    ( [] )
# 1101 "src/topl/ToplParser.ml"
     in
    _menhir_goto_list_prefix_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run9 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | STRING _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv171 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1117 "src/topl/ToplParser.ml"
        )) = _v in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv169 * _menhir_state) = Obj.magic _menhir_stack in
        let ((s : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1125 "src/topl/ToplParser.ml"
        )) : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1129 "src/topl/ToplParser.ml"
        )) = _v in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : 'tv_prefix = 
# 54 "src/topl/ToplParser.mly"
                        ( s )
# 1136 "src/topl/ToplParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv167) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_prefix) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv165 * _menhir_state * 'tv_prefix) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | PREFIX ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState11
        | LID _ | RC | UID _ ->
            _menhir_reduce16 _menhir_env (Obj.magic _menhir_stack) MenhirState11
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState11) : 'freshtv166)) : 'freshtv168)) : 'freshtv170)) : 'freshtv172)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv173 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv174)

and _menhir_goto_label : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_label -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ((('freshtv163 * _menhir_state * 'tv_state)) * _menhir_state * 'tv_state)) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_label) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ((('freshtv161 * _menhir_state * 'tv_state)) * _menhir_state * 'tv_state)) = Obj.magic _menhir_stack in
    let (_ : _menhir_state) = _menhir_s in
    let ((label : 'tv_label) : 'tv_label) = _v in
    ((let ((_menhir_stack, _menhir_s, (source : 'tv_state)), _, (target : 'tv_state)) = _menhir_stack in
    let _4 = () in
    let _2 = () in
    let _v : 'tv_transition = 
# 58 "src/topl/ToplParser.mly"
    ( ToplAst.{source; target; label} )
# 1180 "src/topl/ToplParser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv159) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_transition) = _v in
    ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv157 * _menhir_state * 'tv_transition) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
    | UID _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
    | RC ->
        _menhir_reduce18 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState14) : 'freshtv158)) : 'freshtv160)) : 'freshtv162)) : 'freshtv164)

and _menhir_reduce28 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_option_condition_ = 
# 114 "<standard.mly>"
    ( None )
# 1208 "src/topl/ToplParser.ml"
     in
    _menhir_goto_option_condition_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run27 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | INTEGER _v ->
        _menhir_run30 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | LID _v ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | UID _v ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState27

and _menhir_goto_procedure_pattern : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_procedure_pattern -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv155 * _menhir_state * 'tv_procedure_pattern) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LP ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv149) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UID _v ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
        | RP ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv147) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState62 in
            ((let _v : 'tv_loption_separated_nonempty_list_COMMA_UID__ = 
# 142 "<standard.mly>"
    ( [] )
# 1252 "src/topl/ToplParser.ml"
             in
            _menhir_goto_loption_separated_nonempty_list_COMMA_UID__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv148)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState62) : 'freshtv150)
    | ARROWARROW | LID _ | RC | UID _ | WHEN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv151) = Obj.magic _menhir_stack in
        ((let _v : 'tv_option_arguments_pattern_ = 
# 114 "<standard.mly>"
    ( None )
# 1265 "src/topl/ToplParser.ml"
         in
        _menhir_goto_option_arguments_pattern_ _menhir_env _menhir_stack _v) : 'freshtv152)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv153 * _menhir_state * 'tv_procedure_pattern) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv154)) : 'freshtv156)

and _menhir_goto_option_message_ : _menhir_env -> 'ttv_tail -> 'tv_option_message_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ((('freshtv145 * _menhir_state) * _menhir_state * 'tv_identifier)) * 'tv_option_message_) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | PREFIX ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | LID _ | RC | UID _ ->
        _menhir_reduce16 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState8) : 'freshtv146)

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_identifier : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_identifier -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState1 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv91 * _menhir_state) * _menhir_state * 'tv_identifier) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LC ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv87 * _menhir_state) * _menhir_state * 'tv_identifier) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | MESSAGE ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv81) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | STRING _v ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv77) = Obj.magic _menhir_stack in
                    let (_v : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1326 "src/topl/ToplParser.ml"
                    )) = _v in
                    ((let _menhir_env = _menhir_discard _menhir_env in
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv75) = Obj.magic _menhir_stack in
                    let ((s : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1334 "src/topl/ToplParser.ml"
                    )) : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1338 "src/topl/ToplParser.ml"
                    )) = _v in
                    ((let _1 = () in
                    let _v : 'tv_message = 
# 52 "src/topl/ToplParser.mly"
                          ( s )
# 1344 "src/topl/ToplParser.ml"
                     in
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv73) = _menhir_stack in
                    let (_v : 'tv_message) = _v in
                    ((let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv71) = Obj.magic _menhir_stack in
                    let (_v : 'tv_message) = _v in
                    ((let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv69) = Obj.magic _menhir_stack in
                    let ((x : 'tv_message) : 'tv_message) = _v in
                    ((let _v : 'tv_option_message_ = 
# 116 "<standard.mly>"
    ( Some x )
# 1358 "src/topl/ToplParser.ml"
                     in
                    _menhir_goto_option_message_ _menhir_env _menhir_stack _v) : 'freshtv70)) : 'freshtv72)) : 'freshtv74)) : 'freshtv76)) : 'freshtv78)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv79) = Obj.magic _menhir_stack in
                    (raise _eRR : 'freshtv80)) : 'freshtv82)
            | LID _ | PREFIX | RC | UID _ ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv83) = Obj.magic _menhir_stack in
                ((let _v : 'tv_option_message_ = 
# 114 "<standard.mly>"
    ( None )
# 1373 "src/topl/ToplParser.ml"
                 in
                _menhir_goto_option_message_ _menhir_env _menhir_stack _v) : 'freshtv84)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv85 * _menhir_state) * _menhir_state * 'tv_identifier)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv86)) : 'freshtv88)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv89 * _menhir_state) * _menhir_state * 'tv_identifier) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv90)) : 'freshtv92)
    | MenhirState18 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv95 * _menhir_state * 'tv_identifier) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv93 * _menhir_state * 'tv_identifier) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (i : 'tv_identifier)) = _menhir_stack in
        let _v : 'tv_procedure_pattern = 
# 104 "src/topl/ToplParser.mly"
                 ( ToplAst.ProcedureNamePattern i )
# 1399 "src/topl/ToplParser.ml"
         in
        _menhir_goto_procedure_pattern _menhir_env _menhir_stack _menhir_s _v) : 'freshtv94)) : 'freshtv96)
    | MenhirState13 | MenhirState14 | MenhirState16 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv143 * _menhir_state * 'tv_identifier) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv141 * _menhir_state * 'tv_identifier) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (i : 'tv_identifier)) = _menhir_stack in
        let _v : 'tv_state = 
# 60 "src/topl/ToplParser.mly"
                    ( i )
# 1411 "src/topl/ToplParser.ml"
         in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv139) = _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_state) = _v in
        ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        match _menhir_s with
        | MenhirState13 | MenhirState14 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv101 * _menhir_state * 'tv_state) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ARROW ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv97 * _menhir_state * 'tv_state) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | LID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState16 _v
                | UID _v ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState16 _v
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState16) : 'freshtv98)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv99 * _menhir_state * 'tv_state) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv100)) : 'freshtv102)
        | MenhirState16 ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv137 * _menhir_state * 'tv_state)) * _menhir_state * 'tv_state) = Obj.magic _menhir_stack in
            ((assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | COLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv133 * _menhir_state * 'tv_state)) * _menhir_state * 'tv_state) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | ARRAYWRITE ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv123) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = MenhirState18 in
                    ((let _menhir_stack = (_menhir_stack, _menhir_s) in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    match _tok with
                    | LP ->
                        let (_menhir_env : _menhir_env) = _menhir_env in
                        let (_menhir_stack : 'freshtv119 * _menhir_state) = Obj.magic _menhir_stack in
                        ((let _menhir_env = _menhir_discard _menhir_env in
                        let _tok = _menhir_env._menhir_token in
                        match _tok with
                        | UID _v ->
                            let (_menhir_env : _menhir_env) = _menhir_env in
                            let (_menhir_stack : ('freshtv115 * _menhir_state)) = Obj.magic _menhir_stack in
                            let (_v : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1478 "src/topl/ToplParser.ml"
                            )) = _v in
                            ((let _menhir_stack = (_menhir_stack, _v) in
                            let _menhir_env = _menhir_discard _menhir_env in
                            let _tok = _menhir_env._menhir_token in
                            match _tok with
                            | COMMA ->
                                let (_menhir_env : _menhir_env) = _menhir_env in
                                let (_menhir_stack : (('freshtv111 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1489 "src/topl/ToplParser.ml"
                                )) = Obj.magic _menhir_stack in
                                ((let _menhir_env = _menhir_discard _menhir_env in
                                let _tok = _menhir_env._menhir_token in
                                match _tok with
                                | UID _v ->
                                    let (_menhir_env : _menhir_env) = _menhir_env in
                                    let (_menhir_stack : ((('freshtv107 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1499 "src/topl/ToplParser.ml"
                                    ))) = Obj.magic _menhir_stack in
                                    let (_v : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1504 "src/topl/ToplParser.ml"
                                    )) = _v in
                                    ((let _menhir_stack = (_menhir_stack, _v) in
                                    let _menhir_env = _menhir_discard _menhir_env in
                                    let _tok = _menhir_env._menhir_token in
                                    match _tok with
                                    | RP ->
                                        let (_menhir_env : _menhir_env) = _menhir_env in
                                        let (_menhir_stack : (((('freshtv103 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1515 "src/topl/ToplParser.ml"
                                        ))) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1519 "src/topl/ToplParser.ml"
                                        )) = Obj.magic _menhir_stack in
                                        ((let _menhir_env = _menhir_discard _menhir_env in
                                        let _tok = _menhir_env._menhir_token in
                                        match _tok with
                                        | WHEN ->
                                            _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState26
                                        | ARROWARROW | LID _ | RC | UID _ ->
                                            _menhir_reduce28 _menhir_env (Obj.magic _menhir_stack) MenhirState26
                                        | _ ->
                                            assert (not _menhir_env._menhir_error);
                                            _menhir_env._menhir_error <- true;
                                            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState26) : 'freshtv104)
                                    | _ ->
                                        assert (not _menhir_env._menhir_error);
                                        _menhir_env._menhir_error <- true;
                                        let (_menhir_env : _menhir_env) = _menhir_env in
                                        let (_menhir_stack : (((('freshtv105 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1539 "src/topl/ToplParser.ml"
                                        ))) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1543 "src/topl/ToplParser.ml"
                                        )) = Obj.magic _menhir_stack in
                                        ((let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv106)) : 'freshtv108)
                                | _ ->
                                    assert (not _menhir_env._menhir_error);
                                    _menhir_env._menhir_error <- true;
                                    let (_menhir_env : _menhir_env) = _menhir_env in
                                    let (_menhir_stack : ((('freshtv109 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1554 "src/topl/ToplParser.ml"
                                    ))) = Obj.magic _menhir_stack in
                                    ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
                                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv110)) : 'freshtv112)
                            | _ ->
                                assert (not _menhir_env._menhir_error);
                                _menhir_env._menhir_error <- true;
                                let (_menhir_env : _menhir_env) = _menhir_env in
                                let (_menhir_stack : (('freshtv113 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1565 "src/topl/ToplParser.ml"
                                )) = Obj.magic _menhir_stack in
                                ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
                                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv114)) : 'freshtv116)
                        | _ ->
                            assert (not _menhir_env._menhir_error);
                            _menhir_env._menhir_error <- true;
                            let (_menhir_env : _menhir_env) = _menhir_env in
                            let (_menhir_stack : ('freshtv117 * _menhir_state)) = Obj.magic _menhir_stack in
                            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv118)) : 'freshtv120)
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        let (_menhir_env : _menhir_env) = _menhir_env in
                        let (_menhir_stack : 'freshtv121 * _menhir_state) = Obj.magic _menhir_stack in
                        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv122)) : 'freshtv124)
                | LID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
                | STAR ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv127) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = MenhirState18 in
                    ((let _menhir_env = _menhir_discard _menhir_env in
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv125) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = _menhir_s in
                    ((let _1 = () in
                    let _v : 'tv_label = 
# 63 "src/topl/ToplParser.mly"
         ( None )
# 1597 "src/topl/ToplParser.ml"
                     in
                    _menhir_goto_label _menhir_env _menhir_stack _menhir_s _v) : 'freshtv126)) : 'freshtv128)
                | STRING _v ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv131) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = MenhirState18 in
                    let (_v : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1607 "src/topl/ToplParser.ml"
                    )) = _v in
                    ((let _menhir_env = _menhir_discard _menhir_env in
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv129) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = _menhir_s in
                    let ((s : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1616 "src/topl/ToplParser.ml"
                    )) : (
# 14 "src/topl/ToplParser.mly"
       (string)
# 1620 "src/topl/ToplParser.ml"
                    )) = _v in
                    ((let _v : 'tv_procedure_pattern = 
# 105 "src/topl/ToplParser.mly"
             ( ToplAst.ProcedureNamePattern s )
# 1625 "src/topl/ToplParser.ml"
                     in
                    _menhir_goto_procedure_pattern _menhir_env _menhir_stack _menhir_s _v) : 'freshtv130)) : 'freshtv132)
                | UID _v ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState18) : 'freshtv134)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv135 * _menhir_state * 'tv_state)) * _menhir_state * 'tv_state) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv136)) : 'freshtv138)
        | _ ->
            _menhir_fail ()) : 'freshtv140)) : 'freshtv142)) : 'freshtv144)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list_one_property_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_list_one_property_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState81 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv53 * _menhir_state * 'tv_one_property) * _menhir_state * 'tv_list_one_property_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv51 * _menhir_state * 'tv_one_property) * _menhir_state * 'tv_list_one_property_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_one_property)), _, (xs : 'tv_list_one_property_)) = _menhir_stack in
        let _v : 'tv_list_one_property_ = 
# 213 "<standard.mly>"
    ( x :: xs )
# 1659 "src/topl/ToplParser.ml"
         in
        _menhir_goto_list_one_property_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv52)) : 'freshtv54)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv67 * _menhir_state * 'tv_list_one_property_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | EOF ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv63 * _menhir_state * 'tv_list_one_property_) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv61 * _menhir_state * 'tv_list_one_property_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (ps : 'tv_list_one_property_)) = _menhir_stack in
            let _2 = () in
            let _v : (
# 41 "src/topl/ToplParser.mly"
       (ToplAst.t list)
# 1678 "src/topl/ToplParser.ml"
            ) = 
# 45 "src/topl/ToplParser.mly"
                                 ( ps )
# 1682 "src/topl/ToplParser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv59) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : (
# 41 "src/topl/ToplParser.mly"
       (ToplAst.t list)
# 1690 "src/topl/ToplParser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv57) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : (
# 41 "src/topl/ToplParser.mly"
       (ToplAst.t list)
# 1698 "src/topl/ToplParser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv55) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : (
# 41 "src/topl/ToplParser.mly"
       (ToplAst.t list)
# 1706 "src/topl/ToplParser.ml"
            )) : (
# 41 "src/topl/ToplParser.mly"
       (ToplAst.t list)
# 1710 "src/topl/ToplParser.ml"
            )) = _v in
            (Obj.magic _1 : 'freshtv56)) : 'freshtv58)) : 'freshtv60)) : 'freshtv62)) : 'freshtv64)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv65 * _menhir_state * 'tv_list_one_property_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv66)) : 'freshtv68)
    | _ ->
        _menhir_fail ()

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1726 "src/topl/ToplParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv49) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((i : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1736 "src/topl/ToplParser.ml"
    )) : (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1740 "src/topl/ToplParser.ml"
    )) = _v in
    ((let _v : 'tv_identifier = 
# 115 "src/topl/ToplParser.mly"
                                ( i )
# 1745 "src/topl/ToplParser.ml"
     in
    _menhir_goto_identifier _menhir_env _menhir_stack _menhir_s _v) : 'freshtv50)

and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 13 "src/topl/ToplParser.mly"
       (string)
# 1752 "src/topl/ToplParser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv47) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((i : (
# 13 "src/topl/ToplParser.mly"
       (string)
# 1762 "src/topl/ToplParser.ml"
    )) : (
# 13 "src/topl/ToplParser.mly"
       (string)
# 1766 "src/topl/ToplParser.ml"
    )) = _v in
    ((let _v : 'tv_identifier = 
# 115 "src/topl/ToplParser.mly"
                  ( i )
# 1771 "src/topl/ToplParser.ml"
     in
    _menhir_goto_identifier _menhir_env _menhir_stack _menhir_s _v) : 'freshtv48)

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState81 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv3 * _menhir_state * 'tv_one_property) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv4)
    | MenhirState70 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv5 * _menhir_state * 'tv_procedure_pattern) * 'tv_option_arguments_pattern_) * _menhir_state * 'tv_option_condition_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv6)
    | MenhirState69 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv7 * _menhir_state * 'tv_procedure_pattern) * 'tv_option_arguments_pattern_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv8)
    | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv9 * _menhir_state * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1798 "src/topl/ToplParser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv10)
    | MenhirState62 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv11) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv12)
    | MenhirState56 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv13 * _menhir_state * 'tv_assignment)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv14)
    | MenhirState50 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv15 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv16)
    | MenhirState49 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv17 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1821 "src/topl/ToplParser.ml"
        ))) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1825 "src/topl/ToplParser.ml"
        ))) * _menhir_state * 'tv_option_condition_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv18)
    | MenhirState46 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv19 * _menhir_state * 'tv_and_predicate) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv20)
    | MenhirState43 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv21 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv22)
    | MenhirState42 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv23 * _menhir_state * 'tv_predicate) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv24)
    | MenhirState39 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv25 * 'tv_predop) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv26)
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv27 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv28)
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv29 * _menhir_state)) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1858 "src/topl/ToplParser.ml"
        ))) * (
# 15 "src/topl/ToplParser.mly"
       (string)
# 1862 "src/topl/ToplParser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv30)
    | MenhirState18 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv31 * _menhir_state * 'tv_state)) * _menhir_state * 'tv_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv32)
    | MenhirState16 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv33 * _menhir_state * 'tv_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv34)
    | MenhirState14 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv35 * _menhir_state * 'tv_transition) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv36)
    | MenhirState13 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv37 * _menhir_state) * _menhir_state * 'tv_identifier)) * 'tv_option_message_) * _menhir_state * 'tv_list_prefix_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv38)
    | MenhirState11 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv39 * _menhir_state * 'tv_prefix) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv40)
    | MenhirState8 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv41 * _menhir_state) * _menhir_state * 'tv_identifier)) * 'tv_option_message_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv42)
    | MenhirState1 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv43 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv44)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv45) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv46)

and _menhir_reduce14 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_list_one_property_ = 
# 211 "<standard.mly>"
    ( [] )
# 1911 "src/topl/ToplParser.ml"
     in
    _menhir_goto_list_one_property_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | UID _v ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState1

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

and properties : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 41 "src/topl/ToplParser.mly"
       (ToplAst.t list)
# 1945 "src/topl/ToplParser.ml"
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
    let (_menhir_stack : 'freshtv1) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | PROPERTY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | EOF ->
        _menhir_reduce14 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0) : 'freshtv2))

# 117 "src/topl/ToplParser.mly"
  

# 1976 "src/topl/ToplParser.ml"

# 269 "<standard.mly>"
  

# 1981 "src/topl/ToplParser.ml"
