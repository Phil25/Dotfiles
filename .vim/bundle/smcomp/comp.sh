#!/bin/bash

if [ $# -lt 1 ]; then
	echo No file specified.
	exit
fi

_param=$1
_path=`dirname $_param`

if [ $# -gt 1 ]; then
	if [ $2=="c" -o $2=="custom" ]; then
		_csource=`head -1 $1 | cut -d "$" -f 2`
		echo Custom source selected: \"$_csource\"
		_param="$_path/$_csource"
	fi
fi

_file=`basename $_param`
_path=`dirname $_param`
_bin=${_file%.*}.smx

cd $_path

./spcomp "`pwd`/$_file"
if ! [ -f $_bin ]; then
	cd -
	exit
fi
mv $_bin ../plugins/

cd -
