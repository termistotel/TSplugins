#!/bin/bash

echo -e "\nDokumentacija je dostupna za sljedece pluginove: "

find /home/Durda/LUA/ts3Skripte -name "help.txt" -print0 2>/dev/null |
while IFS= read -r -d $'\0' line; do
  line=$(echo $line | sed -rn 's#.*/(.*)/help.txt$#\1#Ip')
  echo -e "\t- $line"
done

echo -e "\nZa citanje dokumentacije plugina, potrebno je napisati: "
echo -e "\thelp ime_plugina"

