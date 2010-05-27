#!/bin/bash -x
# start from scr-root fld (~> /tmp/swfobject)
orig_pwd=`pwd`

# run before commit ~> . bin/gt.sh flush-tree
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
    #>! if dev-text exists; go there
    if [ -s .home.sites/dev-text ];
    then ls -l .home.sites/dev-pro;
    else echo asserting we are in dev src fld;
	#>! check it
    fi;
    }

## show-branches
function show-bs \
    { #//book.git-scm.com/7_git_references.html
    gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
    }

function dev-cd \
    { echo dev-cd: start assert 'text-depo|dev-env': `pwd`
    if [ -d .home.sites/dev-text ]; then cd .home.sites/dev-text/env; fi; }

# start (in) text-depo <=->*prj_nme
# typic.is ~/text/$prj_nme
function dev-ini-roots \
    { export prj_nme=`basename $orig_pwd`
    echo dev-ini-roots: assert text-depo: $prj_nme
    mkdir -v .home.sites
    #postponed by dev-unp-text:git clone #(p) mkdir -vp /tmp/dev/$prj_nme/dev-env
    mkdir -vp /tmp/dev/$prj_nme/dev-text
    ln -sv -bfT /tmp/dev/$prj_nme/dev-text .home.sites/; }

# typic. prj-ins dir is /tmp/dev/$prj_nme/
function dev-unp-skel \
    { ins_path=/tmp/dev/$prj_nme
    echo dev-unp-skel: assert prj-ins dir..
    unzip $skel -d $ins_path/
    }

# in dev-text git-repo - now real files shall be ignored (only .bak~ shall be..)
function dev-unp-text \
    { depo_path=~/text/$prj_nme
    ins_path=/tmp/dev/$prj_nme
    echo dev-unp-text: assert prj-ins dir..
    cd $ins_path
    git clone $depo_path dev-text #>? | checkout | pull | cp -r $depo_path/.git . | what?
    cd $ins_path/dev-text
    git remote add depo $depo_path
    echo -e '\n*~' > .git/info/exclude #>? more .git config/s ?
    }

function dev-unp \
    { echo "("prj fld: got by prev.executions..: $prj_nme")"
    # echo dev-unp: assert..
    dev-unp-skel
    dev-unp-text
    }

echo task: "(pwd:`pwd`)": $*
eval $*
