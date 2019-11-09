#!/bin/python3

#imports
import socket

# --- CONFIG ---
host = "127.0.0.1"
port = 1234
# --------------

#TODO: improve client
#class
class Client:
    """A basic client class"""

    def __init__(self, host, port):
        #init server address
        self._host = host
        self._port = port

    def connect(self):
        #create socket and connect
        try:
            self._sock = socket.socket()
            self._sock.connect((self._host, self._port))
        except Exception as e:
            print("connect(): " + str(e))

    def send(self, text):
        #send message to server
        self._sock.send(bytes(text, "UTF-8"))

    def receive(self, num):
        #receive answer from server
        return self._sock.recv(num).decode("UTF-8")

    #destructor
    def __del__(self):
        if(self._sock):
            self._sock.close()
            self._sock = None

#main function
if __name__ == "__main__":
    #no global host/port here since
    #we are already in global scope
    c = Client(host, port)
    c.connect()
    c.send("python client\n")
    print(c.receive(1024))
    del c
