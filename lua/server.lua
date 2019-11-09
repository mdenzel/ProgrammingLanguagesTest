#!/bin/lua

--config section
local host = "127.0.0.1"
local port = "1234"

--main function
local function main()
   local socket = require("socket")
   local server = assert(socket.bind(host, port))

   print("Server running")
   
   while 1 do
      --accept client
      local client = server:accept()
      client:settimeout(10)

      --print info about client
      print(client:getpeername())
      
      --answer and stop
      client:send("lua server")
      client:close()
   end
end

--call main function
main()

