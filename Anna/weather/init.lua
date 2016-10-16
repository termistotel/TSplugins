require("ts3init")

unrequire("Anna/weather/json")
local JSON = require("Anna/weather/json")

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

    if (fromID~= myID) then
        gradDanas = string.match(message, 'vrijeme ([ %w]+) sad')
        gradSutra = string.match(message, 'vrijeme ([ %w]+) sutra')
        gradPrognoza, gradDana = string.match(message, 'vrijeme ([ %w]+) (%d%d?) dan')

        
      	if gradDanas then          
          gradDanas = string.gsub(gradDanas, " ", "")
          local handle = io.popen("curl \"http://api.openweathermap.org/data/2.5/weather?" .. 
              "appid=97028444f7de46e06a811ffcc0ef8e72&q=" .. gradDanas .. "\"")
          djejson = handle:read("*a")
          handle:close()


          local data = JSON:decode(djejson)
          sendMsg = "Weather in " .. data["name"] .. "[".. data["sys"]["country"] ..
            "] at this very moment could be described as " ..
            data["weather"][1]["description"] ..
            " with temperature of " .. data["main"]["temp"] - 273.15 .. " degrees Celsius."
            posalji(sendMsg)
      	end
                
        if gradPrognoza and gradDana then
          gradPrognoza = string.gsub(gradPrognoza, " ", "")
          req = "api.openweathermap.org/data/2.5/forecast/daily?q=" .. gradPrognoza .. 
                "&mode=json&units=metric&cnt="
.. gradDana .. "&appid=97028444f7de46e06a811ffcc0ef8e72"     
          
          
          handle = io.popen("curl -s \"" .. req .. "\"")
          http = handle:read("*a")
          handle:close()
          json = JSON:decode(http)

          sendMsg = "[b]" .. json.city.name .. "[" .. json.city.country .. "][/b]\n"
          for i=1,gradDana do
            --date = string.gsub(os.date("%x", json.list[i].dt),
            --      "(%d%d)/(%d%d)/(%d%d)", "%2%.%1%.20%3")
            temp = os.date("*t", json.list[i].dt)
            -- date = os.date("%A", temp.wday)
            date = temp.day .. "." .. temp.month .. " - " .. os.date("%A", json.list[i].dt)
            sendMsg = sendMsg .. date .. " - "
            sendMsg = sendMsg ..json.list[i].weather[1].description .. ", "
            sendMsg = sendMsg  .. "from " .. json.list[i].temp.min .. " C to " .. json.list[i].temp.max .. " C\n"
          end 
          posalji(sendMsg)
        end

    end

    return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}

ts3RegisterModule("weather", registeredEvents)
