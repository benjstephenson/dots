#!/bin/zsh

BRIGHTNESS_FILE=/sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
CURRENT_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
INTERVAL=26

function getPercentage {
	curr=$1
	printf "%d" $((($curr.0 / $MAX_BRIGHTNESS.0) * 100))
}

function update {
	newValue=$1
	percentage=$(getPercentage $newValue)
	echo $newValue > $BRIGHTNESS_FILE
	printf "%d	%d\n" "$newValue"	"$percentage"
}

case $1 in

	get)
		pec=$(getPercentage $CURRENT_BRIGHTNESS)
		printf "%d	%d\n" $CURRENT_BRIGHTNESS	$pec
	;;

	inc)
		if [[ $CURRENT_BRIGHTNESS -eq $MAX_BRIGHTNESS || $CURRENT_BRIGHTNESS -gt $((MAX_BRIGHTNESS - INTERVAL)) ]]; then
			echo "Brightness at max"
			exit 0
		fi
		update $((CURRENT_BRIGHTNESS + INTERVAL))
		exit 0
	;;

	dec)
		if [[ $CURRENT_BRIGHTNESS -eq $INTERVAL ]]; then
			echo "Brightness at min"
			exit 0
		fi

		update $((CURRENT_BRIGHTNESS - INTERVAL))
		exit 0
		;;

esac

