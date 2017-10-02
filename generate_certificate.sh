#!/bin/sh

mkdir -p /etc/lighttpd/certs
cd /etc/lighttpd/certs
rm lighttpd.pem || true
openssl req -new -x509 -keyout lighttpd.pem -out lighttpd.pem -days 365 -nodes -subj '/CN=www.anbada.de/O=boddenberg.it/C=EU'
chmod 400 lighttpd.pem

#if [ "$password0" = "$password0" ]; then
# sudo echo "$user:$password0" > /etc/lighttpd/.lighttpdpassword
#else
#again # generate password
#fi
