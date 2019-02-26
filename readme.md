This is to drop into a terminal to setup macos

### swiss-army-knife mojave edition
```
sudo pkill loginwindow #logs you out eg, xdg-logout gnome-session-quit
dscacheutil -q group -a name admin #list only admin users
pmset noidle #no idle
dscl . list /Users | grep -v '_' # list created users
softwareupdate -i -a --restart
ioreg -r -k AppleClamshellState -d 4 | grep AppleClamshellState  | head -1
```

### installmacos.py
```
curl -o install.py https://raw.githubusercontent.com/munki/macadmin-scripts/master/installinstallmacos.py
sudo python install.py
## do user interaction, wait for download, then...
hdiutil attach ./Install_macOS_10.14.3-18D109.dmg 
```

### install dockutil (todo bootstrap this into a dock icon making script) dependant on https://github.com/homebysix/docklib (first curl)
```
#!/bin/sh
curl -O https://raw.githubusercontent.com/homebysix/docklib/4f3e173367f24b034c60092472c9523d8c7ddfca/docklib.py
curl -O https://gist.githubusercontent.com/zackn9ne/8183cd12667fb04a24972649685ec9a1/raw/9748a422f8b77067e4af3520aa9dc512febc04bb/dockv2.py
python dockv2.py

```

### hostname (scutil)
```
#!/bin/sh
HWNAME="The-host-name"
scutil --set ComputerName "$HWNAME"
scutil --set LocalHostName "$HWNAME"
dscacheutil -flushcache
```

### user creation (sysadminctl) #need help with these

#### via createuserpackage.py
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
```

```
#!/bin/sh
ACN="buser"
FN="Bob User"
PW="password"
sudo sysadminctl -addUser "$ACN" -fullName $FN -password "$PW"
# extra below
## is user admin
sudo dscl . -append /groups/admin GroupMembership "$ACN"
sudo sysadminctl -deleteUser floater
sudo sysadminctl -add sysadminctl -secureTokenStatus tracy
```

### send notification to user
```
osascript -e 'display alert "Hello World!" message "The reason for this pop-up alert: IT Work In Progress"'
```


### microsoft (python) (installer) (run as user with admin priveledges, eg sudo)
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

### slack (python)
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
