#!/bin/sh

echo "wElCome ToO Zackn9neZ HostName ChanG3r"
read -p "Enter Your Hostname eg. NY-iMac-SomeBody: "  HWNAME
sudo scutil --set HostName "$HWNAME"
sudo scutil --set ComputerName "$HWNAME"
sudo scutil --set LocalHostName "$HWNAME"
dscacheutil -flushcache
echo "your new hostname is..."
hostname
