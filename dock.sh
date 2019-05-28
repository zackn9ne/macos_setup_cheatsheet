#!/bin/sh

import os
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
