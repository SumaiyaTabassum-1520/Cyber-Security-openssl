####CA Configure

#Moving to the root using
sudo -i

#Creating directory:
mkdir -p ca/{root-ca,sub-ca,server}/{private,certs,newcerts,crl,csr}

#Changing the root of ca and sub ca private folder
chmod -v 700 ca/{root-ca,sub-ca,server}/private

#Creating file index in both root ca and sub ca
touch ca/{root-ca,sub-ca}/index

#writing serial number of root ca
openssl rand -hex 16 > ca/root-ca/serial

#writing serial number of sub ca
openssl rand -hex 16 > ca/sub-ca/serial

#moving to ca directory
cd ca

#####Generating private key for root ca, sub ca and server

#Public key for rootCA
openssl genrsa -aes256 -out root-ca/private/ca.key 4096

#Public key for subCA
openssl genrsa -aes256 -out sub-ca/private/sub-ca.key 4096

#Public key for server
openssl genrsa -out server/private/server.key 2048

####Generating certificates

##Root-CA

#Creating root ca.config
gedit root-ca/root-ca.conf

#Inserting the code from the link into the root-ca.config
##ROOT-CA File

[ca]

#/root/ca/root-ca/root-ca.conf

#see man ca

default_ca    = CA_default

 

[CA_default]

dir     = /root/ca/root-ca

certs     =  $dir/certs

crl_dir    = $dir/crl

new_certs_dir   = $dir/newcerts

database   = $dir/index

serial    = $dir/serial

RANDFILE   = $dir/private/.rand

 

private_key   = $dir/private/ca.key

certificate   = $dir/certs/ca.crt

 

crlnumber   = $dir/crlnumber

crl    =  $dir/crl/ca.crl

crl_extensions   = crl_ext

default_crl_days    = 30

 

default_md   = sha256

 

name_opt   = ca_default

cert_opt   = ca_default

default_days   = 365

preserve   = no

policy    = policy_strict

 

[ policy_strict ]

countryName   = supplied

stateOrProvinceName  =  supplied

organizationName  = match

organizationalUnitName  =  optional

commonName   =  supplied

emailAddress   =  optional

 

[ policy_loose ]

countryName   = optional

stateOrProvinceName  = optional

localityName   = optional

organizationName  = optional

organizationalUnitName   = optional

commonName   = supplied

emailAddress   = optional

 

[ req ]

# Options for the req tool, man req.

default_bits   = 2048

distinguished_name  = req_distinguished_name

string_mask   = utf8only

default_md   =  sha256

# Extension to add when the -x509 option is used.

x509_extensions   = v3_ca

 

[ req_distinguished_name ]

countryName                     = Country Name (2 letter code)

stateOrProvinceName             = State or Province Name

localityName                    = Locality Name

0.organizationName              = Organization Name

organizationalUnitName          = Organizational Unit Name

commonName                      = Common Name

emailAddress                    = Email Address

countryName_default             = BD

stateOrProvinceName_default     = Dhaka

0.organizationName_default      = EWU

organizationalUnitName_default  = Cyber_Security

commonName_default              = AcmeRootCA

emailAddress                    = cse487@acmeroot_ca.com 


 

[ v3_ca ]

# Extensions to apply when createing root ca

# Extensions for a typical CA, man x509v3_config

subjectKeyIdentifier  = hash

authorityKeyIdentifier  = keyid:always,issuer

basicConstraints  = critical, CA:true

keyUsage   =  critical, digitalSignature, cRLSign, keyCertSign

 

[ v3_intermediate_ca ]

# Extensions to apply when creating intermediate or sub-ca

# Extensions for a typical intermediate CA, same man as above

subjectKeyIdentifier  = hash

authorityKeyIdentifier  = keyid:always,issuer

#pathlen:0 ensures no more sub-ca can be created below an intermediate

basicConstraints  = critical, CA:true, pathlen:0

keyUsage   = critical, digitalSignature, cRLSign, keyCertSign

 

[ server_cert ]

# Extensions for server certificates

basicConstraints  = CA:FALSE

nsCertType   = server

nsComment   =  "OpenSSL Generated Server Certificate"

subjectKeyIdentifier  = hash

authorityKeyIdentifier  = keyid,issuer:always

keyUsage   =  critical, digitalSignature, keyEncipherment

extendedKeyUsage  = serverAuth

#save and exit

#Moving inside root-ca
cd root-ca

#Generating root ca certificate(password: remember password)
openssl req -config root-ca.conf -key private/ca.key -new -x509 -days 7305 -sha256 -extensions v3_ca -out certs/ca.crt

#Ensuring that the certificate has been created properly(password: remember password)
openssl x509 -noout -in certs/ca.crt -text