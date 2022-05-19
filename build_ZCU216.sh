#!/bin/bash


set -e

set -x


echo `date` > runtime.txt


# Load the local config
source config.sh

# Run PYNQ build prequisites from: https://pynq.readthedocs.io/en/latest/pynq_sd_card.html#building-the-image
petalinux-util --webtalk off


# (2020.2) tools

#source 2020.2.sh


export buildroot=`pwd`

if [ ! -e "$prebuilt" ]; then

    echo "$prebuilt DNE"

    exit

fi


if [ ! -d "ZCU216-PYNQ" ]; then

    git clone --recursive https://github.com/adi8v/ZCU216-PYNQ.git

fi


pushd ZCU216-PYNQ/ZCU216

#if [ ! -e "$bsp_filename" ]; then
#    pwd
#    ln -s $bsp
#fi

popd


# git build.sh so that other boards are not rebuilt

pushd ZCU216-PYNQ/PYNQ

echo "" > build.sh

#git commit -a -m "clean out build.sh"

popd

# move tics files to proper directory
cp -a ZCU216-PYNQ/tics/. ZCU216-PYNQ/PYNQ/sdbuild/packages/xrfclk/package/xrfclk/

pushd ZCU216-PYNQ/PYNQ/sdbuild

#bash ./scripts/setup_host.sh

#export PATH=/opt/qemu/bin:/opt/crosstool-ng/bin:$PATH

make BOARDDIR=$buildroot/ZCU216-PYNQ PREBUILT=$prebuilt


BOARD=ZCU216

VERSION=2.7.0

boardname=$(echo ${BOARD} | tr '[:upper:]' '[:lower:]' | tr - _)

timestamp=$(date +'%Y_%m_%d')

imagefile=${boardname}_${timestamp}.img

zipfile=${boardname}_${timestamp}.zip

mv output/${BOARD}-${VERSION}.img $imagefile

zip -j $zipfile $imagefile


popd


echo `date` >> runtime.txt


cat runtime.txt

