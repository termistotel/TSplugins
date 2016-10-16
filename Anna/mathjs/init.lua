require("ts3init")

local function url_encode(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w %-%_%.%~])",
        function (c) return string.format ("%%%02X", string.byte(c)) end)
    str = string.gsub (str, " ", "+")
  end
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

  toFind = string.match(message, "^calc (.+)")
  if (toFind) then
    if (string.match(string.lower(fromName), "sushi")) then
      posalji("Ne pricam s gejcicima, samo s pravim pedercinama!")
      return 0
    end
    
    toFind = url_encode(toFind)

    local handle = io.popen("curl -s \"http://api.mathjs.org/v1/?precision=3&expr=" .. toFind .. "\"")
    result = handle:read("*a")
    handle:close()

    if (string.match(result, "^Error")) then
      sendMsg = "[color=darkred][Error calculating expression][/color] " .. result
    else
      sendMsg = "[color=darkred][Calculated][/color] Result: " .. result
    end

    posalji(sendMsg)
  end

  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}


ts3RegisterModule("mathjs", registeredEvents)
