# generate ssl certs with password
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -sha256

# generate ssl certs no password
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -sha256

# Options
-subj "/C=US/ST=Oregon/L=Portland/O=Company Name/OU=Org/CN=www.example.com"
-subj '/CN=localhost'
-nodes
