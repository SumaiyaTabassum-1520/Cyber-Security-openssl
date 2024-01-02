
#Moving a step back and then to sub-ca
cd ../sub-ca

##Sub-CA
#Creating sub-ca.config
gedit sub-ca.conf

# the code into sub-ca.config file
###############################################################################################################
##SUB-CA File
###############################################################################################################
[ca]

#/root/ca/sub-ca/sub-ca.conf

#see man ca

default_ca    = CA_default

 

[CA_default]

dir     = /root/ca/sub-ca

certs     =  $dir/certs

crl_dir    = $dir/crl

new_certs_dir   = $dir/newcerts

database   = $dir/index

serial    = $dir/serial

RANDFILE   = $dir/private/.rand

 

private_key   = $dir/private/sub-ca.key

certificate   = $dir/certs/sub-ca.crt

 

crlnumber   = $dir/crlnumber

crl    =  $dir/crl/ca.crl

crl_extensions   = crl_ext

default_crl_days    = 30

 

default_md   = sha256

 

name_opt   = ca_default

cert_opt   = ca_default

default_days   = 365

preserve   = no

policy    = policy_loose

 

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