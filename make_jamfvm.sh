#!/bin/bash
#
# To use this script, quit VMware Fusion first!!!
# src: https://www.jamf.com/jamf-nation/discussions/30708/vmware-fusion-virtual-mac-unable-to-enroll
#
# You'll be dragging this script into Terminal, then dragging the *.vmx file into Terminal.
# This requires sudo rights, but you already knew that, right? :)
#
#    /path/to/ThisScript.sh /path/to/MyVm.vmwarevm/MyVm.vmx
#
# 20180208 DM

VMXFILE="$1"

echo ""
echo "**********************************************************"
echo "IMPORTANT: To use this script, quit VMware Fusion first!!!"
echo "**********************************************************"
echo ""

echo "Enter your fake Serial Number, up to 12 characters (letters and numbers)."
read SERIALNUMBER

echo "Enter ModelIdentifier for example MacBookPro15,1 or iMacPro1,1"
read MODELIDENTIFIER

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
echo "serialNumber = $SERIALNUMBER" >> "$VMXFILE"

exit 0
