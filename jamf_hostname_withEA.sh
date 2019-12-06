#!/bin/bash

#welcome to zackn9nes jamf hostname script
jamfbinary=$(/usr/bin/which jamf)
location=$4 #for jamf operator input
model=$5 #for jamf operator input

#whos logged in
user=$( scutil <<< "show State:/Users/ConsoleUser" | awk -F': ' '/[[:space:]]+Name[[:space:]]:/ { if ( $2 != "loginwindow" ) { print $2 }}' )
echo "detected location is" $location
echo "detected user is:" $user

#killswitch
if [ -z "$user" ]
then
	echo "user is null exiting with error"
    exit 1
elif [ $user = "root" ]
then
     echo "user is root user failing gracefully"
     exit 1
elif [ -z "$location" ]
then
	echo "Location is broken exiting with error"
    exit 1
elif [ -z "$model" ]
then
	echo "Model is broken exiting with error"
    exit 1

else
    echo "proceeding"
fi

#back to the device
hostname="${location}-${model}-${user}"
hostname=${hostname:0:15}
echo $hostname

#read -n 1 -s -r -p "Press any key to continue"
$jamfbinary setComputerName -name "$hostname"
$jamfbinary recon


