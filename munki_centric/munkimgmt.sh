#!/bin/sh
$munkiserveruser = root
$munkiserver = 1.1.1.1

printf 'Which do you want? (A)d new pkg or update pkg, (U)pdatemanifest* sets what to install, updateca(T)alog'
read DISTR

case $DISTR in
     A)
          echo "which package do you want to install and add to catalog eg. type GoogleChrome to add or update googlechrome"
          read whichpkg

          autopkg run -v $whichpkg.munki MakeCatalogs.munki

          read -n 1 -s -r -p "Press any key to continue and rsync this to the actual munki server"
          rsync -avz /Users/Shared/munki_repo $munkiserveruser@$munkiserver:/var/www/html
          ;;
     U)
          vi munki_repo/manifests/basic_manifest
          ;;
     T)
          echo "running makecatalogs"
          /usr/bin/munki/makecatalogs
          ls munki_repo/catalogs
          ;; 
     *)
          echo "Hmm, seems i've never used it."
          ;;
esac
