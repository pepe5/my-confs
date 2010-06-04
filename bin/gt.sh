#!/bin/bash -x
# start from scr-root fld (~> /tmp/swfobject)
orig_pwd=`pwd`

# run before commit ~> . bin/gt.sh flush-tree
function flush-tree { get-tree; }
function get-tree \
    { store=doc/tree.find-ls
    if [ -d text/doc ]; then store=text/doc/tree.find-ls; fi
    echo flush-tree: storing to: $store
    echo flush-tree: started at: `date -Is` > $store
    find . -wholename "*/.git" -prune -o -not -type d -exec ls -lQ "{}" \; >> $store; }
#>! while we dont have get-skel-links; we must flush all trees (incl. env)

# ~> unzip =arx/0rig.zip -d ..
#>! see also dev-unp-skel; & unp-rel (release)
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
    if [ -s .home.sites/text ];
    then ls -l .home.sites/pro;
    else echo asserting we are in dev src fld;
	#>! check it
    fi; }

## show-branches
function show-bs \
    { #//book.git-scm.com/7_git_references.html
    gitk $( git show-ref --heads ) --not  $( git show-ref --tags ) ; }

function dev-cd \
    { echo dev-cd: start assert 'text-depo|dev-env': `pwd`
    if [ -d .home.sites/text ]; then cd .home.sites/text/env; fi; }

# start (in) text-depo <=->*prj_nme
# typic.is ~/text/$prj_nme
function dev-ini-roots \
    { export prj_nme=`basename $orig_pwd`
    echo dev-ini-roots: assert text-depo: $prj_nme
    mkdir -v .home.sites
    ins_path=/tmp/dev/$prj_nme
    mkdir -vp $ins_path # dev-ins root
    ln -sv -bfT $ins_path .home.sites/dev-ins
    #(p) mkdir -vp $ins_path/env #< postponed by dev-unp-text:git clone
    mkdir -vp $ins_path/text # dev-text root (inside dev-ins)
    ln -sv -bf $ins_path/text .home.sites/
    ln -sv -bf $ins_path/text /var/cache/git/ #>! make /var/cache/git/ writable for me
    mkdir -vp $ins_path/env
    mkdir -vp $ins_path/bin-cache-1
    mkdir -vp $ins_path/big-samples-1
    mkdir -vp $ins_path/.bak
    ; }

##>! postponed -- to next rel. lets use symlinks in skel-arx
# typic. env @ dev-ins is /tmp/dev/$prj_nme/./env !
# function get-skel-links \
#     { echo get-skel-links: assert dev-ins w/ env "!": $orig_pwd
#     def_store=text/lib/make-links.sh #>? other place then text/? (to inhi.polution of env/ fld)
#     #>! if [ .$1. -e .-. ]; then def_store=/dev/stdout
#     echo - def_store: $def_store
#     pushd env
#     find . -type l | while read lnk; do
# 	ls -lFH $lnk 1>&2 # for feedback about correct linkage
# 	echo ln -sv -bfT `find "$lnk" -printf %l` "$lnk"
#     done
#     popd; }

##>!
# function reg-make-task { ; }
#>! use mtime-upd check mechanism (~> rake? | other?)
function make \
    { echo dev-make: compile all reg/d & upd/d src/s:..;
    pushd src
    echo mtasc `find i*-$2* -printf %l` -O `find o*-$2* -printf %l`
    popd; }

# typic. dev- (prj) -ins dir is /tmp/dev/$prj_nme/
#>? shall skel-pack incl. last (Stab) release? (to be executable..)?
#->var1: no, we can use .bak of stab.r. (stored) in incr.arch. && skel shall not lay in .bak (but in =arx)
#->var2: last stab.r. shall also lay in =arx ..!
function dev-unp-skel \
    { ins_path=/tmp/dev/$prj_nme
    echo dev-unp-skel "(of built-in lib/s freez cache)" : assert prj-ins dir..
    unzip $dev -d $ins_path/env # skel pack shall be w/o root-fld..
    unzip $src -d $ins_path/src # src/s skel..
    ; }

# in dev-text git-repo - now real files shall be ignored (only .bak~ could be incl./ed..)
function dev-unp-text \
    { depo_path=~/text/$prj_nme
    ins_path=/tmp/dev/$prj_nme
    echo dev-unp-text: assert prj-ins dir..
    cd $ins_path
    git clone $depo_path text #>? | checkout | pull | cp -r $depo_path/.git . | what?
    cd $ins_path/text
    git remote add depo $depo_path
    echo -e '\n*~' > .git/info/exclude #>? more .git config/s ?
    ; }

function dev-unp \
    { echo "("prj fld: got by prev.executions..: $prj_nme")"
    # echo dev-unp: assert..
    dev-unp-skel
    dev-unp-text
    ; }

echo task: "(pwd:$orig_pwd)": $*
eval $*
