#!/bin/sh
$munkiserveruser = root
$munkiserver = 1.1.1.1

printf 'Which do you want? (addnewpkg, updatemanifest* sets what to install, updatecatalog )'
read DISTR

case $DISTR in
     addnewpkg)
          echo "which package do you want to install and add to catalog eg GoogleChrome"
          read whichpkg

          autopkg run -v $whichpkg.munki MakeCatalogs.munki

          read -n 1 -s -r -p "Press any key to continue and rsync this to the actual munki server"
          rsync -avz /Users/Shared/munki_repo $munkiserveruser@$munkiserver:/var/www/html
          ;;
     updatemanifest)
          vi munki_repo/manifests/basic_manifest
          ;;
     updatecatalog)
          echo "running makecatalogs"
          /usr/bin/munki/makecatalogs
          ls munki_repo/catalogs
          ;; 
     *)
          echo "Hmm, seems i've never used it."
          ;;
esac
