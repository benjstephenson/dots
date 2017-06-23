#!/bin/bash

python2 $LOCAL_BIN/bing-desktop-wallpaper-changer-master/main.py
feh --bg-scale "/home/bste/Pictures/BingWallpapers/$(date +%Y%m%d).jpg"
