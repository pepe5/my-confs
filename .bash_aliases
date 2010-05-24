# -*- sh -*-
id='$Id: $'
echo $id

alias ll='ls -lF'
alias la='ls -AF'
alias l='ls -CF'

alias al='dtach -a $(ls -t `find ~ -name "*.dtach"` | head -1) -z'
alias log='. ~/bin/log.sh'
alias wget='wget --progress=dot '
alias ri=ri1.8
alias irb='irb --simple-prompt'
alias logr="pgrep -f 'ruby .*-timestamp'; pkill -f 'ruby .*-timestamp'; pgrep -f 'ruby .*-timestamp'"

alias off='xset dpms force off'
alias swp1='setxkbmap -option ctrl:swapcaps'
alias p0='PS1="$> "'
alias p1='PS1="\W$> "'
alias pR='PS1="\W#> "'

alias tar-sh='(cd /host/kraljo/dox(!)/text; find . -newer andL -type f)'

function hi { history | grep -i $@ | cut -d\  -f4- | uniq | tail ;}
. ~/.kraljo_aliases

export HISTTIMEFORMAT="%F %T "
PATH=$PATH:$HOME/bin:/usr/lib/git-core