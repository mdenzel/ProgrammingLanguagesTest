#!/bin/python3

#imports
import socketserver
from os import getpid

# --- CONFIG ---
host = "127.0.0.1"
port = 1234
# --------------

#Server class (for server factory)
#ForkingMixIn will spawn a new process for every connection
#Threads not appropriate due to Pyhton's global interpreter lock
class Server(socketserver.ForkingMixIn, socketserver.TCPServer):
    pass

#handler class (=executing the processes)
class Handler(socketserver.StreamRequestHandler):
    """A basic handler for the server class"""

    def handle(self):
        #print info about client
        print("Client: {}: {}".format(*self.client_address))

        #get data from client with timeout
        data = self.rfile.readline()
        if data:
            #print it
            print("\t" + data.decode("UTF-8"), end="")

        #send back
        pid = getpid()
        print("\tprocess " + str(pid) + " sending...")
        self.wfile.write(bytes("Python server", "UTF-8"))

        #shutdown connection
        return


if __name__ == "__main__":
    Server.allow_reuse_address = True
    s = Server((host, port), Handler)
    try:
        s.serve_forever()
    except:
        pass #ignore keyboard interrupts
    finally:
        print("Closing...")
        s.server_close()
