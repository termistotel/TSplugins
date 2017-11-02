#!/bin/bash

find /home/Durda/LUA/ts3Skripte -name "help.txt" -print0 2>/dev/null |
while IFS= read -r -d $'\0' line; do
  name=$(echo $line | sed -rn 's#.*/(.*)/help.txt$#\1#Ip')
  if [ "$1" = "$name" ]; then
    cat $line
  fi
done
