#!/usr/bin/env bash
#set -e

echo "**** setting build env. ****"
rm -rf /cache/*

BASE_DIR="$(pwd)"
SOURCEDIR="${BASE_DIR}/xdroid"

git config --global user.email "okand7946@gmail.com" && git config --global user.name "omnitrix21"
df -h
mkdir -p "${SOURCEDIR}"
cd "${SOURCEDIR}"

echo -e "$green << Syncing source >> \n $white"
repo init -u https://github.com/xdCLO/xd_manifest -b eleven
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

echo "**** cloning device specific resources and needed dependencies****"
git clone -b eleven  https://github.com/omnitrix21/device_xiaomi_sweet device/xiaomi/sweet


echo -e "$blue***********************************************"
echo "          BUILDING ROM          "
echo -e "***********************************************$nocol"
. b*/e*
lunch xdroid_sweet-userdebug
make xd -j$(nproc --all)
cd out/target/product/sweet
curl -sL https://git.io/file-transfer | sh
./transfer wet xdCLO*.zip

exit
