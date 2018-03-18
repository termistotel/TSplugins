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

  if (string.match(string.lower(message), "^jutrola!?$")) then
    posalji("Nemoj ti meni jutrola glupa butrola!")
  end

  if (string.match(string.lower(message), "^jutrinja!?$")) then
    posalji("Nemoj ti meni jutrinja glupa butrinja!")
  end

  if (string.match(string.lower(message), "^jutrinjolica!?$")) then
    posalji("Nemoj ti meni jutrinjolica glupa butrinjolica!")
  end

  if (string.match(string.lower(message), "femini")) then
    feminizam = {
      '"A woman without a man is like a fish without a bicycle." - Irina Dunn',
      '"Why do people say "grow some balls"? Balls are weak and sensitive. If you wanna be tough, grow a vagina. Those things can take a pounding." - Sheng Wang',
      '"I\'m tough, I\'m ambitious, and I know exactly what I want. If that makes me a bitch, okay." - Madonna',
      '"I myself have never been able to find out precisely what feminism is: I only know that people call me a feminist whenever I express sentiments that differentiate me from a doormat." - Rebecca West',
      '"Feminism is the radical notion that women are human beings." - Cheris Kramarae',
      '"He - and if there is a God, I am convinced he is a he, because no woman could or would ever fuck things up this badly." - George Carlin',
      '"You educate a man; you educate a man. You educate a woman; you educate a generation." - Brigham Young'
    }
    posalji(feminizam[math.random(#feminizam)])
  end

  if (string.match(string.lower(message), "vegan")) then
    veganizam = {
      '"If slaughterhouses had glass walls, the whole world would be vegetarian." - Linda McCartney',
      '"You have just dined, and however scrupulously the slaughterhouse is concealed in the graceful distance of miles, there is complicity." - Ralph Waldo Emerson',
      '"We do not need to eat animals, wear animals, or use animals for entertainment purposes, and our only defense of these uses is our pleasure, amusement, and convenience." - Gary L. Francione',
      '"I choose not to make a graveyard of my body for the rotting corpses of dead animals." - George Bernard Shaw',
      '"Veganism is not a "sacrifice." It is a joy." - Gary L. Francione',
      '"Do you know why most survivors of the Holocaust are vegan? It\'s because they know what it\'s like to be treated like an animal." - Chuck Palahniuk, Lullaby',
      '"A man of my spiritual intensity does not eat corpses." - George Bernard Shaw',
      '"If you are not vegan, please consider going vegan. It’s a matter of nonviolence. Being vegan is your statement that you reject violence to other sentient beings, to yourself, and to the environment, on which all sentient beings depend" - Gary L. Francione',
      '"All sentient beings should have at least one right—the right not to be treated as property" - Gary L. Francione'
    }
    posalji(veganizam[math.random(#veganizam)])
  end

  if (string.match(string.lower(message), "komuni")) then
    komunizam = {
      '"You show me a capitalist, and I\'ll show you a bloodsucker" - Malcom X',
      '"When I give food to the poor, they call me a saint. When I ask why the poor have no food, they call me a communist." - Hélder Câmara, Dom Helder Camara: Essential Writings ',
      '"Freedom in capitalist society always remains about the same as it was in ancient Greek republics: Freedom for slave owners." - Vladimir Lenin',
      '"The end may justify the means as long as there is something that justifies the end." - Leon Trotsky',
      '"The history of all hitherto existing society is the history of class struggles." - Karl Marx',
      '"A specter is haunting Europe—the specter of Communism. All the powers of old Europe have entered into a holy alliance to exorcise this specter; Pope and Czar, Metternich and Guizot, French radicals and German police spies." - Karl Marx',
      '"Communism will win" - Pasko Patak (known as Slavoj Zizek)',
      '"Unity is a great thing and a great slogan. But what the workers’ cause needs is the unity of Marxists, not unity between Marxists, and opponents and distorters of Marxism." - Vladimir Lenin',
      '"An army of the people is invincible!" - Mao Zedong',
      '"Let the ruling classes tremble at a communist revolution. The proletarians have nothing to lose but their chains. They have a world to win. Workingmen of all countries, unite!" - Karl Marx',
      '"The theory of Communism may be summed up in one sentence: Abolish all private property." - Karl Marx'
    }
    posalji(komunizam[math.random(#komunizam)])
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
