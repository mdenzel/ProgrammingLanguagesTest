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
	//connect
	conn, err := net.Dial(CONN_TYPE, CONN_HOST+":"+CONN_PORT)
	if(err != nil){
		fmt.Println(err.Error())
		os.Exit(-1)
	}

	data := make([]byte, 1024)
	conn.Write([]byte("client"))
	conn.Read(data)
	fmt.Println(string(data))
	conn.Close()
}

