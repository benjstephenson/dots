# Disable KWin and use i3gaps as WM
export KDEWM=/usr/bin/i3
#export KDEWM=/usr/bin/sway

# Compositor (Animations, Shadows, Transparency)
# xcompmgr -C
compton -cCFb --backend glx --vsync opengl
