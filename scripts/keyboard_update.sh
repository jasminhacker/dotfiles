#! /bin/sh
# activate with
# inputplug -c ./on-new-kbd.sh

#echo >&2 "$@"
event=$1 id=$2 type=$3

case "$event $type" in
'XIDeviceEnabled XISlaveKeyboard')
	# decrease repeat delay and increase repeat rate
	xset r rate 250 50
	# swap left alt with left super. then mod is close to the spacebar, but you can still use alt
	setxkbmap de,de -variant neo, -option altwin:swap_lalt_lwin,grp:ctrls_toggle
esac
