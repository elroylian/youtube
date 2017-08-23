/*
 * Thread class
*/
package jsimplesslserver;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;

public class SslThread extends Thread {
        
    private static boolean stop = false;
    private Socket c = null;
    
    public SslThread(Socket s) {                      
        c = s;   
    }
    
    public void run() {
        try {
            if (isInterrupted()) {
                // return;
            }            
            
                     
            // Socket client remote IP address
            String clientIP = ""+c.getRemoteSocketAddress();                        
            // timestamp
            long timestamp = System.currentTimeMillis();
            
            BufferedWriter w =  new BufferedWriter(new OutputStreamWriter(c.getOutputStream()));
            BufferedReader r = new BufferedReader(new InputStreamReader(c.getInputStream())); 
            
            stop = false;
            String msg = "";            
            sendMsg(w,"Hello from server :) write someting");                                
                
            // read while user send . (in readMsg())
            while(true && stop != true){                                
                msg = readMsg(r);
                System.out.println(clientIP + " " + timestamp + " " + msg);
                sendMsg(w,"Your string: " + msg);
                if(msg.contains("...")){            
                    break;
                }
                msg = "";
            }   
            w.close();
            r.close();
            c.close();             
            return;
        }catch(Exception e){
            try {
                // c.close();
                stop = true;
                System.out.println("ERROR " + e);
            } catch (Exception ex) {
                System.out.println("ERROR " + e);
            }
        }
    }
    
    public void sendMsg(BufferedWriter w, String send){
        try{
            char[] a = send.toCharArray();
            int n = a.length; 
            w.write(a,0,n);
            w.newLine();
            w.flush();
        }catch(Exception e){                                
            System.out.println("SEND " + e);
            stop = true;
        }
    }
    
    public String readMsg(BufferedReader r){
        String txt = "";
        try {            
            while ((txt = r.readLine()) != null) {
                System.out.println(txt);
                System.out.flush();                
                break;
            }            
        } catch (Exception e) {
            System.out.println("READ " + e); 
            stop = true;
        }
        return txt;
    }
}
