#!/bin/sh

loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

listadmins=$(dscacheutil -q group -a name admin)



if [[ $(echo "$listadmins" | grep $loggedInUser) ]];
then
      echo "<result>$loggedInUser are admin</result>"
    else
      echo "<result>$loggedInUser not admin</result>"
fi
