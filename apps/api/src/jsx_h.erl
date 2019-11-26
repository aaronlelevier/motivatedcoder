%% @doc Map encoded to JSON vai JSX handler.
-module(jsx_h).

-export([init/2]).
-export([content_types_provided/2]).
-export([jsx_json/2]).

init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.

content_types_provided(Req, State) ->
  {[
    {<<"application/json">>, jsx_json}
  ], Req, State}.

jsx_json(Req, State) ->
  Body = jsx:encode(#{foo => bar}),
  {Body, Req, State}.
