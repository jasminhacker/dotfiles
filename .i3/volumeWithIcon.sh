#!/bin/bash
percent=$(/usr/share/i3blocks/volume 5 pulse | cut -d'%' -f 1)

if (($percent=="MUTE")); then
	echo " 0%";
	exit 0;
fi
if (( "$percent" >= 60 )); then
	icon="";
elif (( "$percent" > 0 )); then
	icon="";
else
	icon="";
fi
echo $icon" "$percent"%"

# 
# 
# 

#🔈
#🔉
#🔊
