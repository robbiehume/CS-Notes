#!/usr/bin/bash

# Exit if an error occurs
set -e

error_handler() {
  echo -e "\nAn error occurred on line $1. Exiting..."
  exit 1
}

# Trap errors and call error_handler with the line number
trap 'error_handler $LINENO' ERR

if [[ "$EUID" -ne 0 ]]; then
   echo -e "Script must be run as root\nPlease try running it again with sudo: \"sudo bash install_script.sh\""
   exit
fi

get_service_status (){
    stat=$(sudo systemctl status $1)
    echo "-----------------------------"
    if [[ $stat == *"inactive"* || $stat == *"failed"* ]]; then
        echo "$stat" | grep -E --color "\b(inactive|dead|failed)\b|$"
    else
        export GREP_COLORS='ms=01;32'
        echo "$stat" | grep -E --color "\b(active|running)\b|$"
    fi
    export GREP_COLORS=''
    echo "-----------------------------"
}
