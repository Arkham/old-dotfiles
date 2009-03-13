# Fancy prompt
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[m\] \[\e[1;32m\]\$ \[\e[m\] '

# Some aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -la'
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias top="htop"
alias vi="vim"
alias g-powersave="sudo cpufreq-selector -g powersave &"
alias g-performance="sudo cpufreq-selector -g performance &"
alias g-ondemand="sudo cpufreq-selector -g ondemand &"

# Some exports
export HISTCONTROL="ignoredups"
export PATH="$PATH:/usr/local/bin"
export EDITOR="/usr/bin/vim"
export LESSOPEN="|lesspipe.sh %s"
export OOO_FORCE_DESKTOP="gnome"

# Bash completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# arch aliases
alias p="pacman"
alias y="yaourt"
alias exit="clear; exit"
alias x="startx &> /dev/null"
alias pacs="pacsearch"
pacsearch () {
       echo -e "$(pacman -Ss $@ | sed \
       -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
       -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
       -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
       -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

# Colors for less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
