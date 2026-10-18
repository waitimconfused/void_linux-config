#!/bin/bash

# Simlink file origin: ~/.config/niri/script/sunsetr-cycle.sh

STATE_AUTO="default"
STATE_OFF="day"
STATE_ON="night"

echo "General rule: $STATE_AUTO -> $STATE_OFF -> $STATE_ON -> $STATE_AUTO"

SUNSETR_PRESET=$(sunsetr preset active)

NEW_SUNSETR_PRESET="off"

case $SUNSETR_PRESET in
	$STATE_AUTO)
		NEW_SUNSETR_PRESET="$STATE_OFF"
		;;
	$STATE_OFF)
		NEW_SUNSETR_PRESET="$STATE_ON"
		;;
	$STATE_ON)
		NEW_SUNSETR_PRESET="$STATE_AUTO"
		;;
	*)
		echo "Unknown preset: '$SUNSETR_PRESET'"
		exit
		;;
esac

echo "'$SUNSETR_PRESET' -> '$NEW_SUNSETR_PRESET'"

if [ "$SUNSETR_PRESET" == "$NEW_SUNSETR_PRESET" ]; then
	echo "Change is redundant; ignoring"
	exit 0
fi

# echo $(sunsetr preset active)
sunsetr preset $NEW_SUNSETR_PRESET

if [ "$(sunsetr preset active)" != "$NEW_SUNSETR_PRESET" ]; then
	sunsetr preset $NEW_SUNSETR_PRESET
fi

echo $(sunsetr preset active)
