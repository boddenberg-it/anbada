#!/bin/bash
#
# anbada.sh functions for submit buttons in index.php holds.
# For each of such buttons a functions must be declared.
# Otherwise error message in anbada.log you will find.

set_wlan_ap_mode() {
	sudo sed -i -e 's/#denyinterfaces wlan0/denyinterfaces wlan0/g' /etc/lightdm/lightdm.conf
	sudo cp /etc/network/interfaces.ap /etc/network/interfaces
	sudo reboot
}

set_wlan_client_mode() {
	sudo sed -i -e 's/denyinterfaces wlan0/#denyinterfaces wlan0/g' /etc/lightdm/lightdm.conf
	sudo cp /etc/network/interfaces.client /etc/network/interfaces
	sudo reboot
}

update() {
	# updating raspian
	sudo apt-get update
	sudo apt-get -y upgrade
	# updating anbada
	cd ~/anbada
	git fetch origin
	git rebase origin/release
	# apply webserver changes
	sudo cp lighttpd.conf /etc/lighttpd/lighttpd.conf
	sudo systemctl restart lighttpd.service
}

renew_cert() {
	sudo mkdir -p /etc/lighttpd/certs
	cd /etc/lighttpd/certs
	sudo rm lighttpd.pem || true

	sudo openssl req -new -x509 -keyout lighttpd.pem -out lighttpd.pem \
	-days 365 -nodes -subj '/CN=anbada.local/O=boddenberg.it/C=EU'

	sudo chown www-data:www-data lighttpd.pem
	sudo chmod 400 lighttpd.pem
}

# one single backup thingy, everything except storage, as this is synced!
function backup() {
	mkdir -p "/var/www/html/anbada/backups_of/$serial/"
	adb -s "$1" wait-for-device backup -apk -obb -system \
		-f "/var/www/html/anbada/backups_of/$serial/$serial-$(date)"
}

function restore() {
	exit 0
}

# just sync it
function sync() {
	serial="$1"
	device_storage="/var/www/ssl/syncs/$serial/"
	mkdir -p "$device_storage"

	dirs=$(adb -s "$serial" wait-for-device ls /sdcard | cut -d ' ' -f4 | tail -n +3)
	for dir in $dirs; do
		 adb-sync -s "$serial" --reverse "/sdcard/$dir" "$device_storage"
	done
}

function add_ssid() {
	# omit the clear text password
	sudo wpa_passphrase "$1" "$2" | sed '0~3d' >> /etc/wpa_supplicant/wpa_supplicant.conf
}

function refresh() {
	rm /tmp/anbada/devices || true
	touch /tmp/anbada/devices

	counter=0
	serials=()
	states=()

	devices=$( adb devices|awk '{if(NR>1)print}'|head -n -1)

	for device in $devices; do
		if [ $((counter %2)) -eq 0 ]; then
			serials[$((counter/2))]="$device"
		else
			states[$((counter/2))]="$device"
		fi
		counter=$((counter+1))
	done

	counter=$(($((counter/2))-1))

	if [ $counter -eq -1 ]; then
		echo "<p><b>Please connect a device!</b></p>" > /tmp/anbada/devices
		exit 0
	fi

	while [ $counter -gt -1 ]; do
		serial="${serials[$counter]}"
		state="${states[$counter]}"
		counter=$((counter-1))
		echo "<input type=\"radio\" name=\"device\" class=\"$state\" value=\"$serial\" /> $serial" >> /tmp/anbada/devices
	done
}

mount_encfs() {
	# TODO: think about hashing or just let them fail...
	encfs --extpass="echo $1" ~/anbada/webroot/encrypted ~/anbada/webroot/decrypted
	chown pi:www-data -R ~/anbada/webroot/decrypted
}

umount_encfs(){
	fusermount -u ~/anbada/webroot/decrypted
}

create_ramfs() {
	sudo mkdir -p /tmp/anbada
	sudo mke2fs -m 0 /dev/ram0
	sudo mount /dev/ram0  /tmp/anbada
	sudo chown www-data:www-data /tmp/anbada
	sudo chmod 700 /tmp/anbada
}

# log every invokation with date and IP
echo "[$(date)] $@" >> anbada.log
shift
$@ &
