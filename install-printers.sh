#!/bin/bash

# Linux printer installer
# Written by Joey Germain
# 2/22/l9
#
# TODO: verify that printers actually install, check if root privileges are needed

# Variables
PPD_DRIVER_URL=http://10.10.10.10/installs/driver.ppd
USERNAME=user
SERVER=server
PRINTER=printer
FRIENDLY_NAME=ColorPrinting

#download printer drivers
curl -s $PPD_DRIVER_URL --output /tmp/linuxprinting.ppd

#install printers
lpadmin -p "${FRIENDLY_NAME}" -v "lpd://${USERNAME}@${SERVER}/${PRINTER}" -P "/tmp/linuxprinting.ppd" -o printer-is-shared=false
cupsenable "${FRIENDLY_NAME}" -E
cupsaccept "${FRIENDLY_NAME}"

#delete temporary files
rm /tmp/linuxprinting.ppd

#print success message regardless of whether printers actually install (for now)
echo "Printer installation complete."
