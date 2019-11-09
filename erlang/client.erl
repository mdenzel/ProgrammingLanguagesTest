%module
-module(client).
-export([start/0]).

%variables (or rather macros)
-define(SERVER, "127.0.0.1").
-define(PORT, 1234).

start() ->
    %print some info
    io:fwrite("Erlang client. Connecting to server ~s port ~w\n", [?SERVER, ?PORT]),
    %call connect
    connect().

connect() ->
    %connect to server
    {ok, Socket} = gen_tcp:connect(?SERVER, ?PORT,
                    [binary, {packet, 0},
                     %gen_tcp:recv needs the socket to be passive
                     {active, false}
                    ]),
    %send something to server
    ok = gen_tcp:send(Socket, "Erlang client\n"),
    %receive server's answer
    case gen_tcp:recv(Socket, 0) of
        {ok, Data} ->
            io:fwrite(Data), %print server's answer
            ok = gen_tcp:close(Socket); %stop
        {error, closed} ->
            %error case
            ok
    end.

