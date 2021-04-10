#!/bin/bash
percent=`/usr/share/i3blocks/battery`

IFS=' ' read -ra tokens <<< "$percent"

val=`echo "${tokens[0]}" | sed s/%//`

green=""
yellow="#fabd2f"
red="#cc421d"
if [[ "${tokens[1]}" == "DIS" ]]; then
	if [[ "$val" -gt 99 ]]; then
		icon="██▏"
		color=$green
	elif [[ "$val" -gt 93 ]]; then
		icon="█▉▏"
		color=$green
	elif [[ "$val" -gt 87 ]]; then
		icon="█▊▏"
		color=$green
	elif [[ "$val" -gt 81 ]]; then
		icon="█▋▏"
		color=$green
	elif [[ "$val" -gt 75 ]]; then
		icon="█▌▏"
		color=$green
	elif [[ "$val" -gt 68 ]]; then
		icon="█▍▏"
		color=$green
	elif [[ "$val" -gt 62 ]]; then
		icon="█▎▏"
		color=$green
	elif [[ "$val" -gt 56 ]]; then
		icon="█▏▏"
		color=$green
	elif [[ "$val" -gt 50 ]]; then
		icon="█ ▏"
		color=$green
	elif [[ "$val" -gt 43 ]]; then
		icon="▉ ▏"
		color=$yellow
	elif [[ "$val" -gt 37 ]]; then
		icon="▊ ▏"
		color=$yellow
	elif [[ "$val" -gt 31 ]]; then
		icon="▋ ▏"
		color=$yellow
	elif [[ "$val" -gt 25 ]]; then
		icon="▌ ▏"
		color=$yellow
	elif [[ "$val" -gt 18 ]]; then
		icon="▍ ▏"
		color=$red
	elif [[ "$val" -gt 12 ]]; then
		icon="▎ ▏"
		color=$red
	elif [[ "$val" -gt 06 ]]; then
		icon="▏ ▏"
		color=$red
	else
		icon="  ▏"
		color=$red
	fi
	output="$icon-${tokens[0]}${tokens[2]}"
else
	output=" +${tokens[0]}${tokens[2]}"
	color=$green
fi
echo $output
echo $output
echo $color
# 🔌
# 🔋
# 
#
#
#
#
