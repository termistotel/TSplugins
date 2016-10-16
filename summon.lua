require("ts3init")
--require("ts3autoload")

local function shellKomanda(komanda)
  local handle = io.popen(komanda .. " 2>&1")
  local tmp = handle:read("*a")
  handle:close()
  if string.match(tmp, "\n$") then tmp = string.sub(tmp,1,-1) end
  return tmp
end

local function ocisti(tekst)
  local tmp = string.gsub(tekst, "\"", "")
  tmp,_ = string.gsub(tmp, "&", "")
  tmp,_ = string.gsub(tmp, "|", "")
  tmp,_ = string.gsub(tmp, "$", "")
  tmp,_ = string.gsub(tmp, "`", "")
  return tmp
end

local summons = {}
local dismisses = {}
local summoned = {}


--Učitavanje inkantacija
local f = io.open("plugins/lua_plugin/incantations", "r")
if f then f:close() end

if (f~=nil) then
  for line in io.lines("plugins/lua_plugin/incantations") do 
    local tmp = {}
    for k in string.gmatch(line, "([^|]+)|") do
      if (#k) > 40 then
        tmp = {}
        break
      else
        tmp[#tmp + 1] = k
      end
    end
    if (#tmp>1) then      
      summons[tmp[2]] = ocisti(tmp[1])
      dismisses[tmp[3]] = ocisti(tmp[1])
    end
  end
end


--Prepozavanje naredbi
local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    --tmp = ts3.getClientList(serverConnectionHandlerID)
    myID = ts3.getClientID(serverConnectionHandlerID)
    --for i,v in ipairs(tmp) do ts3.printMessageToCurrentTab(v) end

    local function summon(ime)
      --Stvaranje uha
      --summoned[ime][1] = shellKomanda("pactl load-module module-null-sink sink_name="..ime.."Ear sink_properties=device.description="..ime.."Ear")
      --logPrint(shellKomanda("sqlite3 ~/.ts3client/settings.db \"update Profiles set value='Mode=PulseAudio' || x'0a' || 'Device="..ime.."Ear' || x'0a' || 'DeviceDisplayName="..ime.."Ear' where key='Playback/Default';\""))

      --Stvaranje usta
      --summoned[ime][2] = shellKomanda("pactl load-module module-null-sink sink_name="..ime.."Mouth sink_properties=device.description="..ime.."Mouth")
      --logPrint(shellKomanda("sqlite3 ~/.ts3client/settings.db \"update Profiles set value='Mode=PulseAudio' || x'0a' || 'Device="..ime.."Mouth.monitor' || x'0a' || 'DeviceDisplayName="..ime.."Mouth.monitor' where key='Capture/Default';\""))


      logPrint("I summon thee, "..ime.."!")
      logPrint(shellKomanda("/etc/init.d/tsbot start "..ime))
      --shellKomanda("rm ~/.ts3client/settings.db; cp ~/.ts3client/settings.db.bak ~/.ts3client/settings.db")
    end

    local function dismiss(ime)
      logPrint("Thou art dismissed, "..ime..".")
      os.execute("/etc/init.d/tsbot stop "..ime)
    end


    if (myID ~= fromID) then   
      if #message<=40 then
      --[[
      local s = string.match(message, "summon (%w+)")
      if s and (fromName =="Alobar") then
        summon(s)
      end

    
      local s = string.match(message, "dismiss (%w+)")
      if s and (fromName =="Alobar") then
        dismiss(s)
      end
      --]]
        a = summons[message]
        b = dismisses[message]

        if a and (a~="Anna") then
          summoned[a] = {}
          summon(a)
        end

        if b and (b~="Anna") then
          dismiss(b)
          summoned[b] = nil
        end
      end


    end
    

    return 0

end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}



ts3RegisterModule("summon", registeredEvents)
