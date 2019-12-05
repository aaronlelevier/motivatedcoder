%%%-------------------------------------------------------------------
%% @doc api public API
%% @end
%%%-------------------------------------------------------------------

-module(api_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    % DB
    ok = db:ram_init(),
    % Cowboy
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", toppage_h, []},
            {"/jsx", jsx_h, []},
            {"/record", record_h, []},
            {"/mnesia", mnesia_h, []},
            {"/pg", pg_h, []},
            {"/json", json_h, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
        env => #{dispatch => Dispatch}
    }),
    api_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
