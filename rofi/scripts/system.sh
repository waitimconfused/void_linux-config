#!/bin/bash
TODO_FILE=$HOME/.config/rofi/data/todos

if [[ ! -e "${TODO_FILE}" ]]; then
  touch "${TODO_FILE}"
fi

echo -en "\0markup-rows\x1ftrue\n"

function render() {
  echo "Suspend"
  echo "Hibernate"
  echo "Shutdown"
  echo "Reboot"
}

function trigger() {
  case ${@} in
  "Suspend")
    loginctl suspend
    ;;
  "Hibernate")
    loginctl hibernate
    ;;
  "Shutdown")
    loginctl poweroff
    ;;
  "Reboot")
    loginctl reboot
    ;;
  *)
    echo -e "\0message\x1fUnhandled \${@} value of \"${@}\""
    ;;

  esac

}

case $ROFI_RETV in
0) ;;
1)
  trigger ${@}
  ;;
*)
  echo -e "\0message\x1fUnhandled \$ROFI_RETV value of \"$ROFI_RETV\"&#x0a;\$ROFI_DATA=\"$ROFI_DATA\"&#x0a;\$ROFI_INPUT=\"$ROFI_INPUT\"&#x0a;\${@}=\"${@}\""
  echo -e "ROFI_DATA=$ROFI_DATA"
  echo -e "ROFI_INPUT=$ROFI_INPUT"
  echo -e "@ = ${@}"
  ;;
esac

render
exit 0
