#!/bin/bash

COL_LEN=26
SEL=0
LAST_LEN=$COL_LEN

# list files in dual columns with indexes
cd ./files/
for file in *; do
	SEL=$((SEL+1));
	BASENAME=`basename $file`
	OUT=`printf "%$((COL_LEN-LAST_LEN))s$SEL) $BASENAME"`
	printf "$OUT"
	LAST_LEN=`echo "$OUT" | wc -c`
	if [ $(($SEL%2)) -eq 0 ]; then
		echo ""
		LAST_LEN=$COL_LEN
	fi
done

# exit if no files were listed
if [ $SEL -eq 0 ];then
	echo "No files found."
	exit
fi

echo ""
echo ""
#-e for autocompletion of INPUT
read -e -p "Edit: " INPUT

#open if INPUT relates to file
if [ -f "$INPUT" ]; then
	vim "$INPUT"
	exit
fi

#check if INPUT is a number
NUM_CHECK='^[0-9]+$'
if ! [[ $INPUT =~ $NUM_CHECK ]]; then
	echo "No file found."
	exit
fi

#check if INPUT is in correct range of numbers
if [[ $INPUT -lt 1 || $INPUT -gt $SEL ]];then
	echo "Provide a number from 1 to $SEL."
	exit
fi

#open file of index INPUT
FILES=(*);
vim "${FILES[INPUT-1]}"
