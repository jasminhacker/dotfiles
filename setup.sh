#!/bin/bash

if command -v xset &> /dev/null && xset q &> /dev/null; then
	X=1
fi

# install dependencies
sudo apt install -y git htop openvpn tmux vim xclip zsh
git clone https://github.com/jonathanhacker/dotfiles .dotfiles
if [ -n "$X" ]; then
	git clone https://github.com/jonathanhacker/themes
	mv themes/.themes .dotfiles/
	mv themes/.icons .dotfiles/
	rm -rf themes
	sudo apt install -y autorandr feh fonts-cantarell fonts-font-awesome i3 i3blocks i3lock inputplug light lm-sensors scrot vim-gtk xcompmgr
fi

# chsh would ask for password again -> use sudo
sudo chsh -s /bin/zsh $USER

# create symlinks
ln -fs ~/.dotfiles/.ackrc ~/
ln -fs ~/.dotfiles/.gitconfig ~/
ln -fs ~/.dotfiles/.gitignore ~/
ln -fs ~/.dotfiles/.tmux.conf ~/
ln -fs ~/.dotfiles/.vim ~/
ln -fs ~/.dotfiles/.vimrc ~/
ln -fs ~/.dotfiles/.zsh ~/
ln -fs ~/.dotfiles/.zshrc ~/
ln -fs ~/.dotfiles/gitignore ~/.gitignore

# vim undo directory
mkdir -p ~/.undodir

# install vim plugins.
# send enter to confirm the initially missing gruvbox files
echo | vim +PlugInstall +qall

if [[ "$(hostname)" == *"berry"* ]]; then
	# raspberry pi
	sudo timedatectl set-timezone Europe/Berlin
	sudo sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
	sudo sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen
	sudo dpkg-reconfigure --frontend=noninteractive locales
	sudo update-locale LANG=en_GB.UTF-8
	color="green"
elif [[ "$(hostname)" == *"s"*"rv"* ]]; then
	# server
	color="magenta"
else
	if [ -n "$X" ]; then
		# main
		color="cyan"
	else
		# other
		color="yellow"
	fi
fi

sed -i -r -e "s/(^\s*local promptcolor=).*/\1\"%F{$color}\"/" ~/.zsh/prompt.zsh

if [ -n "$X" ]; then
	ln -fs ~/.vimrc ~/.ideavimrc
	ln -fs ~/.dotfiles/.i3 ~/
	ln -fs ~/.dotfiles/.icons ~/
	ln -fs ~/.dotfiles/.themes ~/

	# themes generated like this:
	#wget -O /tmp/oomox.deb https://github.com/themix-project/oomox/releases/download/1.13.3/oomox_1.13.3_18.10+.deb
	#sudo apt -y install /tmp/oomox.deb
	#oomox-cli ~/.dotfiles/gruvbox.oomox --hidpi False --make-opts gtk320 --output gruvbox
	#oomox-archdroid-icons-cli ~/.dotfiles/gruvbox.oomox -o gruvbox

	# set gtk and icon theme
	gsettings set org.gnome.desktop.interface gtk-theme gruvbox
	gsettings set org.gnome.desktop.interface icon-theme gruvbox

	# set terminal font
	gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 13'

	profile="$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep ^: | sed 's/\///g' | sed 's/://g' | grep -m 1 .)"

	# https://askubuntu.com/questions/270469/how-can-i-create-a-new-profile-for-gnome-terminal-via-command-line
	if [ -z "$profile" ]; then
		dconfdir="/org/gnome/terminal/legacy/profiles:"
		profile_ids=($(dconf list $dconfdir/ | grep ^: | sed 's/\///g' | sed 's/://g'))
		profile_name="gruvbox"
		profile_ids_old="$(dconf read "$dconfdir"/list | tr -d "]")"
		profile_id="$(uuidgen)"

		[ -z "$profile_ids_old" ] && profile_ids_old="["  # if there's no `list` key
		[ ${#profile_ids[@]} -gt 0 ] && delimiter=,  # if the list is empty
		dconf write $dconfdir/list "${profile_ids_old}${delimiter} '$profile_id']"
		dconf write "$dconfdir/:$profile_id"/visible-name "'$profile_name'"

		profile="$profile_id"
		dconf write $dconfdir/default "'$profile'"
	fi
	dconf write /org/gnome/terminal/legacy/default-show-menubar "false"
	dconf write /org/gnome/terminal/legacy/menu-accelerator-enabled "false"
	dconf write /org/gnome/terminal/legacy/profiles:/:$profile/scrollbar-policy "'never'"
	# globally set terminal colors to gruvbox's theme.
	# this allows us to use the normal 8 colors everywhere terminal-related
	# swap gruvboxes colors so the first row contains the brighter colors.
	# also move white into the first row, swapping it with gray
	dconf write /org/gnome/terminal/legacy/profiles:/:$profile/palette "['#282828', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#ebdbb2', '#928374', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286', '#689d6a', '#928374']"
	# original order
	#dconf write /org/gnome/terminal/legacy/profiles:/$profile/palette "['#282828', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286', '#689d6a', '#a89984', '#928374', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#ebdbb2']"

	# configure autorandr
	# https://github.com/phillipberndt/autorandr
	echo
	echo "Done! Store your display setups:"
	echo -e "\tautorandr --save mobile"
	echo -e "\tautorandr --save docked"
fi
