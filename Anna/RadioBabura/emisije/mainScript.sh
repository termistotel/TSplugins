#! /bin/bash
export PATH=$PATH:$HOME"/bin"
PUT="/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/RadioBabura"

$PUT/stopMusic.sh
sleep 1
$1
sleep 1
$PUT/startMusic.sh playEndless