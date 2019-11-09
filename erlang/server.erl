%module
-module(server).
-export([start/0]).

%variables (or rather macros)
-define(TCP_OPTIONS, [binary, {packet, 0},
                      %gen_tcp:recv needs the socket to be passive
                      {active, false},
                      {reuseaddr, true}]).
-define(PORT, 1234).

%"main"
start() ->
    listen().

%start server (= listen to port)
listen() ->
    %print info that server is started
    io:fwrite("Erlang server started. Port: ~w\n", [?PORT]),
    %listen
    {ok, LSocket} = gen_tcp:listen(?PORT, ?TCP_OPTIONS),
    %"LOOP": accept
    accept(LSocket).

%wait for connection
accept(LSocket) ->
    {ok, Socket} = gen_tcp:accept(LSocket),
    spawn(fun() -> handle(Socket) end), %spawn new "threat"
    accept(LSocket). %loop back to accepting...

%handle connection
handle(Socket) ->
    %receive from client
    case gen_tcp:recv(Socket, 0) of
        {ok, Data} ->
            io:format(Data), %print client's data
            gen_tcp:send(Socket, "Erlang server\n"), %send back
            gen_tcp:close(Socket); %close
        {error, closed} ->
            %error case of recv
            ok
    end.

