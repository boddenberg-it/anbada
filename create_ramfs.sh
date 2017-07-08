#!/bin/sh
# script to create ramfs to avoid IO ops on sdcard
# (saving its lifetime and speed up IO ops between lighty and GPIO interface)
sudo mkdir -p /tmp/anbada
sudo mke2fs -m 0 /dev/ram0
sudo mount /dev/ram0  /tmp/anbada
sudo chown www-data /tmp/anbada
sudo chmod 700 /tmp/anbada
