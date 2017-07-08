#!/bin/sh
mkdir -p /etc/lighttpd/ssl/anbada
mkdir -p /etc/lighttpd/keys/
openssl dhparam -out /etc/lighttpd/keys/dhparam.pem 4096
openssl req -new -x509 -newkey rsa:4096 -days 365 -nodes \
	-keyout /etc/lighttpd/ssl/anbada/server.pem \
	-out /etc/lighttpd/ssl/anbada/server.pem
chown www-data:www-data /etc/lighttpd/{ssl,keys} -R
chmod 0600 -R /etc/lighttpd/{ssl,keys}
