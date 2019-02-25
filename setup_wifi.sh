#!/bin/sh
. /etc/sysconfig/wireless
. /etc/sysconfig/network

ifconfig ${NET_DEVICE} down
# LED on lan connetor off
i2cset -f -y 1 0x18 0x52 2
killall udhcpc
sleep 1

wpa_supplicant -Dnl80211 -i${WLAN_DEVICE} -c/etc/wpa_supplicant.conf -B
sleep 3
wpa_cli scan_results > /tmp/scan_results
echo " "
echo "Available networks"
cat /tmp/scan_results | awk '{if(NR>2) print $5 " " $3"dB"}'
echo " "
echo -n "Enter the netork name to connect to : "
read NET
echo -n "Enter the password for $NET : "
read PWD
echo "ctrl_interface=/var/run/wpa_supplicant" > /etc/wpa_supplicant.conf
echo "ctrl_interface_group=0" >> /etc/wpa_supplicant.conf
echo "ap_scan=1" >> /etc/wpa_supplicant.conf
echo "update_config=1" >> /etc/wpa_supplicant.conf
echo "network={" >> /etc/wpa_supplicant.conf
echo "  ssid=\"$NET\"" >> /etc/wpa_supplicant.conf
echo "  psk=\"$PWD\"" >> /etc/wpa_supplicant.conf
echo "  scan_ssid=1" >> /etc/wpa_supplicant.conf
echo "  key_mgmt=WPA-EAP WPA-PSK IEEE8021X NONE" >> /etc/wpa_supplicant.conf
echo "  pairwise=TKIP CCMP" >> /etc/wpa_supplicant.conf
echo "  group=CCMP TKIP WEP104 WEP40" >> /etc/wpa_supplicant.conf
echo "  priority=5" >> /etc/wpa_supplicant.conf
echo "}" >> /etc/wpa_supplicant.conf
sleep 1
kill -9 `pidof wpa_supplicant`
sleep 1
go_wifi.sh

