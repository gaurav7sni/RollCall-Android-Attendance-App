#!/bin/bash
# Usage: KS_PASS=yourpassword ./build-apk.sh path/to/keystore.jks
set -e
KS=${1:-release-key.jks}; AJ=/usr/lib/android-sdk/platforms/android-23/android.jar
S=app/src/main; W=$(mktemp -d)
# AndroidManifest for aapt (needs package attribute)
sed 's|<manifest xmlns:android="http://schemas.android.com/apk/res/android">|<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.gauravjha.rollcall" android:versionCode="1" android:versionName="1.0">|; /android:exported/d; /android:roundIcon/d' $S/AndroidManifest.xml > $W/AndroidManifest.xml
mkdir -p $W/classes
javac --release 8 -cp $AJ -d $W/classes $S/java/com/gauravjha/rollcall/MainActivity.java
dalvik-exchange --dex --output=$W/classes.dex $W/classes
aapt package -f -M $W/AndroidManifest.xml -S $S/res -A $S/assets -I $AJ --min-sdk-version 24 --target-sdk-version 30 -F $W/unsigned.apk
(cd $W && aapt add unsigned.apk classes.dex && zipalign -f 4 unsigned.apk aligned.apk)
apksigner sign --ks $KS --ks-pass env:KS_PASS --key-pass env:KS_PASS --out RollCall.apk $W/aligned.apk
echo "Built RollCall.apk"
