require("ts3init")
-- JSON = require("jokemachine/json")
JSON = require("Anna/wiki/json")


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
  
  toFind = string.match(message, "^hacker news")

  if (toFind) then  
    
    local handle = io.popen("curl -s \"https://hacker-news.firebaseio.com/v0/beststories.json\"")
    local http = handle:read("*a")
    handle:close()
    
    local json_data = JSON:decode(http)
    
    local news = 'https://hacker-news.firebaseio.com/v0/item/' .. json_data[math.random(200)] .. '.json'
    
    handle = io.popen("curl -s \"" .. news .. "\"")
    http = handle:read("*a")
    handle:close()
    
    json_data = JSON:decode(http)
    local title = json_data.title
    
    local sendMsg = "[b]Hacker News: [/b] Score: " .. json_data.score .. ", [url=" .. json_data.url .. "]" .. title
  
    posalji(sendMsg)
  end

  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}


ts3RegisterModule("hackernews", registeredEvents)
