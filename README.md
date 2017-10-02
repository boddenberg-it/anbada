Why?

Anbada shall simplify the backup process for Android devices. 
A full backup can be created via "adb backup". Furthermore one can sync only Photos and Videos as well as the entire data.

WIP.TBC... 















How?

Get the latest raspian lite or full image and flash it to the pi's sdcard.
Connect everything and boot it. Then open a terminal (Ctrl-Alt-F1) and execute:
```
sudo raspi-config
```

Expand the filesystem in "7 Advanced Options" -> "A1 Expand Filesystem".
One may also want to enable the SSH server in "5 Interfacing Options" -> "P2 SSH".

Connect to your WLAN/SSID by executing:
```
sudo wpa_passphrase "SSID" "PASSWORD" >> /etc/wpa_supplicant/wpa_supplicant.conf
```

Then clone anbada and install it by executing:
```
git clone https://git.boddenberg.it/anbada ~/anbada
~/anbada/install.sh
```

Follow instructions to fulfill installation.
