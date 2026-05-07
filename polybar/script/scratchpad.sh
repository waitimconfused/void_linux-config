#!/bin/bash

reload() {
	scratchpad_windows=$( i3-msg -t get_tree | jq '.. | objects | select(.type == "workspace" and .name == "__i3_scratch") | [ .. | objects | select(.window != null) | .name  ]' )

	polybar_message=$( jq --raw-output "map( \"%{F#4E7B31}󰽉%{F-} \" + (.[0:15]) ) | join(\" %{F#2E462B}|%{F-} \")" <<< $scratchpad_windows )
	echo $polybar_message
}

reload

i3-msg -t subscribe -m '[ "window" ]' | while read line ; do
	reload
done