#!/bin/bash

LAYOUT=`setxkbmap -query | grep layout | tr -s " " | cut -d " " -f 2`

if [ $LAYOUT == "pl" ]; then
	LAYOUT=us
else
	LAYOUT=pl
fi

setxkbmap $LAYOUT
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
