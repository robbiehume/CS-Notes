# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias gh='getent hosts'
#alias tsilk='sudo ssh -t test-silk "cd /home/tiuser/tempRobbie; su tiuser"'
alias tsilk='sudo ssh -t test-silk "su - tiuser"'
alias thsilk='sudo ssh -t test-hud-silk "su - tiuser"'
alias tsecsilk='sudo ssh -t test-scsilk "su - tiuser"'
alias tdb='sudo ssh -t test-dbloader "su - tiuser"'
alias tsp='sudo ssh -t test-sprocessor "su - tiuser"'
alias bend='cd /home/rh0863/workspace/BACKEND/Backend/Cloud/src; ls'
alias getsrc='ls /home/rh0863/workspace/BACKEND/Backend/Cloud/src'
#alias ll='ls'
alias lsd='ls --group-directories-first'
alias lst='ls -ltr'
alias cdback='cd -'
alias cdcr='cd /home/rh0863/country_report; lst'
alias clearlogs='rm /home/rh0863/logging/logs/* 2>/dev/null; rm /home/rh0863/logging/psv_logs/* 2>/dev/null; rm /home/rh0863/logging/splunk/* 2>/dev/null'

# Variables
bsrc=/home/rh0863/workspace/BACKEND/Backend/Cloud/src 

# Functions
lstt (){
	if [ $# -eq 2 ]
	then
			ls -ltr $1 | tail -$2
	elif [ $# -eq 1 ]
	then
			if [ -d $1 ]
			then
					ls -ltr $1 | tail
			else
					ls -ltr | tail -$1
			fi
	else
			ls -ltr | tail
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

ghgrep (){
	getent hosts | grep $1
}

rssh() {
	sudo ssh -t $1 "cd /home/tiuser/tempRobbie; su tiuser"
}

rscp() {
	sudo scp $3 $2 tiuser@$1:/home/tiuser/tempRobbie/$4
}

scpsilk() {
	sudo scp $3 $1 tiuser@test-silk:/home/tiuser/tempRobbie/$2
}

scplog() {
	sudo scp -r /home/rh0863/logging tiuser@test-silk:/home/tiuser/tempRobbie/$1
}

scpthreat() {
	sudo scp /home/rh0863/cust_threat/threat_ip_report.py tiuser@test-secsilk:/home/tiuser/tempRobbie/cust_threat
}

update_vimrc() {
	sudo scp ~/.vimrc tiuser@test-silk:/home/tiuser/tempRobbie/.vimrc_	
	sudo scp ~/.vimrc tiuser@test-dbloader:/home/tiuser/tempRobbie/.vimrc_	
}
