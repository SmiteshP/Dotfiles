## --- Alias --- ##

# easy cd
alias -- -='cd -'
alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..
alias -g ......=../../../../..
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# ls
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls --color=tty'
alias lsa='ls -lah'

# vi and vim as alias for nvim
alias vi="nvim"
alias vim="nvim"

# mutt as alias for neomutt
alias mutt="neomutt"

# fix clear for termite
alias clear="echo -ne '\ec'"
bindkey -s '^L' 'clear\n'

# generic aliases
alias df="df -h"                          # human-readable sizes
alias free="free -m"                      # show sizes in MB
alias cp="cp -i"                          # confirm before overwriting something
alias more="less"                         # because more is less :P
alias diff="diff --color"
alias grep="grep --color"

# del - alternative to rm - moves file to trash
alias del="mv --target-directory /home/smith/.local/share/Trash/files --backup=t"

## --- Custom Functions --- ##

disable r

# Use ranger to navigate to a folder in terminal
function r() {
	ranger --choosedir=$HOME/.cache/rangerdir;
	LASTDIR=$(cat $HOME/.cache/rangerdir);
	if [ "$PWD" != "$LASTDIR" ]; then
		cd "$LASTDIR"
	fi
}

# Use fzf to quickly find infomation about installed package
function pacinfo() {
	if [ -z "$1" ]; then
		packname=$(pacman -Qq | fzf --preview="pacman -Qi {}" --preview-window=:hidden --bind="?:toggle-preview")
		[ -z "$packname" ] || pacman -Qi "$packname"
	else
		pacman -Qi $1
	fi
}

# Use fzf to search for packages in the repos
function pacsearch() {
	if [ -z "$1" ]; then
		packname=$(pacman -Ssq | fzf --preview="pacman -Si {}" --preview-window=:hidden --bind="?:toggle-preview")
		[ -z "$packname" ] || pacman -Si $packname
	else
		pacman -Si $1
	fi
}

# acitivate python environment (with fzf)
function activate() {
	if [ -z "$1" ]; then
		envname=$(fd --maxdepth 1 -t d . $HOME/.python_envs | awk -F '/' '{print $5}' | fzf)
		[ -z "$envname" ] || source $HOME/.python_envs/$envname/bin/activate
	else
		source $HOME/.python_envs/$1/bin/activate
	fi
}

# update zsh extras and pkgfile
function zupdate() {
	echo "Update command-not-found database"
	sudo pkgfile -u
	echo
	echo "Powerlevel10k"
	git -C $ZSH/extras/powerlevel10k/ pull --ff-only
	echo
	echo "Dotbare"
	git -C $ZSH/extras/dotbare/ pull --ff-only
}

# ex - archive extractor
# usage: ex <file>
function ex() {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2)   tar xjf $1   ;;
			*.tar.gz)    tar xzf $1   ;;
			*.bz2)       bunzip2 $1   ;;
			*.rar)       unrar x $1   ;;
			*.gz)        gunzip $1    ;;
			*.tar)       tar xf $1    ;;
			*.tbz2)      tar xjf $1   ;;
			*.tgz)       tar xzf $1   ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1;;
			*.7z)        7z x $1      ;;
			*)           echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}
