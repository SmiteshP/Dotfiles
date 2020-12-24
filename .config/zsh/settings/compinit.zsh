# Basic auto/tab complete:
autoload -Uz compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Case insensitive matching

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache

zmodload zsh/complist

compinit -d ~/.cache/zcompdump

_comp_options+=(globdots)		# Include hidden files.
