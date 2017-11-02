import urllib2
import json
import time
import sys

apiurl = "https://euw.api.pvp.net/api/lol/eune/v1.3/game/by-summoner/22840392/recent?api_key=RGAPI-611898ae-067d-487f-800d-ca5b834721af"
put = "/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/LOLwatch"


def podaci(url):
	response = urllib2.urlopen(url).read().decode("utf-8")
	return json.loads(response.decode("utf-8"))

proslaIgra = podaci(apiurl)["games"][0]

while True:
	time.sleep(60)
	novo = podaci(apiurl)
	if not(novo["games"][0]["gameId"] == proslaIgra["gameId"]):
		f = open(put+"/igre","aw")
		f.write(str(novo["games"][0]["gameId"]) +"\t" + str(novo["games"][0]["stats"]["win"])+"\n")
		f.close()
		proslaIgra=novo["games"][0]