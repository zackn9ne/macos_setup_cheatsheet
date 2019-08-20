#!/bin/sh
# install driver 1st
#begin 19f printer
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
  
  
  
# install driver 1st
#begin 15f 
#begin 15f printer
#begin 15f printer
#begin 15f printer

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
