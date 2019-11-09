module Main where

import Network
import System.IO

main = do
  stream <- connectTo "127.0.0.1" (PortNumber 1234)
  hPutStrLn stream "client"
  data_ <- hGetLine stream
  putStrLn data_
