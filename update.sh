#!/bin/bash

# The following mess is an authorship of Phil;
# good luck figuring out what's going on!

C_IMG='\033[0;36m'
C_NUM='\033[0;31m'
C_PATH='\033[0;36m'
C_EMP='\033[0;35m'
C_FILE='\033[0;34m'
NC='\033[0m' # No Color

ID=1
MAX=`cat manifest | wc -l`

SKIPPED=0
UPDATED=0

while read entry; do
	_NAME=`echo $entry | cut -f1 -d " "`;
	_PATH=`echo $entry | cut -f2 -d " "`;
	_NAME=`pwd`/files/$_NAME
	_PATH=${_PATH/\~/$HOME}

	echo ""
	echo -e \($ID/$MAX\) ${C_FILE}$_PATH${NC} -\> ${C_FILE}$_NAME${NC}
	ID=$((ID+1))

	SITUATION=0
	if [ -f "$_PATH" ]; then
		if [ -f "$_NAME" ]; then
			SITUATION=3
		else
			SITUATION=2
		fi
	else
		if [ -f "$_NAME" ]; then
			SITUATION=1
		else
			SITUATION=0
		fi
	fi

	if [ $SITUATION -eq 0 ]; then
		# no files exist
		echo Neither of the files exist.

	elif [ $SITUATION -eq 1 ]; then
		# repo only exist
		echo -e Symlinking ${C_FILE}$_PATH${NC} -\> ${C_FILE}$_NAME${NC}...
		ln -s "$_NAME" "$_PATH"
		UPDATED=$((UPDATED+1))

	elif [ $SITUATION -eq 2 ]; then
		# non-repo only exist
		echo -e Moving ${C_FILE}$_PATH${NC} to repo...
		mv "$_PATH" "$_NAME"
		echo -e Symlinking ${C_FILE}$_PATH${NC} -\> ${C_FILE}$_NAME${NC}...
		ln -s "$_NAME" "$_PATH"
		UPDATED=$((UPDATED+1))

	else
		# both files exist
		if [ -L "$_PATH" ]; then
			# non-repo is already a symlink
			if [ `readlink "$_PATH"` == "$_NAME" ]; then
				echo -e "${C_FILE}$_PATH${NC} is a symlink to the same file, skipping..."
				SKIPPED=$((SKIPPED+1))
			else
				echo -e "${C_FILE}$_PATH${NC} is a symlink to ${C_PATH}`readlink "$_PATH"`${NC}. Replace with ${C_FILE}$_NAME${NC}? [y/N]"
				printf "Selecting: "
				read -u 3 OPTION
				OPTION="${OPTION,,}"
				if [ $OPTION ]; then
					if [ $OPTION = "yes" ] || [ $OPTION = "y" ]; then
						echo -e Backing up ${C_FILE}$_PATH${NC}...
						rm -f "$_PATH.backup"
						mv "$_PATH" "$_PATH.backup"
						echo -e Symlinking ${C_FILE}$_PATH${NC} -\> ${C_FILE}$_NAME${NC}...
						ln -s "$_NAME" "$_PATH"
						UPDATED=$((UPDATED+1))
					else
						echo Skipping...
						SKIPPED=$((SKIPPED+1))
					fi
				else
					echo Skipping...
						SKIPPED=$((SKIPPED+1))
				fi
			fi
		else
			# non-repo is not a symlink
			echo -e "Both files exist. Wat do? [${C_NUM}1${NC}/${C_NUM}2${NC}/${C_NUM}3${NC}]"
			echo -e "${C_NUM}1${NC}) Override ${C_EMP}non-repo file${NC}   ${C_IMG}<-(repo)${NC}"
			echo -e "${C_NUM}2${NC}) Override ${C_EMP}repo file${NC}       ${C_IMG}->(repo)${NC}"
			echo -e "${C_NUM}3${NC}) Skip (default)"
			printf "Selecting: "
			read -u 3 OPTION

			if [ ! $OPTION ]; then
				echo Skipping...
				SKIPPED=$((SKIPPED+1))
				continue
			fi

			if [ $OPTION -eq 1 ]; then
				# overriding non-repo
				echo -e Backing up ${C_FILE}$_PATH${NC}...
				rm -f "$_PATH.backup"
				mv "$_PATH" "$_PATH.backup"
				echo -e Symlinking ${C_FILE}$_PATH${NC} -\> ${C_FILE}$_NAME${NC}...
				ln -s "$_NAME" "$_PATH"
				UPDATED=$((UPDATED+1))
				
			elif [ $OPTION -eq 2 ]; then
				# overiding repo
				echo -e Backing up ${C_FILE}$_NAME${NC}...
				rm -f "$_NAME.backup"
				mv "$_NAME" "$_NAME.backup"
				echo -e Moving ${C_FILE}$_PATH${NC} to repo...
				mv "$_PATH" "$_NAME"
				echo -e Symlinking ${C_FILE}$_PATH${NC} -\> ${C_FILE}$_NAME${NC}...
				ln -s "$_NAME" "$_PATH"
				UPDATED=$((UPDATED+1))

			else
				echo -e "${C_NUM}3${NC}"
				echo -e Skipping
				SKIPPED=$((SKIPPED+1))

			fi
		fi
	fi
done 3<&0 <manifest

echo ""
echo -e "${C_NUM}$UPDATED${NC} file(s) updated, ${C_NUM}$SKIPPED${NC} file(s) skipped."
