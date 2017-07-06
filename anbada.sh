#!/bin/bash

client_ip="$1"
shift

echo "$(date): $client_ip $@" >> anbada.log

if [ "$1" = "refresh" ]; then
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
		echo "yeah"
		serial="${serials[$counter]}"
		state="${states[$counter]}"
		echo "$counter $serial $state"
		echo "<input type=\"radio\" name=\"device\" style=\"$state\" value=\"$serial\"><label>$serial</label><br>" >> /tmp/anbada/devices
		counter=$((counter-1))
	done
fi
