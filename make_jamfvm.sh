#!/bin/bash
#
# To use this script, quit VMware Fusion first!!!
# src: https://www.jamf.com/jamf-nation/discussions/30708/vmware-fusion-virtual-mac-unable-to-enroll
#
# You'll be dragging this script into Terminal, then dragging the *.vmx file into Terminal.
# This requires sudo rights, but you already knew that, right? :)
#
#    /path/to/ThisScript.sh (no arguments needed you will be prompted)
#
# 20180208 DM

SN=$(python -c "import string; from random import randint, sample; print('VM' + ''.join(sample((string.ascii_uppercase + string.digits),10)))")
#VMXFILE="$1"

echo ""
echo "**********************************************************"
echo "IMPORTANT: To use this script, quit VMware Fusion first!!!"
echo "**********************************************************"
echo ""

echo "Quit VMWARE and, show the virtual machine you will be blessing in the finder, drag the path of the VM's inside VMX file as an argument to this script"
read -p "Press enter to continue".
echo "fake Serial Number, will be:" $(echo SN)

echo "drag the path to your .VMX FILE here"
echo "we are about to pop up your finder window of the default VMWare VM's location so you can do this easier"
open ~/Virtual\ Machines.localized/
read VMXFILE

read -r -p "Your getting ModelIdentifier MacBookPro15,1 is this OK? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    MODELIDENTIFIER="MacBookPro15,1"
else
    echo "Ok type in your own ModelIdentifier then maybe you like iMacPro1,1 as a hint:"
    read MODELIDENTIFIER
fi


# Remove device specific crud

sed -i '' '/ethernet0.addressType/d' "$VMXFILE"
sed -i '' '/ethernet0.generatedAddress/d' "$VMXFILE"
sed -i '' '/ethernet0.generatedAddressOffset/d' "$VMXFILE"
sed -i '' '/uuid.bios/d' "$VMXFILE"
sed -i '' '/uuid.location/d' "$VMXFILE"
sed -i '' '/hw.model/d' "$VMXFILE"
sed -i '' '/serialNumber/d' "$VMXFILE"

# Add Model Identifier and Serial Number

echo "hw.model = $MODELIDENTIFIER" >> "$VMXFILE"
echo "serialNumber = $SN" >> "$VMXFILE"

exit 0
