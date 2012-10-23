#!/bin/bash
#>! output should be that-used by dired (~~ ls --dired)
d=`pwd`
[[ $# -eq 1 ]] && d="$1"

pushd "$d" 1>&2
find . -type f |\
while read L; do
    L1=`basename "$L"`
    echo -n '' -$L1: '';

    locate -r "/$L1\$" | awk '{print "\""$0"\""}' | xargs ls -1dt | while read F; do
        echo "`stat -c %s "$F"`":`ls -1td "$F"`
    done > /tmp/count-vers;

    # cat -n /tmp/count-vers 1>&2
    for i in `cat /tmp/count-vers | uniq | cut -d: -f1`; do
        echo `grep -c $i /tmp/count-vers`x:$i ;
    done | uniq | xargs echo;

    locate "$L1" | awk '{print "\""$0"\""}' | xargs ls -dilt 1>&2
done
popd 1>&2