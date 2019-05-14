#!/bin/bash

HWNAME=$(osascript <<EOD
tell application "System Events"
text returned of (display dialog "Please enter your desired hostname: (Use dashes for spaces)" default answer "")
end tell
EOD)

read -p "Enter Your Hostname eg. NY-iMac-SomeBody: "  HWNAME
sudo scutil --set HostName "$HWNAME"
sudo scutil --set ComputerName "$HWNAME"
sudo scutil --set LocalHostName "$HWNAME"
dscacheutil -flushcache
