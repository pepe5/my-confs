#!/bin/bash
# read PASS; export PASS; echo $PASS | base64

##
# http://blog.yjl.im/2012/04/sigusr1-and-sigusr2.html
# nohup bash /home/kraljo/bin/tsm-123.sh  &
# kill -USR1 `pgrep -f tsm-123.sh`
trap sigusr1 SIGUSR1
H=/home/kraljo
cd /mnt/lifeboat-root/mnt/personal-howtos-cache/

sigusr1 ()
{ echo $0: `date -Is | cut -d+ -f1`: starting bak.. >&2
    echo H:$H
    echo pwd:`pwd`
    tar czvf 123.tgz \
        $H/Desktop/*.org* \
        $H/my-box/ibm.keepassx.kdb* \
        $H/lotus/notes/data/notes.ini \
        $H/lotus/notes/data/CZZ06588.ID #~
    mv -vbf 123.cache 123.cache~
    echo $PASS | gpg --batch --passphrase-fd 0 --output 123.cache -c 123.tgz
    echo "`ls -lt`"
    #>! dsmc ba `pwd`/123.cache
    echo $0: `date -Is | cut -d+ -f1`: suspending..; }

echo $0: `date -Is | cut -d+ -f1`: starting daemon.. "(with $(echo $PASS | base64))"
while true; do sleep 1; done
