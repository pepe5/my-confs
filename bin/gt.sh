#!/bin/bash
# -x
# start from scr-root fld (~> /tmp/swfobject)
orig_pwd=`pwd`
# if [ -z $dev_local ];then dev_local='/tmp/dev'; fi
dev_local=~/local ; echo dev_local: $dev_local

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
    gitk $( git show-ref --heads ) --not $( git show-ref --tags ) ; }

function dev-cd \
    { echo dev-cd: start assert 'text-depo|dev-env': `pwd`
    if [ -d .home.sites/text ]; then cd .home.sites/text/env; fi; }

# start (in) text-depo <=->*prj_nme
# typic.is ~/text/$prj_nme
function dev-ini-roots \
    { export prj_nme=`basename $orig_pwd`
    echo dev-ini-roots: assert text-depo: $prj_nme
    mkdir -v .home.sites
    ins_path=$dev_local/$prj_nme
    mkdir -vp $ins_path # dev-ins root
    ln -sv -bfT $ins_path .home.sites/dev-ins
    #(p) mkdir -vp $ins_path/env #< postponed by dev-unp-text:git clone
    mkdir -vp $ins_path/text # dev-text root (inside dev-ins)
    ln -sv -bf $ins_path/text .home.sites/
    ln -sv -bf $ins_path/text /var/cache/git/ #>! make /var/cache/git/ writable for me
    mkdir -vp $ins_path/env
    mkdir -vp $ins_path/bin-cache-1
    mkdir -vp $ins_path/media-store-1
    mkdir -vp $ins_path/.bak
    echo; }

##>! postponed -- to next rel. lets use symlinks in skel-arx
# typic. env @ dev-ins is $dev_local/$prj_nme/./env !
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

# typic. dev- (prj) -ins dir is $dev_local/$prj_nme/
#>? shall pack-skel incl. last (Stab) release? (to be executable..)?
#->var1: no, we can use .bak of stab.r. (stored) in incr.arch. && skel shall not lay in .bak (but in =arx)
#->var2: last stab.r. shall also lay in =arx ..!
function dev-unp-skel \
    { ins_path=$dev_local/$prj_nme
    echo dev-unp-skel "(of built-in lib/s freez cache)" : assert prj-ins dir..
    unzip $dev -d $ins_path/env # skel pack shall be w/o root-fld..
    unzip $src -d $ins_path/src # src/s skel..
    echo; }

# zip symlinks -- have 0% deflation && are not */ (dir) lines
#       65  Stored       _65_   _0%_ 2010-06-24 16:35 a679f907  app/controllers/logs_controller.rb
function pack-skel \
    { zip -ry ~/text/log-viewer/=arx/env-skel,re-freez .
    unzip -lv ~/text/log-viewer/=arx/env-skel,re-freez | grep -E ' 0%.*[^/]$' | head
    echo; }

# in dev-text git-repo - now real files shall be ignored (only .bak~ could be incl./ed..)
function dev-unp-text \
    { depo_path=~/text/$prj_nme
    ins_path=$dev_local/$prj_nme
    echo dev-unp-text: assert prj-ins dir..
    cd $ins_path
    git clone $depo_path text #>? | checkout | pull | cp -r $depo_path/.git . | what?
    cd $ins_path/text
    git remote add depo $depo_path
    echo -e '\n*~' > .git/info/exclude #>? more .git config/s ?
    echo; }


function dev-chk-lnks \
    { echo dev-chk-lnks: assert start at: text/ or depo/ or ins/ ..
    dev_text=`pwd`; echo dev_text: $dev_text
    dev_ins=`find .home.sites/dev-ins -printf %l`; echo dev_ins: $dev_ins
    # pushd $dev_text
    find . -wholename ./.git -prune -or -wholename ./=arx -prune -or \
	-not -type d \
	-not -name "*~" -not -name ".*" -not -path "*/.bak/*" |\
      while read l; do
	# find $dev_text/$l -maxdepth 0 -printf "%p %b %t\n"
	# find $dev_ins/env/$l -maxdepth 0 -printf "%l %b %t (%p)\n"
	# ls -lF -d $dev_text/$l $dev_ins/env/$l;
	echo -ne text:\\t\\t; ls -lF -dL $dev_text/$l;
	echo -ne depl size:\\t; ls -lF -dL $dev_ins/env/$l;
	echo -ne depl lnk:\\t\\t; ls -l -d $dev_ins/env/$l;
	# diff $1 $dev_text/$l $dev_ins/env/$l;
	echo
    done
    echo; }

## use: log-viewer$> gt dev-re-lnk -q 2>/dev/null
#>! not ok if text/ is in depo/ ..
# for now -- dry-mode
function dev-re-lnk \
    { echo at: text/ or depo/ or ins/ ..
    dev_text=`pwd`; echo dev_text: $dev_text
    dev_ins=`find .home.sites/dev-ins -printf %l`; echo dev_ins: $dev_ins
    find . -wholename ./.git -prune -or -wholename ./=arx -prune -or \
	-not -name "*~" -not -name ".*" -not -path "*/.bak/*" \
	-not -type d |\
      while read l; do
	# ll -d $dev_text/$l $dev_ins/env/$l;
	if [ ! -d $dev_text/$l ]; then
	    diff $1 $dev_text/$l $dev_ins/env/$l 1>&2 || \
		echo ln -sv -vbfT $dev_text/$l $dev_ins/env/$l; fi; done
    echo; }

function dev-unp \
    { echo "("prj fld: got by prev.executions..: $prj_nme")"
    # echo dev-unp: assert..
    dev-unp-skel
    dev-unp-text
    # dev-maybe-unp-lnks
    echo; }

#>!! i am loosing grouping
# - what next? ruby? rake?
# - could help?: //www.faqs.org/docs/abs/HTML/variables2.html or //tldp.org/LDP/abs/html/internalvariables.html
#--> for now act var.: mov ty git + split this to pre-comi & post-comi batches
#>! move triggers to git !
# assert cwd in text/
function comi-ZZ \
    { echo commit: w/ params: -a $@
    echo pre trigger cleanup:; get-tree
    echo pre trigger files cat: NY
    git commit -a $@ # "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" # $@
    #>! git push
    echo post trigger start bg test: NY
    echo; }

# always show tree
function gitk \
    { #//stackoverflow.com/questions/1838873/visualizing-branch-topology-in-git
    echo '>' git log --graph --full-history --all --color '#>:'
    git log --graph --full-history --all --color \
    --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s" | cat
    #//stackoverflow.com/questions/67699/how-do-i-clone-all-remote-branches-with-git
    `which gitk` --all & }

# ARGV[0] = './.git/objects/88/40d736a8e50f7dc3dd0696e456345303ea818e'
function unz-blob \
    { ruby -r'zlib' - <<-EOF
    ARGV[0] = '$1'
    d = ''
    fn = '/tmp/'+ File.basename (ARGV[0]) +'.zip'
    File .open (ARGV[0]) {|f| d = Zlib::Inflate.inflate f.read}; puts d.size
    File .open (fn, 'w') {|f| f.write d [d.index ("\000") +1 .. -1] }; puts %x{file #{fn}}
EOF
    echo; }

echo pwd: $orig_pwd
task=$1; shift
echo task: $task, params: $*
if [ .$task. == .comi. ];
then comi $@;
else eval $task $* # \"\" "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" #
fi
