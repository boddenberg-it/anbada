#!/bin/bash

create_crontabs() {
	# ramfs
	cron_cmd_0="@reboot root /home/pi/anbada/anbada.sh root@boot create_ramfs"
	# samba file backdoor
	cron_cmd_1="@reboot pi if -f /home/pi/backdoor.txt; then \
		/home/pi/anbada/anbada.sh backdoor@boot mount_encfs "$(cat /home/pi/backdoor.txt)"; \
		rm /home/pi/backdoor.txt; \
		fi"

	sudo echo "$cron_cmd_0" > /etc/cron.d/anbada
	sudo echo "$cron_cmd_1" > /etc/cron.d/file_backdoor
}

ensure_passwords_match() {
	echo "Please enter password for $1:"
	read -s foo
	echo "Please re-type password for $1:"
	read -s bar

	if [ ${#foo} -lt 8 ]; then
		echo "Password to short, 8 characters are minimum!"
		ensure_passwords_match "$1"
	fi

	if [ "$foo" = "$bar" ]; then
		export password="$foo"
	else
		echo "Passwords didn't match, please try again."
		ensure_passwords_match "$1"
	fi
}

prepare_installation() {
	echo "Preparing installation.."
	# change hostname
	sudo hostname -b anbada
	sudo sh -c "echo 'anbada' > /etc/hostname"
	sudo sed -i -e 's/raspberrypi/anbada/g' /etc/hosts
	# disable desktop autologin
	sudo sed -i -e 's/autologin-user=pi/#autologin-user=pi/g' /etc/lightdm/lightdm.conf
}

install_packages() {
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y --force-yes install \
		php-cgi \
		lighttpd \
		encfs \
		android-tools-adb \
		dnsmasq \
		hostapd \
		resolvconf\
		samba-common \
		samba
}

configure_samba() {
	smb_cfg="[global] \n
		workgroup = WORKGROUP \n
		security = user \n
		map to guest = bad user \n
	\n
	[blobbhome] \n
   	path = /home/pi/anbada/ \n
   	browsable = yes \n
   	writable = yes \n
   	valid users = pi \n"
	sudo sh -c "echo -e '"$smb_cfg"' >> /etc/samba/smb.conf"
	sudo /etc/init.d/samba
# TODO:	sudo smbpasswd -a pi
}

enable_WiFi_AP() {

	sudo echo "denyinterfaces wlan0" >> /etc/dhcpcd.conf

	# create both interfaces file (AP/client)
	iff="/etc/network/interfaces"
	if_conf="allow-hotplug wlan0 \n
  	iface wlan0 inet static \n
    address 192.168.0.1 \n
    netmask 255.255.255.0 \n
    network 192.168.0.0 \n"
	sudo cp "$iff" "$iff.client"
	sudo sh -c "echo -e'"$if_conf"' >> /etc/default/hostapd"
	sudo cp "$iff" "$iff.ap"

	# create dnsmasq config file
	sudo sh -c "echo 'interface=wlan0' > /etc/dnsmasq.conf"
	sudo sh -c "echo 'dhcp-range=192.168.0.2,192.168.0.20,255.255.255.0,24h' >> /etc/dnsmasq.conf"

	# append link to /etc/hostapd/hostapd.conf file in /etc/default/hostapd
	sudo sh -c "echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' >> /etc/default/hostapd"

	# create hostapd.conf config file
	etc_hostapd_hostapdconf="\n
	interface=wlan0 \n
	driver=nl80211 \n
	ssid=$1 \n
	hw_mode=g \n
	channel=7 \n
	wmm_enabled=0 \n
	macaddr_acl=0 \n
	auth_algs=1 \n
	ignore_broadcast_ssid=0 \n
	wpa=2 \n
	wpa_passphrase=$2 \n
	wpa_key_mgmt=WPA-PSK \n
	wpa_pairwise=TKIP \n
	rsn_pairwise=CCMP \n"
	sudo sh -c "echo -e'"$etc_hostapd_hostapdconf"' > /etc/hostapd/hostapd.conf"
}

configure_lighttpd() {
	source webroot/anbada.sh
	renew_cert
	sudo cp lighttpd.conf /etc/lighttpd/
	sudo /etc/init.d/lighttpd restart
}

echo "Welcome to the Anbada installer"
sleep 2
prepare_installation
install_packages
install_anbada

echo ""
echo "Please enter the following configurations before the installation starts:"
echo "    - SSID name and password of the anbada WLAN hotspot"
echo "    - username and passowrd for anbada web client"
echo "    - user name and password for samba shares"
echo "    - password for file encryption"
echo "    - Login credentials for Pi"
echo
echo "Please enter name for SSID/WLAN:"

read SSID
ensure_passwords_match "WLAN passphrase"
WLAN_PASSPHRASE="$password"

echo "Please enter password for anbada webclient:"
ensure_passwords_match "anbada front end"
SSID_PASSWORD="$password"

echo "Please Setup the password for file encryption:"
mkdir -p ~/anbada/webroot/encrypted
mkdir -p ~/anbada/webroot/decrypted
echo p | encfs ~/anbada/webroot/encrypted ~/anbada/webroot/decrypted

echo "Please enter username for front end:"
ensure_passwords_match "anbada front end"
SSID_PASSWORD="$password"

echo "Please a new password for pi user"
passwd
echo "Please set Samba password for the pi user"
configure_samba
echo
echo "That's all. :)"
echo "from now on you can lean back and watch the show. It will take some minutes afterwards all necessary information will be printed!!! to the screen with a prompt to reboot into WiFi Access Point (AP) mode."
echo
sleep 3
enable_WiFi_AP "$SSID" "$WLAN_PASSPHRASE"
configure_lighttpd
echo
echo "Installation successful, the system will reboot as WiFi AP."
echo "hit enter to reboot or CTRL+C to abort automatic reboot..."
input reboot
if [ "$reboot" = "reboot" ]; then
	sudo reboot
fi
