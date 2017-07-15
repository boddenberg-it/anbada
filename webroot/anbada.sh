#!/bin/bash
#
# anbada.sh functions for submit buttons in index.php holds.
# For each of such buttons a functions must be declared.
# Otherwise error message in anbada.log you will find.

function backup() {
	serial="$1"
	flags=""

	if [ "$2" = "apps:on" ]; then
		flags="-apk"
	fi
	if [ "$3" = "storage:on" ]; then
		flags="${flags} -shared"
	fi
	if [ "$4" = "system_apps:on" ]; then
		flags="${flags} -system"
	fi

	mkdir -p "/var/www/html/backups_of/$serial/"
	adb -s "$serial" wait-for-device backup -f "/var/www/html/backups_of/$serial/$serial-$(date)" $flags
}

function restore() {
	exit 0
}

function sync() {
	mkdir oooohjjee
	exit 0
}

function add_ssid() {
	# omit the clear text password
	wpa_passphrase "$1" "$2" | sed '0~3d' >> /etc/wpa_supplicant/wpa_supplicant.conf
}

function refresh() {
	rm /tmp/anbada/devices || true
	touch /tmp/anbada/devices

	counter=0
	serials=()
	states=()

	devices=$(sudo adb devices|awk '{if(NR>1)print}'|head -n -1)

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

# log every invokation with date and IP
echo "[$(date)] $@" >> anbada.log
shift
$@
