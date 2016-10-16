require("ts3init")

local function posaljiPoruku(poruka, fromID, targetMode)
  local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
  local myID = ts3.getClientID(serverConnectionHandlerID)
    if targetMode == 1 then
      ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, poruka, fromID)
      return 0
  else
    ts3.requestSendChannelTextMsg(serverConnectionHandlerID, poruka, ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        return 0
    end
end

local function inList(b, as)
  if (type(as)~="table") then return false end
  for _,a in ipairs(as) do
    if b == a then return true end
  end
  return false
end

local pool1 = {"Povećanje spama me rastužuje", "Bio bih zahvalan kada bi spam prestao", "Zašto Anna spama", 
              "Anna je bot i botovi nemaju pravo pričanja", "Kada robot priča, to je po definiciji spam", 
              "Anna nije živo biće, za razliku od mene", "Neka spam prestane", "Zašto je ovaj spam tu", 
              "PRESTANI SPAMAT", "control your spam"}

local function onTextMessageEventttt(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)

    myID = ts3.getClientID(serverConnectionHandlerID)
    myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)

    
    --math.randomseed(os.time())
    --time_check = os.clock()
    
    

   

    if (fromID~= myID) then

      if (fromName == "Anna") and (message ~= "Spamm is OFF") then
        posaljiPoruku(pool1[math.random(#pool1)], fromID, targetMode)
      end

    end

    return 0
end

local registeredEvents = {
  onTextMessageEvent = onTextMessageEventttt
}



ts3RegisterModule("mojaskripta", registeredEvents)
