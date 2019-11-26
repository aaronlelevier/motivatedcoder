%% @doc Map encoded to JSON vai JSX handler.
-module(record_h).
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
  Bike = bike:init(<<"Meta AM HT">>, 1099),
  Body = jsx:encode(bike:to_map(Bike)),
  {Body, Req, State}.
