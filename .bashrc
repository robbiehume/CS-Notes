# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ll='ls'
alias lsd='ls --group-directories-first'
alias lst='ls -ltrh'
alias lsa='ls -al'
alias lsta='ls -altrh'
alias lsat='ls -altrh'
alias cdback='cd -'
alias cdb='cd -'
alias docs='cd ~/Documents'
alias downs='cd ~/Downloads'

# Variables

# Functions
lstt (){
	if [ $# -eq 2 ]
	then
			ls -ltrh $1 | tail -$2
	elif [ $# -eq 1 ]
	then
			if [ -d $1 ]
			then
					ls -ltrh $1 | tail
			else
					ls -ltrh | tail -$1
			fi
	else
			ls -ltrh | tail
	fi
}


cdls (){
	cd $1; ls
}

cdlst (){
    cd $1; lst
}

lsgrep (){
    ls -ltr | grep -i $1
}


# Git
alias gits='git status'

gitd () {
    git diff $1
}  

gita () {
    git add .
    git commit -m "$1"
    git push
}
