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
complete -W 'httpd apache nginx' starts stops restarts statuss isactive


# VARIABLES
#export PYTHONUSERBASE=/home/dev_icrhume1/working/bin/


# Misc.
export EDITOR=vim
export H=~

# shopt commands
shopt -s cdspell dirspell #direxpand extdebug


# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
HISTSIZE= #5000
HISTFILESIZE= #5000
HISTTIMEFORMAT="[%F %T]:  "
HISTCONTROL=ignoredups
#HISTIGNORE='ll':'lsa':'lst':'ls':'cdb':'cdh':'vbrc':'sbrc':'vrc'
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command (useful for when you have multiple ssh sessions open)
# http://superuser.com/questions/20900/bash-history-loss
#shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# If wanting to refresh history, do bash -l to get history of other open sessions

# Allow ctrl-S for history navigation (with ctrl-R)
[[ $- == *i* ]] && stty -ixon

#######################################################
# GENERAL ALIASES
#######################################################

# Aliases to list directory files
alias ll='sudo ls -lh --color'
alias ls='sudo ls --color'
alias slt='sudo ls -ltrh --color'
alias sl='sudo ls --color'
#alias l='ls'
#alias s='ls'
#alias lo='ls -o'
alias {lst,llt}='sudo ls -ltrh --color'
alias lsa='sudo ls -Alh --color'
alias lsta='sudo ls -Altrh --color'
alias lsg='lst| grep -i '
alias lsgrep='lst | grep -i '

# Aliases to change directory
alias cdb='cd -; ll'
alias cdh='cd ~; ll'
alias cd..='cd ..; ll'
alias cd...='cd ../..; ll'
alias ...='cd ../..'
alias ....='cd ../../..'
# Move 'up' so many directories instead of using several cd ../../, etc.
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }
alias docs='cd ~/Documents'
alias downs='cd ~/Downloads'

# Aliases to modified commands
alias suroot='sudo bash --init-file /home/robbie/.bashrc' # allows for root shell with user .bashrc
alias cp='cp -i' # -v?
alias cpp='/usr/bin/cp'
alias mv='mv -i' # -v?
alias mvv='/usr/bin/mv'
alias mkdir='mkdir -p'
alias diff='diff --color'
alias sdiff='sudo diff --color'
alias svdiff='sudo vimdiff -c "source /home/robbie/.vimrc"'
alias cls='clear'
alias rmd='rm -rfv'
alias cim='vim'
alias vi='vim'
alias tail='sudo tail'
alias tailf='sudo tail -F'

# sudo aliases
alias sudo='sudo '   # allows for sudo to run aliases
alias svim='sudo vim -c "source /home/robbie/.vimrc" '
alias srm='sudo rm'
alias smv='sudo mv'
alias sln='sudo ln'
alias sdr='sudo systemctl daemon-reload'

# tail functions
tailj () {
    if [[ $# -eq 1 ]]
    then
        sudo tail $1 | grep -o '{[^}]*}' | jq
    elif [[ $# -eq 2 ]]
    then
        sudo tail -F $2 | jq
    fi
}

# Run last command (Similar to !!)
#    Can pass a parameter to run the first command that matches it
#        Ex: 'pp v' will run last command that starts with v
#    If nothing is provided, it will run the last command
alias {rr}='fc -s'  # or just r?
alias pp='fc -s -2'    # run 2nd to last command
alias ppp='fc -s -3'    # run 2nd to last command

pf () {
    #cat ~/.bash_eternal_history | grep $1 | tail -1
    re='^[0-9]+$'
    if [[ $# -eq 0 ]]
    then
        fc -s
    #elif ! [[ $1 =~ $re ]]
    #then
    #    echo "elif"
    #    #fc -s -$1
    else
        eval "$(cat ~/.bash_eternal_history | grep $1 | tail -1)"
    fi
}

# Edit .bashrc / .vimrc
alias vbrc='vim ~/.bahrc'
alias sbrc='. ~/.bashrc'
alias vrc='vim ~/.vimrc'

# See currently used ports
alias ports='sudo netstat -tulpn | grep LISTEN | grep ":[0-9]*"'

# Search files in the current folder
alias findg='find . | grep '

# See bash command line history
alias his='history'
alias hist='history | tail'
alias {hg,gh}='history | grep '
alias vhis='vim ~/.bash_eternal_history'

# Search running processes
alias psg='ps aux | grep '
alias psa='ps aux'
alias js='jobs'
alias fgg='fg ~'

# Git aliases / functions
#export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa -o 'IdentitiesOnly yes'" # Make git use ssh key instead of cert
alias cdg='cd `git rev-parse --show-toplevel`' # cd to git project top-level directory
alias {gits,gs}='git status'
alias gita='git add' # or ga
alias gitb='git branch' # or gb
alias {gitd,gd}='git fetch'
alias {gitd,gd}='git diff --no-index'
alias gdi='git diff'
alias gdm='git diff --diff-filter=M'
alias {gitdc,gdc}='git diff --cached'
alias gdcm='git diff --cached --diff-filter=M'
alias {gcr,gci}='git checkout dev_branch'
alias gcm='git checkout main'
alias gmm='git merge main'
alias gcmm='git checkout main; git merge icrhume1'
alias {gpcm,gpm}='git push; gcmm'
alias {gmr,gmi}='git merge dev_branch'
alias {gpush,gitp}='git push'
alias pullmain='cd `git rev-parse --show-toplevel` && git checkout main && git pull'  # cd to top level directory, checkout main, and pull
alias pushmain='git push; git checkout dev_branch'
glh () {
    if [[ $# -eq 0 ]]
    then
        git log | head -n 10
    else
        git log | head -n $1
    fi
}
com () {
    git commit -m "$@"
}
gac () {
    git add .
    git commit -m "$@"
}
gacp () {
    gac $@
    git push
}
add () {
    if [ $# -eq 0 ]
    then
        git add .
    else
        git add $@
    fi
}


##### Misc. aliases
alias {nt,ngt}='sudo nginx -t'

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

cl (){
    cd $1; ll
}

mkcd (){
    mkdir -p $1; cd $1; pwd
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

getvar (){ # output the value of a variable
    local first=${!1:-"$1"}
    shift
    command echo "$first" "$@"
}

vimd () {
    vimdiff $1 $2
}

vdiff () {
    vimdiff $1 $2
}

svd () {
    sudo vimdiff -c "source /home/robbie/.vimrc" $1 $2
}

rmt (){
    mv -v $1 ~/trash_bin
}

restarts (){
    sudo systemctl restart $1; isactive $1 #sudo systemctl status $1
}

statuss (){
    sudo systemctl status $1
}

isactive (){
    stat=$(sudo systemctl status $1)
    if [[ $stat == *"inactive"* ]]; then
        echo "$stat" | grep -E --color "\b(inactive|dead)\b|$"
    else
        export GREP_COLORS='ms=01;32'
        echo "$stat" | grep -E --color "\b(active|running)\b|$"
    fi
    export GREP_COLORS=''
}

stops (){
    sudo systemctl stop $1; isactive $1
}

starts (){
    sudo systemctl start $1; isactive $1
}
