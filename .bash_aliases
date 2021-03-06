# -*- sh -*-
# id='$Id: $'
# echo $id

#>!
# when i do not mng a store of session/s hier. pid/s, for now i use 'labeling process':
# (you must suspend it (^MGQZ RET) to have it in ps listing as a label)
#>! use ssh pixu2 bash --rcfile ~/.rcXYZ -i # to SendEnv (when AccepEnv is off on the server)
alias s-1='sh -c "echo $PS1@`hostname`:`tty | cut -d/ -f 3-`: -B pool07@bl44@titan1: local session terminal: for telnet/s >> ~/tmp/.labels; ls -l ~/tmp/.labels; sleep 4"' #>! sed -i d..
alias s1='pgrep -f `tty | cut -d/ -f 3-` -l' # session/s-hier's (local-) parent-pid
function l1 \
    { echo $PS1@`hostname`:$(pgrep -f `tty | cut -d/ -f 3-` -l) @ $(basename `pwd`): $@ @ \(`pwd`\) @ `date -Is` \(ini/s:`ls *.ini`\)>> ~/tmp/.labels
    ls -l ~/tmp/.labels
    l=`tail -1 ~/tmp/.labels`
    sh -c "echo '$l'; sleep 4" &
    ljob=`jobs | fgrep 'sh -c' | cut -c2` #>! get it by $!
    kill -STOP %$ljob
    echo; }

function sp \
    { tty=`tty | cut -d/ -f 3-` #; echo \ -tty: $tty
    pid=$(pgrep -f `tty | cut -d/ -f 3-` | sort -n | head -1) #; echo \ -pid: $pid
    # echo \ -grep $pid ~/tmp/.labels:
    grep $pid ~/tmp/.labels
    # echo \ -ps hp $pid:
    ps hp $pid
    # echo
    ps fwx | sed -ne "/$pid/,\$p" | ruby -ne 'BEGIN{gets}; if /\\_/; print $_ else return end'
    echo; }
alias lless='less -S +F `ls -1t **/*stamped* | head -1`' #last less
alias ltail='tail -f `ls -1t **/*stamped* | head -1`' #last less
#>! alias sl=list (here connected) sessions
#>! emacs desktop one-liner:
# nohup bash -c 'cd /home/kraljo/Dropbox/B-P/dev-java-uniq/vosao-stu/doc; emacs' &

# one-liner: grep -E 'Name: |Pre: ' `ls -1t /mnt/jubiler/home/ttt/tttauto/52titan/sts* | head -1` | while read name; do echo -n $name '' ; read pre; echo $pre; done 2>/dev/null | tee /tmp/ttt/tttauto/pres-`date -Is `.st | tail
function flush-pres \
    { path=/mnt/jubiler/home/ttt/tttauto
    if (( $# == 1)); then path=$path/$1; else path=$path/52titan; fi
    echo -flush-pres: path: $path
    grep -E 'Name: |Pre: ' `ls -1t $path/sts* | head -1` |\
    while read name; do echo -n $name '' ; read pre; echo $pre; done 2>/dev/null |\
    tee /tmp/ttt/tttauto/`basename $path`-`date -Is `.prerqs.st | tail
    echo; }

# watch-d by less-S
alias wd='clear; while true; do 
sleep 2; echo -e "\033[0;0H"; 
date -Is; echo; 
find . -type f | xargs ls -ldt 2>/dev/null | head -20 | while read l; do echo `echo -n $l | cut -c26-` "        "; done | less -SE; 
done'

alias rk="while true; do wmctrl -a 'as07'; sleep 1; wmctrl -a 'keepalive'; sleep 1000; done &" # (R)desktop- (K)eepalive
alias ll='ls -lF'
alias la='ls -AF'
alias l='ls -CF'
alias d1='echo -n date -Is:\  ; date -Is; echo'
alias f1='find . -name "*.dtach" -ls'
alias bsh='java -cp /usr/share/java/bsh-2.0b4.jar bsh.Interpreter'
alias wget='wget --progress=dot '
alias unzip-stream="python -c \"import zipfile,sys,StringIO;zipfile.ZipFile(StringIO.StringIO(sys.stdin.read())).extractall(sys.argv[1] if len(sys.argv) == 2 else '.')\""
alias unzip-out="python -c \"import zipfile,sys,StringIO;print(zipfile.ZipFile(StringIO.StringIO(sys.stdin.read())).open(sys.argv[1] if len(sys.argv) == 2 else '.').read())\""
alias p0='PS1="$> "'
alias p1='PS1="\W$> "'
alias pR='PS1="\W#> "'

alias off='xset dpms force off'
alias xr='xrandr --output LVDS1 --off; sleep 1; xrandr --output VGA1 --mode 1680x1050 --pos 0x0 --output LVDS1 --mode 1600x900 --pos 1680x150; echo "pep> alias is deprecated - use script version!"'
alias swp1='setxkbmap -option ctrl:swapcaps'
alias ri=ri1.8
alias irb='irb --simple-prompt'
alias gx="sudo su - games -c 'startx -- :1'"
alias gff="sudo su - games -c 'DISPLAY=:0 nohup firefox' &"

function fn \
    { set | sed -ne "/$1 ()/,/^}$/p"
    echo; }

function ediffer \
    { emacsclient --eval "(ediff-files \"$1\" \"$2\")"
    echo; }

## recursive diff query
function rediff \
    { echo A=$1 1>&2
    echo B=$2 1>&2
    # ruby ma byt 1.8:
    diff -rq $1 $2 | ruby -ane 'if /Files (.*) and (.*) differ$/; puts "ediffer #{$1} #{$2}" else puts "# (#{$F[-1]})" end'
    echo 1>&2; }

## sync based on diff-util query
# dsync /media/2D77-BD8D/Ibm-box/Documents/Logs/ .
# stu //www.daniweb.com/software-development/shell-scripting/threads/120990
#>! test if it do not output directories
#>! add opt. to set cp-command (cp|rsync|scp|..)
#>! if you want vanilla awk -> echo 'ab cb ad' | awk '{gsub(/a./,SUBSEP"&"SUBSEP);split($0,cap,SUBSEP);print cap[2]"|"cap[4]}'

# use as evar ab-set <A-DIR> <B-DIR>
function evar { eval `$*`; }
function ab-set \
    { echo 1>&2 A=$1
    echo 1>&2 B=$2
    echo export A=\"$1\";
    echo export B=\"$2\"; }

function ab-from-diff \
    { echo "#" ab: A=$A
    echo "#" ab: B=$B
    if [[ -n $1 ]]; then echo "#" ab: prefx: $1; fi
    #>! perl groups capturing; till vanilla awk version will be formulated
    #>! then add quotes around A+B
    awk -v prefx="$1" -v base="$A" -v target="$B" '/^Files/ {print prefx, $2, $4}'
    echo; }

function dsync \
    { echo A=$1
    echo B=$2
    diff -rq $1 $2 | fgrep -v "Only in $2" |\
    awk -v base=$1 -v target=$2 '
    /^Only in/ {print "cp -vb", gensub(/:/,"","",$3)"/"$4, target"/"gensub(base"(.*):","\\1","",$3)}
    /^Files/ {print "/bin/cp -vbf --backup=t", $2, $4}'
    echo; }
function dsync-last-working \
    { echo A=$1
    echo B=$2
    diff -rq $1 $2 | fgrep -v "Only in $2" |\
    awk '/^Only in/ {print "cp-new -vb",$3,$4} /^Files/ {print "cp-OVER -vbf --backup=t",$2,$4}'
    echo; }
function dsync-ruby \
    { echo A=$1
    echo B=$2
    diff -rq $1 $2 | ruby1.8 -ane '
    BEGIN {O=/Only in (.*) differ|Files (.*) and/; }
    puts "* #{O}"
    p $F
    if !/Only in $2/; $_ .match O; puts %Q{cp -vf #{$1}} end '
    echo; }
## test:
# mkdir -vp /tmp/A/nested /tmp/B/nested
# echo > /tmp/A/nested/only-orig
# echo 1 > /tmp/A/nested/modify; echo 2 > /tmp/B/nested/modify
# diff -rq /tmp/A/ /tmp/B/
# B$ dsync /tmp/A/ .
# A=/tmp/A/
# B=.
# cp -vbf --backup=t /tmp/A/nested/modify ./nested/modify
# cp -vb /tmp/A/nested/only-orig ./nested

alias findup=/usr/share/fslint/fslint/findup
alias log='. ~/bin/log.sh'
alias logr="pgrep -l -f 'ruby .*-timestamp'; pkill -f 'ruby .*-timestamp'; pgrep -l -f 'ruby .*-timestamp'"
alias al='dtach -a $(ls -t `find ~ -name "*.dtach"` | head -1) -z'
alias tar-sh='(cd /host/kraljo/dox(!)/text; find . -newer andL -type f)'

# //user.it.uu.se/~matkin/documents/shell/
function forwhich \
    { ( IFS=: ; for D in $PATH; do for F in $D/"$1"; do [ -x $F ] && echo $F; done; done ) ; }

function grep_dist \
    { #>! how to wget recursively?
    while read l;
    do echo \  -- $l:;
	wget --no-proxy -T 1 -rl 3 "$l" -O - 2>/dev/null | grep -in smsc;
    done < menu.hrefs | head -300
    echo; }

if [ -f ~/.kraljo_aliases ]; then
    . ~/.kraljo_aliases
fi
PATH=$PATH:$HOME/bin:/usr/lib/git-core
alias gl2='git log --all -g --abbrev-commit --pretty=oneline' # for pipe use format:%h
alias gl='git log --graph --format="%ai %h --%d %s [ --%an ]" | perl -nle "print qq{# \$_}" | head'

export JAVA_HOME=/usr/lib/jvm/java-6-openjdk # /usr/lib/jvm/jdk1.6.0_22
export PATH=$PATH:$JAVA_HOME/bin:/mnt/lifeboat-root/bin:/mnt/lifeboat-root/usr/bin
#export http_proxy=http://wpad.intinfra.com:3128
export HISTTIMEFORMAT="%F %T "
function hi { history | grep -i $@ | cut -d\  -f5- | uniq | tail ;}
function tailr { tail -f 1 | ruby -ne "BEGIN{$stdin.sync=true}; if /$1/i .match $_; $2; puts $_ end" ;} #== grep --line-buffered

export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
#>? eval "$(lesspipe)"

#>? used also by gnome?! ( -x $SSH_AUTH_SOCK )
alias c=$HOME/bin/pcomint
function sshg 	{ [[ ( -z $SSH_AGENT_PID ) ]] && . lk; jobs > /tmp/sshg.jobs; eval `. ~/bin/sshg.sh $@` ;}
function g	 	{ [[ ( -z $SSH_AUTH_SOCK ) || ( -x $SSH_AUTH_SOCK ) ]] && . lk; jobs > /tmp/sshg.jobs; eval `. ~/bin/sshg.sh $@` ;}
function sshd 	{ [[ ( -z $SSH_AUTH_SOCK ) || ( -x $SSH_AUTH_SOCK ) ]] && . lk; jobs > /tmp/sshg.jobs; eval `. ~/bin/sshdeuba -x $@` ;}

#>! use source ~/text/sc/lib/bash/fn1
function d \
    { [[ ( -z $SSH_AUTH_SOCK ) || ( -x $SSH_AUTH_SOCK ) ]] && . lk;
    jobs > /tmp/sshg.jobs
    TICKET=$2; echo 1>&2 TICKET=$TICKET
    CMD=`. ~/bin/sshdeuba -x $* | perl -pe 's/\@sls\./\@dbkpsas5\./; s/ -v / /'`
    if echo $@ | egrep '^-'; then TICKET=$3; fi # expecting ONLY 1 switch for now
    dtach -n ~/tmp/$TICKET.dtach -z bash
    commit.py $TICKET "PS1='$TICKET:\W$> '"
    commit.py $TICKET "$CMD"
    #>! use aaa.py instead of sleep/ing (blind) task/s
    #>! add also emacsclient request, formulating right .con.log file-name
    (sleep 2; commit.py $TICKET reset; commit.py $TICKET "logger -p user.info $TICKET") &
    dtach -a ~/tmp/$TICKET.dtach -z
    #>! append here map/ws_stop, $FQDN need to be got yet by s/t~> sshd -d -x
    FQDN=`sshdeuba -d -x $1 $TICKET`
    wget -O - "http://9.158.166.235:8080/map/ws_stop.php?h=$FQDN&t=$TICKET"
    echo;}

alias f=$HOME/bin/sshf.sh

#(<) alias fg-mach='eval `~/bin/fg-mach.sh`'
#>! add here (to sshg) detection and handling for /gsni. See also fg-mach
# function sshg \
# { . lk #>! move to sshg.sh
#     cmd="ssh sls4root@dbkpsas4.rze.de.db.com -F /home/kraljo/.ssh/deuba.config -A -t 'sls -c root@$1'"
#     echo $cmd
#     eval $cmd;}

export PATH=$PATH:$HOME/opt/node-8.16/bin
# export WORKON_HOME=$HOME/.virtualenvs 
# source /usr/bin/virtualenvwrapper.sh 
export PIP_VIRTUALENV_BASE=$WORKON_HOME

export recoll_tmp=/mnt/lifeboat-tmp/=arx-sam7/.find-ls-l.cat/.recoll,tmp
function reco \
    { Q=$1; echo Q:$Q
    shift
    O=${*// /.*}; echo O:$O
    recoll -c ~/.recoll,logs,try/ -t -q "phrase:\"$Q\"" |\
    perl -ne 'm|\[file://([^	]+)\][ 	]| and print "$1\n"' |\
    egrep -v '\.pdf|\.zip' |\
    while read l;
    do echo '' -[[file:$l]] :; egrep -in -- "$Q.*$O" "$l" | cut -c 1-200 | awk '{print "\t"$0}' | head -2;
    done | head -33
    echo; }

function enkey \
{ perl -nle '(/\W*(.*)(\.rpm)/ or /\W*(.*)/) and print "$1: $_"' |\
     perl -ple 'if (/libstdc/) {s/([^.]+-[0-9]+)([.-][0-9]+)[.-].*: (.*)/$1 $3/i}
     else {s/([^.]+?)(-[0-9]+[0-9a-z]*)[.-].*: (.*)/$1 $3/i}'; }

# archkey uses "key (arch)" identification as ~> http://rpm.pbone.net/index.php3/stat/4/idpl/15161516/dir/redhat_el_6/com/qtnx-0.9-10.el6.x86_64.rpm.html
function archkey \
{ perl -nle '(/\W*(.*)(\.rpm)/ or /\W*(.*)/) and print "$1: $_"' |\
     perl -ple 'if (/libstdc/) {s/([^.]+-[0-9]+)([.-][0-9]+[.-]).*(\.[^.]+): (.*)/$1$3 $4/i}
     else {s/([^.]+?)(-[0-9]+[0-9a-z]*[.-]).*(\.[^.]+[^:]): (.*)/$1$3 $4/i}'; }

function comsplit \
      { python -c "import itertools as it, sys;
for L in sys.stdin:
   L = L.split (' ')
   C = '' .join (E[0] for E in it.takewhile (lambda T: T[0]==T[1], zip (L[0], L[1], )))
   print '<', C, L[0][len(C):]
   print '>', C, L[1][len(C):]"; }

function enver \
    { while read L; do
    export K=`echo $L | enkey | cut -d\  -f1`
    echo $L | perl -ne '/^$ENV{"K"}-(.*)(.x86_64|.noarch|.i[36]86)/ and print "$1 $_"'; done; }

keystest=$HOME/text/my-confs/doc/keystest.rpm-qa
function testkeys \
    { echo "cat $keystest | enkey | awk '{print " -"$0}' #:"
    cat $keystest | enkey | awk '{print " -"$0}'
    echo
    echo "cat $keystest | archkey | awk '{print " -"$0}' #:"
    cat $keystest | archkey | awk '{print " -"$0}'
    echo; }

unset command_not_found_handle
