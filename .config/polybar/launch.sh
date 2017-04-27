# Basic script to kill all old bars and launch new.

# Terminate already running bad instances
killall -q polybar

# Wait until the processes have been shut down
while grep -x polybar >/dev/null; do sleep 1; done

# Launch the top bar
MONITOR=HDMI1 polybar top &
MONITOR=DP2 polybar top &
MONITOR=eDP1 polybar top &

# Launch the bottom bar
MONITOR=HDMI1 polybar bottom &
MONITOR=DP2 polybar bottom &
MONITOR=eDP1 polybar bottom &
