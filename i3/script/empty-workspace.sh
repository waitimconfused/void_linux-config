#!/bin/bash

RAW_WORKSPACES=$(i3-msg -t get_workspaces | jq)

WORKSPACES=$(i3-msg -t get_workspaces | jq "map(.num|tonumber) | [.[] | select(.>=0)]")
CURRENT=$(echo $RAW_WORKSPACES | jq ".[] | select(.focused==true) | .num")
CURRENT_COUNT=$(i3-msg -t get_tree | jq --arg ws "$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')" '.. | objects | select(.type=="workspace" and .name==$ws) | [.. | objects | select(.window!=null and .sticky==false)] | length')

workspace_error="?"
new_workspace=$workspace_error

for (( i=1; i<$(echo $WORKSPACES | jq "length" ); i++ )); do
	previous="$(echo $WORKSPACES | jq ".[$((i - 1))]")"
	current=$(echo $WORKSPACES | jq ".[$i]")

	if (( $current != "$((previous + 1))" )); then
		new_workspace=$((previous + 1))
		break;
	fi
done

case $1 in
	"move")
	
		if (( $CURRENT_COUNT == "1" )); then
			echo "Workspace has one window."
			exit 0
		fi

		if [[ $new_workspace != $workspace_error ]]; then
			echo "Moving window to workspace #$new_workspace"
			i3-msg move to workspace $new_workspace
			exit 0
		fi
		
		new_workspace=$(echo $WORKSPACES | jq "max")
		new_workspace=$((new_workspace + 1))

		echo "Moving window to workspace #$new_workspace"
		i3-msg move window to workspace $new_workspace
		;;

	"set")

		if (( $CURRENT_COUNT == "0" )); then
			echo "Workspace already empty."
			exit 0
		fi

		if [[ $new_workspace != $workspace_error ]]; then
			echo "Moving view to workspace #$new_workspace"
			i3-msg workspace $new_workspace
			exit 0
		fi

		new_workspace=$(echo $WORKSPACES | jq "max")
		new_workspace=$((new_workspace + 1))

		echo "Moving view to workspace #$new_workspace"
		i3-msg workspace $new_workspace
		;;

	"both")
	
		if (( $CURRENT_COUNT == "1" )); then
			echo "Workspace has one window."
			exit 0
		fi

		if [[ $new_workspace != $workspace_error ]]; then
			echo "Moving window+view to workspace #$new_workspace"
			i3-msg move window to workspace $new_workspace, workspace $new_workspace
			exit 0
		fi
		
		new_workspace=$(echo $WORKSPACES | jq "max")
		new_workspace=$((new_workspace + 1))

		echo "Moving window+view to workspace #$new_workspace"
		i3-msg move window to workspace $new_workspace, workspace $new_workspace
		;;

	"info")

		echo "workspaces = $(echo $WORKSPACES | jq) (length=$(echo $WORKSPACES | jq "length"))"
		echo "current = $CURRENT"
		echo "windows = $(i3-msg -t get_tree | jq --arg ws "$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')" '.. | objects | select(.type=="workspace" and .name==$ws) | [.. | objects | select(.window!=null and .sticky==false)] | map(.name)') (length=$CURRENT_COUNT)"
		echo ""

		echo "MOVE:"
		if (( $CURRENT_COUNT == "1" )); then
			echo "  Workspace has one window. Not changing."
		
		elif [[ $new_workspace != $workspace_error ]]; then
			echo "  Moving window to workspace #$new_workspace"
		else
			fake_workspace=$(echo $WORKSPACES | jq "max")
			fake_workspace=$((fake_workspace + 1))

			echo "  No gap in workspaces found. Setting to last+1"
			echo "  Moving window to workspace #$fake_workspace"
		fi

		echo "SET:"
		if (( $CURRENT_COUNT == "0" )); then
			echo "  Workspace already empty."
		
		elif [[ $new_workspace != $workspace_error ]]; then
			echo "  Moving view to workspace #$new_workspace"
		else
			fake_workspace=$(echo $WORKSPACES | jq "max")
			fake_workspace=$((fake_workspace + 1))

			echo "  No gap in workspaces found. Setting to last+1"
			echo "  Moving view to workspace #$fake_workspace"
		fi

		echo "BOTH:"
		if (( $CURRENT_COUNT == "1" )); then
			echo "  Workspace has one window. Not changing."
		
		elif [[ $new_workspace != $workspace_error ]]; then
			echo "  Moving window+view to workspace #$fake_workspace"
		else
			fake_workspace=$(echo $WORKSPACES | jq "max")
			fake_workspace=$((fake_workspace + 1))

			echo "  No gap in workspaces found. Setting to last+1"
			echo "  Moving window+view to workspace #$fake_workspace"
		fi
		;;
	
	*)
		echo "Unexpected parameter \"$1\". Must be \"move\", \"set\", \"both\", \"info\"."
		echo "  \"move\": Move current window to an empty workspace"
		echo "  \"set\":  Move current workspace to an empty workspace"
		echo "  \"both\": Move both current window and workspace to an empty workspace"
		echo "  \"info\": Show debug information"
esac
