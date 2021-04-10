# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# cached completion
zstyle ':completion::complete:*' use-cache 1

zstyle ':completion:*' verbose yes
# shows what is completioned
#zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format '%F{red}No matches found%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _expand _complete _approximate _ignored

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# don't prompt for a huge list, page it
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# don't prompt for a huge list, menu it
zstyle ':completion:*:default' menu 'select=0'

# have zsh use the same colorscheme
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  
# blue option completion
zstyle ':completion:*:options' list-colors '=(-- *)=0;34'

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

# Separate man page sections
zstyle ':completion:*:manuals' separate-sections true

# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions

# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'

# Errors format
#zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

zstyle ':completion::approximate*:*' prefix-needed false

# use shift-tab to navigate backwards through completion lists
bindkey '^[[Z' reverse-menu-complete
