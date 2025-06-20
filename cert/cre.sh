openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=NG/ST=Rivers/L=Choba/O=Mono Institution/OU=Finance/CN=*.monoinstitute.net/emailAddress=monoinstitute@gmail.com"

echo "CA's self-signed certificate"
openssl x509 -in ca-cert.pem -noout -text

# 2. Generate web server's private key and certificate signing request (CSR)
openssl req -newkey rsa:4096 -keyout server-key.pem -out server-req.pem -subj "/C=NG/ST=Rivers/L=PHC/O=Mono Finance/OU=Finance/CN=*.monofinance.net/emailAddress=mrikehchukwuka@gmail.com"

# 3. Use CA's private key to sign web server's CSR and get back the signed certificate
openssl x509 -req -in server-req.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -days 60 -extfile server-ext.cnf

echo "Server's signed certificate"
openssl x509 -in server-cert.pem -noout -text

echo "Command to verify Server and CA certificates"
openssl verify -CAfile ca-cert.pem server-cert.pem
