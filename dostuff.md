This is to drop into a terminal to setup macos

*** hostname (scutil)
```
#!/bin/sh
scutil --set ComputerName "Tracy-MacBook-Air"
scutil --set LocalHostName "Tracy-MacBook-Air"
dscacheutil -flushcache
```

*** user creation (sysadminctl)
```
#!/bin/sh
sudo sysadminctl -deleteUser floater
sudo sysadminctl -addUser bobuser -fullName "Bob User" -password "password"
sudo sysadminctl -add sysadminctl -secureTokenStatus tracy
```

*** dock creation make a python script and chmod +x it (python)
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
        '/Applications/Google Chrome.app', j
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
