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
#>! alias sl=list (here connected) sessions

alias rk="while true; do wmctrl -a 'rdesktop'; sleep 1; wmctrl -a 'keepalive'; sleep 1000; done &" # (R)desktop- (K)eepalive
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

function rediff \
    { echo A=$1
    echo B=$2
    diff -rq $1 $2 | ruby1.8 -ane 'if /Files (.*) and (.*) differ$/; puts "ediffer #{$1} #{$2}" else puts "# (#{$F[-1]})" end'
    echo; }

function dsync \
    { echo A=$1
    echo B=$2
    diff -rq $1 $2 | ruby1.8 -ane '
    BEGIN {O=/Only in (.*) differ|Files (.*) and/; }
    puts "* #{O}"
    p $F
    if !/Only in $2/; $_ .match O; puts %Q{cp -vf #{$1}} end '
    echo; }

alias log='. ~/bin/log.sh'
alias logr="pgrep -l -f 'ruby .*-timestamp'; pkill -f 'ruby .*-timestamp'; pgrep -l -f 'ruby .*-timestamp'"
alias al='dtach -a $(ls -t `find ~ -name "*.dtach"` | head -1) -z'
alias tar-sh='(cd /host/kraljo/dox(!)/text; find . -newer andL -type f)'

# //user.it.uu.se/~matkin/documents/shell/
function forwhich \
    { ( IFS=: ; for D in $PATH; do for F in $D/"$1"; do [ -x $F ] && echo $F; done; done ) ; }

if [ -f ~/.kraljo_aliases ]; then
    . ~/.kraljo_aliases
    PATH=$PATH:$HOME/bin:/usr/lib/git-core
fi

export JAVA_HOME=/usr/lib/jvm/java-6-openjdk # /usr/lib/jvm/jdk1.6.0_22
export PATH=$PATH:$JAVA_HOME/bin

export HISTTIMEFORMAT="%F %T "
function hi { history | grep -i $@ | cut -d\  -f5- | uniq | tail ;}
function tailr { tail -f 1 | ruby -ne "BEGIN{$stdin.sync=true}; if /$1/i .match $_; $2; puts $_ end" ;} #== grep --line-buffered
