
public class Server implements Runnable {
  private String ip;
  private int port;

  //constructor
  public Server(String ip, int port){
    this.ip = ip;
    this.port = port;
  }

  @Override
  public void run(){
    //create socket
    Inet4Address ia = new Inet4Address(this.ip);
    ServerSocket s = null;
    try{
      s = new ServerSocket(port, 0, ia);
    }catch(Exception e){
      System.err.println(e.getMessage());
      return;
    }

    //accept connections from clients
    while(!Thread.interrupted()){
      Socket client = null;
      try{
        client = s.accept();
        println("Client: " + client.inetAddress.toString());

        //handle client
        (new Thread(new Handler(client))).start();
      }catch(Exception e){
        System.err.println("accept failed");
      }
    }
  }
}

class Handler implements Runnable {
  private Socket client;

  public Handler(Socket client){
    this.client = client;
  }

  @Override
  public void run(){
    try{
      //setup
      PrintWriter sout = new PrintWriter(client.getOutputStream(), true);
      BufferedReader sin = new BufferedReader(new InputStreamReader(client.getInputStream()));

      //print info
      sout.println("Groovy server");
      sout.flush();
      System.out.println(sin.readLine());

      //shutdown
      sout.close();
      sin.close();
      client.close();
    }catch(Exception e){
      System.err.println("Could not handle client\n" + e);
    }
  }
}

//"main" like in scripting languages...
println("starting server");
new Thread(new Server("127.0.0.1", 1234)).start();

