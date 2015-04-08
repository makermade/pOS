#!/bin/bash

ANDROID_HOME=$(cd $(dirname $BASH_SOURCE); pwd)

source $ANDROID_HOME/.config

VARIANT=${VARIANT:-eng}
PRODUCT_NAME=${PRODUCT_NAME:-full_${DEVICE}}
DEVICE=${DEVICE:-${PRODUCT_NAME}}
LUNCH=${LUNCH:-${PRODUCT_NAME}-${VARIANT}}

TOOLS_PATH=$ANDROID_HOME/out/host/`uname -s | tr "[[:upper:]]" "[[:lower:]]"`-x86/bin
EMULATOR=$ANDROID_HOME/prebuilts/android-emulator/linux-x86_64/emulator
KERNEL=$ANDROID_HOME/prebuilts/qemu-kernel/arm/kernel-qemu-armv7

SDCARD_SIZE=${SDCARD_SIZE:-512M}
SDCARD_IMG=${SDCARD_IMG:-$ANDROID_HOME/out/target/product/${DEVICE}/sdcard.img}

if [ ! -f "${SDCARD_IMG}" ]; then
	echo "Creating sdcard.img, size: ${SDCARD_SIZE}"
	${TOOLS_PATH}/mksdcard -l sdcard ${SDCARD_SIZE} ${SDCARD_IMG}
fi

export PATH=$PATH:$TOOLS_PATH
$EMULATOR \
	-kernel $KERNEL \
	-sysdir $ANDROID_HOME/out/target/product/$DEVICE/ \
	-data $ANDROID_HOME/out/target/product/$DEVICE/userdata.img \
	-sdcard $SDCARD_IMG \
	-memory 1024 \
	-partition-size 512 \
	-skindir $ANDROID_HOME/development/tools/emulator/skins \
	-skin WVGA800 \
	-show-kernel \
	-verbose \
	-gpu off \
	-camera-back webcam0 \
	-qemu -cpu cortex-a8 -serial pty

