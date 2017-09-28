#!/bin/bash

echo ""
printf "Update mode [in/out]: "
read -r MODE

if [ $MODE == "out" -o $MODE == "o" ]; then
	cp .{bash_profile,vimrc} ~
	cp -r ./.config ~
	echo "Dotfiles exported to computer."
else
	cp ~/.{bash_profile,vimrc} .
	cp -r ~/.config/{gtk-2.0,gtk-3.0,xfce4,i3} ./.config/
	echo "Dotfiles imported to `pwd`."
fi

echo ""
