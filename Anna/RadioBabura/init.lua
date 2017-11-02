require("ts3init")
unrequire("Anna/RadioBabura/treee")
require("Anna/RadioBabura/treee")


local songLoc = ts3.getPluginPath().."lua_plugin/Anna/RadioBabura/pjesme"
local plugLoc = ts3.getPluginPath().."lua_plugin/Anna/RadioBabura"
local dirLoc = ts3.getPluginPath().."lua_plugin/Anna"
local rasporedLoc = ts3.getPluginPath().."lua_plugin/Anna/RadioBabura/emisije"

local requestPopis = ucitajPjesme("plugins/lua_plugin/Anna/burzum/pjesme.txt")

local function randomElement(acc)
  return acc[math.random(#acc)]
end

local function pocisti(a)
  local tmp
  if string.match(a,"^%[URL%]") then tmp = string.sub(a,6,-1) end
  if string.match(tmp,"%[%/URL%]") then tmp = string.sub(tmp,1,-7) end
  return tmp
end

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
  local tmp = handle:read("*a")
  handle:close()
  if tmp ~= nil then if string.match(tmp, "\n$") then tmp = string.sub(tmp,1,-2) end end
  return tmp
end

local function inList(b, as)
  if (type(as)~="table") then return false end
  for _,a in ipairs(as) do
    if b == a then return true end
  end
  return false
end



local function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
  local myID = ts3.getClientID(serverConnectionHandlerID)
   local myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)
  logPrint(status)
  if status == 4 then
    unmuteSelf()
    ts3.requestClientMove(serverConnectionHandlerID, myID, 477, "")
    ts3.flushClientSelfUpdates(serverConnectionHandlerID)
    math.randomseed(os.time())
  end
  
  return 0
end

local function stopMusic()
  return shellKomanda(plugLoc.."/stopMusic.sh")
end

local function pokreniRandom(location)
  local pjesme = {}
  for val in string.gmatch(shellKomanda("ls "..location), "([^\n]+)") do
    if val ~= nil then pjesme[#pjesme+1] = val end
  end
  local tmpPjesam = pjesme[math.random(#pjesme)]
  shellKomanda("mpg123 -o pulse \""..location.."/"..tmpPjesam.."\"".." &")
  return tmpPjesam
end

local function pokreniSve(location)
  --return shellKomanda("find -L "..location.." -name \"*.mp3\" | xargs -d '\n' mpg123 -o pulse -Z &")
  --shellKomanda(location.."/startMusic.sh repopulateQueue")
  shellKomanda(location.."/startMusic.sh playEndless &")
  return 0
end

local function ubaciQueue(a)
  local file = io.open (plugLoc.."/queue", "r")
  local tmp = file:read("*all")
  file:close()
  file = io.open(plugLoc.."/queue", "w")
  file:write(a.."\n"..tmp)
  file:close()
end

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
  local myID = ts3.getClientID(serverConnectionHandlerID)
  local myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)

  if (fromID~= myID) then

    if (message == "refresh") then
      shellKomanda(plugLoc.."/startMusic.sh repopulateQueue")
    end

    if (message == "radio stop") then
      posaljiPoruku(stopMusic(),fromID,targetMode)
    end

    if (message == "radio start") then
      stopMusic()
      shellKomanda(plugLoc.."/startMusic.sh playEndless &")
      --pokreniSve(plugLoc)
    end

    if (message == "radio play") then
      stopMusic()
      shellKomanda(plugLoc.."/startMusic.sh playOne")
    end

    if (message == "trenutna ?") or (message == "trenutna?") then
			local songName = shellKomanda("cat "..plugLoc.."/currentSong")
			if string.match(songName, "^https?://") then
      	posaljiPoruku("[url]"..songName.."[/url]", fromID,targetMode)
			else
      	posaljiPoruku(songName, fromID,targetMode)
			end
    end

    if (message == "decode note") then
    	local text = shellKomanda("cat "..plugLoc.."/.raenote")
    	posaljiPoruku(string.sub(text,1,1013),fromID,targetMode)
    	posaljiPoruku(string.sub(text,1014,1014+879),fromID,targetMode)
    	posaljiPoruku(string.sub(text,1014+880,1014+879+862),fromID,targetMode)
    	posaljiPoruku(string.sub(text,1014+880+862,nil),fromID,targetMode)
    end

    local a = string.match(message,"^request (.+)$")
    if a then
      local matches = {}
      local svePjesme = {}
      nadiDobre(a,requestPopis,matches,nil,0.5)
      if (#matches>0) then
        for _,k in ipairs(matches) do sviLeafovi(k,svePjesme) end
        local match = randomElement(svePjesme)
        posaljiPoruku("You requested: "..match[1],fromID,targetMode)
        ubaciQueue(match[2])
      else
        posaljiPoruku("Nema toga", fromID, targetMode)
      end
    end

    if (message == "next") then
      stopMusic()
      shellKomanda(plugLoc.."/startMusic.sh playEndless &")
    end

  end
  return 0
end




--Ucitavanje rasporeda
local tmp = ""
local tmp1= ""
local tmp2= ""

local file = io.open (rasporedLoc.."/raspored", "r")
for line in file:lines() do
  if not string.match(line,"^#") then
    tmp1= string.match(line, "^([^%s]+%s+[^%s]+%s+[^%s]+%s+[^%s]+%s+[^%s]+%s+)")
    tmp2= string.match(line, "^[^%s]+%s+[^%s]+%s+[^%s]+%s+[^%s]+%s+[^%s]+%s+(.+)")
    tmp = tmp..tmp1..rasporedLoc.."/mainScript.sh ".."\\\""..rasporedLoc.."/"..tmp2.."\\\"".. "\n"
  end
end
shellKomanda("echo \""..tmp.."\" | crontab -")


local registeredEvents = {
  onTextMessageEvent = onTextMessageEvent,
  onConnectStatusChangeEvent = onConnectStatusChangeEvent
}



ts3RegisterModule("RadioBabura", registeredEvents)
