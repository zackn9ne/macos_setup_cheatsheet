#!/bin/bash
## Set $4 in the JSS for what policy clicking Button 2 calls
## Set the variables
JamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

icon_folder="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/SharedSupport/Microsoft Error Reporting.app/Contents/Resources/office_threshold_arrow.icns"
icon_folder="/System/Library/CoreServices/CoreTypes.bundle/Contents/Library/MobileDevices.bundle/Contents/Resources/com.apple.iphone-xr-7.icns"
icon_folder="/System/Library/PreferencePanes/DateAndTime.prefPane/Contents/Resources/DateAndTime.icns"
icon_size=150
## PREP MESSAGE

#afplay --volume 4 /System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/system/payment_success.aif

title="Restart Needed"
heading="Your computer has been on for over 30 days."
descrip="Please consider restarting your computer to keep it running at its peak. If you are ready, save your work and click the Ok button below. If you are not ready, please hit cancel and restart at your earliest convenience.

**IMPORTANT** This message will no longer appear once you restart your computer. If you feel you have restarted it and are still getting this message please email support@company.nyc."

## Displaying Notification Window (JAMFHelper)
RESULT=$("$JamfHelper" -windowType hud -title "$title" -heading "$heading" -description "$descrip" -button1 "Maybe Later" -button2 "Restart Now!" -defaultButton 1 -lockHUD -icon "$icon_folder" -iconSize "$icon_size")

if [ $RESULT == 0 ]; then
    exit 0

elif [ $RESULT == 2 ]; then
    jamf policy -event $4
fi
