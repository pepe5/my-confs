#!/bin/bash
f=~/.local/share/parcellite/history

olds=''
inotail -f $f | while read l; do
    news="`perl -ne '/\0\0\0([^\0]+)\0\0\0/ and print $1' $f`"
    if [[ ."$olds". != ."$news". ]]; then
        # (>) echo -parcellite: $news "<<" $olds;
        notify-send "$news"
        olds="$news"
    fi
done

