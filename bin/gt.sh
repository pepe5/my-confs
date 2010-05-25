#!/bin/bash -x
# start from scr-root fld (~> /tmp/swfobject)

# run before commit ~> . doc/tasks.sh flush-tree
function flush-tree \
    { echo flush-tree: started at: `date -Is` > doc/tree.find-ls
    find . -wholename ./.git -prune -o -not -type d -exec ls -lQ "{}" \; >> doc/tree.find-ls; }

# ~> unzip =arx/0rig.zip -d ..
function unzip-rev \
    { unzip $2 ..; }

# zoom out log
function log-zo \
    { point=$(if [ -z $2 ]; then echo HEAD; else echo $2; fi)
    case $1 in
    (1) git log --oneline --stat $point;;
    (2) git log --oneline --shortstat $point;;
    (3) git log --oneline $point;; esac; }

function log-in \
    { #>! check if .git/ exists
    alias gt=$(echo doc/gt.sh)
    echo log in: aliases expanded by: gt;
    #>! if dev-ins exists; go there
    if [ -s .home.sites/dev-ins ];
    then ls -l .home.sites/dev-pro;
    else echo asserting we are in dev src fld;
	#>! check it
    fi;
    }

echo task: "(pwd:`pwd`)": $*
eval $*
