# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d ~/.cache/zcompdump
_comp_options+=(globdots)		# Include hidden files.
