module Main where

import Control.Concurrent
import Network
import System.IO

main = do
  socket <- listenOn (PortNumber 1234)
  server socket

server socket = do
  y <- accept socket
  forkIO (handle y)
  server socket

-- handles the protocol
handle (stream, host, port) = do
  hGetLine stream
  hPutStrLn stream "server"
  putStrLn $ "connection: " ++ host ++ ":" ++ show port
