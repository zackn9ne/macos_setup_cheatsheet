#!/bin/sh

FILE=/Library/Application\ Support/JAMF/.userdelay.plist
if [ -f "$FILE" ]; then
   echo "<result>Deferals Exist</result>"
else
   echo "<result>Nothing Defered</result>"
fi
