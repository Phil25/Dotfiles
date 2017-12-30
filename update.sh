#!/bin/bash
# laptop/i3 Version

echo ""
printf "Update mode [in/out]: "
read -r MODE

if [ $MODE == "out" -o $MODE == "o" ]; then
	cp .{bashrc,bash_profile,Xresources,vimrc,xinitrc} ~
	cp -r ./.config ~
	echo "Dotfiles exported to computer."
else
	cp ~/.{bashrc,bash_profile,Xresources,vimrc,xinitrc} .
	cp -r ~/.config/{bumblebee-status,i3,rofi,xfce4,ranger} ./.config/
	echo "Dotfiles imported to `pwd`."
fi

echo ""
