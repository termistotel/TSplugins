require("ts3init")
JSON = require("Anna/wiki/json")

local function unescape(str)
  str = string.gsub( str, '&lt;', '<' )
  str = string.gsub( str, '&gt;', '>' )
  str = string.gsub( str, '&quot;', '"' )
  str = string.gsub( str, '&apos;', "'" )
  str = string.gsub( str, '&#(%d+);', function(n) return string.char(n) end )
  str = string.gsub( str, '&#x(%d+);', function(n) return string.char(tonumber(n,16)) end )
  str = string.gsub( str, '&amp;', '&' )
  return str
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

  toFind = string.match(string.lower(message), "chuck norris")
  if (toFind) then

    local handle = io.popen("curl -s \"http://api.icndb.com/jokes/random\"")
    result = handle:read("*a")
    handle:close()

    local decode = JSON:decode(result)
    local joke = decode.value.joke

    joke = unescape(joke)

    local baburazi = {"Alobar", "Lonelos", "Tormentor", "Jakyx"}
    local baburaz = baburazi[math.random(#baburazi)]

    joke = joke:gsub("Chuck Norris", baburaz)
    joke = joke:gsub("Chuck", baburaz)

    local sendMsg = "[color=darkred][Fact][/color] " .. joke
    posalji(sendMsg)
  end

  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}


ts3RegisterModule("jokemachine", registeredEvents)
