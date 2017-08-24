/*
 * simple ssl server 
 */
package jsimplesslserver;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.SecureRandom;
import java.util.concurrent.ExecutorService;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.net.ssl.*;
// thread pool
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;

public class JSimpleSslServer {

    
    public static void main(String[] args) {
            
        try {
            
            KeyStore clientStore = KeyStore.getInstance("PKCS12");            
            clientStore.load(new FileInputStream("marcys.p12"), "123456".toCharArray());            
            
            KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());            
            // KeyManagerFactory kmf = KeyManagerFactory.getInstance("SunX509");
            
            kmf.init(clientStore, "123456".toCharArray());
            KeyManager[] kms = kmf.getKeyManagers();
            
            // TrustStore
            KeyStore trustStore = KeyStore.getInstance("JKS");
            // java trustcerts store !!! dont change this password: default password name: changeit 
            trustStore.load(new FileInputStream("C:\\Program Files\\Java\\jdk1.8\\jre\\lib\\security\\cacerts"), "changeit".toCharArray());
            // Linux: /home/user/jdk1.8.0_141/jre/lib/security/cacerts 
            
            TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
            // TrustManagerFactory tmf = TrustManagerFactory.getInstance("SunX509");
            tmf.init(trustStore);            
            TrustManager[] tms = tmf.getTrustManagers();
            
            SSLContext sslContext = SSLContext.getInstance("TLSv1.2");
            sslContext.init(kms, tmf, new SecureRandom());
            
            SSLServerSocketFactory ssf = (SSLServerSocketFactory) sslContext.getServerSocketFactory();
            
            // All ip addresses
            SSLServerSocket sslServerSocket = (SSLServerSocket) ssf.createServerSocket(8888);
            // Single ip address
            // InetAddress addrIP = InetAddress.getByName("127.0.0.1");
            // SSLServerSocket sslServerSocket = (SSLServerSocket) ssf.createServerSocket(8888,0,addrIP);
            
            sslServerSocket.setEnabledCipherSuites(new String[]{
                    "SSL_DH_anon_EXPORT_WITH_RC4_40_MD5",
                    "SSL_DH_anon_WITH_RC4_128_MD5",
                    "SSL_RSA_EXPORT_WITH_RC4_40_MD5",
                    "SSL_RSA_WITH_RC4_128_MD5",
                    "SSL_RSA_WITH_RC4_128_SHA",
                    "TLS_ECDHE_ECDSA_WITH_RC4_128_SHA",
                    "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
                    "TLS_ECDHE_RSA_WITH_RC4_128_SHA",
                    "TLS_ECDH_ECDSA_WITH_RC4_128_SHA",
                    "TLS_ECDH_RSA_WITH_RC4_128_SHA",
                    "TLS_ECDH_anon_WITH_RC4_128_SHA",
                    "TLS_KRB5_EXPORT_WITH_RC4_40_MD5",
                    "TLS_KRB5_EXPORT_WITH_RC4_40_SHA",
                    "TLS_KRB5_WITH_RC4_128_MD5",
                    "TLS_KRB5_WITH_RC4_128_SHA"
            });
            
            //SSLSocket sslsocket = (SSLSocket) sslserversocket.accept();            
            // BufferedReader r = new BufferedReader(new InputStreamReader(sslsocket.getInputStream()));
            // BufferedWriter w = new BufferedWriter(new OutputStreamWriter(sslsocket.getOutputStream()));                        

            System.out.println("Starting server");
            
            // or with thread pools           
            while (true) {      
                try{
                    // ExecutorService pool = Executors.newFixedThreadPool(1000);
                    ThreadPoolExecutor pool = (ThreadPoolExecutor) Executors.newCachedThreadPool();
                    // Accept new connections
                    SSLSocket sslSocket = (SSLSocket) sslServerSocket.accept();                
                    // Run in separate thread with thread pool
                    pool.submit(() -> new SslThread(sslSocket).start());
                    // Run in separate thread
                    // new SslThread(c).start()                
                }catch(Exception e){
                    System.out.println("Socket thread error " + e);
                }
            }
            
        } catch (Exception e) {
            System.out.println("Socket starting... " + e);
        }
        
    }
}
