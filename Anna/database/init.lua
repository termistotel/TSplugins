require("ts3init")
unrequire("Anna/database/sql")
require("Anna/database/sql")

local pastOnline = {}
local sviKlijenti = {}

file = io.open ("plugins/lua_plugin/Anna/database/sviKlijenti.popis", "r")
local z = 0
for line in file:lines() do
	z = z + 1
	sviKlijenti[z] = {}
	sviKlijenti[z][1] = string.match(line, "(.+)\t")
	sviKlijenti[z][2] = string.match(line, "\t(.+)")
end
file:close()

local function strSplit(str, sep)
	local tmp = {}
	for val in string.gmatch(str,"(.-)"..sep) do tmp[#tmp+1] = val end
	tmp[#tmp+1] = string.match(str,sep.."([^"..sep.."]-)$")
	return tmp
end

local function inList(b, as)
  if (type(as)~="table") then return false end
  for _,a in ipairs(as) do
    if b == a[1] then return true end
  end
  return false
end

local function zapisiKlijente(sviKlijenti)
  local file = io.open("plugins/lua_plugin/Anna/database/sviKlijenti.popis", "w")

  for i,lik in pairs(sviKlijenti) do
    file:write(lik[1].."\t"..lik[2].."\n")
  end

  io.close(file)  
  return 0
end

local function updateKlijente(sviKlijenti,sadOnline)
  --local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
  for i,lik in pairs(sadOnline) do
  	if (not inList(lik[1],sviKlijenti)) then
	  if (lik[3]~="Unknown") then
	  	sviKlijenti[#sviKlijenti+1] = {}
	  	sviKlijenti[#sviKlijenti][1] = lik[1]
	  	sviKlijenti[#sviKlijenti][2] = lik[3]
	  end
  	end
  end
    
  zapisiKlijente(sviKlijenti)
  return 0
end

local function nadjiKlijenta(uniqueID,sviKlijenti)
  for i,lik in pairs(sviKlijenti) do
    if lik[1] == uniqueID then
      return lik
    end
  end
  return {unknown, unknown}
end

local function procitajPodatak(line)
  local tmp = {}
  for k in string.gmatch(line, "(.-)\t") do    
    tmp[#tmp + 1] = k                            
  end   
  tmp[#tmp + 1] = string.match(line, "\t([^\t]-)$")                   
  return tmp 
end

local function posaljiPoruku(poruka, fromID, targetMode)
  local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
  local myID = ts3.getClientID(serverConnectionHandlerID)
  if (poruka == "") or (poruka == nil) then return 0 end
  if targetMode == 1 then
    ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, poruka, fromID)
    return 0
  else
    ts3.requestSendChannelTextMsg(serverConnectionHandlerID, poruka, ts3.getChannelOfClient(serverConnectionHandlerID, myID))
    return 0
  end
end

local function popis(serverConnectionHandlerID,kanali)
  local tmpPopis = {}
  local z = 1
  for i,kanal in ipairs(kanali) do
    for j,klijent in ipairs(ts3.getChannelClientList(serverConnectionHandlerID, kanal)) do
      tmpPopis[z] = {}
      tmpPopis[z][1] = ts3.getClientVariableAsString(serverConnectionHandlerID, klijent, 0)
      tmpPopis[z][2] = ts3.getClientVariableAsString(serverConnectionHandlerID, klijent, 1)
      ts3.requestClientVariables(serverConnectionHandlerID, klijent)
      tmpPopis[z][3] = ts3.getClientVariableAsString(serverConnectionHandlerID, klijent, 3)
      if tmpPopis[z][3] == "" then tmpPopis[z][3] = "Unknown" end
      z = z + 1
    end
  end
  return tmpPopis
end

local function ucitajVarijable(serverConnectionHandlerID, clientID)
    local platforma = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, 3)
    local ime = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, 1)
    local uniqueID = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, 0)

    
    if uniqueID == "" then
      uniqueID = "Unknown"
	end
    if ime == "" then
      ime = "Unknown"
	end
    if platforma == "" then
      platforma = "Unknown"
	end

	return {uniqueID, ime, platforma}
end

local function onTextMessageEventttt(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    local tmp = ts3.getClientList(serverConnectionHandlerID)
    local myID = ts3.getClientID(serverConnectionHandlerID)
    local myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)

    --math.randomseed(os.time())
    --time_check = os.clock()

--[[
    if message == "testinjo" then
      local file1 = io.open("plugins/lua_plugin/Anna/database/moves.data", "r")
      for line in file1:lines() do
		posaljiPoruku(dodajRed("moves", strSplit(line,"\t")),fromID,targetMode)     	
	  end
      io.close(file1)
      return 0 
    end
--]]

    a = string.match(message, "^SQL (.+)")

    if a and (fromID ~= myID) then
    	posaljiPoruku(sqlQuery(a),fromID,targetMode)
    end

    if (targetMode==2) then
    --dodaj u fajl
      local vrijeme = os.time()
      local datum = os.date("%Y-%m-%d",vrijeme)
      local sati = os.date("%X",vrijeme)
      local data = datum.."\t"..sati.."\t"..fromName.."\t"..string.len(message)
      local file = io.open("plugins/lua_plugin/Anna/database/msgs.data", "a")
      file:write(data.."\n")
      io.close(file)

      --dodaj u SQL
	  posaljiPoruku(dodajRed("msgs", {datum,sati,fromName,string.len(message)}),fromID,targetMode)  
    end

    return 0
end



function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
    local vrijeme = os.time()
    local datum = os.date("%Y-%m-%d",vrijeme)
    local sati = os.date("%X",vrijeme)
    local file = io.open("plugins/lua_plugin/Anna/database/moves.data", "a")
    local data = datum.."\t"..sati
    local kanali = ts3.getChannelList(serverConnectionHandlerID)
    local tmpPopis = popis(serverConnectionHandlerID,kanali)
    local userVar = {}
    local platforma = ""
    local ime = ""
    local uniqueID = ""

    --Postavi pastOnline ako jos nije postavljen
    if (table.getn(pastOnline) + 1) < table.getn(tmpPopis) then
    --  logPrint("pastOnline nije postavljen")
      pastOnline = tmpPopis
      io.close(file)
      return 0
    end
    
    --Ako se klijent spaja treba postavit platformu iz proslih vrijednosti (jer nemre procitat trenutno iz nekog razloga)
    if oldChannelID == 0 then
      userVar = ucitajVarijable(serverConnectionHandlerID, clientID)
      uniqueID = userVar[1]
      ime = userVar[2]

      for i,lik in pairs(sviKlijenti) do
        if lik[1] == uniqueID then
          platforma = lik[2]
        end
      end

      file:write(data..
        "\t"..uniqueID..
        "\t"..ime.. 
        "\t"..platforma..
        "\t".."void"..
        "\t"..ts3.getChannelVariableAsString(serverConnectionHandlerID, newChannelID, 0).. 
        "\t".."Connecting\n")

      --dodaj u SQL
	  posaljiPoruku(dodajRed("moves", {datum,sati,uniqueID,ime,platforma,"void",ts3.getChannelVariableAsString(serverConnectionHandlerID, newChannelID, 0),"Connecting"}),fromID,targetMode)  

    --Ako odlazi s servera, podaci od njegovog ID-a će bit nedostupni jer ga server već diskonekta kad mi pokušamo pristupiti
    --Zato treba provjeriti tko sad nije online, a prije je bio
    elseif newChannelID == 0 then

      uniqueID = "Unknown"
      ime = "Unknown"
      platforma = "Unknown"

      for i,lik in pairs(pastOnline) do
        if not inList(lik[1],tmpPopis) then
          uniqueID = lik[1]
          ime = lik[2]
          platforma = lik[3]
          if (platforma == "Unknown") and (uniqueID ~= "Unknown") then
            platforma = nadjiKlijenta(uniqueID, sviKlijenti)[2]
          end
          break
        end
      end

      --Ako ode odma nakon što uđe
      if (uniqueID == "Unknown") and (ime == "Unknown") and (platforma == "Unknown") then
        local zadnja = ""
        file = io.open ("plugins/lua_plugin/Anna/database/moves.data", "r")
        for line in file:lines() do
          if line == "\n" then break end
          zadnja = line
        end
        file:close()
        local podatak = procitajPodatak(zadnja)
        uniqueID = podatak[3]
        ime = podatak[4]
        platforma = podatak[5]
      end



      file:write(data..
        "\t"..uniqueID..
        "\t"..ime .. 
        "\t"..platforma..
        "\t"..ts3.getChannelVariableAsString(serverConnectionHandlerID, oldChannelID, 0).. 
        "\t".."void"..
        "\t".."Leaving\n")

      --dodaj u SQL
	  posaljiPoruku(dodajRed("moves", {datum,sati,uniqueID,ime,platforma,ts3.getChannelVariableAsString(serverConnectionHandlerID, oldChannelID, 0),"void","Leaving"}),fromID,targetMode)  

    --Za normalno micanje samo treba normalno pročitati
    else
      userVar = ucitajVarijable(serverConnectionHandlerID, clientID)
      uniqueID = userVar[1]
      ime = userVar[2]
      platforma = userVar[3]
      local oldChannel = ts3.getChannelVariableAsString(serverConnectionHandlerID, oldChannelID, 0)
      local newChannel = ts3.getChannelVariableAsString(serverConnectionHandlerID, newChannelID, 0)

      file:write(data..
        "\t"..uniqueID..
        "\t"..ime .. 
        "\t"..platforma..
        "\t"..oldChannel.. 
        "\t"..newChannel..
        "\t".."Moving\n")


      --dodaj u SQL
	  posaljiPoruku(dodajRed("moves", {datum,sati,uniqueID,ime,platforma,oldChannel,newChannel,"Moving"}),fromID,targetMode)  


    end

    --updateaj popise ljudi koji su online i sve klijente
    io.close(file)
    pastOnline = tmpPopis
    updateKlijente(sviKlijenti,pastOnline)

    return 0
end

function onClientMoveTimeoutEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, timeoutMessage)
    local kanali = ts3.getChannelList(serverConnectionHandlerID)
    local tmpPopis = popis(serverConnectionHandlerID,kanali)
    local vrijeme = os.time()
    local datum = os.date("%Y-%m-%d",vrijeme)
    local sati = os.date("%X",vrijeme)
    local file = io.open("plugins/lua_plugin/Anna/database/moves.data", "a")
    local data = datum.."\t"..sati

    --Postavi pastOnline ako jos nije postavljen
    if (table.getn(pastOnline) + 1) < table.getn(tmpPopis) then
    --  logPrint("pastOnline nije postavljen")
      pastOnline = tmpPopis
      io.close(file)
      return 0
    end

    uniqueID = "Unknown"
    ime = "Unknown"
    platforma = "Unknown"

    --Isto kao kad klijent normalno odlazi
    for i,lik in pairs(pastOnline) do
      if not inList(lik[1],tmpPopis) then
        uniqueID = lik[1]
        ime = lik[2]
        platforma = lik[3]
        if (platforma == "Unknown") and (uniqueID ~= "Unknown") then
          platforma = nadjiKlijenta(uniqueID, sviKlijenti)[2]
        end
        break
      end
    end    

    --Ako ode odma nakon što uđe
    if (uniqueID == "Unknown") and (ime == "Unknown") and (platforma == "Unknown") then
      local zadnja = ""
      file = io.open ("plugins/lua_plugin/Anna/database/moves.data", "r")
      for line in file:lines() do
        if line == "\n" then break end
        zadnja = line
      end
      file:close()
      local podatak = procitajPodatak(zadnja)
      uniqueID = podatak[3]
      ime = podatak[4]
      platforma = podatak[5]
    end

    local oldChannel = ts3.getChannelVariableAsString(serverConnectionHandlerID, oldChannelID, 0)
    file:write(data..
      "\t"..uniqueID..
      "\t"..ime .. 
      "\t"..platforma..
      "\t"..oldChannel.. 
      "\t".."void"..
      "\t".."Connection timeout\n")


      --dodaj u SQL
	  posaljiPoruku(dodajRed("moves", {datum,sati,uniqueID,ime,platforma,oldChannel,"void","Connection timeout"}),fromID,targetMode)  

    io.close(file)
    pastOnline = tmpPopis

end



local registeredEvents = {
  onTextMessageEvent = onTextMessageEventttt,
  onClientMoveEvent = onClientMoveEvent,
  onClientMoveTimeoutEvent = onClientMoveTimeoutEvent
}


ts3RegisterModule("database", registeredEvents)
