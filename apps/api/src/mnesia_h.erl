%% @doc Map encoded to JSON vai JSX handler.
-module(mnesia_h).
-include_lib("records.hrl").

-export([init/2]).
-export([content_types_provided/2]).
-export([json/2]).

init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.

content_types_provided(Req, State) ->
  {[
    {<<"application/json">>, json}
  ], Req, State}.

json(Req, State) ->
  Q = db:select(bike),
  Body = jsx:encode([bike:to_map(X) || X <- Q]),
  {Body, Req, State}.
