This is to drop into a terminal to setup macos

### misc helpful commands
```
sudo pkill loginwindow #logs you out eg, xdg-logout gnome-session-quit
pmset noidle #no idle
softwareupdate -i -a --restart
ioreg -r -k AppleClamshellState -d 4 | grep AppleClamshellState  | head -1
sudo installer -pkg /path/to/package.pkg -target /
rm /var/db/.applesetupdone #will ask to create user account on next boot with GUI #you have to be onsite and boot into single user mode
```

### monitor traffic with nettop (mini tutorial)
```
nettop
- press h to bring up help menu
- press e to toggle delta traffic (traffic since load v. current thoroughput)
```

### is mac bound to ad
```
dsconfigad -show | awk '/Active Directory Domain/{print $NF}'
```

### autopkg area additional tut: https://grahamgilbert.com/blog/2014/06/30/making-packages-with-autopkg/
```
1. download and install autopkg
2. autopkg repo-add https://github.com/autopkg/recipes
3. autopkg list-recipes | grep Excel
4. autopkg run MicrosoftExcel2016.install
5. pkg's end up in /Library/AutoPkg/Cache/

```

### erase all the apple apps one liner
```
rm -rf /Applications/Numbers.app/; rm -rf /Applications/Pages.app; rm -rf /Applications/iMovie.app; rm -rf /Applications/Keynote.app; rm -rf /Applications/GarageBand.app
```

### munki area
```
SERVER="1.2.3.4."

#client side-set them
sudo defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL "http://$SERVER/munki_repo"
sudo defaults write /Library/Preferences/ManagedInstalls ClientIdentifier "basic_manifest"
sudo defaults write /Library/Preferences/ManagedInstalls InstallAppleSoftwareUpdates -bool TRUE

#client side-check them
sudo defaults read /Library/Preferences/ManagedInstalls SoftwareRepoURL
sudo defaults read /Library/Preferences/ManagedInstalls ClientIdentifier
# Check suppress usernotification and installapplesoftwareupdate settings
defaults read /Library/Preferences/ManagedInstalls SuppressUserNotification
defaults read /Library/Preferences/ManagedInstalls InstallAppleSoftwareUpdates

#admin side
/usr/local/munki/munkiimport ~/Downloads/1Password-7.2.4.pkg 
vi /Users/Shared/munki_repo/manifests/basic_manifest
rsync -avz /Users/Shared/munki_repo root@$SERVER:/var/www/html

#autopkg side
autopkg run -v GoogleChrome.munki MakeCatalogs.munki #adds google chrome and essentially runs makecatalogs for any new item listed in this session of commands

#rsync side
rsync -avzh /Users/shared/munki_repo root@$SERVER:/var/www/html

#client side where's my apps
managedsoftwareupdate
or
managedsoftwareupdate -vvv # or it didn't happen
cat /Library/Managed Installs/Logs/ManagedSoftwareUpdate.log # can also be helpful.

```

### kext
```
kextstat | grep -v com.apple

With the advent of macOS 10.13 High Sierra, Apple introduced User Approved Kernel Extension Loading (UAKEL). This means that kernel extensions (also called kexts or security extensions) must be approved before they can be installed...

...Because xyz requires kexts to be installed, you will need to configure an MDM Profile and MDM Configuration for Kernel Extension Whitelist to bypass the user dialog that is normally required to approve a kext. 
```

### stupid mac tricks (links)
```
login screen helps: https://twocanoes.com/12-customizations-for-the-mojave-macos-login-window-that-you-didnt-know-about/
how to setup crontab on macos: https://alvinalexander.com/mac-os-x/mac-osx-startup-crontab-launchd-jobs
```

### filevault commands
```
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

### user tools
```
dscl . list /Users | grep -v '_' # list created users

## is user admin
dscacheutil -q group -a name admin #list only admin users

sudo dscl . -append /groups/admin GroupMembership "$ACN"

## delete user
sudo sysadminctl -deleteUser floater

## reset a users pw
/usr/bin/dscl . -passwd /Users/someadmin "$ome$ecret!" #run as root to not require existing pw, escape pw with quotes if special chars
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

### installmacos.py area
```
sudo curl -o installmacos.py https://raw.githubusercontent.com/munki/macadmin-scripts/master/installinstallmacos.py
sudo python installmacos.py
## or if coming from an older version the catalogurl might have to be spec'd
sudo python installmacos.py --catalogurl https://swscan.apple.com/content/catalogs/others/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog

## do user interaction, wait for download, then...
hdiutil attach ./Install_macOS_10.14.3-18D109.dmg 
open ./Install_macOS_10.14.3-18D109.dmg 
```
### Reset Dock
```
#!/bin/sh
killall cfprefsd
killall Dock

#if these don't work try v
rm $HOME/Library/Preferences/com.apple.Dock.plist; killall cfprefsd; killall Dock
```

### Dock Icons dependant on https://github.com/homebysix/docklib
```
#!/bin/sh
curl -O https://raw.githubusercontent.com/homebysix/docklib/4f3e173367f24b034c60092472c9523d8c7ddfca/docklib.py
curl -O https://gist.githubusercontent.com/zackn9ne/8183cd12667fb04a24972649685ec9a1/raw/9748a422f8b77067e4af3520aa9dc512febc04bb/dockv2.py
python dockv2.py

```

### change hostname script takes userinput
```
curl https://raw.githubusercontent.com/zackn9ne/macos_setup_cheatsheet/master/osahost.sh | sudo bash
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
