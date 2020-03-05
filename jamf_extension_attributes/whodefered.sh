#!/bin/sh

FILE="/Library/Application Support/JAMF/.userdelay.plist"
if [ -f "$FILE" ]; then
   if grep -q date "$FILE"; then
      echo "<result>Deferals Exist</result>"
   fi
else
   echo "<result>Nothing Defered</result>"
fi
