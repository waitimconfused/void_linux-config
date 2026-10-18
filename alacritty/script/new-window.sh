#!/bin/bash

ACTIVE_WM_CLASS=$(niri msg --json focused-window | jq ".app_id")
if [[ $ACTIVE_WM_CLASS == *"Alacritty"* ]]; then
	# Get PID. If _NET_WM_PID isn't set, bail.
	PID=$(niri msg --json focused-window | jq ".pid")
	if [[ "$PID" == "" ]]; then
		alacritty
	fi
	# Get first child of terminal
	CHILD_PID=$(pgrep -P $PID)
	if [[ "$PID" == "" ]]; then
		alacritty
	fi

	# Get current directory of child. The first child should be the shell.
	pushd "/proc/${CHILD_PID}/cwd"
	SHELL_CWD=$(pwd -P)
	popd
	# Start alacritty with the working directory
	alacritty --working-directory $SHELL_CWD
else
	alacritty
fi
