require("ts3init")
--require("ts3autoload")

function muteSelf()
  return  ts3.setClientSelfVariableAsInt(ts3.getCurrentServerConnectionHandlerID(), 5, 1)
end

function unmuteSelf()
  return  ts3.setClientSelfVariableAsInt(ts3.getCurrentServerConnectionHandlerID(), 5, 0)
end

local function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
  if status < 3 then logPrint("Mute: "..muteSelf()..", status: "..status) end
  return 0
end

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
  --tmp = ts3.getClientList(serverConnectionHandlerID)
  myID = ts3.getClientID(serverConnectionHandlerID)
  --for i,v in ipairs(tmp) do ts3.printMessageToCurrentTab(v) end
  if (myID ~= fromID) then
    if (message == "reload") then
      logPrint(" ")
--      logPrint("\n".."ID = "..fromID.."  Ime = "..fromName.." reloaded".."\n")		
      logPrint("ID = "..fromID.."  Ime = "..fromName.." reloaded")
      logPrint(" ")
      ts3RegisteredModules = {}
      ts3autoload.loadModules()
    end

    toUnload = string.match(message, "unload (%w+)" )
    if (toUnload) then
		  ts3RegisteredModules[toUnload] = nil
		  if ts3autoload.unload(toUnload .. "/init") == true then
			  ts3.printMessageToCurrentTab("Failed to unload module: " .. toUnload)
			  logPrint("Failed to unload module: " .. toUnload)
  		else
	          logPrint("\n".."ID = "..fromID.."  Ime = "..fromName.." unloaded "..toUnload.."\n")
		  end

    end	

  end
  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent,
  onConnectStatusChangeEvent = onConnectStatusChangeEvent
}



ts3RegisterModule("reload", registeredEvents)
