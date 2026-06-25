#!/bin/bash
status="$(playerctl status --no-messages)"

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


	icon="%{F#4E7B31}󰎇%{F-}"
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