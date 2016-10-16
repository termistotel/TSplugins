require("ts3init")
local JSON = require("Anna/github/json")




local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)

  myID = ts3.getClientID(serverConnectionHandlerID)   
  myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)

  if (fromID == myID) then
    return 0
  end

  local function posalji(poruka)
    if targetMode == 1 then
      ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, poruka, fromID)
    else
      ts3.requestSendChannelTextMsg(serverConnectionHandlerID, poruka, myChannelID)
    end
  end

  toFind = string.match(message, "^github (.+)")
  if (toFind) then
    
    toFind1 = string.match(toFind, "^trending (.+)")
    if toFind1 then

      local start = tonumber(toFind1)
      naredba = "curl -G -s "
      naredba = naredba .. "\"https://api.github.com/search/repositories\" "
      naredba = naredba .. "--data-urlencode \"sort=stars\" --data-urlencode \"order=desc\" --data-urlencode \"q=created:>=`date --date=\"30 days ago\" \'+%Y-%m-%d\'`\""
      
      local handle = io.popen(naredba)
      djejson = handle:read("*a")
      handle:close()

      local data = JSON:decode(djejson)

      poruka = "Popularni repozitoriji u zadnjih mjesec dana:  [Page "..start.."]"

      start = (start-1)*5 + 1

      for i=start,start+4,1 do
--      for k,v in ipairs(data["items"]) do
        if not data["items"][i] then break end
        if data["items"][i]["language"] then
          poruka = poruka.."\n["..data["items"][i]["language"].."]"
        else
          poruka = poruka.."\n[unknown]"
        end
        poruka = poruka.."[url="..data["items"][i]["svn_url"].."]"..data["items"][i]["name"].."[/url]:"..data["items"][i]["description"]
   
      end

      posalji(poruka)


--[[
      local link = data[4][1]
      local summary = data[3][1]
      if not link then
        posalji("You and I... we have a problem.")
        return 0
      end

      if string.match(summary, "may refer to:") then
          summary = ""
      end
    
  		string.gsub(summary, '"%)', '" %)')
      local sendMsg = "[b][url="..link.."]"..data[2][1].."[/url][/b]: "..summary
      posalji(sendMsg)
      --]]
    end
  end

  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}


ts3RegisterModule("github", registeredEvents)
