# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Misc.
HISTSIZE=2000
HISTFILESIZE=2000
complete -C '/usr/local/bin/aws_completer' aws
source /usr/share/bash-completion/completions/git
export EDITOR=vim


# User specific aliases and functions
alias ll='ls -lh --color=auto'
alias lsd='ls --group-directories-first'
alias lst='ls -ltrh'
alias llt='ls -ltrh'
alias lsa='ls -Alh'
alias lsta='ls -Altrh'
alias lsat='ls -Altrh'
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

gitb () {
    git branch $1
}

gita () {
    git add .
    git commit -m "$1"
    git push
}

svim () {    
    # sudo -e $1
        # EDITOR environment variable must be set to vim 
        # once inside vim do :set ft=type, where type is the file type. Ex: :set ft=nginx
    # OR: sudo -Nu /home/robbie/.vimrc $1
    sudo vim $1
        # Once in file, need to do :source /home/robbie/.vimrc
        # Can add nnoremap rvi :source /home/robbie/.vimrc<CR> in the /root/.vimrc
}

vimd () {
    vimdiff $1 $2
}

vdiff () {
    vimdiff $1 $2
}
