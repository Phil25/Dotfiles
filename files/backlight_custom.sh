#!/bin/bash

LOC=/sys/class/backlight/acpi_video0/
CUR=`cat $LOC/brightness`.0
MAX=`cat $LOC/max_brightness`.0
echo $(awk "BEGIN { pc=100*${CUR}/${MAX}; i=int(pc); print (pc-i<0.5)?i:i+1 }")%
