-module(joe_tests).

-compile({parse_transform, schnapps}).
-compile(export_all).
-encoding({utf8, unicode, list}).


aoob() -> "a∞b".


-include_lib("eunit/include/eunit.hrl").

-ifdef(TEST).

aoob_test_() ->
    [ ?_assertEqual(aoob(), [97, 8734, 98]) ].

-endif.
