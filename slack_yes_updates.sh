#!/bin/bash
#variable for storing the current users name
#this lets the update slack button show back up
currentuser=`stat -f "%Su" /dev/console`

#substituting as user stored in variable to modify plist
su "$currentuser" -c "defaults write com.tinyspeck.slackmacgap SlackNoAutoUpdates -bool NO"
