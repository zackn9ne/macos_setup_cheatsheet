# macOS Sysadmin Cheatsheet

## make vmware fusion do stuff with JAMF
```
#echo below to ~/VirtualMachines/$vmname/*.vmdk
#
hw.model = "MacBookPro8,1"
serianNumber = $stuff
```


## Convert HVIC files to jpg
```
brew install imagemagick
magick mogrify -monitor -format jpg *.HEIC
```

## GIF Screen recorder
`brew cask install licecap`


## no screensaver allowed in login screen
`sudo defaults write /Library/Preferences/com.apple.screensaver loginWindowIdleTime 0`

## Add Printsystem to JAMF
PPD's are in
`/private/etc/cups/PPD`

drivers are in
`/Library/Printers/PPDs/Contents/Resources/`

## Synology
```
sudo smbstatus 
ps -p $PID-o comm= #get details on problematic $PID
awk -v val=$UID -F ":" ‘$3==val{print $1}’ /etc/passwd #to get details on problematic $UID
```

# Mac Admin GUI Tools
## Privledges.app
`/Applications/Privileges.app/Contents/Resources/PrivilegesCLI --remove`

# MacAdmin Commands and Tricks

# oneDrive mac files on demand scope
Files On-Demand requires the latest version of Mac OS Mojave 10.14. You can download and install Mac OS Mojave from the Mac App Store.

# generate a serial number
`python -c "import string; from random import randint, sample; print('VM' + ''.join(sample((string.ascii_uppercase + string.digits),10)))"`

# sign packages (you have to setup your Apple Developer ID 1st)
`productsign --sign “Developer ID Installer: Your Developer Name (1A2B3C4D5E)” ~/Desktop/example.pkg ~/Desktop/signed-example.pkg`

# check the package signature
`pkgutil --check-signature /path/to/package.pkg`

# make guest account script
`curl -O https://raw.githubusercontent.com/sheagcraig/guestAccount/master/guest_account && sudo guest_account enable`


# make macOs USB installers Instructions
https://support.apple.com/hr-hr/HT201372

# install pkg's
`sudo installer -pkg /path/to/package.pkg -target /`

# create a bootable VMWare Mojave Image
Create a virtual disk image .dmg to fit the installation media. This command will do the trick: `hdiutil create -o /tmp/Mojave -size 8000m -layout SPUD -fs HFS+J`

Mount it using this command: `hdiutil attach /tmp/Mojave.dmg -noverify -mountpoint /Volumes/install_build`

Use the createinstallmedia tool that is packed in the Mojave installer that you downloaded from the AppStore to write the Mojave Installer to the virtual disk image we just created. remember to use sudo!: `sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/Mojave`

# users and hosnames

### copy paste and press return to rename computers with zackn9nez hoStnamE ChanGeR ScRiPT :computer:

```
curl -O https://raw.githubusercontent.com/zackn9ne/macos_setup_cheatsheet/master/host-name-changer.sh && sh host-name-changer.sh
```

# escallate user to admin
`dscl . -append /groups/admin GroupMembership USERNAME`

# revok admin privledges
`sudo dseditgroup -o edit -d USERNAME -t user admin`

# password reset
`/usr/bin/dscl . -passwd /Users/USERNAME "N3wPassWorD"`

# is root user enabeled
`sudo dscl . -read /Users/root Password`

# get logged in user
```
loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`
```
or

get logged in console user

`id -un`

# get all users
`dscl . list /Users | grep -v '_'`

### get admin users
`dscacheutil -q group -a name admin`

### delete user
`sudo sysadminctl -deleteUser USERNAME`

### log people out :door:

`sudo pkill loginwindow #logs you out eg, xdg-logout gnome-session-quit`


### is mac bound to ad
```
dsconfigad -show | awk '/Active Directory Domain/{print $NF}'
```


### reset mac to new status on boot password break in hack :minidisc:
Start or restart your Mac. As soon as you hear the startup tone, press and hold Command-S on the keyboard. Keep holding down those keys until you see a black screen with white lettering. This is called “booting into Single User Mode.”

```
rm /var/db/.applesetupdone #will ask to create user account on next boot with GUI #you have to be onsite and boot into single user mode
```

# macos cruft

### rebuild spotlight index :flashlight:
`sudo mdutil -i on /`

### open link in chrome
`open -a "Google Chrome" https://chrome.google.com/webstore/detail/clear-cache/cppjkneekbjaeellbfkmgnhonkkjfpdn?hl=en`

### fuxor chrome for a fuxored user
```
#!/bin/sh
sudo pkill chrome
rm -rf "~/Library/Application Support/Google"
rm -rf "~/Library/Caches/com.google.Chrome*"
rm -rf "~/Library/Google"
```


### crash logs directory :flashlight:
```
ls ~/Library/Logs/DiagnosticReports/ 
```


# Essential MacAdmin Tools

### autopkg and autopkgr (GUI)

```
1. download and install autopkg
2. autopkg repo-add https://github.com/autopkg/recipes
3. autopkg list-recipes | grep Excel
4. autopkg run MicrosoftExcel2016.install
5. open ~/Library/AutoPkg/Cache/

```



### how to create a kext
```

With the advent of macOS 10.13 High Sierra, Apple introduced User Approved Kernel Extension Loading (UAKEL). This means that kernel extensions (also called kexts or security extensions) must be approved before they can be installed...

...Because xyz requires kexts to be installed, you will need to configure an MDM Profile and MDM Configuration for Kernel Extension Whitelist to bypass the user dialog that is normally required to approve a kext. 
```

```
create a kext from an pre-approved action on a sample machine
how to see what Kexts are allowed (with sample kext download) no need to sign, just make and feed to JAMF
https://forums.ivanti.com/s/article/How-To-Add-Kernel-Extension-Exceptions-using-Ivanti-MDM-in-2018-3
```

### stupid mac tricks (links)
```
login screen helps: https://twocanoes.com/12-customizations-for-the-mojave-macos-login-window-that-you-didnt-know-about/
how to setup crontab on macos: https://alvinalexander.com/mac-os-x/mac-osx-startup-crontab-launchd-jobs
```

### filevault commands
```
## is fv on?
`sudo fdesetup status`

## check fv status
diskutil cs list | grep 'Conversion Progress'

### check fv status live update eg or... wait check status with command emulation
while :; do clear; diskutil cs list | grep 'Conversion Progress'; sleep 2; done

## can user unlock filevault
sysadminctl -secureTokenStatus tracy

## troubleshooting a failed filevault
fdesetup status
sudo fdesetup disable

##add user to filevault unlock list
sudo fdesetup add -usertoadd username

## filevault spare tires
sudo fdesetup list
sudo diskutil apfs updatePreboot /

```



### send notification to user
```
osascript -e 'display alert "Hello World!" message "The reason for this pop-up alert: IT Work In Progress"'
osascript -e 'display alert "Hello World!" message "Leave open and plugged in: Automated installs in progress"'
```

### mobileconfig to supress chrome 1strun
```
curl -o firstchrome.mobileconfig  https://raw.githubusercontent.com/moofit/Config_Profiles/master/Google%20Chrome%20-%20Suppress%20First%20Run.mobileconfig && open firstchrome.mobileconfig
```

### install printer using lpinfo.. make a package to install drivers first
```
#install drivers first
CURRENTPRNTR=`sudo cat /etc/cups/printers.conf | grep MakeModel | cut -c11-`
lpinfo --make-and-model "$CURRENTPRNTR" -m

lpoptions -l #list all printer options
lpadmin -p $MODEL \
-o StringBeforeEqualsSign=ValueAfterColon #found on lpoptions -l pRiNtErNaMe -t
```

### Download MacOS Installers, run them via command line
```
sudo curl -o installmacos.py https://raw.githubusercontent.com/munki/macadmin-scripts/master/installinstallmacos.py
sudo python installmacos.py
## or if coming from an older version the catalogurl might have to be spec'd
sudo python installmacos.py --catalogurl https://swscan.apple.com/content/catalogs/others/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog

## do user interaction, wait for download, then...
hdiutil attach ./Install_macOS_10.14.3-18D109.dmg 
open ./Install_macOS_10.14.3-18D109.dmg 
```

### Mojave installer
## create a mojave installer USB 
`sudo ~/Downloads/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/newdisk`

## erase and reinstall
`sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/startosinstall --agreetolicense --eraseinstall --newvolumename "Macintosh HD" --nointeraction`

## do in place upgrade
`sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/startosinstall --agreetolicense --nointeraction`


### cool neat mojave install command line options
```
Arguments
--license, prints the user license agreement only.
--agreetolicense, agree to the license you printed with --license.
--rebootdelay, how long to delay the reboot at the end of preparing. This delay is in seconds and has a maximum of 300 (5 minutes).
--pidtosignal, Specify a PID to which to send SIGUSR1 upon completion of the prepare phase. To bypass "rebootdelay" send SIGUSR1 back to startosinstall.
--installpackage, the path of a package (built with productbuild(1)) to install after the OS installation is complete; this option can be specified multiple times.
--eraseinstall, (Requires APFS) Erase all volumes and install to a new one. Optionally specify the name of the new volume with --newvolumename.--newvolumename, the name of the volume to be created with --eraseinstall.
--preservecontainer, preserves other volumes in your APFS container when using --eraseinstall.
--usage, prints this message.
```

### Reset Dock
```
#!/bin/sh
killall cfprefsd
killall Dock

#if these don't work try v
rm $HOME/Library/Preferences/com.apple.Dock.plist; killall cfprefsd; killall Dock
```

### Copy and Paste all this and press return. Dock Icons uses https://github.com/homebysix/docklib library
```
#!/bin/sh
echo "downloading library..."
curl -O https://raw.githubusercontent.com/homebysix/docklib/4f3e173367f24b034c60092472c9523d8c7ddfca/docklib.py
echo "downloading script..."
curl -O https://raw.githubusercontent.com/zackn9ne/macos_setup_cheatsheet/master/dock.py
echo "creating dock..."
python dock.py

```


### Pycreateuserpkg area https://github.com/gregneagle/pycreateuserpkg

```
#get the script (if this errors, download the developer command line tools).
git clone https://github.com/gregneagle/pycreateuserpkg.git
 
#go into the project
cd pycreateuserpkg
 
#run the script with options replacing username, password, UID, and where you want to save it
#createuserpkg -a -u UID -n SHORTNAME  -p PASSWORD -V VERSION -i  PACKAGE_IDENTIFIER /path/to/save/user.pkg
#this will create an admin user named "mac" with password "mac" with a package version "1" and a package identifier com.twocanoes.mds.createuser and save it to a package called User.pkg in /tmp. Don't worry too much about the version and identifier, just use reasonable values.
#The UID should be something >500, since macOS starts creating users around there. I usually start at 900. 
./createuserpkg -a -u 900 -n "mac"  -p mac -V 1 -i  com.twocanoes.mds.createuser /tmp/User.pkg

#examples regular user create a pkg
./createuserpkg -u 900 -n "carolinet" -f "Caroline User" -p "secretpass" -V 1 -i com.company.net.createuser /tmp/Carolineu.pkg
./createuserpkg -u 900 -n "floater" -f "Floater User" -p "coolnewstartup" -V 1 -i com.coolnewstartup.net.createuser /tmp/float-coolnewstartup.pkg

#now install it
installer -pkg /tmp/temp.pkg -target /

```



### microsoft (python script) (installer) (run as user with admin priveledges, eg sudo)
```
#!/usr/bin/env python
import urllib2
import os
import sys

filedata = urllib2.urlopen('https://go.microsoft.com/fwlink/?linkid=830196')
datatowrite = filedata.read()

with open('./msupdater.pkg', 'wb') as f:
    f.write(datatowrite)

os.system('sudo installer -pkg ./msupdater.pkg -target /')
os.system('cd /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS && ./msupdate --install')
```


### ..but if you have to script.. slack (python)
```
#!/usr/bin/env python
import urllib2
import os
import sys

src = "https://raw.githubusercontent.com/bwiessner/install_latest_slack_osx_app/master/install_latest_slack_osx_app.sh"
dest = "slack.sh"

filedata = urllib2.urlopen(src)
datatowrite = filedata.read()

with open('./' + dest, 'wb') as f:
    f.write(datatowrite)
    
os.system('sudo chmod +x' + dest)
os.system('sudo ./' + dest)

```
