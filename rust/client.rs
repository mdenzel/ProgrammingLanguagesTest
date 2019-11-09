use std::net::TcpStream;
use std::string::String;
use std::io::{Read, Write};

fn main(){
    //connect
    let mut stream = TcpStream::connect("127.0.0.1:1234").unwrap();
    let mut data = [0_u8; 128];

    //write
    let _ = stream.write(b"client\n");
    //receive
    let _ = stream.read(&mut data);

    println!("{}", String::from_utf8_lossy(&data));
}

