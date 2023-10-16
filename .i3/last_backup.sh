#!/bin/sh

mod=$(date -r ~/.i3/last_backup +%s)
now=$(date +%s)          
days=$(expr \( $now - $mod \) / 86400)
if [ "$days" -eq 1 ]; then
	echo "$days day"
else
	echo "$days days"
fi

if [ "$days" -ge 7 ]; then
	echo "#cc241d"
elif [ "$days" -ge 14 ]; then
	echo "#fabd2f" 
fi

