use std::io::prelude::*;
use std::net::TcpListener;
use std::net::TcpStream;
use std::fs;

fn main() {
    let listener = TcpListener::bind("0.0.0.0:80").unwrap();
    println!("Server is running");

    // listen for incoming connection
    for stream in listener.incoming() {
        let stream = stream.unwrap();
        handle_connection(stream);
    }
}

/// Builds a response an send it back.
///
/// Builds a response based on an html file and send it back
/// to the requester.
fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    let status_line = "HTTP/1.1 200 OK";
    let contents = fs::read_to_string("/app/web_files/hello_world.html").unwrap();

    let response = format!(
        "{}\r\nContent-Length: {}\r\n\r\n{}",
        status_line,
        contents.len(),
        contents
    );

    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();
}

