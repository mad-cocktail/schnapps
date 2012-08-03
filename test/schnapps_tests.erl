-module(schnapps_tests).


-include_lib("eunit/include/eunit.hrl").

-ifdef(TEST).

joe_test_() ->
    {module, joe_tests}.

icu_test_() ->
    {module, icu_tests}.

-endif.
