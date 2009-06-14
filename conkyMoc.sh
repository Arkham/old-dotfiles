#!/bin/bash

INFO=`mocp --info` 
echo ""

if [ "$INFO" == "State: STOP" ]; then

    echo "      MOC is off. Silence everywhere.."

else

    ARTIST=`mocp --info | grep Artist | cut -f2 -d :`
    TITLE=`mocp --info | grep SongTitle | cut -f2 -d :`

    expr substr "$ARTIST - $TITLE" 1 42
fi

echo ""
