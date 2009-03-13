## Fancy prompt
PS1="\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \[\e[m\] "

## Bash completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

## Shopt options
shopt -s cdspell        # This will correct minor spelling errors in a cd command.
shopt -s histappend     # Append to history rather than overwrite.
shopt -s checkwinsize   # Check window size (rows, columns) after each command.
shopt -s dotglob        # Files beginning with . are returned in path-name expansions.

## Aliases
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
#
alias la="ls -lA"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
#
alias df="df -h"
alias du="du -hs"
alias exit="clear; exit"
alias pgrep="pgrep -fl"
#
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias mkdir="mkdir -p"
function mkdircd () {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}
#
alias vi="vim"
alias top="htop"
alias recent="ls -lAt | head"
alias update="yaourt -Syu --aur"
#
alias g-powersave="sudo cpufreq-selector -g powersave &"
alias g-performance="sudo cpufreq-selector -g performance &"
alias g-ondemand="sudo cpufreq-selector -g ondemand &"

## Exports
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTCONTROL="ignoreboth"
export PATH="$PATH:/usr/local/bin"
export EDITOR="/usr/bin/vim"
export LESSOPEN="|lesspipe.sh %s"
export OOO_FORCE_DESKTOP="gnome"

## Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m' 
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## Something to read
fortune && echo
