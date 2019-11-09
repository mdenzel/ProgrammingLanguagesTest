package main

import(
	"fmt"
	"net"
	"os"
)

const(
	CONN_HOST = "127.0.0.1"
	CONN_PORT = "1234"
	CONN_TYPE = "tcp"
)

func main(){
	//listen
	l, err := net.Listen(CONN_TYPE, ":"+CONN_PORT)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(-1)
	}
	
	fmt.Println("started")

	//run
	for {
		//accept socket
		conn, err := l.Accept()
		if err != nil {
			fmt.Println(err.Error())
			os.Exit(-1)
		}

		//log
		fmt.Printf("con: %s %s\n", conn.RemoteAddr(), conn.LocalAddr())
		//subroutine
		go handleRequest(conn)
	}
}

func handleRequest(conn net.Conn){
	message := "server"
	conn.Write([]byte(message));
	conn.Close()
}

