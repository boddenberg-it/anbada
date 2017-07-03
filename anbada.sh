#!/bin/sh

echo "[$(date)] anbada.sh $@" >> /var/www/html/logs/latest.log

echo "$(sudo adb devices)" > /tmp/anbada/myFile.txt
