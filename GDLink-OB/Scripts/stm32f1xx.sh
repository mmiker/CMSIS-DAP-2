#!/bin/sh

TARGET="stm32f103c8"
PACK_NAME="$PACKS/Keil.STM32F1xx_DFP.2.3.0.pack"

Usage() {
	echo "Usage: $0 [erase | flash | info]."
}

if [ $# -eq 0 ]; then
	Usage
else
	case $1 in
	erase)
		echo "Erase Device..."
		pyocd erase --chip --target $TARGET --pack=$PACK_NAME
	;;
	flash)
		if [ $# -eq 2 ]; then
			echo "Flash Device..."
			pyocd flash $2 --target $TARGET --pack=$PACK_NAME
		else
			Usage
			echo "Usage: $0 erase [APP.hex]"
		fi
	;;
	info)
		echo "Try unlock Device..."
		pyocd-flashtool --unlock --target $TARGET --pack=$PACK_NAME
	esac
fi
