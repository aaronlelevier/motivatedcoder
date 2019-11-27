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

create_tables() ->
  mnesia:create_schema([node()]),
  mnesia:start(),
  mnesia:create_table(
    bike, [
      {attributes, record_info(fields, bike)},
      {disc_copies, [node()]}
    ]
  ),
  mnesia:stop().

insert(Row) ->
  F = fun() -> mnesia:write(Row) end,
  mnesia:transaction(F).

select(Table) ->
  do(qlc:q([X || X <- mnesia:table(Table)])).

do(Q) ->
  F = fun() -> qlc:e(Q) end,
  {atomic, Val} = mnesia:transaction(F),
  Val.