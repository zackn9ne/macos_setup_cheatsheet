#!/bin/sh
#gets the Proper Formatted name of the last user who logged into the macOS

LastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
FullLastUser=`dscl . read /Users/$LastUser | awk '/RealName/ { getline; print $0 }'`
echo $FullLastUser
