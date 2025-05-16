#!/usr/bin/bash

hostname=$(hostname)
if [[ $hostname == "server_name" ]]; then
    echo "Aborting script... run update_user_files instead"
    exit
fi

# turn on extglob (for +([0-9])) and nullglob (so non-matches vanish)
shopt -s extglob nullglob

# glob for /usr/bin/python3.<one or more digits>
candidates=(/usr/bin/python3.+([0-9]))

# pick the highest version, or fall back to plain python3
if (( ${#candidates[@]} )); then
    python_cmd=$(printf '%s\n' "${candidates[@]}" | sort -V | tail -n1)
else
    python_cmd=python3
fi

if [ ! -d /tmp/robbie/working ] || [ ! -L ~/working ]; then
    sudo mkdir -p /tmp/robbie/working
    if groups | grep -qw my_group; then
        sudo chown robbie.robbie -R /tmp/robbie
    else
        sudo chown robbie.robbie -R /tmp
    fi
    ln -nfs /tmp/robbie/working ~/working
fi

if [ ! -d ~/trash_bin ]; then
    mkdir ~/trash_bin
fi

if [ ! -d ~/tmp ]; then
    mkdir ~/tmp
fi

command cp ~/.vimrc ~/tmp
command cp ~/.bashrc ~/tmp

#cat /export/robbie/.bash_eternal_history >> /export/robbie/.bash_eternal_history
command cp /export/robbie/.bashrc /export/robbie/
command cp /export/robbie/.bash_profile /export/robbie/
command cp /export/robbie/.git-prompt.sh /export/robbie/
command cp /export/robbie/.vimrc /export/robbie/

if ! command -v diff-highlight &>/dev/null; then
    echo "no diff-highlight"
    $python_cmd -m pip install diff-highlight
fi

if [ ! -f ~/.gitconfig ]; then
    cp /export/robbie/.gitconfig ~/
fi

mkdir -p /export/robbie/.undodir
sudo mkdir -p /root/.undodir
sudo cp /export/robbie/.vimrc.root /root/.vimrc

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    scp -r server_name:~/.ssh/id_rsa.pub ~/.ssh/
    scp -r server_name:~/.ssh/id_rsa ~/.ssh/
fi

command -v vim >/dev/null || sudo dnf install -y vim

source /export/robbie/.bash_profile
#bash -l
