#!/bin/sh
# query DEP for your user name and location variables 
# hash your jssSecrets like this user:pass

jamfbinary=$(/usr/bin/which jamf)
jssSecrets=$4
jssHost=$5 #noslash



serial=$(ioreg -rd1 -c IOPlatformExpertDevice | awk -F'"' '/IOPlatformSerialNumber/{print $4}')


data=$(curl -k ${jssHost}/JSSResource/computers/serialnumber/${serial}/subset/location -H "Accept: application/xml" -H "Authorization: Basic ${jssSecrets}" )
username=$(echo $data | /usr/bin/awk -F'<username>|</username>' '{print $2}')
building=$(echo $data | /usr/bin/awk -F'<building>|</building>' '{print $2}')
echo $username "and" $building

product_name=$(ioreg -l | awk '/product-name/ { split($0, line, "\""); printf("%s\n", line[4]); }')

if [ -z "$serial" ]
then
	echo "no serial found failing"
    exit 1
elif [ -z "$username" ]
then
	echo "no username found failing"
    exit 1
elif [ -z "$building" ]
then
	echo "no building found failing"
    exit 1
else
    echo "safety check satisfied"
fi

if echo "$product_name" | grep -q "MacBookAir*"
then
    PREFIX="MBA"
    
elif echo "$product_name" | grep -q "MacBookPro*"
then
    PREFIX="MBP"

elif echo "$product_name" | grep -q "iMac*"
then
    PREFIX="iMAC"

elif echo "$product_name" | grep -q "Parallels*"
then
    PREFIX="VM"


else
    echo "No model identifier found."
    PREFIX=""
    
    if [ "$PREFIX" == "" ]; then
    echo "Error: No model identifier found."
    fi
    exit 1
fi

echo "Username:" $username
echo "Building:" $building
echo "Product:" $product_name
echo "PREFIX:" $PREFIX

user=$(echo $username|tr . -)

echo $user


hostname="${building}-${PREFIX}-${user}"
echo "About to set hostname to $hostname"

#read -n 1 -s -r -p "Press any key to continue"
$jamfbinary setComputerName -name "$hostname"
$jamfbinary recon


/usr/local/bin/jamf recon


exit 0
