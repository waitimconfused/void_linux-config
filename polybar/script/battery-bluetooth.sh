#!/bin/bash

if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]; then
	echo ""
	exit 0
fi


uuids=$(bluetoothctl devices Connected | cut -f2 -d' ')
uuids=($uuids)

if [[ $1 = "debug" ]]; then
	echo "UUIDS (${#uuids[@]}):"
	echo $uuids
	echo ""
fi

message=""
for (( i=0; i<${#uuids[@]}; i++ )); do

	if (( $i > 0 )); then
		message="$message %{F#2E462B}|%{F-} "
	fi

	battery=$(bluetoothctl info ${uuids[$i]} | grep -e "Battery Percentage" | awk -F'[()]' '{print $2}')

	if [[ $1 = "debug" ]]; then
		echo "INFO (${uuids[$i]}):"

		if [[ $battery = "" ]]; then
			battery="not-provided"
		else
			battery="$battery%"
		fi

		echo "  Battery: $battery"
		continue
	fi

	if [[ $battery = "" ]]; then
		message="$message%{F#4E7B31}󰂯%{F-}"
		continue
	fi

	rounded_battery=$(awk -v n="$battery" 'BEGIN{print int(n/25)*25}')

	message="$message%{F#4E7B31}"

	case $rounded_battery in
		"0")
			message="$message󰂯 "
			;;
		"25")
			message="$message󰂯 "
			;;
		"50")
			message="$message󰂯 "
			;;
		"75")
			message="$message󰂯 "
			;;
		"100")
			message="$message󰂯 "
			;;
		*)
			message="$message 󰂯 ($rounded_battery)"
	esac

	message="$message%{F-} $battery%"



done

# bluetoothctl devices Connected | cut -f2 -d' ' | while read uuid; do
# 	message="$message $(bluetoothctl info $uuid | grep -e "Battery Percentage" | awk -F'[()]' '{print $2}')"
# 	echo "UUID=$uuid"
# 	echo "BATT=$message"
# 	echo
# done

echo "$message"

# battery="$(bluetoothctl info | grep "Battery Percentage" | awk -F'[()]' '{print $2}')"

# echo "$battery%"
