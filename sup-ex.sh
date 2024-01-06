#!/usr/bin/env bash
#set -e

echo "**** setting build env. ****"
rm -rf /cache/*

BASE_DIR="$(pwd)"
SOURCEDIR="${BASE_DIR}/sup-ex"

git config --global user.email "okand7946@gmail.com" && git config --global user.name "omnitrix21"
df -h
mkdir -p "${SOURCEDIR}"
cd "${SOURCEDIR}"

echo -e "$green << Syncing source >> \n $white"
repo init --depth=1 --no-repo-verify -u https://github.com/SuperiorExtended/manifest -b UDC -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

echo "**** cloning device specific resources and needed dependencies****"
git clone -b sup-ex https://github.com/omnitrix21/device_xiaomi_sweet device/xiaomi/sweet
rm -rf hardware/lineage/compat && git clone https://github.com/basamaryan/android_hardware_lineage_compat -b lineage-21.0 hardware/lineage/compat

echo -e "$blue***********************************************"
echo "          BUILDING ROM          "
echo -e "***********************************************$nocol"
. b*/e*
lunch superior_sweet-userdebug
make bacon 
exit
