-module(schnapps).
-export([parse_transform/2]).


parse_transform(Forms, _Options) ->
    case extract_encoding_name(Forms) of
    []  -> io:format(user, "[schnapps] Set the charset attribute. Skip.", []), Forms;
    [EncodingAttr] ->
        EncRec = decode_encoding(to_term(EncodingAttr)),
        F = encoder(EncRec),
        X = [case erl_syntax:type(SubTree) of
             function -> erl_syntax:revert(erl_syntax_lib:map(F, SubTree));
             _Type -> SubTree
             end || SubTree <- Forms],
%       io:format(user, "Before:\t~p\n\nAfter:\t~p\n", [Forms, X]),
        X
    end.


-record(encoding, {source_enc, strings_enc, strings_type}).
decode_encoding({SourceEnc, StrEnc, StrType}) ->
    #encoding{source_enc = SourceEnc,
              strings_enc = StrEnc,
              strings_type = StrType}.


encoder(#encoding{source_enc = FromEnc,
                  strings_enc = ToEnc,
                  strings_type = ToType}) ->
    fun(Node) ->
        case erl_syntax:type(Node) of
        string ->
            RawStr   = raw_string(Node),
            BinUtf8  = convert_chars_to_standard_presetation(RawStr, FromEnc),
            Wanted   = convert_standard_presetation_to_wanted(BinUtf8, ToEnc, ToType),
            erl_syntax:revert(erl_syntax:abstract(Wanted));
        _OtherType ->
            Node
        end
    end.

raw_string(Node) ->
    Bytes = erl_syntax:string_value(Node),
    list_to_binary(Bytes).

%% The standard (for this library) presentation is a binary in UTF-8.
convert_chars_to_standard_presetation(From, FromEnc) ->
    unicode:characters_to_binary(From, FromEnc, utf8).

convert_standard_presetation_to_wanted(From, ToEnc, ToType) ->
    case ToType of
        binary -> unicode:characters_to_binary(From, utf8, ToEnc);
        list ->   unicode:characters_to_list(From, ToEnc)
    end.

to_term(Expr) ->
    {value, Value, _} = erl_eval:exprs(revert_tree(Expr), []),
    Value.

revert_tree(Tree) ->
    [erl_syntax:revert(T) || T <- lists:flatten(Tree)].

extract_encoding_name(Forms) ->
    [erl_syntax:attribute_arguments(F)
       || F <- Forms, erl_syntax:type(F) =:= attribute,
          erl_syntax:atom_value(erl_syntax:attribute_name(F)) =:= encoding].
