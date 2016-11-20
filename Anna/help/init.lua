require("ts3init")

local function shellKomanda(komanda)
  local handle = io.popen(komanda .. " 2>&1")
  tmp = handle:read("*a")
  handle:close()
  if string.match(tmp, "\n$") then tmp = string.sub(tmp,1,-1) end
  return tmp
end

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
  myID = ts3.getClientID(serverConnectionHandlerID)   
  myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)

  local function posalji(poruka)
    if targetMode == 1 then
      ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, poruka, fromID)
    else
      ts3.requestSendChannelTextMsg(serverConnectionHandlerID, poruka, myChannelID)
    end
  end

  if (fromID == myID) then
    return 0
  end

  toFind = string.match(message, "^help$")
  if (toFind) then
    -- More than 1024 charactes problem
    posalji(shellKomanda('/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/help/help.sh'))
    return 0  
  end

  toFind = string.match(message, "^help (.+)")
  if (toFind) then
    toSend = '\n' .. shellKomanda('/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/help/get_help.sh "' .. toFind .. '"')
    if (toSend ~= '\n') then
        posalji('\n\n[b][color=darkred]HELP[/color] - ' .. toFind .. '[/b]\n\n' .. shellKomanda('/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/help/get_help.sh "' .. toFind .. '"'))
    end
  end

  return 0
end

local registeredEvents = {
  onTextMessageEvent = onTextMessageEvent
}


ts3RegisterModule("man", registeredEvents)

