# Load fzf keybinding and completions
[[ ! -f /usr/share/fzf/key-bindings.zsh ]] || source /usr/share/fzf/key-bindings.zsh
[[ ! -f /usr/share/fzf/completion.zsh ]] || source /usr/share/fzf/completion.zsh

# fzf - Regex search
export FZF_DEFAULT_OPS="--extended"
# fzf - use fd as underlying command
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height=90% --layout=reverse --preview-window ",,border-sharp"'
