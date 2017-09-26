#!/bin/bash
# laptop/i3 Version

echo ""
printf "Update mode [in/out]: "
read -r MODE

if [ $MODE == "out" -o $MODE == "o" ]; then
	cp .{bash_profile,vimrc,xinitrc} ~
	cp -r ./.config ~
	echo "Dotfiles exported to computer."
else
	cp ~/.{bash_profile,vimrc,xinitrc} .
	cp -r ~/.config/{bumblebee-status,i3,rofi} ./.config/
	echo "Dotfiles imported to `pwd`."
fi

echo ""
