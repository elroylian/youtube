/*
 * simple ssl client
*/
package jsimplesslclient;

import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import java.io.*;
import java.security.Security;
import java.util.Date;
import javax.net.ssl.SSLSession;

public class JSimpleSslClient {

    public static void main(String[] args) {
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        PrintStream out = System.out;
      
        String trustStoreFilename = System.getProperty("javax.net.ssl.trustStore");      
        System.out.println(trustStoreFilename);
        
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        System.setProperty("javax.net.ssl.trustStore", "YOUTUBE");
        // System.setProperty("javax.net.ssl.trustStorePassword", "123456");      
     
        // System.setProperty("javax.net.ssl.trustStore","/home/user/jdk1.8.0_141/jre/lib/security/cacerts");
        // System.setProperty("javax.nt.ssl.trustStorePassword","changeit");
        // String certificatesTrustStorePath = "/home/user/jdk1.8.0_141/jre/lib/security/cacerts";
        // System.setProperty("javax.net.ssl.trustStore", certificatesTrustStorePath);        
        
        try {
           SSLSocketFactory f = (SSLSocketFactory) SSLSocketFactory.getDefault();
           SSLSocket c = (SSLSocket) f.createSocket("127.0.0.1", 8888);
           printSocketInfo(c);
           c.startHandshake();
           BufferedWriter w = new BufferedWriter(new OutputStreamWriter(c.getOutputStream()));
           BufferedReader r = new BufferedReader(new InputStreamReader(c.getInputStream()));
           String m = "";
           
           while ((m=r.readLine())!= null) {
              out.println(m);
              out.println("Write something ");              
              m = in.readLine();
              m = m + " " + new Date();
              w.write(m,0,m.length());
              w.newLine();
              w.flush();
           }
           w.close();
           r.close();
           c.close();           
        } catch (IOException e) {
           System.out.println("Error " +e.toString());
        }
    }
    private static void printSocketInfo(SSLSocket s) {
        System.out.println("Socket class: "+s.getClass());
        System.out.println("   Remote address = "
           +s.getInetAddress().toString());
        System.out.println("   Remote port = "+s.getPort());
        System.out.println("   Local socket address = "
           +s.getLocalSocketAddress().toString());
        System.out.println("   Local address = "
           +s.getLocalAddress().toString());
        System.out.println("   Local port = "+s.getLocalPort());
        System.out.println("   Need client authentication = "
           +s.getNeedClientAuth());
        SSLSession ss = s.getSession();
        System.out.println("   Cipher suite = "+ss.getCipherSuite());
        System.out.println("   Protocol = "+ss.getProtocol());
   }
    
}
