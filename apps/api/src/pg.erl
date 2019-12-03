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

-spec connect() -> pid().
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

%% converts the QResult (query result) to a list of 2 item tuples,
%% that can then be converted to JSON using `jsx`
-spec to_list(QResult:: tuple()) -> list().
to_list(QResult) ->
  {ok, ColInfo, Rows} = QResult,
  ColNames = [ColName || {column, ColName, _ColType, _, _, _, _} <- ColInfo],
  ColTypes = [ColType || {column, _ColName, ColType, _, _, _, _} <- ColInfo],
  L = [lists:zip3(ColNames, ColTypes, tuple_to_list(R)) || R <- Rows],
  [convert_jsonb(X) || X <- L].

-spec convert_jsonb(L::list()) -> list().
convert_jsonb(L) ->
  convert_jsonb(L, []).

-spec convert_jsonb(list(), Acc::list()) -> list().
convert_jsonb([], Acc) -> lists:reverse(Acc);
convert_jsonb([H|T], Acc) ->
  {ColName, ColType, Value} = H,
  Value2 = case ColType of
    jsonb ->
      jsx:decode(Value);
    _ ->
      Value
  end,
  convert_jsonb(T, [{ColName, Value2}|Acc]).
