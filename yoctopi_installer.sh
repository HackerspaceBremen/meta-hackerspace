#!/bin/bash

# yocto_workspace-installer - Installiert den Yocto Workspace für den RPi - getested auf Xubuntu 16.04


#### Setup Routine

#Abhängigkeiten
sudo apt-get update
sudo apt-get -y install build-essential git cmake autoconf zip chrpath diffstat gawk libncurses5-dev texinfo python2.7

#Python 2.7 als "Standard"
sudo ln -sf /usr/bin/python2.7 /usr/bin/python
sudo ln -sf /usr/bin/python2.7 /usr/bin/python2

#Shell zu bash konfigurieren
dpkg-reconfigure -p critical dash

#Yocto meta-layer herunterladen
cd ~
git clone -b rocko git://git.yoctoproject.org/poky.git poky-rocko
cd ~/poky-rocko
git clone -b rocko git://git.openembedded.org/meta-openembedded
git clone -b rocko https://github.com/meta-qt5/meta-qt5
git clone -b rocko git://git.yoctoproject.org/meta-security
git clone -b rocko git://git.yoctoproject.org/meta-raspberrypi

#RPi Layer herunterladen
mkdir ~/rpi
cd ~/rpi
git clone -b rocko git://github.com/jumpnow/meta-rpi

#Workspace vorbereiten
mkdir -p ~/rpi/build/conf
cd ~
source poky-rocko/oe-init-build-env ~/rpi/build

#Configs für den rpi layer vorbereiten
cd ~/rpi
cp meta-rpi/conf/local.conf.sample build/conf/local.conf
cp meta-rpi/conf/bblayers.conf.sample build/conf/bblayers.conf

source poky-rocko/oe-init-build-env ~/rpi/build
