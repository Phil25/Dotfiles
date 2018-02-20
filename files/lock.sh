#!/bin/bash

# Custom lockscreen script using i3lock-color.
# Created based on betterlockscreen by Pavan Jadhaw.
# https://github.com/pavanjadhaw/betterlockscreen

screenFile="$HOME/.cache/i3lock/screen.png"
letterEnteredColor=0a81f5ff
letterRemovedColor=d23c3dff
passwordCorrect=00b159ff
passwordIncorrect=d23c3dff
background=00000000
foreground=ffffffff

# Script to run if you loose rectange coords,
# since these things make no damn sense at all!
#rectangles=" "
#SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
#for RES in $SR; do
#	SRA=(${RES//[x+]/ })
#	CX=$((${SRA[2]} + 25))
#	CY=$((${SRA[1]} - 30))
#	rectangles+="rectangle $CX,$CY $((CS+300)),$((CY-80)) "
#done 
#echo $rectangles

scrot "$screenFile" &&
convert "$screenFile" \
	-blur 0x12 \
	-draw "fill black fill-opacity 0.6 rectangle 25,738 300,658" \
	"$screenFile" &&

i3lock \
	-t -i "$screenFile" \
	--timepos="x+110:h-70" \
	--datepos="tx:ty+25" \
	--clock \
	--datestr "%B %d, %A" \
	--indicator \
	--insidecolor=$background \
	--ringcolor=$foreground \
	--line-uses-inside \
	--keyhlcolor=$letterEnteredColor \
	--bshlcolor=$letterRemovedColor \
	--separatorcolor=$background \
	--insidevercolor=$passwordCorrect \
	--insidewrongcolor=$passwordIncorrect \
	--ringvercolor=$foreground \
	--ringwrongcolor=$foreground \
	--indpos="x+240:h-70" \
	--radius=20 \
	--ring-width=5 \
	--veriftext="" \
	--wrongtext="" \
	--timecolor=$foreground \
	--datecolor=$foreground \
	--force-clock
