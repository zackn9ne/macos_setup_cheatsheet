This is to drop into a terminal to setup macos

### misc helpful commands
```
sudo pkill loginwindow #logs you out eg, xdg-logout gnome-session-quit
dscacheutil -q group -a name admin #list only admin users
pmset noidle #no idle
dscl . list /Users | grep -v '_' # list created users
softwareupdate -i -a --restart
ioreg -r -k AppleClamshellState -d 4 | grep AppleClamshellState  | head -1
```

### stupid mac tricks
* login screen helps: https://twocanoes.com/12-customizations-for-the-mojave-macos-login-window-that-you-didnt-know-about/
* how to setup crontab on macos: https://alvinalexander.com/mac-os-x/mac-osx-startup-crontab-launchd-jobs


### filevault commands
```
diskutil cs list | grep 'Conversion Progress'
### or... wait check status with command emulation
while :; do clear; diskutil cs list | grep 'Conversion Progress'; sleep 2; done

fdesetup status
sudo fdesetup disable
```

### user manipulation
```
## is user admin
sudo dscl . -append /groups/admin GroupMembership "$ACN"
sudo sysadminctl -deleteUser floater
sudo sysadminctl -add sysadminctl -secureTokenStatus tracy
```

### send notification to user
```
osascript -e 'display alert "Hello World!" message "The reason for this pop-up alert: IT Work In Progress"'
```

### mobileconfig to supress chrome 1strun
```
curl -O https://raw.githubusercontent.com/moofit/Config_Profiles/master/Google%20Chrome%20-%20Suppress%20First%20Run.mobileconfig
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

### installmacos.py
```
sudo curl -o installmacos.py https://raw.githubusercontent.com/munki/macadmin-scripts/master/installinstallmacos.py
sudo python installmacos.py
## or if coming from an older version the catalogurl might have to be spec'd
sudo python installmacos.py -catalogurl https://swscan.apple.com/content/catalogs/others/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog

## do user interaction, wait for download, then...
hdiutil attach ./Install_macOS_10.14.3-18D109.dmg 
open ./Install_macOS_10.14.3-18D109.dmg 
```

### make dock icons! dependant on https://github.com/homebysix/docklib
```
#!/bin/sh
curl -O https://raw.githubusercontent.com/homebysix/docklib/4f3e173367f24b034c60092472c9523d8c7ddfca/docklib.py
curl -O https://gist.githubusercontent.com/zackn9ne/8183cd12667fb04a24972649685ec9a1/raw/9748a422f8b77067e4af3520aa9dc512febc04bb/dockv2.py
python dockv2.py

```

### change hostname script i wrote that takes userinput
```
curl -O https://gist.githubusercontent.com/zackn9ne/c7d3a41ed939567d6e4dae8e7b40c48d/raw/ce4804d317975b1f4ccac520d50ae2d383ed4c08/hostname.sh
```
or
```
#!/bin/sh
echo "Please enter your desired hostname NO SPACES ALLOWED, use dash"
read HWNAME
scutil --set ComputerName "$HWNAME"
scutil --set LocalHostName "$HWNAME"
dscacheutil -flushcache

```
### tool based

### install apps with autopkg https://github.com/autopkg/autopkg

### user creation with Pycreateuserpkg https://github.com/gregneagle/pycreateuserpkg

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
