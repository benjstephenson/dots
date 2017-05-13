#!/bin/bash

#xrandr --output eDP1 --auto --output HDMI1 --auto --panning 2176x1741+2560+0 --scale 1.7x1.7 --right-of eDP1
#xrandr --output eDP1 --auto --output HDMI1 --auto --panning  3264x1836+2560+0 --scale 1.7x1.7 --right-of eDP1

#An example of the panning syntax for a 4k laptop with an external 1920x1080 monitor to the right:
xrandr --output eDP1 --auto --output HDMI1 --auto --panning 3840x2160+3840+0 --scale 2x2 --right-of eDP1
