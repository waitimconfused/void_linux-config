#!/bin/bash
exit_message=$( playerctl status --no-messages 2>&1)

colour_background="#112717"
colour_foreground="#AAE8B6"
colour_primary="#4E7B31"
colour_alert="#BB334C"
colour_disabled="#2E462B"

if [[ $exit_message != "" ]]; then

	case $exit_message in
		"Could not connect to players: Unknown or unsupported transport “disabled” for address “disabled:”")
			exit_message="Unknown or unsupported transport"
			;;
	esac

	for ((i = 30; i >= 0 ; i-- )); do
		echo "%{F$colour_alert}$exit_message%{F-} ($i sec)"
		
		if (( i != 0 )); then sleep 1; fi
	done
	exit
fi

show() {
	status="$(playerctl status --no-messages)"

	if [ "$status" = "" ]; then
		echo ""
		exit 0
	fi

	playbutton="%{A:playerctl play-pause:}"

	if [ "$status" = "Paused" ]; then
		playbutton="$playbutton"
	else
		playbutton="$playbutton"
	fi

	playbutton="$playbutton%{A}"

	title=$(playerctl metadata title)
	info=""
	if [[ $title != "" ]]; then
		title="$( jq --raw-output "truncate(.;20)" <<< "\"$title\"" )";
		info="($title)"
	fi


	icon="%{F$colour_primary}󰎇%{F-}"
	echo "$icon %{A:playerctl previous:}󰒮%{A} $playbutton %{A:playerctl next:}󰒭%{A} $info"

}

show

playerctl status --follow \
| while read -r player status; do
    show
done

playerctl metadata --follow \
| while read -r player status; do
    show
done