#!/bin/bash

################################################################################
# Presentation window; file named presentation.pdf
################################################################################
eval $(xdotool getmouselocation --shell)
wid=$(xdotool search "presentation.pdf")
# https://askubuntu.com/questions/9162/is-there-an-x-app-which-can-position-the-mouse-relative-to-a-window-not-the-scr
# https://stackoverflow.com/questions/8480073/how-would-i-get-the-current-mouse-coordinates-in-bash
xdotool mousemove --window $wid 0 0 mousedown 3 mouseup 3
xdotool mousemove $X $Y

################################################################################
# Notes window; opened with Okular
################################################################################
xdotool search "Μέθοδοι"  windowactivate --sync key --clearmodifiers keydown Left keyup Left
