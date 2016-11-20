#! /bin/bash

if [ -z "$2" ]; then
  PUT="/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/RadioBabura"
else
  PUT=$2/..
fi

echo "Stopping Music"

while [ -s $PUT/runningPID ]
do
  kill -SIGTERM $(head -1 $PUT/runningPID)
  tail -n +2 $PUT/runningPID | sponge $PUT/runningPID
done
#ps ax | grep "intercept.py" | grep -v grep | cut -c-5 | tr '\n' ' '

kill $(ps ax | grep "intercept.py" | grep -v grep | cut -c-5 | tr '\n' ' ')

#echo "Stopping Music"
#if (ps ax | grep "$BOTNAME" | grep "startMusic.sh" | grep -v grep  > /dev/null); then
#  kill -SIGTERM $(ps ax | grep "$BOTNAME" | grep "startMusic.sh" | grep -v grep  | cut -c-5 | tr '\n' ' ')
#  kill -SIGTERM $(ps ax | grep "$BOTNAME" | grep "mpg123" | grep -v grep  | cut -c-5 | tr '\n' ' ')
  
#  if (ps ax | grep "youtube-dl" | grep -v grep > /dev/null); then
#    kill -SIGTERM $(ps ax | grep "youtube-dl" | grep -v grep  | cut -c-5 | tr '\n' ' ')
#  fi

#  if (ps ax | grep "$BOTNAME" | grep "startMusic.sh" | grep -v grep  > /dev/null); then
#    echo "Normal kill failed, trying aggressively..."
#    kill -SIGKILL $(ps ax | grep "$BOTNAME" | grep "startMusic.sh" | grep -v grep | cut -c-5 | tr '\n' ' ')
#      if (ps ax | grep "$BOTNAME" | grep "startMusic.sh" | grep -v grep > /dev/null); then
#        echo "Couldn't kill"
#      else
#        echo "Killed aggressively"
#      fi
#  fi
#else
#  echo "$BOTNAME not running"
#fi
