#!/bin/bash
LATEST=`curl https://dl.google.com/widevine-cdm/current.txt`
[ -f $LATEST-linux-x64.zip ] && rm $LATEST-linux-x64.zip
wget https://dl.google.com/widevine-cdm/$LATEST-linux-x64.zip
unzip -o $LATEST-linux-x64.zip
[ -d /usr/lib/chromium ] || sudo mkdir -p /usr/lib/chromium
sudo mv libwidevinecdm.so /usr/lib/chromium && sudo chmod 644 /usr/lib/chromium/libwidevinecdm.so
rm -rf $LATEST-linux-x64.zip LICENSE.txt manifest.json