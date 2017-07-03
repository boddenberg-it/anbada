#!/bin/sh

client_ip="$1"
shift

if [ "$1" = "refresh" ]; then
	echo "$(sudo adb devices)" > /tmp/anbada/devices
fi
