require("ts3init")
JSON = require("Anna/wiki/json")
-- test

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
  math.randomseed(os.time())

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

  cryptoName = string.match(message, "^\!price (.+)")

  if (cryptoName) then
    cryptoName = string.upper(cryptoName)

    local curlCommand = "curl -s \"https://min-api.cryptocompare.com/data/price?fsym=" .. cryptoName.. "&tsyms=USD\""
    local handle = io.popen(curlCommand)
    local http = handle:read("*a")
    handle:close()
    
    local json_data = JSON:decode(http)
    
    local rate = json_data.USD

    if (not rate) then
      posalji("Baburaz, to ti ne postoji :/")
    else
      local sendMsg = cryptoName .. " price is $" .. rate
      posalji(sendMsg)
    end
    
  end

  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}


ts3RegisterModule("cryptoprice", registeredEvents)
