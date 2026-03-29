#!/bin/bash

FILE="$HOME/.config/i3/script/brightness-value"

STEP_SIZE=5

if [ ! -f "$FILE" ]; then
	echo "100" > "$FILE"
fi


VALUE=$(< "$FILE")

case $1 in
	"up")
		VALUE=$((VALUE + $STEP_SIZE))
		;;
	"down")
		VALUE=$((VALUE - $STEP_SIZE))
		;;
	"max")
		VALUE=100
		;;
	"min")
		VALUE=0
		;;
esac

if (( VALUE > 100 )); then
	VALUE=100
fi

if (( VALUE < 0 )); then
	VALUE=0
fi

echo $VALUE
echo "$VALUE" >"$FILE"
brillo -S "$VALUE.00"
