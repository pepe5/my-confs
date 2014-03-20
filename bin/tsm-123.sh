#!/bin/bash
# read -p Password: PASS; export PASS; echo PASS~:$PASS | base64
# export LID=...; echo LID:$LID
# F=nohup.out; date > $F; tail -f $F &
# nohup bash /home/kraljo/bin/tsm-123.sh  &
# kill -USR1 `pgrep -f tsm-123.sh`

##
# http://blog.yjl.im/2012/04/sigusr1-and-sigusr2.html
trap sigusr1 SIGUSR1
H=/home/kraljo
cd /mnt/lifeboat-root/mnt/personal-howtos-cache/

sigusr1 ()
{ exec > >(tee /tmp/tsm-123.log)
    exec 2>&1
    echo; echo $0: `date -Is | cut -d+ -f1`: starting bak.. >&2
    echo H:$H
    echo pwd:`pwd`
    tar czvf 123.tgz \
        $H/Desktop/*.org* \
        $H/my-box/ibm.keepassx.kdb* \
        $H/lotus/notes/data/notes.ini \
        $H/lotus/notes/data/$LID.ID #~
    mv -vbf 123.cache 123.cache~
    echo $PASS | gpg --batch --passphrase-fd 0 --output 123.cache -c 123.tgz
    echo "`ls -lt`"
    
    # http://stackoverflow.com/questions/5920333/how-to-check-size-of-a-file
    minimumsize=1500000
    actualsize=$(du -b "123.cache" | cut -f 1)
    if [ $actualsize -ge $minimumsize ];
    then dsmc ba "`pwd`/123.cache"
    else echo $0: "size is under $minimumsize bytes! skipping upload.."
    fi
    echo $0: `date -Is | cut -d+ -f1`: suspending..; }

echo
echo $0: `date -Is | cut -d+ -f1`: starting daemon..
#>! test var/s readiness
echo $0: "-PASS: $(echo $PASS | base64)"
echo $0: "-ID: $(echo $LID)"
while true; do sleep 1; done
