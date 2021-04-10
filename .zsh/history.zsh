HISTFILE=~/.config/histfile

# store more history
SAVEHIST=10000
HISTSIZE=10000

# append instead of overwriting
setopt APPEND_HISTORY

# write after each command
setopt INC_APPEND_HISTORY

# share history between multiple shells
setopt SHARE_HISTORY

# groups successive commands into one
setopt HIST_IGNORE_DUPS

# groups identical commands into one (regardless of other commands in between)
setopt HIST_IGNORE_ALL_DUPS

# merge whitespace
setopt HIST_REDUCE_BLANKS

# don't save commands starting with a space
setopt HIST_IGNORE_SPACE

# remove duplicates if the histfile grows too large
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

# don't find duplicates when cycling through history
setopt HIST_FIND_NO_DUPS
