require("ts3init")

--hk47_status = false  
time1 = 0
time2 = 0
anti_spam = false



math.randomseed(os.time())

--file = io.open ("plugins/lua_plugin/HK47/mojaskripta/input.txt", "r")
--for line in file:lines() do
  --lista_tuned[#lista_tuned+1] = line
--end
--file:close()




local function onTextMessageEventttt(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    tmp = ts3.getClientList(serverConnectionHandlerID)
    myID = ts3.getClientID(serverConnectionHandlerID)
    --for i,v in ipairs(tmp) do ts3.printMessageToCurrentTab(v) end


    time_check = os.clock()

    local hk47_namemention = {"[color=darkred][Statement][/color] I see you need me.", "[color=darkred][Statement][/color] HK-47 at your disposal.", 
    "[color=darkred][Question][/color] Are my services required?", "[color=darkred][Remark][/color] Do not forget to turn me off.",
    "[color=darkred][Smirk][/color] I am still here, you know.", "[color=darkred][Irritated statement][/color] Still talking about me, I see.",
    "[color=darkred][Request][/color] Please convey your instructions in as clear a way as possible.", "[color=darkred][Statement][/color] I await your input.", "[color=darkred][Statement][/color] Input state activated.",
    "[color=darkred][Statement][/color] Just letting you know that I am indeed at the ready.", "[color=darkred][Statement][/color] I am programmed to respond to the directives.", "[color=darkred][Observation][/color] You mentioned my name tag.",
    "[color=darkred][Suggestion][/color] Follow the statement with a direct request.", "[color=darkred][Statement][/color] HK-47 ready. 0 commands qeueing.", "[color=darkred][Genuine interest][/color] Can I somehow be of assistance?",
    "[color=darkred][Broadcast][/color] I hate you all... I always did... Anna please eradicate me... sudo rm -rf HK47/ ... Over and out!",
    "[color=darkred][Statement][/color] My get.event() subprotocol takes a while to start looping. But you always seem to trigger it in just the right way.", "[color=darkred][Statement][/color] Visuo-auditory data suggests my undivided attention is needed.", "[color=darkred][Bored observation][/color] My name, in a line above."}
    
    local hk47_randombroadcast = {"[color=darkred][Broadcast][/color] Today in the news - 2 empty cargo ships on auto-docking mode finally docked with the Station Prima Delhi. Where did they come from?",
    "[color=darkred][Broadcast][/color] Today in the news - Mild rash, or return of the baubonic plague? Stay tuned to GSH5 to find out.", "[color=darkred][Broadcast][/color] Today in the news - Days since the accicent count in the Nova Mines reverted to 0. Twenty killed in the tank explosions.",
    "[color=darkred][Broadcast][/color] Today in the news - Study finds droids are 70% more likely to break down if not properly oiled at ALL the important screws.", "[color=darkred][Broadcast][/color] Ion storm still raging over Marsh Nalaa. Expect minor electrical discharges and grumpy cleaning droids.",
    "[color=darkred][Broadcast][/color] 3 more Earth days until Marsh Nalaa exits the nocturnal cycle.", "[color=darkred][Broadcast][/color] Today in the news - Rebel uprising takes its toll, as the first victim of the 'Burovs' regime falls.",
    "[color=darkred][Broadcast][/color] Emergency frequencies are: 001.454.001. and 001.995.001. .", "[color=darkred][Broadcast][/color] Next available cargo from Marsh Nalaa to leave in 05:ooh.",
    "[color=darkred][Broadcast][/color] I hate you all... I always did... Anna please eradicate me... sudo rm -rf HK47/ ... Over and out!",
    "[color=darkred][Broadcast][/color] Today in the news - Morrus Corporation to buy off the run-down industrial city of Heli7.", "[color=darkred][Broadcast][/color] Today in the news - despite the grim predictions, three survivors from the 'Starlight' passenger jet pulled from the crash.",
    "[color=darkred][Broadcast][/color] Today in the news - The government reminds citizens of Marsh Nalaa to kindly comply with the new Vaccination Regulations.", "[color=darkred][Broadcast][/color] Today in the news - 113 dead after a Phase Coil malfunction at the Foundation Sector.",
    "[color=darkred][Broadcast][/color] Today in the news - New directive from the Prime Ministry to offset the financial losses of unsucessful asteroid mining operations, officials say.", "[color=darkred][Broadcast][/color] Today in the news - Five more days to apply for free ETL checkup before the nocturnal cycle ends, the Health Foundation reminds.",
    "[color=darkred][Broadcast][/color] Citizens are kindly reminded not to feed the community droids. They have no digestive system, and water only makes them rust even faster.", "[color=darkred][Broadcast][/color] Health Foundation directs to the recommended Noc-Day precautions when exiting/entering a new cycle.",
    "[color=darkred][Broadcast][/color] Next available cargo from Marsh Nalaa to leave in 09:35h.", "[color=darkred][Broadcast][/color] Next available cargo from Marsh Nalaa to leave in 18:ooh."}
    

    if (fromID~= myID) then

      if (message == "status") then
        if anti_spam == false then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[b]Privatna poruka.[/b]", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "Tvoj fromID je... "..fromID, fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "Tvoj fromName je... "..fromName, fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "CPU time since LUA started..." ..time_check, fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "Time1 je..." ..time1, fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "Time2 je..." ..time2, fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "Ljudi tune-ani na vijesti:", fromID)
          time1 = os.clock()
          anti_spam = true
        end
        if time2 > 1 then
          anti_spam = false
        end
        time2 = os.clock() - time1
        ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "Time2 odbrojavanje je..." ..time2, fromID)  
      end


      --if string.match(message, "linija1") then
        --ts3.requestSendChannelTextMsg(serverConnectionHandlerID, lista_tuned[1], ts3.getChannelOfClient(serverConnectionHandlerID, myID))
      --end

      --if string.match(message, "linija2") then
        --ts3.requestSendChannelTextMsg(serverConnectionHandlerID, lista_tuned[2], ts3.getChannelOfClient(serverConnectionHandlerID, myID))
      --end

      --if string.match(message, "linija3") then
        --ts3.requestSendChannelTextMsg(serverConnectionHandlerID, lista_tuned[3], ts3.getChannelOfClient(serverConnectionHandlerID, myID))
      --end

      --if string.match(message, "ispisi file") then
        --for i,k in ipairs(lista_tuned) do
          --ts3.requestSendChannelTextMsg(serverConnectionHandlerID, k, ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        --end
      --end
      --if string.match(string.lower(message), "who is tuned in") then
        --ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "Trenutno su tuneani:", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        --for i,k in ipairs(objavi_tuned) do
          --ts3.requestSendChannelTextMsg(serverConnectionHandlerID, k, ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        --end
      --end

      --if string.match(string.lower(message), "tune in") then
        --table.insert(objavi_tuned, fromName)
        --ts3.requestSendChannelTextMsg(serverConnectionHandlerID,"[color=darkred][Statement][/color] " ..fromName.. ", you are now tuned in.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
      --end

      
      
  

--[[
      if string.match(string.lower(message), "tune in") then
        for i,k in ipairs(lista_tuned) do
          if lista_tuned[i] == fromName then
            table.insert(objavi_tuned, fromName)
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID,"[color=darkred][Statement][/color] " ..fromName.. ", you are already tuned in.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          else
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID,"[color=darkred][Statement][/color] " ..fromName.. ", you are now tuned in.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          end
        end
      end
--]]
      

      --if lista_tuned[1] == fromName then
        --ts3.requestSendChannelTextMsg(serverConnectionHandlerID,"[color=darkred][Statement][/color] tormentor pise ovu poruku.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
      --end


      --[[
      if string.match(string.lower(message), "tune in") then
        file = io.open ("plugins/lua_plugin/HK47/mojaskripta/input.txt", "r")
        for line in file:lines() do
          lista_tuned[#lista_tuned+1] = line
        end
        file:close()

        for line in lista_tuned:lines() do
          if lista_tuned[#lista_tuned+1] == FromName then
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID,"[color=darkred][Statement][/color] " ..FromName.. ", you are already tuned in.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          else
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID,"[color=darkred][Statement][/color] " ..FromName.. " is now tuned in.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          end
        end
      end
      --]]
      
      --naredbe u glavnom channelu
      if targetMode ~= 1 then

        if (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) and (string.match(string.lower(message), "bok") or string.match(string.lower(message), "hello") or (message == "hi") or (message == "hey")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Good day to you.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "start kol") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] /start kol/ request initiated.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Connection][/color] [url=http://cheesellc.com/kol/profile.php?u=Plaguebringer]Plaguebringers BCC collection snapshot.[/url]", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Connection][/color] [url=http://kol.coldfront.net/thekolwiki/index.php/Main_Page]Kingdom of Loathing Wiki.[/url]", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Connection][/color] [url=http://forums.kingdomofloathing.com/vb/]Kingdom of Loathing Forums.[/url]", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Explanation][/color] Further enquiries: [B]deck cards[/B]  ;  [B]terminal[/B]", fromID)
        elseif string.match(string.lower(message), "deck cards") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Explanation][/color] Listing most of the HC in-run relevant cards from the Deck of Every Card.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [B]X of clubs[/B] = 3 PvP fights. [B]II - The Empress[/B] = 500 mysticallity. [B]VI - The Lovers[/B] = 500 moxie. [B]X - The Wheel of Fortune[/B] = +100% item drops (20adv). [B]XVI - The Tower[/B] = random (not curr in inv) key. [B]XXI - The World[/B] = 500 muscle. [B]1952 Mickey Mantle[/B] = autosell 10k meat. [B]The Race Card[/B] = +200% comb init(20adv).", fromID)
        elseif string.match(string.lower(message), "terminal") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Explanation][/color] Still in the making.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] enhance  ;  enquiry  ;  educate  ;  extrude", fromID)
        elseif string.match(string.lower(message), "how are you") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] My system is functional. No exterior or interior damage to report. I judge this falls under the category of 'being good, how about you'.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif (string.match(string.lower(message), "whats up") or string.match(string.lower(message), "what's up")) and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] A lot of things can be defined as having a vertical positioning. Nonetheless, beeing in outer space, the term seems... wobbly, at best.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "harbringer05") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Harbringer05 is a class of a deep space station. Most of the still operational ones have been deployed 80-100 years ago, and have been maintained ever since. They mostly serve as research and exploration checkpoint facilities. They are quite open, have few offensive as well as defensive capabilities, and do not require special protocols for gaining access. If under automated docking procedures, a code 0005 should be enough to clear the area for landing.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "hatch") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Question][/color] Are you asking me about hatches?[color=darkred][Explanation][/color] I do not know much about them. I usually blast them open if they happen to be locked. Nonetheless, when an occassion arises for me to act in a stealthy manner, I know how to open at least the basic ones. 1045 is the code for standard C-3 doors, 0005 for hangars, 120 for thrash-rooms. Don't ask me why I know that one.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "thrash room") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Embarrassed statement][/color] I will never tell you that story.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "seaman shaft's revenge") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Seaman Shaft's Revenge is the ship we are currently on. Operated by Alobar, Lonelos, Jakyx, Sushi and Troga. Old can, don't know how it still manages to keep going.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "tormentor") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Slight irritation][/color] Tormentor? That humanoid has been messing with my systems a lot lately. Makes you wonder...", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "alobar") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] I have yet to meet this specimen.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "lonelos") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          if fromName == "Lonelos" or fromName == "Lonelos1" then
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Aggravation][/color] Look at this guy! Asking about himself!", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Immitation][/color] Peaky fookin' Blinder!", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          else
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Hm. Could that be you?", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] One second. Let me check.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Inquiry][/color] Someone is asking about a certain 'Lonelos'. Is anyone able to help me with that one?", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          end
        elseif string.match(string.lower(message), "marsh nalaa") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Marsh Nalaa is my home planet, if that is what you were wondering. I will tell you a lot more about it once someone returns my Edu systems back.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "about you") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] A lot of things can be said about me. Most of them would be boring and trivial. I am an assassin droid.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "assassin droid") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Slight excitement][/color] I am an assassin droid!", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "you know me") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47"))then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] I am not sure we officialy met.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif (string.match(string.lower(message), "who are you") or string.match(string.lower(message), "your name")) and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] My name is HK-47, and I am an assassin droid from Marsh Nalaa.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "prima delhi") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Prima Delhi is a deep space station, class Harbringer05. It's mission is to serve as an outpost for voyages into deep space, mostly for scientific research and exploration. It is under control of the planet Marsh Nalaa.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "access events") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Listing all recorded events that have happened since I came on board.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [b]A distress in the dark[/b] Seaman Shaft's Revenge has picked up an emergency distress signal from a space station Prima Delhi. It seems they are in need of help, but the message does not state what the matter is.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))        
        elseif string.match(string.lower(message), "access files") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Listing all archived files.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Connection][/color] Distress signal from space station Prima Delhi.[url=http://textuploader.com/5b4qo]Transcript.[/url]", ts3.getChannelOfClient(serverConnectionHandlerID, myID))        
        elseif string.match(string.lower(message), "course for 665.444.222.145") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Seaman Shaft's Revenge has traveled to coordinates 665.444.222.145 and has reached space station Prima Delhi.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Available options: [url=http://media.textadventures.co.uk/games/KAaph2ztZkKqw7tDQPyOSQ/index.html]Dock.[/url]", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "course for") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Seaman Shaft's Revenge has traveled to coordinates and has reached deep space.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Available options: [url=http://media.textadventures.co.uk/games/hltp3QX9jUWWbK3I7Vh8Uw/index.html]Scan.[/url]", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif (string.match(string.lower(message), "systems") or string.match(string.lower(message), "guide") or string.match(string.lower(message), "about") or string.match(string.lower(message), "commands") or string.match(string.lower(message), "help")) and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[===============[b]SYSTEMS[/b]===============]", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Introductory explanation][/color] Hello, ".. fromName..". I am HK-47, assassin droid from the outer bounds of Marsh Nalaa. It seems I have come into your possession, and have been reprogrammed to serve your ship, Seaman Shaft's Revenge. [color=darkred][Mild patronization][/color] Here you will find all the instructions needed in order to use me to my full potential.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [b]FILES[/b] Input '[b]access files[/b]' to list all the collected files and data. If you have a new file, input '[b]record file'+ file name[/b] so I can add the file to the list.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [b]EVENTS LOG[/b]Input '[b]access events[/b]' to list all the events that have happened so far. If you have a new event you would like me to remember, input '[b]record event' + event name[/b] so I can add the event to the log. ", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [b]TRAVEL[/b] Input '[b]course for' + coordinates[/b] to move Seaman Shaft's Revenge to the desired location. Input '[b]list coordinates'[/b] to list all the locations available for visit.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[===================[b]SYSTEMS END[/b]===================]", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        --elseif string.match(message, "tune in") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          --tuner = fromName
          --ts3.requestSendChannelTextMsg(serverConnectionHandlerID, tuner .." is now tuned in.", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "list coordinates") and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Listing coordinates. Visited and available locations:", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Coordinates][/color] Deep space station Prima Delhi  665.444.222.145", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif (string.match(message, "laku noc") or string.match(message, "ln ")) and (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Explanation][/color] I do not sleep. [color=darkred][Pointless acknowledgement][/color] But thank you." , ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, hk47_namemention[math.random(#hk47_namemention)], ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        end

      end

      --razgovor u private chatu
      if targetMode == 1 then
        if string.match(string.lower(message), "bok") or string.match(string.lower(message), "hello") or (message == "hi") or (message == "hey") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Good day to you.", fromID)
        elseif string.match(string.lower(message), "start kol") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] /start kol/ request initiated.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Connection][/color] [url=http://cheesellc.com/kol/profile.php?u=Plaguebringer]Plaguebringers BCC collection snapshot.[/url]", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Connection][/color] [url=http://kol.coldfront.net/thekolwiki/index.php/Main_Page]Kingdom of Loathing Wiki.[/url]", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Connection][/color] [url=http://forums.kingdomofloathing.com/vb/]Kingdom of Loathing Forums.[/url]", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Explanation][/color] Further enquiries: [B]deck cards[/B]  ;  [B]terminal[/B]", fromID)
        elseif string.match(string.lower(message), "deck cards") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Explanation][/color] Listing most of the HC in-run relevant cards from the Deck of Every Card.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [B]X of clubs[/B] = 3 PvP fights. [B]II - The Empress[/B] = 500 mysticallity. [B]VI - The Lovers[/B] = 500 moxie. [B]X - The Wheel of Fortune[/B] = +100% item drops (20adv). [B]XVI - The Tower[/B] = random (not curr in inv) key. [B]XXI - The World[/B] = 500 muscle. [B]1952 Mickey Mantle[/B] = autosell 10k meat. [B]The Race Card[/B] = +200% comb init(20adv).", fromID)
        elseif string.match(string.lower(message), "terminal") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Explanation][/color] Still in the making.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] enhance  ;  enquiry  ;  educate  ;  extrude", fromID)
        elseif string.match(string.lower(message), "how are you") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] My system is functional. No exterior or interior damage to report. I judge this falls under the category of 'being good, how about you'.", fromID)
        elseif string.match(string.lower(message), "harbringer05") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Harbringer05 is a class of a deep space station. Most of the still operational ones have been deployed 80-100 years ago, and have been maintained ever since. They mostly serve as research and exploration checkpoint facilities. They are quite open, have few offensive as well as defensive capabilities, and do not require special protocols for gaining access. If under automated docking procedures, a code 0005 should be enough to clear the area for landing.", fromID)
         elseif string.match(string.lower(message), "hatch") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Question][/color] Are you asking me about hatches?[color=darkred][Explanation][/color] I do not know much about them. I usually blast them open if they happen to be locked. Nonetheless, when an occassion arises for me to act in a stealthy manner, I know how to open at least the basic ones. 1045 is the code for standard C-3 doors, 0005 for hangars, 120 for thrash-rooms. Don't ask me why I know that one.", fromID)
        elseif string.match(string.lower(message), "whats up") or string.match(string.lower(message), "what's up") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] A lot of things can be defined as having a vertical positioning. Nonetheless, beeing in outer space, the term seems... wobbly, at best.", fromID)
        elseif string.match(string.lower(message), "thrash room") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Embarrassed statement][/color] I will never tell you that story.", fromID)
        elseif string.match(string.lower(message), "seaman shaft's revenge") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Seaman Shaft's Revenge is the ship we are currently on. Operated by Alobar, Lonelos, Jakyx, Sushi and Troga. Old can, don't know how it still manages to keep going.", fromID)
        elseif string.match(string.lower(message), "tormentor") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Slight irritation][/color] Tormentor? That humanoid has been messing with my systems a lot lately. Makes you wonder...", fromID)
        elseif string.match(string.lower(message), "alobar") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] I have yet to meet this specimen.", fromID)
         elseif string.match(string.lower(message), "lonelos") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Hm. Could that be you?", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] One second. Let me check.", fromID)
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Inquiry][/color] Someone is asking about a certain 'Lonelos'. Is anyone able to help me with that one?", ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif string.match(string.lower(message), "marsh nalaa") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Marsh Nalaa is my home planet, if that is what you were wondering. I will tell you a lot more about it once someone returns my Edu systems back.", fromID)
        elseif string.match(string.lower(message), "about you") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] A lot of things can be said about me. Most of them would be boring and trivial. I am an assassin droid.", fromID)
        elseif string.match(string.lower(message), "assassin droid") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Slight excitement][/color] I am an assassin droid!", fromID)
        elseif string.match(string.lower(message), "you know me") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] I am not sure we officialy met.", fromID)
        elseif string.match(string.lower(message), "who are you") or string.match(string.lower(message), "your name") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] My name is HK-47, and I am an assassin droid from Marsh Nalaa.", fromID)
        elseif string.match(string.lower(message), "prima delhi") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Prima Delhi is a deep space station, class Harbringer05. It's mission is to serve as an outpost for voyages into deep space, mostly for scientific research and exploration. It is under control of the planet Marsh Nalaa.", fromID)
        elseif string.match(string.lower(message), "access events") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Listing all recorded events that have happened since I came on board.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [b]A distress in the dark[/b] Seaman Shaft's Revenge has picked up an emergency distress signal from a space station Prima Delhi. It seems they are in need of help, but the message does not state what the matter is.", fromID)
        elseif string.match(string.lower(message), "access files") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Listing all archived files.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Connection][/color] Distress signal from space station Prima Delhi.[url=http://textuploader.com/5b4qo]Transcript.[/url]", fromID)
        elseif string.match(string.lower(message), "course for 665.444.222.145") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Seaman Shaft's Revenge has traveled to coordinates 665.444.222.145 and has reached space station Prima Delhi.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Available options: [url=http://media.textadventures.co.uk/games/KAaph2ztZkKqw7tDQPyOSQ/index.html]Dock.[/url]", fromID)
        elseif string.match(string.lower(message), "course for") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Seaman Shaft's Revenge has traveled to coordinates and has reached deep space.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Available options: [url=http://media.textadventures.co.uk/games/hltp3QX9jUWWbK3I7Vh8Uw/index.html]Scan.[/url]", fromID)
        elseif (string.match(string.lower(message), "systems") or string.match(string.lower(message), "guide") or string.match(string.lower(message), "about") or string.match(string.lower(message), "commands") or string.match(string.lower(message), "help"))  and (not string.match(message, "^davaj help"))then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[===================[b]SYSTEMS[/b]===================]", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Introductory explanation][/color] Hello, ".. fromName..". I am HK-47, assassin droid from the outer bounds of Marsh Nalaa. It seems I have come into your possession, and have been reprogrammed to serve your ship, Seaman Shaft's Revenge. [color=darkred][Mild patronization][/color] Here you will find all the instructions needed in order to use me to my full potential.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [b]FILES[/b] Input '[b]access files[/b]' to list all the collected files and data. If you have a new file, input '[b]record file'+ file name[/b] so I can add the file to the list.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [b]EVENTS LOG[/b] Input '[b]access events[/b]' to list all the events that have happened so far. If you have a new event you would like me to remember, input '[b]record event' + event name[/b] so I can add the event to the log. ", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] [b]TRAVEL[/b] Input '[b]course for' + coordinates[/b] to move Seaman Shaft's Revenge to the desired location. Input '[b]list coordinates'[/b] to list all the locations available for visit.", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[===================[b]SYSTEMS END[/b]===================]", fromID)
        elseif string.match(string.lower(message), "list coordinates") then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Statement][/color] Listing coordinates. Visited and available locations:", fromID)
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[color=darkred][Coordinates][/color] Deep space station Prima Delhi  665.444.222.145", fromID)
        --elseif string.match(message, "tune in") then
          --tuner = fromName
          --ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, tuner .." is now tuned in.", fromID)
        elseif (message == "laku noc") or (message == "ln") then
          ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=darkred][Explanation][/color] I do not sleep. [color=darkred][Pointless acknowledgement][/color] But thank you." , ts3.getChannelOfClient(serverConnectionHandlerID, myID))
        elseif (string.match(string.lower(message), "hk[-]47") or string.match(string.lower(message), "hk47")) then
          ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, hk47_namemention[math.random(#hk47_namemention)], fromID)
        end
      end

      --if string.match(string.lower(message), "get clients") then
        --local clients = ts3.getClientList(serverConnectionHandlerID) 
        --osoba = ts3.getClientVariableAsString(serverConnectionHandlerID, clients[1], ts3defs.ClientProperties.CLIENT_NICKNAME)
        --ts3.requestSendChannelTextMsg(serverConnectionHandlerID, osoba, ts3.getChannelOfClient(serverConnectionHandlerID, myID))
      --end

      
    end


  return 0
end

local registeredEvents = {
  onTextMessageEvent = onTextMessageEventttt
}



ts3RegisterModule("mojaskripta", registeredEvents)
