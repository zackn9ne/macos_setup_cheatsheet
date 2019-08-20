#!/bin/bash
currentUser=`ls -l /dev/console | awk '{ print $3 }'`
/usr/local/bin/dockutil --allhomes --add /Applications/Google\ Chrome.app
/usr/local/bin/dockutil --allhomes --add /Applications/Microsoft\ Word.app
/usr/local/bin/dockutil --allhomes --add /Applications/Microsoft\ Excel.app
/usr/local/bin/dockutil --allhomes --add /Applications/Microsoft\ PowerPoint.app
/usr/local/bin/dockutil --allhomes --add /Applications/Slack.app
su "$currentUser" -c "defaults write com.apple.dock show-recents -bool FALSE"
su "$currentUser" -c "killall Dock"
