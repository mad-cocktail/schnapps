-module(icu_tests).

-compile({parse_transform, schnapps}).
-compile(export_all).
-encoding({utf8, utf16, binary}).


hello() -> "Привет".


-include_lib("eunit/include/eunit.hrl").

-ifdef(TEST).

hello_test_() ->
    [ ?_assertEqual(hello(), 
                    unicode:characters_to_binary(
                        [1055,1088,1080,1074,1077,1090], unicode, utf16)) ].

-endif.
