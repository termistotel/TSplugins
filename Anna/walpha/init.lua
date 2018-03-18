require("ts3init")
JSON = require("Anna/wiki/json")

local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

local function urlencode(url)
  if url == nil then
    return
  end
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w ])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

local urldecode = function(url)
  if url == nil then
    return
  end
  url = url:gsub("+", " ")
  url = url:gsub("%%(%x%x)", hex_to_char)
  return url
end

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

  query = string.match(message, "^\!walpha (.+)")

  if (query) then
    apikey = "GQ7WXQ-QHKTX9QYTG"

    local curlCommand = "curl -s \"http://api.wolframalpha.com/v1/result?appid=" .. apikey .. "&i=" .. urlencode(query) .. "&units=metric" .. "\""
    local handle = io.popen(curlCommand)
    local http = handle:read("*a")
    handle:close()

    posalji(http)
  end

  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}


ts3RegisterModule("walpha", registeredEvents)
