#!/bin/bash

reload() {

	if [[ $MONITOR == "" ]]; then
		echo "Unset \$MONITOR value."
		exit 0
	fi

	current_workspace=$(i3-msg -t get_workspaces | jq -r ".[] | select(.output==\"$MONITOR\" and .visible)".name)

	windows=$(
		i3-msg -t get_tree |
		jq --raw-output \
			--arg ws $current_workspace \
			' .. | objects
			| select(.type=="workspace" and .name==$ws)
			| [.. | objects | select(.window!=null and .sticky==false)]
			| if ( . | length ) == 1
				then " "+truncate(.[0].name;30)+" "
				else map(
					if (.focused == true)
						then "%{u#2E462B}%{+u} "+truncate(.name;20)+" %{-u}"
						else " "+truncate(.name;20)+" "
					end
				) | join(" ")
			end'
	)

	scratchpad_windows=$(
		i3-msg -t get_tree |
		jq --raw-output '.. | objects
			| select(.type == "workspace" and .name == "__i3_scratch")
			| [
				.. | objects
				| select(.window != null)
				| .name
			]
			| map("%{F#4E7B31}󰛑%{F-} " + (.[0:15]) )
			| join(" ")'
	)

	echo "$windows $scratchpad_windows"
}

reload

i3-msg -t subscribe -m '[ "window", "workspace" ]' | while read line ; do
	reload
done
