# colorful output
alias ls='ls --color'
alias la='ls -la --color'
alias ll='ls -ll --color'
alias llh='ls -llh --color'
alias lah='ls -lah --color'
alias grep='grep --color=auto -i'
# create parent directories if nonexistent
alias mkdir='mkdir -p'
# allow substituting sudo in aliases
alias sudo='sudo '

# application shortcuts
# for sway, decreases load time
#alias v='vim -X'
alias v='vim'
alias e='evince'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# git
alias gs='git status'
alias gc='git commit'
alias gm='git commit -m'
alias ga='git add'
alias gl='git log'

# config files
alias zshrc='vim ~/.zshrc && source ~/.zshrc'
alias aliases='vim ~/.zsh/aliases.zsh && source ~/.zshrc'
alias i3='vim ~/.i3/config'
alias i3blocks='vim ~/.i3/i3blocks.conf'

# log viewing
alias syslog='view /var/log/syslog'
alias log='journalctl -xefu'
# prints the whole file and follows
alias f='tail +1f'

# package manager
alias apt='sudo apt'
alias aptin='sudo apt install'
alias update='sudo apt update && sudo apt upgrade'

# systemctl
alias sc='systemctl'
alias systemctl='sudo systemctl'
alias scs='\systemctl status' # doesn't need root
alias scr='systemctl restart'
alias scu='systemctl start' # up
alias scd='systemctl stop' # down

# repair typos
alias 1ake=make
alias maek=make

# shorten pipe commands
alias -g G="| grep"
alias -g L="| less"
alias -g H="| head"
alias -g T="| tail"
# run tasks in background
alias -g bg="&>/dev/null"

alias ff='firefox'
alias py='python3'

# 256 colorsupport for tmux
#alias tmux='tmux -2'
alias tma='tmux attach'

alias loadnvm='export NVM_DIR="$HOME/.nvm"; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'

c(){
	local file=$1
	gcc -g -std=c11 -pedantic -Wall -Wextra "$file" -o "${file%.*}"
}


c++(){
	local file=$1
	g++ -g -std=c++17 -Wall -Wextra "$file" -o "${file%.*}"
}

jav(){
	local file=$1
	javac $1
	java ${file%.*}
}

baressh(){
	# prevent opening tmux in the remote session
	ssh $@ -t NO_TMUX=1 /bin/zsh
}

