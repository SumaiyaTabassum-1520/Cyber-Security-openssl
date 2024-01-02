cd /etc/bind
gedit /etc/hosts

#[After the command edit next]

10.0.2.15	zara-VirtualBox.verysecureserver.com	zara-VirtualBox

#[save and exit]

hostname
dnsdomainname
hostname --fqdn

cp named.conf.options named.conf.options.orig
gedit named.conf.options

[After the command edit next]

	//========================================================================
	dnssec-validation auto;
	listen-on-v6 { any; };
	recursion yes;
	listen-on{192.168.4.7;};
	allow-transfer {none;};
	
	forwarders {
	192.168.0.1;

	};

#[save and exit]

cp named.conf.local named.conf.local.orig
gedit named.conf.local

#[After the command edit next]

#forward lookup zone
zone "verysecureserver.com" IN{
	type master;
	file "/etc/bind/db.verysecureserver.com";
};

#reverse lookup zone
zone "4.168.192.in-addr.arpa" IN {
	type master;
	file "/etc/bind/db.4.168.192";
};

#[save and exit]

named-checkconf
ls
# cat named.conf.local
cp db.local db.verysecureserver.com
gedit db.verysecureserver.com
#[Replace full file with that text]

;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	ns1.verysecureserver.com. root.verysecureserver.com. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	ns1.verysecureserver.com.
ns1	IN	A	192.168.0.20
www	IN	A	192.168.0.20
@	IN	AAAA	::1
[Save and exit]
-------------------------------------------------------------------------------------

named-checkzone verysecureserver.com db.verysecureserver.com
cp db.127 db.4.168.192
gedit db.4.168.192

-------------------------------------------------------------------------------------
[Replace full file with that text]
;
; BIND reverse data file for local loopback interface
;
$TTL	604800
@	IN	SOA	ns1.verysecureserver.com. root.verysecureserver.com. (
			      1			; Serial
			 604800			; Refresh
			  86400			; Retry
			2419200			; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	ns1.verysecureserver.com.
24	IN	PTR	ns1.verysecureserver.com.
24	IN	PTR	www.verysecureserver.com.

#[Save and exit]

named-checkzone 4.168.192.in-addr.arpa db.4.168.192
named-checkconf
named-checkzone verysecureserver.com db.verysecureserver.com
named-checkzone 4.168.192.in-addr.arpa db.4.168.192

service bind9 restart
service bind9 status

nslookup www.verysecureserver.com

gedit /etc/resolv.conf

#[Replace last line with that text]

nameserver 192.168.4.7
search localdomain

#[Save and exit]

nslookup www.verysecureserver.com
ping www.verysecureserver.com