#!/bin/bash

window_id=$( xdotool getwindowfocus );
i3_window=$( i3-msg -t get_tree | jq ".. | objects | select(.window!=null and .window_properties.instance!=\"polybar\" and .focused)" );
is_fullscreen=$( echo $i3_window | jq ".fullscreen_mode==1" )
is_floating=$( echo $i3_window | jq ".floating==\"user_on\"" )
is_sticky=$( echo $i3_window | jq ".sticky" )

if [[ $is_fullscreen = "true" ]]; then
	is_floating="false"
	is_sticky="false"
fi

echo "Window ID: $window_id"
echo "Fullscreen: $is_fullscreen"
echo "Floating: $is_fullscreen"
# echo "I3 Window: $i3_window"

case $1 in
	in)
		# ./libinput-gestures.sh in
		case $2 in
			3)
				# ./libinput-gestures.sh in 3
				if [[ $is_fullscreen == "true" ]]; then
					i3-msg "[id=$window_id] fullscreen disable; floating disable; sticky disable"
				elif [[ $is_floating == "false" ]]; then
					i3-msg "[id=$window_id] floating enable; resize set 952 507 px; move window to position center"
				fi
				;;
			4)
				# ./libinput-gestures.sh in 4
				if [[ $is_fullscreen == "true" ]]; then
					i3-msg "[id=$window_id] fullscreen disable; floating disable; sticky disable"
				elif [[ $is_floating == "false" ]]; then
					i3-msg "[id=$window_id] floating enable; sticky enable; resize set 952 507 px; move window to position center"
				fi
				;;
			*)
				echo "Unknown amount of fingers: '$2'; Expected '3' or '4'."
		esac
		;;

	out)
		# ./libinput-gestures.sh out
		if [[ $is_fullscreen == "true" ]]; then
			exit 0
		elif [[ $is_floating == "true" ]]; then
			i3-msg "[id=$window_id] floating disable; sticky disable"
		else
			i3-msg "[id=$window_id] fullscreen enable"
		fi	
		;;
	
	*)
		echo "Unknown gesture: '$1'. Expected 'in' or 'out'"
		;;
esac
