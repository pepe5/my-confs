# -*- sh -*-
id='$Id: $'
echo $id

alias ll='ls -lF'
alias la='ls -AF'
alias l='ls -CF'
alias p0='PS1="$> "'
alias p1='PS1="\W$> "'
alias pR='PS1="\W#> "'
alias wget='wget --progress=dot '

alias off='xset dpms force off'
alias swp1='setxkbmap -option ctrl:swapcaps'
alias ri=ri1.8
alias irb='irb --simple-prompt'

alias log='. ~/bin/log.sh'
alias logr="pgrep -l -f 'ruby .*-timestamp'; pkill -f 'ruby .*-timestamp'; pgrep -l -f 'ruby .*-timestamp'"
alias al='dtach -a $(ls -t `find ~ -name "*.dtach"` | head -1) -z'
alias tar-sh='(cd /host/kraljo/dox(!)/text; find . -newer andL -type f)'

. ~/.kraljo_aliases
PATH=$PATH:$HOME/bin:/usr/lib/git-core

export HISTTIMEFORMAT="%F %T "
function hi { history | grep -i $@ | cut -d\  -f7- | uniq | tail ;}
