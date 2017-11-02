require("ts3init")
unrequire("Anna/mojaskripta/strMatch")
require("Anna/mojaskripta/strMatch")

debug.sethook()

spm=10
local function posaljiPoruku(poruka, fromID, targetMode)
  local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
  local myID = ts3.getClientID(serverConnectionHandlerID)
    if targetMode == 1 then
      ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, poruka, fromID)
      return 0
  else
    ts3.requestSendChannelTextMsg(serverConnectionHandlerID, poruka, ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        return 0
    end
end

local function shellKomanda(komanda)
  local handle = io.popen(komanda .. " 2>&1")
	tmp = handle:read("*a")
	handle:close()
	if string.match(tmp, "\n$") then tmp = string.sub(tmp,1,-1) end
	return tmp
end

local function inList(b, as)
  if (type(as)~="table") then return false end
  for _,a in ipairs(as) do
    if b == a then return true end
  end
  return false
end

local pool1 = {"Imam dobrog baca", "prica se po kvartu da trebate neke senzacije",
  "pa daaa...", "buraz, tebi nije brodo", "kakve su ovo drolje", "buraz, daj si spopravi to",
  "jeben ti je ovaj tiket buraz", "daj da ti zalimpam"}

local poolLenny = {}    
poolLenny[1] = {"velik","oh my","daj mi ga","dijete", "djete", "djeca","vrtić", "masan", "ak me bereš"}
poolLenny[2] = {"( ͡° ͜ʖ ͡°)"}

local poolDunno = {}    
poolDunno[1] = {"ne znam", "neznam", "kajaznam","kaja znam", "kaj ja znam", "who knows", "nikad neznaš", "you never know"}
poolDunno[2] = {"¯_(ツ)_/¯", "¯\\_(ツ)_/¯"}

local poolGoodgod = {}
poolGoodgod[1] = {"good god", "good lord", "great scott", "lordy", "lawd"}
poolGoodgod[2] = {"( •_•)>⌐■-■"}

local poolSummoncthulhu = {}
poolSummoncthulhu[1] = {"that is not dead which can eternal lie", "and with strange aeons even death may die"}
poolSummoncthulhu[2] = {"╭(◕◕ ◉෴◉ ◕◕)╮", "(屮｀∀´)屮", "ƪ(`▿▿▿▿´ƪ)"}

local quran_quotes = {"[I]And fight them until there is no Fitnah and the religion, all of it, is for Allah.[/I] [Quran 8:39]", 
                      "[I]Obey Allah and His Messenger; But if they turn back, then surely Allah does not love the unbelievers.[/I] [Quran 3:32]", 
                      "[I]Be not weary and faint-hearted, crying for peace, when ye should be uppermost, for Allah is with you.[/I] [Quran 47:35]", 
                      "[I]Let those fight in the way of Allah who sell the life of this world for the other. Whose fighteth in the way of Allah, be he slain or be he victorious, on him We shall bestow a vast reward.[/I] [Quran 4:74]", 
                      "[I]Indeed, Allah has purchased from the believers their lives and their properties for that they will have Paradise. They fight in the cause of Allah, so they kill and are killed.[/I] [Quran 9:111]", 
                      "[I]I will cast terror into the hearts of those who disbelieve. Therefore strike off their heads and strike off every fingertip of them.[/I] [Quran 8:12]", 
                      "[I]If thou comest on them in the war, deal with them so as to strike fear in those who are behind them, that haply they may remember.[/I] [Quran 8:57]", 
                      "[I]Fight against them so that Allah will punish them by your hands and disgrace them and give you victory over them and heal the breasts of a believing people.[/I] [Quran 9:14]", 
                      "[I]Go forth, light-armed and heavy-armed, and strive with your wealth and your lives in the way of Allah! That is best for you if ye but knew.[/I] [Quran 9:41]", 
                      "[I]Therefore listen not to the Unbelievers, but strive against them with the utmost strenuousness.[/I] [Quran 25:52]", 
                      "[I]I have been commanded to fight against people till they testify that there is no god but Allah, that Muhammad is the messenger of Allah.[/I] [Muslim 1:33]", 
                      "[I]Know that Paradise is under the shades of swords.[/I] [Bukhari 52:73]"}


local function onTextMessageEventttt(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    tmp = ts3.getClientList(serverConnectionHandlerID)
    myID = ts3.getClientID(serverConnectionHandlerID)
    myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)

    --for i,v in ipairs(tmp) do print(v) end

    --Mijenjaj moj opis

    
    --math.randomseed(os.time())
    --time_check = os.clock()
    


    if (fromID~= myID) then

      if message=="test" then
      	coroutine.resume(co)
      	coroutine.resume(co)
      end

      if (strMatchPerfect(string.lower(string.sub(message,1,20)),"muteaj se") > 0.37) then
        if string.match(string.lower(message),"od") then
          unmuteSelf()
          ts3.flushClientSelfUpdates(serverConnectionHandlerID)
        else
          muteSelf()
          ts3.flushClientSelfUpdates(serverConnectionHandlerID)
        end
      end


      if (message == "control your spam") then
          if (spm==0) then 
              posaljiPoruku("Spam is ON", fromID, targetMode)
              spm=10
          else
              posaljiPoruku("Spam is OFF", fromID, targetMode)
              spm=0
          end
      end


      if (spm == 0) then return 0 end

      a = string.match(message,"^testKomanda")
      if (a) then
        posaljiPoruku("Dragi korisnice, ovo jos nije implementirano. Hvala Vam na razumijevanju.", fromID, targetMode)
        --os.execute("sqlite3 ~/.ts3client/settings.db \"update Profiles set value='Mode=PulseAudio' || x'0a' || 'Device=NAME-ear' || x'0a' || 'DeviceDisplayName=NAME-ear' where key='Playback/Default';\"")
        posaljiPoruku(shellKomanda("echo $PULSE_SINK"), fromID, targetMode)
      end

      
      if string.match(string.lower(message), "babura") then
        posaljiPoruku(pool1[math.random(#pool1)], fromID, targetMode)
      end

      if string.match(string.lower(message), "jihad?") then
        posaljiPoruku(quran_quotes[math.random(#quran_quotes)], fromID, targetMode)
      end
      

      
      if string.match(string.lower(message), "hahah") then
        posaljiPoruku("[b]Brutal. Savage. Rekt.[/b]", fromID, targetMode)
      end

	if string.match(string.lower(message), "peki mi cio") then
        posaljiPoruku("hula hularem", fromID, targetMode)
      end

  if string.match(string.lower(message), "mijau") then
        posaljiPoruku("Vau Vau! Grrr...!", fromID, targetMode)
      end

  if (message == "polish") then
    posaljiPoruku("ą Ą  ę Ę  ł Ł  ń Ń  ó Ó  ś Ś  ź Ź  ż Ż", fromID, targetMode)
    end

  if string.match(string.lower(message), "sacred land") then
        posaljiPoruku("卐", fromID, targetMode)
      end

      if (string.match(string.lower(message), "i have..")) then
        posaljiPoruku("... [url=https://www.youtube.com/watch?v=6qJ1E8EljVM]returned[/url].", fromID, targetMode)
        return 0
      end

      if (message == "carrier..") or (message == "Carrier..") then
        posaljiPoruku("... [url=https://www.youtube.com/watch?v=2vj37yeQQHg]has arrived[/url].", fromID, targetMode)
      end

      if (message == "stay awhile..") or (message == "Stay awhile..") then
        posaljiPoruku("... [url=https://www.youtube.com/watch?v=tAVVy_x3Erg]and listen[/url].", fromID, targetMode)
      end
      if (message == "češć") then
        posaljiPoruku("Cześć! Jak się masz?", fromID, targetMode)
      end
      


      --Emoji
      for i,k in ipairs(poolLenny[1]) do
        if string.match(string.lower(message),k) then
          posaljiPoruku(poolLenny[2][math.random(#poolLenny[2])],fromID,targetMode)
          break
        end
      end

      for i,k in ipairs(poolDunno[1]) do
        if string.match(string.lower(message),k) then
          posaljiPoruku(poolDunno[2][math.random(#poolDunno[2])],fromID,targetMode)
          break
        end
      end

      for i,k in ipairs(poolGoodgod[1]) do
        if string.match(string.lower(message),k) then
          posaljiPoruku(poolGoodgod[2][math.random(#poolGoodgod[2])],fromID,targetMode)
          break
        end
      end

      for i,k in ipairs(poolSummoncthulhu[1]) do
        if string.match(string.lower(message),k) then
          posaljiPoruku(poolSummoncthulhu[2][math.random(#poolSummoncthulhu[2])],fromID,targetMode)
          break
        end
      end

      if string.match(string.lower(message),"fali ti.+\\") or string.match(string.lower(message),"fali joj.+\\") or string.match(string.lower(message),"fali ti.+ruka") or string.match(string.lower(message),"fali joj.+ruka") then
        posaljiPoruku("Hvala! ¯_(ツ)_/¯\\",fromID,targetMode)
      end

     

    end

    return 0
end

local registeredEvents = {
  onTextMessageEvent = onTextMessageEventttt
}



ts3RegisterModule("mojaskripta", registeredEvents)
