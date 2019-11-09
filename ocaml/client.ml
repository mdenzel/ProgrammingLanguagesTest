
(* imports *)
open Printf;;
open Unix;;

  
(* --- CONFIG --- *)
let ip = "127.0.0.1";;
let port = 1234;;
(* -------------- *)

let () =
  (* connect to server *)
  let (ic,oc) = open_connection (ADDR_INET(inet_addr_of_string ip, port)) in

  (* send data *)
  output_string oc ("Ocaml client\n");
  flush oc;

  (* server answer *)
  let data = input_line ic in
  printf "server: %s\n" data;
  
  (* shutdown *)
  shutdown_connection ic
