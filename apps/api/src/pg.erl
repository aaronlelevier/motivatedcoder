%%%-------------------------------------------------------------------
%%% @author aaron lelevier
%%% @copyright (C) 2019, <COMPANY>
%%% @doc spike of using `epgsql`
%%%
%%% @end
%%% Created : 01. Dec 2019 12:09 PM
%%%-------------------------------------------------------------------
-module(pg).
-author("aaron lelevier").
-compile(export_all).
-export([]).
-include_lib("epgsql/include/epgsql.hrl").

-define(PG_TABLE, "djangoaws").

connect() ->
  {ok, C} = epgsql:connect("localhost", "postgres", "postgres", #{
    database => ?PG_TABLE,
    timeout => 4000
  }),
  C.

-spec create() -> epgsql_cmd_squery:response().
create() ->
  C = connect(),
  epgsql:squery(C,
    "CREATE TABLE bike (name)").

-spec insert() -> epgsql_cmd_squery:response().
insert() ->
  C = connect(),
  epgsql:squery(C,
    "insert into account(name)"
    "    values ('joe'), (null)"
    "    returning *").

-spec query(Q::string()) -> epgsql_cmd_squery:response().
query(Q) ->
  C = connect(),
  epgsql:squery(C, Q).