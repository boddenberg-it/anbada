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
			serials[$counter]="$device"
		else
			echo "odd $counter $device"
			position=$((counter/2))
	echo "position: $position"
			states[$position]="$device"
		fi
		counter=$((counter+1))
	done

#	while [ $counter -gt -1 ]; do
#		echo $counter
#		echo "<input type=\"radio\" name=\"device\" style=\"$states[$counter]\" value=\"$serial[$counter]\"><label>$serial[$counter]</label><br>" >> /tmp/anbada/devices
#		counter=$((counter-1))
#	done

	echo "$serials[0]"
	echo "$states[0]"
	echo 
fi
