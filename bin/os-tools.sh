# -*- utf-8 -*-

function du-sort { nice du -s $1 2>/dev/null | sort -rn | awk '{print $2}' | xargs du -sh 2>/dev/null | head; }
# 11G     /home/ttt
# 1.2G    /home/tester
# 290M    /home/kraljo
# 109M    /home/loydlr
# 0       /home/follnerr
# 0       /home/devel

function off-host \
    { n=$(ssh -l root $@ echo 2>&1 | grep -i offending | cut -d: -f2); echo $n
    perl -i~ -ne "$. == $n or print" ~/.ssh/known_hosts; }

function grep-rpm-files \
    { find . -name "*.rpm" | while read i
    do echo pkg: $i ..;
	rpm2cpio "$i" | cpio -id
	find ./ -not -type f -name "*.cache" -exec fgrep -i 'Telephone</option>' "{}" \; -print
	# rm -rf *
    done; }

function grep-rpms \
    { rpm -qa | grep upower | while read i;
    do rpm -ql $i | while read fname;
	do [ -f $fname ] && grep -Hn 'Telephone' $fname && echo -- $i; done; done; }

function anti-word \
    { wget -P /usr/share/antiword/ http://unicode.org/Public/MAPPINGS/ISO8859/8859-2.TXT
    antiword -m 8859-2 /mnt/win/temp/Pr.doc | iconv -f latin2 -t utf8; }

alias sshfs='sshfs -o idmap=user -o allow_other '
#~> kraljo@jubiler:/ ~/mnt/kraljo\@jubiler/
