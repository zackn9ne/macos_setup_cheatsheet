#!/bin/sh


# install driver 1st from MFGR
#begin 15f 
#begin 15f printer
#begin 15f printer
#begin 15f printer

MODEL="Canon-iR-ADV-C250-350-15f"
DISPLAY_NAME="Finance Dept"
LOCATION="Office"
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
