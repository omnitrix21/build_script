#!/usr/bin/env bash
#set -e

echo "**** setting build env. ****"
rm -rf /cache/*

BASE_DIR="$(pwd)"
SOURCEDIR="${BASE_DIR}/rising"

git config --global user.email "okand7946@gmail.com" && git config --global user.name "omnitrix21"
df -h
mkdir -p "${SOURCEDIR}"
cd "${SOURCEDIR}"

echo -e "$green << Syncing source >> \n $white"
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs --depth=1
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

echo "**** cloning device specific resources and needed dependencies****"
git clone -b rising https://github.com/omnitrix21/device_xiaomi_sweet device/xiaomi/sweet
rm -rf hardware/lineage/compat && git clone https://github.com/basamaryan/android_hardware_lineage_compat -b lineage-21.0 hardware/lineage/compat

echo -e "$blue***********************************************"
echo "          BUILDING ROM          "
echo -e "***********************************************$nocol"
. b*/e*
riseup sweet userdebug
ascend
cd out/target/product/sweet
curl -sL https://git.io/file-transfer | sh
./transfer wet Rising*.zip

exit
