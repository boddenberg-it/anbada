#!/bin/bash

client_ip="$1"
shift

if [ "$1" = "refresh" ]; then
	rm /tmp/anbada/devices || true
	touch /tmp/anbada/devices

	counter=0
	serials=()
	states=()

	devices=$(sudo adb devices|awk '{if(NR>1)print}'|head -n -1)

	for device in $devices; do
		echo "$counter: $device"
		if [ $((counter %2)) -eq 0 ]; then
			echo "even $counter $device"
			serials[$((counter/2))]="$device"
		else
			echo "odd $counter $device"
			position=$((counter/2))
	echo "position: $position"
			states[$position]="$device"
		fi
		counter=$((counter+1))
	done
	echo $counter
	counter=$(($((counter/2))-1))
	echo $counter

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
