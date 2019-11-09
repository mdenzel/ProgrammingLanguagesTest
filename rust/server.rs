use std::io::Write;
use std::net::{TcpListener, TcpStream};
use std::thread;

fn main(){
    //listen
    let listener = TcpListener::bind("127.0.0.1:1234").unwrap();
    
    println!("started");

    //accept sockets
    for stream in listener.incoming(){
        thread::spawn(|| handle_connection(stream.unwrap()));
    }
}

fn handle_connection(stream: TcpStream){
    //handle
    let mut stream = stream;
    stream.write(b"server\n").unwrap();
    println!("connection: {}", stream.peer_addr().unwrap());
}


