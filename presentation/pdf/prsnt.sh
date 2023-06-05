#!/bin/bash

# $1 should be 1     for Down, 3    for up
# $2 should be Right for Down, Left for up
# i.e. "./prsnt.sh 1 Right" goes one slide forward and
#      "./prsnt.sh 3 Left"  goes one slide backward
#
# The presentation should be opened with Adobe PDF reader and its filename
# should be "presentation.pdf".
# The notes' file should be opened with Okular

################################################################################
# Presentation window; file named presentation.pdf
################################################################################
eval $(xdotool getmouselocation --shell)
wid=$(xdotool search "pdf - Adobe")
# https://askubuntu.com/questions/9162/is-there-an-x-app-which-can-position-the-mouse-relative-to-a-window-not-the-scr
# https://stackoverflow.com/questions/8480073/how-would-i-get-the-current-mouse-coordinates-in-bash
xdotool mousemove --window $wid 10 10 mousedown $1 mouseup $1
xdotool mousemove $X $Y

################################################################################
# Notes window; opened with Okular
################################################################################
xdotool search "Μέθοδοι"  windowactivate --sync key --clearmodifiers keydown $2 keyup $2
