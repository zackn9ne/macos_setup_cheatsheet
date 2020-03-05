#!/bin/sh

FILE=/Library/Application\ Support/JAMF/.userdelay.plist
if [ -f "$FILE" ]; then
    echo "$FILE exist"
fi
