#!/bin/sh

# Set jamfbin
JAMFBIN=$(/usr/bin/which jamf)

# Get the current logged in user that we'll be modifying
if [ ! -z "$3" ]; then
	CURRENTUSER=$3
else
	CURRENTUSER=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
fi

# Get location of default DEPnotify plist form JPS
DNPLIST=/Users/"$CURRENTUSER"/Library/Preferences/menu.nomad.DEPNotifyUserInput.plist

# Get username var
USERNAME=$(/usr/libexec/plistbuddy $DNPLIST -c "print 'Computer Name'" | tr [A-Z] [a-z])

# Set username var
$JAMFBIN createAccount -username $USERNAME -realname $USERNAME -password Welcome2019 -admin

# Outta here
pkill loginwindow
