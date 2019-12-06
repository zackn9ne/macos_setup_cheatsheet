#!/bin/bash

#welcome to zackn9nes jamf hostname script
jamfbinary='/usr/local/bin/jamf'
jssURL="https://xxx.jamfcloud.com/JSSResource/"
usernamePasswordHash='xxx'
apiEndpointEA='computerextensionattributes'
apiEndpointSerial='computers/serialnumber'
Location=$4 #for jamf user input
#auto get serial on device side
SERIAL=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')

#test specific serial here
#SERIAL='xxx'

#you will need an EA at id 8 which culls the last user test them with this block
#----
#availableEAs=${jssURL}${apiEndpointEA}
#echo "payload is" $availableEAs
#curl -k ${availableEAs} -H "Accept: application/json" -H "Authorization: Basic ${usernamePasswordHash}"
#---


echo "now getting last user for" $SERIAL
EAID=8
echo parsing ${jssURL}${apiEndpointSerial}/${SERIAL}/subset/extension_attributes
xml=$(curl -k ${jssURL}${apiEndpointSerial}/${SERIAL}/subset/extension_attributes -H "Accept: application/xml" -H "Authorization: Basic ${usernamePasswordHash}")
echo "xml is>>>>>" $xml
LastUser=$(echo $xml | xpath "//*[id=$EAID]/value/text()")
echo "last user is" $LastUser

#searialism
DEVICEINFO=$(curl -k ${jssURL}${apiEndpointSerial}/${SERIAL}/subset/hardware -H "Accept: application/xml" -H "Authorization: Basic ${usernamePasswordHash}")
MODEL=$(echo $DEVICEINFO | /usr/bin/awk -F'<model_identifier>|</model_identifier>' '{print $2}')
echo $MODEL


#killswitch
if [ -z "$LastUser" ]
then
	echo "LastUser is broken exiting with error"
    exit 1
elif [ -z "$Location" ]
then
	echo "Location is broken exiting with error"
    exit 1
else
    echo "proceeding"
fi

#back to the device
if echo "$MODEL" | grep -q "MacBookAir"
then
	PREFIX="MBA"
elif echo "$MODEL" | grep -q "MacBookPro"
then
	PREFIX="MBP"
elif echo "$MODEL" | grep -q "Mac Mini"
then
	PREFIX="MM"
elif echo "$MODEL" | grep -q "iMac"
then
	PREFIX="IM"
elif echo "$MODEL" | grep -q "MacPro"
then
	PREFIX="MP"
else
	echo "No model identifier found."
	PREFIX="uNK"
fi

hostname="${Location}-${PREFIX}-${LastUser}"
hostname=${hostname:0:15}
echo $hostname

#read -n 1 -s -r -p "Press any key to continue"
$jamfbinary setComputerName -name "$hostname"
$jamfbinary recon


