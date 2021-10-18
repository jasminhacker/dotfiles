# if reset prompt is executed while completion waits for disk io, zsh segfaults :(
# thus, we don't use TRAPALRM
#TMOUT=1
#TRAPALRM(){
#	zle reset-prompt
#}

# man zshmisc

# since we set the terminal's colors to be the gruvbox scheme,
# we can use the 16 colors and theme our prompt with them
local black='0'
local red='1'
local green='2'
local yellow='3'
local blue='4'
local purple='5'
local aqua='6'
local white='8'
# orange is the exception, as it is not part of the 16 colors.
# we use its extended 256 color.
# https://web.archive.org/web/20120905043337/http://lucentbeing.com/blog/that-256-color-thing
# https://gist.github.com/MicahElliott/719710
local orange='8;5;208'
# color + 30 = foreground
# color + 40 = background

# manually configure the colors for all file types
# then get default dircolors for file suffixes and substitute their colors with the style equivalent
export LS_COLORS=\
"bd=0;$yellow:"\
"ca=1;3$white:"\
"cd=0;3$yellow:"\
"di=1;3$blue:"\
"ex=1;3$green:"\
"fi=0;3$white:"\
"ln=0;3$aqua:"\
"mh=1;3$white:"\
"mi=1;3$red:"\
"or=1;3$red:"\
"ow=0;4$green;3$black:"\
"pi=0;3$yellow:"\
"sg=0;4$yellow;3$black:"\
"so=1;3$purple:"\
"st=0;4$blue;3$black:"\
"su=0;4$red;3$black:"\
"tw=0;4$green;3$black:"\
"$(dircolors -p | grep '^\.' | sed 's/^\./\*./' | sed \
	-e "s/ 01;31$/=0;3$blue:/" \
	-e "s/ 01;35$/=0;3$orange:/" \
	-e "s/ 00;36$/=0;3$aqua:/" \
	| tr -d '\n')"
# archive, image, audio

unset black
unset red
unset green
unset yellow
unset blue
unset purple
unset aqua
unset white
unset orange

# overwrite the time the prompt was created with the time the command is executed
preexec () {
	local date=`date +"%H:%M:%S"`
    local len_right=`echo $date | wc -c`
	# yellow date
	date="%F{yellow}$date%f"
    len_right=$(( $len_right + 1))
    local right_start=$(($COLUMNS - $len_right))

	# ansi escape codes: move up one line, then move right to the date position
    print -P "\033[1A\033[${right_start}C ${date}"
}

precmd() {
	# get working directory with '~'
	local dir=`print -P %~`
	# determine its length
	local dir_length=`echo $dir | wc -c`

	# subtract '> ' (time disappears on its own) and the trailing newline
	local width=$(($COLUMNS - 2 - 1))
	# allow the prompt to be half the length
	width=$(($width / 2))
	# check if the string is too long
	while [[ $dir_length -gt $width ]]; do
		# takes the first element in the path longer than one letter and shortens it
		local shortened=`echo $dir | sed -r 's:(/)([^/])([^/]+)(/)(.*):\1\2\4\5:g'`
		if [ "$shortened" = "$dir" ]; then
			# the shortening didn't change anything
			break
		fi
		dir=$shortened
		dir_length=${#${(S%%)dir//$~zero/}} 
	done

	if [[ $dir_length -gt $width ]]; then
		# if the path is still too long, shorten the beginning
		local substring_length=$(($width - 2 - 1))
		local cut_length=$(($dir_length - $substring_length))
		local substring=`echo $dir | cut -c${cut_length}-`
		dir='..'$substring
	fi

	# check if we are in a git directory. 
	local git="";
	git rev-parse --is-inside-work-tree > /dev/null 2>&1;
	if [ $? -eq 0 ]; then 
		# get the current branch
		#local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)";
		# check if the git is clean
		git diff --exit-code --quiet;
		if [ $? -eq 0 ]; then 
			git=" %F{green}%f";
		else 
			git=" %F{red}%f";
		fi;
	fi;

	# check for a python virtualenv
	local venv=""
	if [ -n "$VIRTUAL_ENV" ]; then
		venv=""
	fi

	# for a two line prompt, print the first line in precmd, don't put in in PROMPT (to avoid resizing issues)
	# using 'print' or 'print -rP' for prompt expansion

	local date=`date +"%H:%M:%S"`

	local promptcolor="%F{cyan}"

	# current working directory
	PROMPT="$promptcolor$dir>$venv$git%f "
	# return code if nonzero and time
	RPROMPT="%(?..%F{red}(%?%) %F)%F{yellow}$date%f"
}
