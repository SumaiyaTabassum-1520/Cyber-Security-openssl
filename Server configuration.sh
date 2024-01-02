
#Moving to server
cd ../server

#Generating certificate signing request from server
openssl req -key private/server.key -new -sha256 -out csr/server.csr

#moving to sub ca to sign the server’s certificate
cd ../sub-ca

#Sub ca signing certificate request of server
openssl ca -config sub-ca.conf -extensions server_cert -days 365 -notext -in ../server/csr/server.csr -out ../server/certs/server.crt

#seeing detail
cat index

echo "127.0.0.2 www.verysecureserver.com" >> /etc/hosts
ping www.verysecureserver.com


#copy to newcerts directory
cp /root/ca/root-ca/certs/ca.crt /home/zara/certificate
cp /root/ca/sub-ca/certs/sub-ca.crt /home/zara/certificate/
cp /root/ca/server/certs/server.crt /home/zara/certificate/
cp /root/ca/server/private/server.key /home/zara/certificate/


#Next go to this location
sudo -i
cd /opt/lampp/etc/extra
chmod 777 httpd-ssl.conf 
gedit httpd-ssl.conf

#line 106
change server.crt location with your server.crt file location
{106 SSLCertificateFile "/home/zara/certificate/server.crt"}

#line 116
change server.key location with your server.key file location
{116 SSLCertificateKeyFile "/home/zara/certificate/server.key"}

#line 136
change full line with your location
{136 SSLCACertificatePath "/home/rizvee/certificate"}