# .bashrc

## Best .bashrc's
# https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c
# https://www.reddit.com/r/commandline/comments/9md3pp/a_very_useful_bashrc_file/

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Auto completions
#    bash_completion may need to be installed
complete -C '/usr/local/bin/aws_completer' aws
source /usr/share/bash-completion/completions/git
complete -W 'httpd apache nginx' starts stops restarts statuss

# Misc.
export EDITOR=vim
# shopt commands
shopt -s cdspell dirspell direxpand extdebug


# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
HISTSIZE= #5000
HISTFILESIZE= #5000
HISTTIMEFORMAT="[%F %T]:  "
HISTIGNORE='ll':'lsa':'lst':'ls':'cdb':'cdh'
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command (useful for when you have multiple ssh sessions open)
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# If wanting to refresh history, do bash -l to get history of other open sessions

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon


#######################################################
# GENERAL ALIASES
#######################################################

# Aliases to list directory files
alias sl='ls'
#alias l='ls'
#alias s='ls'
#alias lo='ls -o'
alias ll='ls -lh --color=auto'
alias lsd='ls --group-directories-first'
alias lst='ls -ltrh'
alias llt='ls -ltrh'
alias lsa='ls -Alh'
alias lsta='ls -Altrh'
alias lsat='ls -Altrh'
alias lsg='ls -ltrh | grep -i '
alias lsgrep='ls -ltrh | grep -i '

# Aliases to change directory
alias cdb='cd -'
alias cdh='cd ~'
alias ...='cd ../..'
alias ....='cd ../../..'
# Move 'up' so many directories instead of using several cd ../../, etc.
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }
alias docs='cd ~/Documents'
alias downs='cd ~/Downloads'

# Aliases to modified commands
alias cp='cp -i' # -v?
alias mv='mv -i' # -v?
alias mkdir='mkdir -p'
alias diff='diff --color'
alias cls='clear'
alias rmd='rm -rfv'
alias svim='sudo vim -c "source /home/robbie/.vimrc"'
alias his='history'

# Edit .bashrc / .vimrc
alias vbrc='vim ~/.bahrc'
alias sbrc='. ~/.bashrc'
alias vrc='vim ~/.vimrc'

# Search files in the current folder
alias findg='find . | grep '

# Search command line history
#alias hg='history | grep '

# Search running processes
alias psg='ps aux | grep '
alias psa='ps aux'

# Git aliases
alias gits='git status' # or gs
alias gitb='git branch' # or gb
alias gitd='git diff' # or gd
alias gcm='git checkout main'
alias gmm='git merge main'
gita () {
    git add .
    git commit -m "$1"
    git push
}


# Variables


#######################################################
# SPECIAL FUNCTIONS
#######################################################
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

cdl (){
    cd $1; ll
}

#svim () {    
    # sudo -e $1
        # EDITOR environment variable must be set to vim 
        # once inside vim do :set ft=type, where type is the file type. Ex: :set ft=nginx
    # OR: sudo -Nu /home/robbie/.vimrc $1
#    sudo vim $1
        # Once in file, need to do :source /home/robbie/.vimrc
        # Can add nnoremap rvi :source /home/robbie/.vimrc<CR> in the /root/.vimrc
#}

vimd () {
    vimdiff $1 $2
}

vdiff () {
    vimdiff $1 $2
}

svd () {
    sudo vimdiff -c "source /home/robbie/.vimrc" $1 $2
}

restarts (){
    sudo service $1 restart; sudo service $1 status
}

statuss (){
    sudo service $1 status
}

stops (){
    sudo service $1 stop; sudo service $1 status
}

starts (){
    sudo service $1 start; sudo service $1 status
}
