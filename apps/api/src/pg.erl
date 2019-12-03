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

%% converts the QResult (query result) to a list of 2 item tuples,
%% that can then be converted to JSON using `jsx`
-spec to_list(QResult:: tuple()) -> list().
to_list(QResult) ->
  {ok, ColInfo, _Rows} = QResult,
  Columns = [ColName || {column, ColName, _, _, _, _, _} <- ColInfo],
%%  [lists:zip(Columns, tuple_to_list(R)) || R <- Rows].
  [lists:zip(Columns, tuple_to_list(R)) || R <- example_rows()].

example_rows() ->
  Rows = [{
    <<"6">>,<<"0">>,<<"ami-0d5d9d301c853a04a">>,
    <<"i-0b97590d72d533b10">>,<<"t2.micro">>,
    <<"motivatedcoder">>,<<"2019-11-30 09:13:27-08">>,
    [{<<"State">>, <<"disabled">>}]
  }],
  Rows.