#!/bin/bash

##
# http://blog.yjl.im/2012/04/sigusr1-and-sigusr2.html
# nohup bash /home/kraljo/bin/tsm-123.sh  &
# kill -USR1 `pgrep -f tsm-123.sh`
trap sigusr1 SIGUSR1

sigusr1 ()
    { echo $0: date, $i >&2
    echo; }

echo $0: starting..
i=0
while let ++i; do sleep 1; done
