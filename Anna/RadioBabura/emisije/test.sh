#! /bin/bash

PUT1="/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/RadioBabura"
PUT=$HOME"/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/RadioBabura/emisije/EmisijePodcastovi/testEmisija"
OPIS="TEST SUSTAVA 20:00. PRVO MP3 PA YOUTUbE"

case "$1" in
	play)
		#pustanje mp3-a:
		TRENUTNI=$(head -1 $PUT"/mp3queue")										#uzima prvu liniju u fajlu mp3queue
		echo -e "\n"$OPIS"\nTrenutno je epizoda: "$TRENUTNI > $PUT1/currentSong	#dodavanje da se opis može vidjet sa "trenutna?"

		echo $PUT"/"$TRENUTNI | xargs cat | playmp3				#playaj taj mp3 
		tail -n +2 $PUT/mp3queue | sponge $PUT/mp3queue			#izbrisi taj mp3 s popisa jer je odslušan
		echo -e $TRENUTNI >> $PUT/mp3finished					#stavi na popis gotovih



		#pustanje linkova s youtube-a
		TRENUTNI=$(head -1 $PUT"/youtubequeue")              											#uzima prvu liniju u fajlu mp3queue
		echo -e "\n"$OPIS"\nTrenutno je epizoda: "$TRENUTNI > $PUT1/currentSong 						#dodavanje da se opis može vidjet sa "trenutna?"

		playyoutube $TRENUTNI																			#skini video s linka, konvertiraj ga u zvuk i pusti
		tail -n +2 $PUT"/youtubequeue" | sponge $PUT"/youtubequeue"										#izbrisi taj link s popisa jer je odslušan
		echo -e $TRENUTNI >> $PUT/youtubefinished														#stavi na popis gotovih

	;;

	description)
		echo -e $OPIS
	;;
esac
