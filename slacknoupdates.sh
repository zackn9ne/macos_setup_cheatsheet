#!/bin/bash
#this works well in a jamf policy it will probably work well elsewhere
#variable for storing the current users name
currentuser=`stat -f "%Su" /dev/console`

#substituting as user stored in variable to modify plist
su "$currentuser" -c "defaults write com.tinyspeck.slackmacgap SlackNoAutoUpdates -bool YES"
