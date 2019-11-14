#!/bin/bash

# Linux printer installer
# Written by Joey Germain
# 11/14/19

# Variables
PPD_DRIVER_URL=http://10.10.10.10/installs/driver.ppd
USERNAME=user
SERVER=server
PRINTER=printer
FRIENDLY_NAME=ColorPrinting

# Download printer drivers
curl --silent $PPD_DRIVER_URL --output /tmp/linuxprinting.ppd

# Install printers
lpadmin -p "${FRIENDLY_NAME}" -v "lpd://${USERNAME}@${SERVER}/${PRINTER}" -P "/tmp/linuxprinting.ppd" -o printer-is-shared=false
cupsenable "${FRIENDLY_NAME}" -E
cupsaccept "${FRIENDLY_NAME}"

# Delete temporary files
rm /tmp/linuxprinting.ppd

# Echo if printer installation succeeded
printer_installed=$(lpstat -p | grep "${FRIENDLY_NAME_BW} ")
if [ ! -z "${printer_installed}" ]; then
	echo "${FRIENDLY_NAME} installed successfully"
fi
