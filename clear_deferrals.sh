#!/bin/sh

# this is for jamfPro
# it looks for if there are any policy deferrals set and clears them
if [ -f "/Library/Application\ Support/JAMF/.userdelay.plist"]; then 
	rm -rf /Library/Application\ Support/JAMF/.userdelay.plist
else 
	echo "file not found 404 no deferrals set"
fi
