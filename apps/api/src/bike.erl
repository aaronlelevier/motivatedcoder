%%%-------------------------------------------------------------------
%%% @author aaron lelevier
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Nov 2019 8:35 AM
%%%-------------------------------------------------------------------
-module(bike).
-author("aaron lelevier").
-export([init/2, fields/0, to_map/1]).
-include_lib("records.hrl").

init(Name, Price) ->
  #bike{
    name = Name,
    price = Price
  }.

fields() ->
  [type, name, price].

to_map(Bike) ->
  lists:zip(fields(), tuple_to_list(Bike)).