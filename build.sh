source .config

VARIANT=${VARIANT:-eng}
PRODUCT_NAME=${PRODUCT_NAME:-full_${DEVICE}}
DEVICE=${DEVICE:-${PRODUCT_NAME}}
LUNCH=${LUNCH:-${PRODUCT_NAME}-${VARIANT}}

export USE_CCACHE=yes &&
source build/envsetup.sh &&
lunch $LUNCH &&
time make $MAKE_FLAGS $@

ret=$?

if [ $ret -ne 0 ]; then
	echo
	echo \> Build failed\! \<
	echo
else
	if echo $DEVICE | grep generic > /dev/null ; then
		echo Run \|./run-emulator.sh\| to start the emulator
		exit 0
	fi
	exit 0
fi

exit $ret
