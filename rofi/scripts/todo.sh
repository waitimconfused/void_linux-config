#!/bin/bash
TODO_FILE=$HOME/.config/rofi/data/todos

if [[ ! -a "${TODO_FILE}" ]]; then
	touch "${TODO_FILE}"
fi

echo -en "\0markup-rows\x1ftrue\n"


function add_todo() {
	echo -e "`date +"%B %d %H:%M"` $*" >> "${TODO_FILE}"
}

function remove_todo() {
	if [[ ! -z "$DONE_FILE" ]]; then
		echo "${*}" >> "${DONE_FILE}"
	fi
	sed -i "/^${*}$/d" "${TODO_FILE}"
}

function get_todos() {
	if [ -s $TODO_FILE ]; then
		echo -en "\0message\x1f"
	else
		echo -en "\0message\x1fNo active reminders"
	fi

	echo -en "\0display\x1f"

	IFS=''
	while read line; do
		echo "$line"
	done < $TODO_FILE
}

if [[ $ROFI_RETV == "1" ]]; then
	item=${@}
	content=$(head -n 1 $item)

	echo $item > $HOME/.config/rofi/content.txt

	item_exists=$(grep "^${item}$" "${TODO_FILE}")

	if [[ -n "${item_exists}" ]]; then
		remove_todo ${item}
	fi

elif [[ $ROFI_RETV == "2" ]]; then
	new_item=${@}
	add_todo ${new_item}
fi

get_todos
exit 0

