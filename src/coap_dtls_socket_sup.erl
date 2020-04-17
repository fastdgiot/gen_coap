%%--------------------------------------------------------------------
%% Copyright (c) 2020 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(coap_dtls_socket_sup).

-author("dwg <dwg@emqx.io>").

-behaviour(supervisor).

%% API
-export([start_link/0, start_socket/2]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================
start_link() ->
    supervisor:start_link(?MODULE, []).

start_socket(SocketSup, ListenSocket) ->
    supervisor:start_child(SocketSup, [ListenSocket]).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

init([]) ->
    {ok, {{simple_one_for_one, 1000, 3600},
          [{socket, {coap_dtls_socket, start_link, []},
            transient, 5000, worker, [coap_dtls_socket]}]}}.
