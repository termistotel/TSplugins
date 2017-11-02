require("ts3init")

local plugLoc = ts3.getPluginPath().."lua_plugin/Anna/LOLwatch"

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

local function inList(b, as)
  if (type(as)~="table") then return false end
  for _,a in ipairs(as) do
    if b == a then return true end
  end
  return false
end

local function shellKomanda(komanda)
  local handle = io.popen(komanda .. " 2>&1")
  local tmp = handle:read("*a")
  handle:close()
  if tmp ~= nil then if string.match(tmp, "\n$") then tmp = string.sub(tmp,1,-2) end end
  return tmp
end

local function onTextMessageEventttt(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    tmp = ts3.getClientList(serverConnectionHandlerID)
    myID = ts3.getClientID(serverConnectionHandlerID)
    myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)

    --for i,v in ipairs(tmp) do print(v) end

    --Mijenjaj moj opis

    
    --math.randomseed(os.time())
    --time_check = os.clock()
    

    if (fromID~= myID) then

      if string.match(string.lower(message), "start lolwatch") then
        shellKomanda("python2.7 "..plugLoc.."/LOLwatch.py & echo $! >> "..plugLoc.."/runningPID")
        posaljiPoruku("A valjda je pokrenuto", fromID, targetMode)
      end

      if string.match(string.lower(message), "stop lolwatch") then
        local tmp = shellKomanda(plugLoc.."/stopLOLwatch.sh")
        posaljiPoruku(tmp, fromID, targetMode)
      end

    end

    return 0
  end

local registeredEvents = {
  onTextMessageEvent = onTextMessageEventttt
}



ts3RegisterModule("LOLwatch", registeredEvents)
