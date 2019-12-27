#!/bin/sh

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
