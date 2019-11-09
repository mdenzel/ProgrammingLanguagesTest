
(* imports *)
open Printf;;
open Unix;;

(* --- CONFIG --- *)
let ip = "127.0.0.1";;
let port = 1234;;
(* -------------- *)
       
(* implementation
note: ocaml classes must be lower case*)
class server init_ip init_port =
object(self)
  (* constants *)
  val ip = init_ip
  val port = init_port
               
  (* methods *)
  method handle_connection s =
    (* init *)
    let cout = out_channel_of_descr s in
    fprintf cout "Ocaml server\r\n%!";
    flush cout;
    let cin = in_channel_of_descr s in
    let data = input_line cin in
    printf "client: %s\n" data;
               
  method handle_loop sock =
    let (s, _) = accept sock in
    match fork() with
    | 0 ->
       (* child *)
       printf "Subprocess %d handle_connection\n" @@getpid();
       self#handle_connection s;
       close s
    | (-1) ->
       (* error *)
       eprintf "Error: fork\n";
       self#handle_loop sock
    | pid ->
       (* parent *)
       self#handle_loop sock
                        
  method run =
    (* restricts ip to be a string and port to be an int*)
    printf "Running server at %s/%d\n" ip port;

    (* start socket *)
    let addr = ADDR_INET (inet_addr_of_string ip, port) in
    let sock = socket PF_INET SOCK_STREAM 0 in
    setsockopt sock SO_REUSEADDR true;
    try
      bind sock addr;
      listen sock 10;
      self#handle_loop sock;
    with
      _ -> close sock; raise (Failure "bind/listen failed")

end;;


(* actually run the program *)
let () =
  printf "Server start\n";
  flush Pervasives.stdout; (*Unix.stdout hides Pervasives.stdout*)
  let s = new server ip port in
  s#run;
  exit 0
;;
