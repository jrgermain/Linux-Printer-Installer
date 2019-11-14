#!/bin/bash

# Printer install shell script for Quinnipiac campus printing
# An example of my genreic printer script tweaked for a specific organization
#
# Written by Joey Germain
# 11/14/19

# Variables
DRIVER_BW_URL=http://is.quinnipiac.edu/installs/MacCampusPrinting.zip
DRIVER_COLOR_URL=http://is.quinnipiac.edu/installs/MacCampusPrintingColor.zip
SERVER=mfdserver
PRINTER_BW=maccampusprinting
PRINTER_COLOR=maccampusprintingcolor
FRIENDLY_NAME_BW=CampusPrinting
FRIENDLY_NAME_COLOR=CampusPrintingColor

#prompt for username
echo "Please enter your Quinnipiac network username: "
read username

#strip @qu.edu or @quinnipiac.edu from username (if present) by ignoring anything after '@'
username=${username%@*}

#download and unzip printer drivers
curl -s ${DRIVER_BW_URL} --output /tmp/MacCampusPrinting.zip
curl -s ${DRIVER_COLOR_URL} --output /tmp/MacCampusPrintingColor.zip
unzip -qq -o /tmp/MacCampusPrinting.zip -d /tmp
unzip -qq -o /tmp/MacCampusPrintingColor.zip -d /tmp

#install printers
lpadmin -p "${FRIENDLY_NAME_BW}" -v "lpd://${username}@${SERVER}/${PRINTER_BW}" -P "/tmp/MacCampusPrinting.ppd" -o printer-is-shared=false
cupsenable "${FRIENDLY_NAME_BW}" -E
cupsaccept "${FRIENDLY_NAME_BW}"

lpadmin -p "${FRIENDLY_NAME_COLOR}" -v "lpd://${username}@${SERVER}/${PRINTER_COLOR}" -P "/tmp/MacCampusPrintingColor.ppd" -o printer-is-shared=false
cupsenable "${FRIENDLY_NAME_COLOR}" -E
cupsaccept "${FRIENDLY_NAME_COLOR}"

#delete temporary files
rm /tmp/MacCampusPrinting*

#print success message if printers installed successfully
bw_installed=$(lpstat -p | grep "${FRIENDLY_NAME_BW} ")
color_installed=$(lpstat -p | grep "${FRIENDLY_NAME_COLOR} ")

if [ ! -z "${bw_installed}" ]; then
	echo "${FRIENDLY_NAME_BW} installed successfully"
fi
if [ ! -z "${color_installed}" ]; then
	echo "${FRIENDLY_NAME_COLOR} installed successfully"
fi

