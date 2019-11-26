%%%-------------------------------------------------------------------
%% @doc motivatedcoder public API
%% @end
%%%-------------------------------------------------------------------

-module(motivatedcoder_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    motivatedcoder_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
