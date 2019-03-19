#!/bin/bash

HWNAME=$(osascript <<EOD
tell application "System Events"
text returned of (display dialog "Please enter your desired hostname: (Use dashes for spaces)" default answer "")
end tell
EOD)

scutil --set ComputerName "$HWNAME"
scutil --set LocalHostName "$HWNAME"
dscacheutil -flushcache
