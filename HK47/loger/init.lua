require("ts3init")

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)

        myID = ts3.getClientID(serverConnectionHandlerID)

        if myID~=fromID then
          zahtjev = string.match(message, 'log me, hk47')
        	if zahtjev then
            logedIn[#logedIn+1]=fromID
        	end

          zahtjev = string.match(message, 'reset log')
          if zahtjev then
            logedIn={}
          end
        end

    return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}



ts3RegisterModule("loger", registeredEvents)
