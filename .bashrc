#!/bin/bash
# ~/.bashrc

if [[ $- != *i* ]] ; then
     # Shell is non-interactive. Be done now!
     return
fi

## Fancy prompt
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
black='\[\e[0;30m\]'
BLACK='\[\e[1;30m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
magenta='\[\e[0;35m\]'
MAGENTA='\[\e[1;35m\]'
white='\[\e[0;37m\]'
WHITE='\[\e[1;37m\]'
NC='\[\e[0m\]' # No Color
# 
PS1="${green}\u${NC} ${BLUE}\w${NC} ${GREEN}\$ ${NC} "

## Bash completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

## Shopt options
shopt -s cdspell        # This will correct minor spelling errors in cd command.
shopt -s checkwinsize   # Check window size (rows, columns) after each command.
shopt -s cmdhist        # Save multi-line commands in history as single line.
shopt -s dotglob        # Include dotfile in path-name expansions.
shopt -s histappend     # Append to history rather than overwrite.
shopt -s nocaseglob     # Pathname expansion will be treated as case-insensitive.

## Aliases
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
#
eval `dircolors`
alias la="ls -lA"
alias ls="ls -hF --color=auto"
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
#
alias x="screen startx"
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
export EDITOR="/usr/bin/vim"
export BROWSER="firefox -new-tab"
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

## Functions
# pacsearch() - Colorize pacman output
pacsearch () {
       echo -e "$(pacman -Ss $@ | sed \
       -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
       -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
       -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
       -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

# mkdircd() -- Mkdir and cd into it
function mkdircd () {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

# ex() -- Extract compressed files (tarballs, zip, etc)
ex() {
    for file in "$@"; do
        if [ -f "$file" ]; then
            local file_type=$(file -bizL "$file")
            case "$file_type" in
                *application/x-tar*|*application/zip*|*application/x-zip*|*application/x-cpio*)
                    bsdtar -x -f "$file" ;;
                *application/x-gzip*)
                    gunzip -d -f "$file" ;;
                *application/x-bzip*)
                    bunzip2 -f "$file" ;;
                *application/x-rar*)
                    7z x "$file" ;;
                *application/octet-stream*)
                    local file_type=$(file -bzL "$file")
                    case "$file_type" in
                        7-zip*) 7z x "$file" ;;
                        *) echo -e "Unknown filetype for '$file'\n$file_type" ;;
                    esac ;;
                *)
                    echo -e "Unknown filetype for '$file'\n$file_type" ;;
            esac
        else
            echo "'$file' is not a valid file"
        fi
done
}

# scpas()/scptw() -- upload files to remote ssh servers
function scpas() { 
    scp "$@" ark@asengard.net:web/upload/ ; 
}
function scptw() { 
    scp "$@" arkham@twilightlair.net: ; 
}

# Aur build helper
function aurbuild() {
    wget "http://aur.archlinux.org/packages/$1/$1.tar.gz" && \
        tar xvzf "$1.tar.gz" && rm -i "$1.tar.gz" && cd $1 ;
}
