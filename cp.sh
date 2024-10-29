#!/bin/bash


#if [ "$#" -lt 2 ]; then
#    echo "Usage: cpr SOURCE DEST"
#    exit 1
#fi

if [ -d "$1" ]; then
  command cp -r -i --preserve=mode,timestamps "$@"
else
  command cp -i --preserve=mode,timestamps "$@"
fi

#if [ $(whoami) == 'root' ]; then
#  chown -R dev_icrhume1.dev_icrhume1 ${@: -1}
#fi
