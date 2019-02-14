This is to drop into a terminal to setup macos

*** swiss-army-knife mojave edition
```
sudo pkill loginwindow #logs you out eg, xdg-logout gnome-session-quit
dscl . list /Users | grep -v "^_" #list users
dscacheutil -q group -a name admin #list only admin users
pmset noidle #no idle
softwareupdate -i -a --restart
```

*** installmacos.py
```
curl -o install.py https://raw.githubusercontent.com/munki/macadmin-scripts/master/installinstallmacos.py
sudo python install.py
```

*** install dockutil (bootstrap)
```
curl -o dockutil.py https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil
```

*** hostname (scutil)
```
#!/bin/sh
HWNAME="The-host-name"
scutil --set ComputerName $HWNAME
scutil --set LocalHostName $HWNAME
dscacheutil -flushcache
```

*** user creation (sysadminctl) #need help with these
```
#!/bin/sh
ACN="buser"
FN="Bob User"
PW="password"
sudo sysadminctl -addUser $ACN -fullName $FN -password $PW
# extra below
## is user admin
sudo dscl . -append /groups/admin GroupMembership $ACN
sudo sysadminctl -deleteUser floater
sudo sysadminctl -add sysadminctl -secureTokenStatus tracy
```

*** send notification to user
```
osascript -e 'display alert "Hello World!" message "The reason for this pop-up alert: IT Work In Progress"'
```

*** dock creation make a python script and chmod +x it (python) #should use mobileconfig
```
#!/usr/bin/env python
import urllib2
import os

filedata = urllib2.urlopen('https://raw.githubusercontent.com/homebysix/docklib/master/docklib.py')
datatowrite = filedata.read()

with open('./docklib.py', 'wb') as f:
    f.write(datatowrite)


from docklib import Dock 

def makeDock():
    tech_dock = [ 
        '/Applications/Google Chrome.app',
        '/Applications/Microsoft Excel.app', 
        '/Applications/Microsoft Word.app', 
        '/Applications/Microsoft PowerPoint.app', 
        '/Applications/Slack.app' 
    ] 
    dock = Dock() 
    for item in tech_dock: 
        if os.path.exists(item): 
            item = dock.makeDockAppEntry(item) 
            dock.items['persistent-apps'].append(item) 
            dock.save() 

makeDock()
```

*** microsoft (python) (installer) (run as user with admin priveledges, eg sudo)
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

*** slack (python)
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
