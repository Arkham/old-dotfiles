#! /bin/bash
# display information from mocp for conky

# check if mocp is running
pgrep -fl mocp &> /dev/null
if [ $? -gt 0 ]; then
    echo; echo "      MOC is off. Silence everywhere.."; echo
    exit 1
fi

# mocp is running, extract info
INFO=`mocp --info` 

echo

if [ "$INFO" == "State: STOP" ]; then
    echo "    MOC is stopped. Silence everywhere.."; echo
    exit 0
else
    ARTIST=`mocp --info | grep Artist | cut -f2 -d :`
    TITLE=`mocp --info | grep SongTitle | cut -f2 -d :`
    STRING="$ARTIST - $TITLE"

    LEN=`expr length "$STRING"`
    CURLEN=$LEN

    MAXPOS=100
    MAXLINE=37

    # main loop
    while : ; do
        
        STARTPOS=1
        
        # check where the first word ends
        ENDPOS=`expr index "$STRING" " "`
        
        # no space found -> last word
        if [ $ENDPOS -eq 0 ]; then
            LASTWORD=`expr substr "$STRING" 1 $MAXPOS`
            LASTWORDLEN=`expr length "$WORD"`

            # check if the last word exceeds the line
            let CURLINE=$LEN-$CURLEN+$LASTWORDLEN
            if [ $CURLINE -gt $MAXLINE ]; then
                echo; echo -n " $LASTWORD"
            else
                echo -n "$LASTWORD"
            fi

            # exit the while
            break
        fi

        # extract the word
        let WORDLEN=$ENDPOS-$STARTPOS
        WORD=`expr substr "$STRING" $STARTPOS $WORDLEN`

        # check if the word exceeds the line
        let CURLINE=$LEN-$CURLEN+$WORDLEN
        if [ $CURLINE -gt $MAXLINE ]; then
            echo; echo -n " $WORD "
            LEN=$CURLEN
        else
            echo -n "$WORD "
        fi

        # remove the word from the string and go on
        let ENDPOS=$ENDPOS+1
        STRING=`expr substr "$STRING" $ENDPOS $MAXPOS`

        # update length of the current string
        CURLEN=`expr length "$STRING"`
    done
fi

echo; echo

exit 0
