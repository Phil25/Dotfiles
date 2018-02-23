#!/bin/bash

C_FILE='\033[0;34m'
NC='\033[0m' # No Color

if [ $# -ne 2 ]; then
	echo "Usage: ./.add.sh <name> <file path>"
	exit
fi

if ! [ -f "$2" ]; then
	echo "File '$2' not found."
	exit
fi

if [ -L "$2" ]; then
	echo "File '$2' is a symlink."
	exit
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -f "$SCRIPT_DIR"/files/"$1" ]; then
	echo "Name '$1' is already registered."
	exit
fi

echo "$1 $2" >> "$SCRIPT_DIR"/manifest
echo -e Moving ${C_FILE}$2${NC} to repo...
mv "$2" "$SCRIPT_DIR"/files/"$1"
echo -e Symlinking ${C_FILE}$2${NC} -\> ${C_FILE}$1${NC}...
ln -s "$SCRIPT_DIR"/files/"$1" "$2"
echo "Added file '$2.'"
