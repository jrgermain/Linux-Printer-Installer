#!/bin/bash

# Printer install shell script for Quinnipiac campus printing
# An example of my genreic printer script tweaked for a specific organization
#
# Written by Joey Germain
# 10/31/2018

#prompt for username
echo "Please enter your Quinnipiac network username: "
read username

#strip @qu.edu or @quinnipiac.edu from username by ignoring anything after '@'
username=${username%@*}

#download printer drivers
curl -s http://is.quinnipiac.edu/installs/MacCampusPrinting.zip --output /tmp/MacCampusPrinting.zip
curl -s http://is.quinnipiac.edu/installs/MacCampusPrintingColor.zip --output /tmp/MacCampusPrintingColor.zip

#unzip printer drivers
unzip -qq -o /tmp/MacCampusPrinting.zip -d /tmp
unzip -qq -o /tmp/MacCampusPrintingColor.zip -d /tmp

#install printers
lpadmin -p "CampusPrinting" -v "lpd://${username}@mfdServer/maccampusprinting" -P "/tmp/MacCampusPrinting.ppd" -o printer-is-shared=false
cupsenable "CampusPrinting" -E
cupsaccept "CampusPrinting"

lpadmin -p "CampusPrintingColor" -v "lpd://${username}@mfdServer/maccampusprintingcolor" -P "/tmp/MacCampusPrintingColor.ppd" -o printer-is-shared=false
cupsenable "CampusPrintingColor" -E
cupsaccept "CampusPrintingColor"

#delete temporary files
rm /tmp/MacCampusPrinting*

#print success message regardless of whether printers actually install (for now)
echo "Printer installation complete."
