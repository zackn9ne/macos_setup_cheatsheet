#!/bin/bash

HWNAME=$(osascript <<EOD
tell application "System Events"
text returned of (display dialog "Please enter your desired hostname: (Use dashes for spaces)" default answer "")
end tell
EOD)

#HWNAME="NY-iMac-SomeBody"
sudo scutil --set HostName "$HWNAME"
sudo scutil --set ComputerName "$HWNAME"
sudo scutil --set LocalHostName "$HWNAME"
dscacheutil -flushcache
