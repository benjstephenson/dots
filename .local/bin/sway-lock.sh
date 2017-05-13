#!/usr/bin/env bash

if [ -z "$XDG_RUNTIME_DIR" ] && [ -z "$SWAYSOCK" ]; then
  uid=$(iu -u $USER)
	export XDG_RUNTIME_DIR="/run/user/$uid/"
	export SWAYSOCK=$(find $XDG_RUNTIME_DIR -iname sway*sock)
fi

swaygrab /home/$USER/lockscreen.png
convert -blur 0x6 /home/$USER/lockscreen.png /home/$USER/lockscreen.png

swaylock -i /home/$USER/lockscreen.png
