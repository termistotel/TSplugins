require("ts3init")

local pool = {["google"]="www.google.com",
              ["youtube"]="www.youtube.com",
              ["facebook"]="www.facebook.com",
              ["woodenpotatoes"]="https://www.youtube.com/user/WoodenPotatoes",
              ["duckduckgo"]="https://duckduckgo.com/",
              ["lemonparty"]="http://lemonparty.fr",
              ["reddit"]="https://www.reddit.com/",
  	          ["gw2reddit"]="https://www.reddit.com/r/Guildwars2/"}

local searchPool = {}


local function napuniTabelu(file,mod,tabela)
  local f = io.open(file, mod)
  if f then f:close() end

  if (f~=nil) then

    for line in io.lines(file) do 
      local tmp = {}

      for k in string.gmatch(line, "([^|]+)|") do
        tmp[#tmp + 1] = k
      end

      if (#tmp>1) then
        tabela[tmp[1]] = tmp[2]
      end
    end

  end

end

napuniTabelu("plugins/lua_plugin/Anna/linker/Trazilice","r", searchPool)
napuniTabelu("plugins/lua_plugin/Anna/linker/Stranice","r", pool)

local function dajUrl(url, tekst)
  tekst=string.lower(tekst)
  return "[i][url="..url.."]"..tekst:gsub("(%l)(%w+)", function(a,b) return string.upper(a)..b end).."[/url][/i]"
end


local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)

  myID = ts3.getClientID(serverConnectionHandlerID)   
  myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myID)
  math.randomseed(os.time())    

  local function posalji(poruka)
    if targetMode == 1 then
      ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, poruka, fromID)
    else
      ts3.requestSendChannelTextMsg(serverConnectionHandlerID, poruka, myChannelID)
    end
  end


  if (fromID~= myID) then

  --Otvaranje stranica
        stranica = string.match(message, '^otvori (%w+)')
      	if stranica then
          stranica = string.lower(stranica)
          if pool[stranica] then
            if math.random(100)~=1 then
              posalji(dajUrl(pool[stranica], stranica))
            else
              posalji(dajUrl(pool["lemonparty"], stranica))
	          end
          end
      	end

  --Tražilice
	  for k,v in pairs(searchPool) do
	  	search = string.match(message, '^'..k..' (.*)')
	    if search then
     	  search1, _ = string.gsub(search," ", "+")
	      posalji(dajUrl(v..search1, search))
      end
    end

  --[[
  --guglavanje
       search = string.match(message, 'guglaj (.*)')
       if search then
     	  search1, _ = string.gsub(search," ", "+")
	      posalji("Guglavam: "..dajUrl("https://www.google.hr/search?q="..search1, search))
         return 0
       else
         search = string.match(message, 'googlaj (.*)')
         if search then
           search1, _ = string.gsub(search," ", "+")
           posalji("Googlavam: "..dajUrl("https://www.google.hr/search?q="..search1, search))
           return 0
         end
       end

  --duckanje       
       search = string.match(message, 'duckaj (.*)')
       if search then
     	  search1, _ = string.gsub(search," ", "+")
        posalji("Duckam: "..dajUrl("https://duckduckgo.com/?q="..search1, search))
        return 0
       end

  --jutubanje
      search = string.match(message, 'jutubaj (.*)')
      if search then
     	  search1, _ = string.gsub(search," ", "+")
        posalji("Jutubavam: "..dajUrl("https://www.youtube.com/results?search_query="..search1, search))
        return 0
      else
        search = string.match(message, 'youtubaj (.*)')
        if search then
          search1, _ = string.gsub(search," ", "+")
	        posalji("Youtubavam: "..dajUrl("https://www.youtube.com/results?search_query="..search1, search))
          return 0
        end
      end
  --]]

  end
  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}



ts3RegisterModule("linker", registeredEvents)
