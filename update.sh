#!/bin/bash

echo ""
printf "Update mode [in/out]: "
read -r MODE

if [ $MODE == "out" -o $MODE == "o" ]; then
	cp .{bash_profile,vimrc,xinitrc} ~
	cp -r ./.config ~
	cp -r ./.vim ~
	echo "Dotfiles exported to computer."
else
	cp ~/.{bash_profile,vimrc,xinitrc} .
	cp -r ~/.config/{gtk-2.0,gtk-3.0,xfce4,autostart} ./.config/
	cp -r ~/.vim/bundle/smcomp ./.vim/bundle/smcomp/
	echo "Dotfiles imported to `pwd`."
fi

echo ""
