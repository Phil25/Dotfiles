#!/bin/bash

# This script does the following:
# 	- Compile .sp given as first parameter (absoulte path)
#	- If successful, move .smx to ../plugins/
#	- If second parameter is "c" or "custom":
#		- Extract source to compile from the first parameter file
#			- Information on external source must be on the first line
#			- format: //$file.sp$ (relative paths work)
#		- Compile and move if successful
#
# Source to compile must have spcomp in its directory!

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

./spcomp "$_file"
if [ -f $_bin ]; then
	mv $_bin ../plugins/
fi

cd -
