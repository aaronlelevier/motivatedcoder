%%%-------------------------------------------------------------------
%%% @author aaron lelevier
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Nov 2019 8:02 AM
%%%-------------------------------------------------------------------
-module(db).
-author("aaron lelevier").
-include_lib("stdlib/include/qlc.hrl").
-include_lib("records.hrl").

-compile(export_all).
-export([]).

%% records

%% 'bike' table w/ disc copies
create_tables() ->
  ok = mnesia:create_schema([node()]),
  ok = mnesia:start(),
  {atomic, ok} = mnesia:create_table(
    bike, [
      {attributes, record_info(fields, bike)},
      {disc_copies, [node()]}
    ]
  ),
  stopped = mnesia:stop().

%% 'bike' table w/ disc copies
-spec ram_init() -> ok.
ram_init() ->
  ok = mnesia:start(),
  % create bike table
  {atomic, ok} = mnesia:create_table(
    bike, [
      {attributes, record_info(fields, bike)}
    ]
  ),
  % populate
  Bike = bike:init(<<"Meta AM HT">>, 1399),
  {atomic, ok} = db:insert(Bike),
  ok.

insert(Row) ->
  F = fun() -> mnesia:write(Row) end,
  {atomic, ok} = mnesia:transaction(F).

select(Table) ->
  do(qlc:q([X || X <- mnesia:table(Table)])).

do(Q) ->
  F = fun() -> qlc:e(Q) end,
  {atomic, Val} = mnesia:transaction(F),
  Val.