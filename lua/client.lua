#!/bin/lua

--config section
local host = "127.0.0.1"
local port = "1234"

--main function
local function main()
   --connect to server
   local socket = require("socket")
   local server = assert(socket.tcp())
   server:connect(host, port)

   --send
   server:send("lua client\n")

   --receive
   local s, status, partial = server:receive()
   print(s or partial)
end
   
--call main function
main()

