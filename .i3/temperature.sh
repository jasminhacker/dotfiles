#!/bin/bash
value=$(/usr/share/i3blocks/temperature | head -n 1 | sed 's/\..*//g')

if (( "$value" >= 90 )); then
	temperature=" $value°C";
	color="#cc241d"
elif (( "$value" >= 70 )); then
	temperature=" $value°C";
	color="#fabd2f"
elif (( "$value" >= 60 )); then
	temperature=" $value°C";
	#color="#8ec07c"
else
	temperature=" $value°C";
	#color="#8ec07c"
fi

echo "$temperature"
echo "$temperature"
echo "$color"
