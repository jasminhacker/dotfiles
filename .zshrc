# https://web.archive.org/web/20170512092443/https://stackoverflow.com/questions/171563/whats-in-your-zshrc

# use gruvbox scheme in the shell
source "$HOME/.dotfiles/gruvbox_256palette.sh"

# in ssh sessions, automatically enter a tmux session
# attach to the existing one if present
# prevent this behavior by setting NO_TMUX
# https://unix.stackexchange.com/a/113768
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$NO_TMUX" ]; then
		exec tmux new-session -A -s main
	fi
fi

# allows to profile load times with zprof
#zmodload zsh/zprof

autoload -U compinit promptinit
compinit
promptinit

source ~/.zsh/options.zsh

source ~/.zsh/aliases.zsh

source ~/.zsh/history.zsh

# vim mode
bindkey -v
# Yank to the system clipboard
function vi-yank-xclip {
	zle vi-yank
	echo "$CUTBUFFER" | xclip -selection clipboard -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# grey forward suggestion
# https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions.zsh
# improve performance by not rebinding each precmd
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

source ~/.zsh/prompt.zsh

# uses color definitions from the theme, thus source after prompt.zsh
source ~/.zsh/completion.zsh

# syntax highlighting in the command line
source ~/.zsh/zsh-syntax-highlighting.zsh

# zsh history substring search plugin
# has to be sourced after syntax highlighting
source ~/.zsh/zsh-history-substring-search.zsh
# bind up and down arrow for history search functionality
bindkey 'OA' history-substring-search-up
bindkey 'OB' history-substring-search-down

# apt-get recommendations
[ -f /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found

# enable reverse search
bindkey '^R' history-incremental-search-backward
bindkey '^T' history-incremental-search-forward

#disable control s (freezes terminal)
stty -ixon

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/Documents/bin"

# hack to make Home/End keys work in tmux
# for some reason, tmux changes the escape sequences it sends when receiving Home/End
# this has probably to do with the (invalid) changing of the TERM variable
# this fixes these new escapes to also perform the same actions
# other applications seem to work fine, only zsh needs special treatment
bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line

# make intellij work on sway
#export _JAVA_AWT_WM_NONREPARENTING=1
