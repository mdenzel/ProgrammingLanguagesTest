
//TODO

public class Client implements Runnable {
  private String ip;
  private int port;

  //constructor
  public Client(String ip, int port){
    this.ip = ip;
    this.port = port;
  }

  @Override
  public void run(){
    Socket s = null;
    System.out.println("connecting to " + this.ip + ":" + this.port);
    try {
      s = new Socket(this.ip, this.port);
    } catch (Exception e){
      System.out.println("Cannot connect to " + this.ip + ":" + this.port);
      System.exit(-1);
    }

    //set socket timeout
    s.setSoTimeout(3000);
    
    //send
    s << "Groovy client\n";

    //receive
    try{
      s.withStreams { inStream, outStream ->
          def reader = inStream.newReader()
          def answer = reader.readLine()
          println "$answer"
      }
    }catch (Exception e){
      System.err.println("Socket died");
    }
    
    //close
    s.close();
  }
  
}

//"main"
new Thread(new Client("127.0.0.1", 1234)).start();
