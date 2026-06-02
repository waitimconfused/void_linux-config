#!/bin/bash

i3_window=$( i3-msg -t get_tree | jq ".. | objects | select(.window!=null and .window_properties.instance!=\"polybar\" and .focused)" );
i3_window_id=$(jq --raw-output ".window" <<< $i3_window)

i3_window_x=$(jq --raw-output ".rect.x" <<< $i3_window)
i3_window_y=$(jq --raw-output ".rect.y" <<< $i3_window)
i3_window_width=$(jq --raw-output ".rect.width" <<< $i3_window)
i3_window_height=$(jq --raw-output ".rect.height" <<< $i3_window)
i3_window_output=$(jq --raw-output ".output" <<< $i3_window)

i3_output=$( i3-msg -t get_outputs | jq ".[] | select( .name == \"$i3_window_output\" )" )
i3_output_x=$( jq ".rect.x" <<< $i3_output )
i3_output_y=$( jq ".rect.y" <<< $i3_output )
i3_output_width=$( jq ".rect.width" <<< $i3_output )
i3_output_height=$( jq ".rect.height" <<< $i3_output )

echo "Window: $i3_window_id ($i3_window_width x $i3_window_height )"
echo "Output: $i3_window_output ($i3_output_width x $i3_output_height )"


output_left=$(( $i3_output_x + 8))
output_centre_x=$(( $i3_output_x + $i3_output_width / 2 ))
output_right=$(( $i3_output_x + $i3_output_width - 8 ))

output_top=$(( $i3_output_y + 58))
output_centre_y=$(( $i3_output_y + $i3_output_height / 2 ))
output_bottom=$(( $i3_output_y + $i3_output_height - 8 ))

new_x=$i3_output_x
new_y=$i3_output_y

case $1 in
	left)
		new_x=$output_left
		;;
	centre)
		new_x=$(( $output_centre_x - $i3_window_width / 2 ))
		;;
	right)
		new_x=$(( $output_right - $i3_window_width ))
		;;

	*)
		echo "ERROR: Unexpected horizontal anchor \"$1\". Expected \"left\", \"centre\", or \"right\""
		;;
esac

case $2 in
	top)
		new_y=$output_top
		;;
	centre)
		new_y=$(( $output_centre_y - $i3_window_height / 2 ))
		;;
	bottom)
		new_y=$(( $output_bottom - $i3_window_height ))
		;;

	*)
		echo "ERROR: Unexpected vertical anchor \"$1\". Expected \"top\", \"centre\", or \"bottom\""
		;;
esac

echo "Location: ($new_x, $new_y)"

i3-msg "[id=$i3_window_id] move window to position $new_x $new_y px"