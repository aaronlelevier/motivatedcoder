%%%-------------------------------------------------------------------
%%% @author aaron lelevier
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. Dec 2019 5:34 AM
%%%-------------------------------------------------------------------
-module(pg_h).
-author("aaron lelevier").

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
  QResult = pg:query("select * from ec2_instance"),
  L = pg:to_list(QResult),
  Body = jsx:encode(L),
  {Body, Req, State}.
