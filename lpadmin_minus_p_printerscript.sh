#!/bin/sh

#begin printer example 1
# install driver 1st
MODEL="Konica-Minolta-C454e-PS"
DISPLAY_NAME="PW WEST"
LOCATION="PW WEST"
PROTOCOL="lpd"
DEVICE_URI="10.1.50.248"
DRIVER="/Library/Printers/PPDs/Contents/Resources/KONICAMINOLTAC454e.gz"

/usr/sbin/lpadmin -p "${MODEL}" \
  -D "${DISPLAY_NAME}" \
  -L "${LOCATION}" \
  -E -v "${PROTOCOL}://${DEVICE_URI}" \
  -P "${DRIVER}" \
  -o printer-is-shared=false 

  -o tonersavemode=on \
  -o duplex=duplexnotumble \
  -o CNPdeUseJobAccount=True \
  -o CNUseJobAccount=True \
  -o CNAuthenticate=True
  
  


#begin printer example 2
# install driver 1st
MODEL="Canon-iR-ADV-C250-350"
DISPLAY_NAME="19f"
LOCATION="19f"
PROTOCOL="lpd"
DEVICE_URI="10.9.8.12"
DRIVER="/Library/Printers/PPDs/Contents/Resources/CNPZUIRAC250ZU.ppd.gz"

/usr/sbin/lpadmin -p "${MODEL}" \
  -D "${DISPLAY_NAME}" \
  -L "${LOCATION}" \
  -E -v "${PROTOCOL}://${DEVICE_URI}" \
  -P "${DRIVER}" \
  -o printer-is-shared=false \
  -o tonersavemode=on \
  -o duplex=duplexnotumble \
  -o CNPdeUseJobAccount=True \
  -o CNUseJobAccount=True \
  -o CNAuthenticate=True
  
  
#begin printer example 3  
# install driver 1st

MODEL="Canon-iR-ADV-C250-350-15f"
DISPLAY_NAME="15f"
LOCATION="15f"
PROTOCOL="lpd"
DEVICE_URI="10.9.10.122"
DRIVER="/Library/Printers/PPDs/Contents/Resources/CNPZUIRAC250ZU.ppd.gz"

/usr/sbin/lpadmin -p "${MODEL}" \
  -D "${DISPLAY_NAME}" \
  -L "${LOCATION}" \
  -E -v "${PROTOCOL}://${DEVICE_URI}" \
  -P "${DRIVER}" \
  -o printer-is-shared=false \
  -o tonersavemode=on \
  -o duplex=duplexnotumble \
  -o CNPdeUseJobAccount=True \
  -o CNUseJobAccount=True \
  -o CNAuthenticate=True
