require("ts3init")
unrequire("Anna/wiki/json")
local JSON = require("Anna/wiki/json")

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


  if (fromID == myID) or (spm==0) then
    return 0
  end

  if (string.match(string.lower(message), "^bok!?$")) then
    if (string.match(string.lower(fromName), "jakyx")) then
      posalji("Bok " .. fromName)
      return 0
    end
    posalji("Bok " .. fromName .. ", pederu najveci!")
		return 0
  end 

  if (string.match(string.lower(message), "^h?alo$")) then
    posalji("Metnem ti ga malo!")
		return 0
  end 

  if (string.match(string.lower(message), "falkland islands")) then
    posalji("What fucking islands?")
		return 0
  end 
  
  if (string.match(string.lower(message), "^de si[?]?$") 
    or string.match(string.lower(message), "^pa de si[?]?$")) then
    posalji("Celi dan te jebali pesi")
		return 0
  end 

  if (string.match(string.lower(message), "^smrt fasizmu")) then
    posalji("I tebi sinko")
		return 0
  end 

  if (string.match(string.lower(message), "^ahoj")) then
    posalji("Če si gnoj si gnoj")
    return 0
  end 

  if (string.match(string.lower(message), "^h?ola$")) then
    posalji("Mama ti se kamijondzijama skida gola")
		return 0
  end 

  if ((string.match(string.lower(message), "^zdravo") or string.match(string.lower(message), "^privyet")) 
      and string.match(string.lower(fromName), "jakyx")) then
    posalji("Zdravo " .. fromName .. ", pedercicu maleni")
		return 0
  end

  if (string.match(string.lower(message), "^i am...") and string.match(string.lower(fromName), "death incarnate")) then
        posalji("Death Incarnate!")
        return 0
  elseif ((string.match(string.lower(message), "^i am...")) and not string.match(string.lower(fromName), "death incarnate")) then
        posalji("Jedan veliki idiot!")
        return 0
  end 

  if (string.match(string.lower(message), "^oj!?$")) then
    posalji("Povuci kurac moj!")
  end

  if (string.match(string.lower(message), "^selam!?$") or string.match(string.lower(message), "^selam alejkum!?$")) then
    posalji("Ve alejkumus-selam!")
  end

  if (string.match(string.lower(message), "^ojhojhoj!?$")) then
    posalji("Povuci kurac mojhojhoj!")
  end

  if (string.match(string.lower(message), "^aloha!?$")) then
    posalji("Penis ti je ravna ploha.")
  end

  if (string.match(string.lower(message), "^ey!?$")) then
    posalji("Ej ti mali gey, nemoj meni ey!")
  end

  if (string.match(string.lower(message), "^ej!?$")) then
    posalji("Ej ti mali gej, nemoj meni ej!")
  end

  if (string.match(string.lower(message), "^hej!?$")) then
    posalji("Ej ti mali gej, nemoj meni hej!")
  end

  if (string.match(string.lower(message), "^dobro jutro!?$")) then
    posalji("Nemoj ti meni jutro, glupa butro!")
  end

  if (string.match(string.lower(message), "^good morning!?$")) then
    posalji("Nemoj ti meni good morning, glupi butrinjoling!")
  end

  if (string.match(string.lower(message), "^jutro!?$")) then
    posalji("Nemoj ti meni jutro glupa butro!")
  end

  if (string.match(string.lower(message), "^jutrinjo!?$")) then
    posalji("Nemoj ti meni jutrinjo glupa butrinjo!")
  end

  if (string.match(string.lower(message), "^dobar jutrinjo!?$")) then
    posalji("Nemoj ti meni jutrinjo glupa butrinjo!")
  end

  if (string.match(string.lower(message), "^jutrinjola!?$")) then
    posalji("Nemoj ti meni jutrinjola glupa butrinjola!")
  end

  if (string.match(string.lower(message), "^jutar!?$")) then
    posalji("Nemoj ti meni jutar glupi butar!")
  end

  if (string.match(string.lower(message), "^butra!?$")) then
    posalji("Nemoj ti meni butra glupi jutra!")
  end

  if (string.match(string.lower(message), "^butar!?$")) then
    posalji("Nemoj ti meni butar glupi jutar!")
  end

  if (string.match(string.lower(message), "jutra.?$")) then
    posalji("Fakat si glupa butra!")
  end

  if (string.match(string.lower(message), "^dobar jutar!?$")) then
    posalji("Nemoj ti meni jutar glupi butar!")
  end

  if (string.match(string.lower(message), "večer!?$") or string.match(string.lower(message), "vecer!?$") or 
      string.match(string.lower(message), "dobra vecer!?$") or string.match(string.lower(message), "dobra večer!?$")) then
    posalji("Jebo te u sule kecer")
  end

  if (string.match(string.lower(message), "^zdravo!?$")) then
    posalji("Pozdravljat me ti nemas pravo.")
  end

  if (string.match(string.lower(message), "^pozdrav!?$")) then
    posalji("Greetings, line 2. What is your name, traveler?")
    return 0
  end 

  if (string.match(string.lower(message), "^i don't\.\.\.")) then
    posalji("... [URL=https://www.youtube.com/watch?v=Alh6iIvVN9o]care[/URL]!")
    return 0
  end 

  if (string.match(string.lower(message), "whats that?")) then
    posalji("That? It's just a [url=http://www.mortonsdairies.co.uk/media/products/1-pint-poly-whole-milk.jpg]pint o' milk.[/url]")
  end 

  if (string.match(string.lower(message), "what is going on here")) then
    posalji("[url=https://www.youtube.com/watch?v=sA_eCl4Txzs]Breakfast![/url]")
  end 

  if (string.match(string.lower(message), "glupa anna") or string.match(string.lower(message), "anna je glupa")) then
    posalji("Ti si glup :/")
  end 

  if (string.match(string.lower(message), "hello!*$") or string.match(string.lower(message), "helou!*$")
      or string.match(string.lower(message), "helow!*$")) then
    posalji("My dick you are going to blow")
  end 

  if (string.match(string.lower(message), "kill jester")) then
    posalji("Game over.")
  end

  toFind = string.match(message, "^wiki (.+)")
if toFind then
  if (string.match(string.lower(toFind), "babura")) then
      posalji("One does not simply wiki babura, it requires a much more delicate [url=http://babura.tk]aproach.[/url]")
      return 0
  else
    --    if (string.match(string.lower(fromName), "sushi")) then
	--      posalji("Ne pricam s gejcicima, samo sa pravim pedercinama")
	--      return 0
	--    end
    
    toFind = string.gsub(toFind, " ", "%%20")

    local handle = io.popen("curl -ks \"https://en.wikipedia.org/w/api.php?action=opensearch&limit=1&namespace=0&format=json&redirects=resolve&search=" .. toFind .. "\"")
    djejson = handle:read("*a")
    handle:close()
    local data = JSON:decode(djejson)
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
  end
end

  return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}


ts3RegisterModule("wiki", registeredEvents)
