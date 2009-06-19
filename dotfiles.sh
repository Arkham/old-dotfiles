#!/bin/bash
# Dotfiles backup & deploy script

dotfiles=( ~/.bashrc \
           ~/.conkyrc \
           ~/.conkyForecast.config
           ~/.scripts/conkyMoc.sh \
           ~/.scripts/conkyForecast.template \
           ~/.Xdefaults \
           ~/.vimrc \
           ~/.emacs \
           ~/.config/awesome/rc.lua \
           /etc/X11/xorg.conf \
           /etc/rc.conf \
           /etc/syslog-ng.conf )

ACTION=${1:-"backup"}

case "$ACTION" in
    backup)
        for x in "${dotfiles[@]}"; do
            # Check if the version differs
            diff "$x" "`basename $x`" &> /dev/null
            if [ $? -gt 0 ]; then
                echo "Backing up $x ..."
                cp "$x" "`basename $x`"
            fi
        done
        echo "Backup completed."
        ;;
    *)
        echo "usage: $0 {backup|deploy}"
esac
