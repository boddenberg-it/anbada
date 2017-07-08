#!/bin/sh

apt-get update
apt-get -y upgrade
apt-get -y install \
	\
	git \
	android-tools-adb \
	lighttpd \
	php5-cgi \
	encryptfs-utils

# allow user www-data to use ADB and adding new SSID
sudo echo "www-data ALL=(ALL) NOPASSWD: /usr/bin/adb" >> /etc/sudoers
sudo echo "www-data ALL=(ALL) NOPASSWD: /usr/bin/wpa_passphrase" >> /etc/sudoers

# generate certificate and DH param for lighty
./generate_certificate.sh

# generating password for anbada webpage:
./generate_lighty_password.perl

# apply changes and restart lighttpd config
cp lighttpd.conf /etc/lighttpd/lighttpd.conf
sudo /etc/init.d/lighttpd restart
