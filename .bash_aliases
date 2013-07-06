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
alias locate='locate -d `printf "%s\n" $HOME/.scfs/*.locate | tr "\n" ":"` '
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
alias p0='PS1="$> "'
alias p1='PS1="\W$> "'
alias pR='PS1="\W#> "'

alias off='xset dpms force off'
alias xr='xrandr --output LVDS1 --off; sleep 1; xrandr --output VGA1 --mode 1680x1050 --pos 0x0 --output LVDS1 --mode 1600x900 --pos 1680x150'
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

#export http_proxy=http://wpad.intinfra.com:3128
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk # /usr/lib/jvm/jdk1.6.0_22
export PATH=$PATH:$JAVA_HOME/bin:/mnt/lifeboat-root/bin:/mnt/lifeboat-root/usr/bin
export HISTTIMEFORMAT="%F %T "

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

# make data to be on destination side, but src side will stay valid - as symlink. -- Counterpart to cp-l
function mv-l \
    { [[ -e "$2" ]] && TO="$2/`basename $1`" #>! count on mv -t/-T opt/s
    mv "$@"
    while [[ ${a:0:1} = - ]]; do shift; done #>! getopts
    ln -sv $2 $1
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

function hi { history | grep -i $@ | cut -d\  -f5- | uniq | tail ;}
function tailr { tail -f 1 | ruby -ne "BEGIN{$stdin.sync=true}; if /$1/i .match $_; $2; puts $_ end" ;} #== grep --line-buffered

export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
#>? eval "$(lesspipe)"

alias c=$HOME/bin/pcomint
function sshg 	{ [[ ( -z $SSH_AUTH_SOCK ) || ( -x $SSH_AUTH_SOCK ) ]] && . lk; jobs > /tmp/sshg.jobs; eval `. ~/bin/sshg.sh $@` ;}
function g 	{ [[ ( -z $SSH_AUTH_SOCK ) || ( -x $SSH_AUTH_SOCK ) ]] && . lk; jobs > /tmp/sshg.jobs; eval `. ~/bin/sshg.sh $@` ;}
function sshd 	{ [[ ( -z $SSH_AUTH_SOCK ) || ( -x $SSH_AUTH_SOCK ) ]] && . lk; jobs > /tmp/sshg.jobs; eval `. ~/bin/sshd.sh -x $@` ;}

#>! use source ~/text/sc/lib/bash/fn1
function d \
    { [[ ( -z $SSH_AUTH_SOCK ) || ( -x $SSH_AUTH_SOCK ) ]] && . lk;
    jobs > /tmp/sshg.jobs
    TICKET=$2; echo 1>&2 TICKET=$TICKET
    CMD=`. ~/bin/sshd.sh -x $* | perl -pe 's/\@sls\./\@dbkpsas5\./; s/ -v / /'`
    if echo $@ | egrep '^-'; then TICKET=$3; fi # expecting ONLY 1 switch for now
    dtach -n ~/tmp/$TICKET.dtach -z bash
    commit.py $TICKET "PS1='$TICKET:\W$> '"
    commit.py $TICKET "$CMD"
    #>! use aaa.py instead of sleep/ing (blind) task/s
    #>! add also emacsclient request, formulating right .con.log file-name
    (sleep 2; commit.py $TICKET reset; commit.py $TICKET "logger -p user.info $TICKET") &
    dtach -a ~/tmp/$TICKET.dtach -z
    #>! append here map/ws_stop, $FQDN need to be got yet by s/t~> sshd -d -x
    FQDN=`sshd.sh -d -x $1 $TICKET`
    wget -O - "http://wbub-wiki:8080/map/ws_stop.php?h=$FQDN&t=$TICKET"
    echo;}

alias f=$HOME/bin/sshf.sh

#(<) alias fg-mach='eval `~/bin/fg-mach.sh`'
#>! add here (to sshg) detection and handling for /gsni. See also fg-mach
# function sshg
# { . lk #>! move to sshg.sh
#     cmd="ssh sls4root@dbkpsas4.rze.de.db.com -F /home/kraljo/.ssh/1.config -A -t 'sls -c root@$1'"
#     echo $cmd
#     eval $cmd;}

export WORKON_HOME=$HOME/.virtualenvs 
export PIP_VIRTUALENV_BASE=$WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh 
