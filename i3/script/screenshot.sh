path="$HOME/Pictures/Screenshots/`date +%Y-%m-%d_%H:%M:%S`.png"

scrot --select --file "$path" -e 'xclip -selection clipboard -t image/png -i $f'

echo "Saved image to: $path"
echo "Copied image to xclip"

return_value=$(
	notify-send \
		"Screenshot Saved" \
		"Image saved to:$path\n(Copied to clipboard)" \
		--icon=$path \
		--action="open=Open" \
		--action="copy=Copy Path" \
		--action="delete=Remove"
)

echo "Notification button: $return_value"

case $return_value in
	"open")
		ristretto "$path" &
		echo "Opened image in Ristretto"
		;;
	"copy")
		echo $path | xclip -selection clipboard
		echo "Copied path to clipboard"
		;;
	"delete")
		rm "$path"
		echo "Removed image"
		;;
esac
