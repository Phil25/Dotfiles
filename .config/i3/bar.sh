#!/bin/bash

function sep(){
	printf " | "
}

while [ true ]; do

	# master volume
	printf "`amixer get Master | grep % | cut -d " " -f 6 | cut -d "]" -f 1`%"

	sep # wifi
	printf "`ip -br address | grep wlp | tr -s " " | cut -d " " -f 3 | cut -d "/" -f 1`"

	sep # battery
	printf "`acpi | cut -d "," -f 1 | cut -d " " -f 3 | grep -Eo ^[A-Z][a-z]`"
	printf " `acpi | cut -d "," -f 2 | cut -d " " -f 2`%"

	sep # time - date
	printf "`date +'%H:%M:%S - %a, %d %b %Y'`"

	printf "\n"
	sleep 1

done
