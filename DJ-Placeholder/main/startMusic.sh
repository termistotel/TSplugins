#! /bin/bash

if [ -z "$2" ]; then
  PUT="/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/DJ-Placeholder/main"
else
  PUT=$2/..
fi

case "$1" in
	repopulateQueue)
		find -L $PUT -name "*.mp3*" | sort --random-sort > $PUT/queue
		;;
	playOne)
		#head -1 $PUT/queue | sed 's/ /\\ /g' | xargs mpg123 -o pulse 
		CURRENTSONG=$(head -1 $PUT/queue)
		tail -n +2 $PUT/queue | sponge $PUT/queue
		echo $CURRENTSONG > $PUT/currentSong
		if (echo $CURRENTSONG | grep "^http" > /dev/null); then
			youtube-dl --no-progress -f mp4 $CURRENTSONG -o - | ffmpeg -i - -vn -f s16le - | pacat -d AnnaMouth & echo $! >> $PUT/runningPID 
			youtube-dl --no-progress -f mp4 $CURRENTSONG -o - | ffmpeg -i - -vn -f s16le - | pacat -d DJ-PlaceholderMouth &	echo $! >> $PUT/runningPID
		else
			TMP=$(echo $CURRENTSONG | sed 's/ /\\ /g')
			echo $TMP | xargs cat | mpg123 -o pulse -a AnnaMouth - & echo $! >> $PUT/runningPID
			echo $TMP | xargs cat | mpg123 -o pulse -a DJ-PlaceholderMouth - & echo $! >> $PUT/runningPID
		fi
		;;
	playEndless)
		while :
		do
			while [ -s $PUT/queue ]
			do
				echo $$ > $PUT/runningPID
				CURRENTSONG=$(head -1 $PUT/queue)
				tail -n +2 $PUT/queue | sponge $PUT/queue
				echo $CURRENTSONG > $PUT/currentSong
				if (echo $CURRENTSONG | grep "^http" > /dev/null); then
					youtube-dl --no-progress -f mp4 $CURRENTSONG -o - | ffmpeg -i - -vn -f s16le - | pacat -d AnnaMouth & echo $! >> $PUT/runningPID 
					youtube-dl --no-progress -f mp4 $CURRENTSONG -o - | ffmpeg -i - -vn -f s16le - | pacat -d DJ-PlaceholderMouth &	echo $! >> $PUT/runningPID
				else
					TMP=$(echo $CURRENTSONG | sed 's/ /\\ /g')
					echo $TMP | xargs cat | mpg123 -o pulse -a AnnaMouth - & echo $! >> $PUT/runningPID
					echo $TMP | xargs cat | mpg123 -o pulse -a DJ-PlaceholderMouth - & echo $! >> $PUT/runningPID
				fi
				sleep 2
				#Cekaj dok proces ne zavrsi
				while kill -0 $! 2> /dev/null; do sleep 1; done;
			done

			find -L $PUT -name "*.mp3*" | sort --random-sort > $PUT/queue 
			#repopulate
		done
		;;
esac