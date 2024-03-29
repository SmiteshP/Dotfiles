# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Vim mode
bindkey -v

# Set language variable
export LANG=en_US.UTF-8

# Path to zsh config
ZSH="$HOME/.config/zsh"

# Source all settings
for f in $ZSH/settings/*.zsh; do
	source $f;
done

# To customize prompt, run `p10k configure` or edit $ZSH/settings/p10k.zsh
source $ZSH/extras/powerlevel10k/powerlevel10k.zsh-theme

# Source dotbare
source $ZSH/extras/dotbare/dotbare.plugin.zsh

# Source zsh autosuggestions
source $ZSH/extras/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source zsh syntax higlighting (must be sourced at the end)
source $ZSH/extras/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
