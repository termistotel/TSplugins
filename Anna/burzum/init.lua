unrequire("strMatch")
require("strMatch")

local function primjeniFunTablica(fun,tablica)
	local tmp = {}
	for i,val in pairs(tablica) do
		tmp[i] = fun(val)
	end
	return tmp
end

local function stvoriTablicu(tablica, keyevi, razina)
	if keyevi[razina+2] == nil then
		tablica[string.lower(keyevi[razina])]=keyevi[razina+1]
		return 0
	elseif tablica[string.lower(keyevi[razina])] == nil then
		tablica[string.lower(keyevi[razina])]={}
	end
	stvoriTablicu(tablica[string.lower(keyevi[razina])],keyevi, razina+1)
end

--Ucitavanje pjesama iz fajla
pjesme = {}
minOsjetljivost = 0.5

file = io.open ("plugins/lua_plugin/Anna/burzum/pjesme.txt", "r")
for line in file:lines() do
    local tmp = {}

    for k in string.gmatch(line, "([^|]+)|") do        --Pronađi sve podatke u liniji i upiši ih redom u tmp
        tmp[#tmp + 1] = k    	                       --tmp[1] je žanr, tmp[2] je bend, tmp[3] je pjesma
    end

      --Unošavanje u glavnu tabelu
    if #tmp>3 then
    	stvoriTablicu(pjesme,tmp,1)
    end

end
file:close()


function tableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


local function ikeyval(table, dva)

	dva[1] = dva[1] +1
	dva[2] = next(table, dva[2])

	return dva
end

--VERZIJA 3

function TableConcat(t1,t2)
	local t3 = {}
	for i=1,#t1 do
		t3[#t3+1] = t1[i]
	end
    for i=1,#t2 do
        t3[#t3+1] = t2[i]
    end
    return t3
end

local function inList(b, as)
	if (type(as)~="table") then return false end
	for _,a in ipairs(as) do
		if b == a then return true end
	end
	return false
end

local function isprazniListu(as)
	for i=1,#as,1 do
		table.remove(as,i)
	end
end

function nadiDobre(a,table,acc,blacklist,koef)
	if koef == nil then koef = 0 end
	if (type(table)~="table") then return koef end

	for key, t in pairs(table) do
		if (key==a) and (not inList(a,blacklist)) then
			if koef<2 then
				koef = 2
				isprazniListu(acc)
				acc[1]={key,t}
			else
				acc[#acc+1]={key,t}
			end
		end

		if (koef <2) then
			local tmpa= vectorizeOptimal2(a)
			tmpk = slicnost(vectorizeOptimal2(key),tmpa)
--			local tmpa= vectorizePerfect(a)
--			tmpk = slicnost(vectorizePerfect(key),tmpa)
			if tmpk == koef then
				acc[#acc+1]={key,t}
			end

			if tmpk > koef then
				koef = tmpk
				isprazniListu(acc)
				acc[1]={key,t}
			end

		end

		koef = nadiDobre(a,t,acc,blacklist,koef)
	end
	return koef
end

local function sviLeafovi(node,acc,blacklist)
	if (type(node[2])~="table") then
		if not inList(node[1], blacklist) then acc[#acc+1]=node end
		return 0
	end
	for key, t in pairs(node[2]) do
		if not inList(key, blacklist) then sviLeafovi({key,t},acc) end
	end
	return nil
end

local function randomElement(acc)
	return acc[math.random(#acc)]
end

local function nadiSvojstva(table,node)
	if (type(table)~="table") then	return nil	end

	for key, t in pairs(table) do

		if node[2] == nil then
			uvjet = key==node[1]
		else
			uvjet = (key==node[1]) and (t==node[2])
		end

		if uvjet then
			return {key}
		end

		local tmp = nadiSvojstva(t,node)
		if tmp ~= nil then
			tmp[#tmp+1] = key
			return tmp
		end
	end

end

local function videoID(link)
	vidID = string.match(link, "watch%?v=([A-Za-z0-9_%-]+)")
	if vidID ~= nil then
		test = string.match(vidID, "([^(A-Za-z0-9_%-)])")
	else
		vidID = string.match(link, "http://youtu.be/([A-Za-z0-9_%-]+)")
		if vidID == nil then vidID = string.match(link, "https://youtu.be/([A-Za-z0-9_%-]+)") end
		if vidID ~= nil then
			test = string.match(vidID, "([^(A-Za-z0-9_%-)])")
		end
	end
	if test or (vidID==nil) then
		return nil
	else
		return vidID
	end
end

local function kapitaliziraj(tekst)
	return tekst:gsub("(%l)(.+)", function(a,b) return string.upper(a)..b end)
end

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

local function dajPlaylistu(table, queries, poster, iznimke, randomFlag)
    local komanda = "/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/burzum/PlaylistScript/playlist_updates.py"
    local pjesme = {}
	local svePjesme={}
	local sendMsg = ""
	local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
	local uspjesniTagovi = {}
	local fromName = poster[2]
	local fromID = poster[1]
	local targetMode = poster[3]
	local imeListe = ""


	for _,query in ipairs(queries) do
		local tmpPjesme = {}
		local tmp = #pjesme
		nadiDobre(string.sub(query,1,40),table,tmpPjesme,iznimke,0.5)
		pjesme = TableConcat(pjesme, tmpPjesme)
		if tmp < #pjesme then
			uspjesniTagovi[#uspjesniTagovi+1]=query
		end
	end

	--Naziv playliste
	if #uspjesniTagovi==2 then
		imeListe = " \""..kapitaliziraj(uspjesniTagovi[1])..", "..kapitaliziraj(uspjesniTagovi[2]).."\""
	elseif #uspjesniTagovi==1 then
		imeListe = " \""..kapitaliziraj(uspjesniTagovi[1]).."\""
	elseif #uspjesniTagovi==0 then
		return nil
	else
		imeListe = " \""..kapitaliziraj(uspjesniTagovi[1])..", "..kapitaliziraj(uspjesniTagovi[2])..", ...\""
	end

	komanda = komanda..imeListe

	--opis playliste
	local opis = " \"".."This playlist was created by "..fromName..":  "
	for i,k in ipairs(uspjesniTagovi) do
		if i == #uspjesniTagovi then
			opis = opis..k
		else
			opis = opis..k..", "
		end
	end	
	opis =opis.."\""

	komanda = komanda..opis

	--Ucitavanje svih pjesama
	for _,k in ipairs(pjesme) do
     	sviLeafovi(k,svePjesme,iznimke)
    end

    --shuffle
	if randomFlag and (#svePjesme > 1) then
		local count = #svePjesme
		local tmp = {}
		for i = count, 2, -1 do
			j = math.random(i)
			svePjesme[i], svePjesme[j] = svePjesme[j], svePjesme[i]
		end
	end

	--Extractanje ID-ova iz linka
	for _,node in ipairs(svePjesme) do
		local vidID = videoID(node[2])
		if vidID ~= nil then
			komanda = komanda.." "..vidID
		else
			sendMsg = "[ERROR] "..node[1]..":"..node[2].." Nije dobar link youtube videa."
		end
	end


	--Izvršavanje
	if #svePjesme > 0 then

		posaljiPoruku("[color=darkred][b]Building playlist[/b][/color], please stand-by...",fromID, targetMode)

	    local handle = io.popen(komanda)
		listID = handle:read("*a")
		handle:close()

		posaljiPoruku("[color=darkred][b]Work done:[/b][/color] [url=https://www.youtube.com/watch?v="..videoID(svePjesme[1][2]).."&list="..listID.."]"..imeListe,fromID, targetMode)
	else
		posaljiPoruku("[color=darkred][b]Cannot process.[/b][/color]",fromID, targetMode)
	end
end


local function citanjePlaylista(covjek)
    local komanda = "/home/ts3srv/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/burzum/PlaylistScript/popis.py"
	local fromID = covjek[1]
	local fromName = covjek[2]
	local targetMode = covjek[3]


	posaljiPoruku("[color=darkred][b]Connecting...[/b][/color]",fromID,targetMode)
    local handle = io.popen(komanda)
	tekst = handle:read("*a")
	handle:close()
	for linija in string.gmatch(tekst, "(.-)[\n]") do
		local tmp = {}
		for svojstvo in string.gmatch(linija, "([^|]+)|") do
			tmp[#tmp+1] = svojstvo
		end
		poruka = "[url=https://www.youtube.com/playlist?list="..tmp[1].."]"..tmp[2].."[/url]: "..tmp[3]
		posaljiPoruku(poruka,fromID, targetMode)
	end
end

local helpStrPool = {"help", "pomoc"}


local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)

    myID = ts3.getClientID(serverConnectionHandlerID)
    --math.randomseed(os.time())

    if (fromID~= myID) then
       	

	      	a = string.match(string.lower(message), "^davaj (.+)")
	      	if a~= nil then
	      		--help
	      		if (inList(a,helpStrPool)) then
	      			local poruka = "[color=darkred][b]HELP[/b][/color]\nUzimanje random pjesme koja odgovara TAG-u:\n[b]davaj[/b] [TAG]\n\n"
	      			poruka = poruka.."listanje svih pjesama sa tagom:\n[b]davaj[/b] [OPCIJE]\n       OPCIJE mogu biti: zanrove, artiste [TAG], pjesme [TAG]\n\n"
	      			poruka = poruka.."stvaranje playliste:\n[b]playlista[/b] [TAG1],[TAG2]... [b]bez[/b] [TAG3],[TAG4]... [b]shuffle[/b]\n       [b]\"bez\"[/b] i [b]\"shuffle\"[/b] su opcionalni\n\n"
	      			poruka = poruka.."Popis već napravljenih playlista:\n[b]ispisi youtube playliste[/b]"
	        	    posaljiPoruku(poruka, fromID, targetMode)
	        	    return 0
	      		end

	      		--Pretraživanje žanrova
				if (string.match(a,"zanrove")) then
	    			listaZanrova = {}
					for key in pairs(pjesme) do
						listaZanrova[key] = true
					end

					sendMsg = ""
					for key in pairs(listaZanrova) do
						sendMsg = sendMsg .. key .. "[b],[/b]  " 
					end

	        	    sendMsg = "[color=darkred][/color] "..string.sub(sendMsg, 1, -11)
	        	    posaljiPoruku(sendMsg, fromID, targetMode)
					return 0

	            --Broj pjesama
	            elseif string.match(a,"^broj pjesama") then
	            	local broj = 0
	            	local matches = {}
	            	local svePjesme = {}
            		sviLeafovi({nil,pjesme},svePjesme)
					posaljiPoruku("Broj pjesama: "..#svePjesme, fromID, targetMode)
					return 0



	            --Pretraživanje artista
	            elseif string.match(a,"artiste ") then
	            	local b = string.match(a,"artiste (.+)")
	            	local artists = ""
	            	local matches = {}
	            	local svePjesme = {}
	            	nadiDobre(string.sub(b,1,40),pjesme,matches,nil,minOsjetljivost)
            		for _,k in ipairs(matches) do sviLeafovi(k,svePjesme) end
            		for _,k in ipairs(svePjesme) do
            			local svojstva = nadiSvojstva(pjesme,k)
            			artist = svojstva[2] 
            			if string.match(artists, artist) == nil then artists=artists..artist..", " end
            		end
            		artists = "[color=darkred][/color]"..string.sub(artists,1,-3)
					posaljiPoruku(artists, fromID, targetMode)
					return 0


				--Pretrazivanje pjesama
	            elseif string.match(a,"pjesme ") then
	            	local b = string.match(a,"pjesme (.+)")
	            	local pjesmice = ""
	            	local matches = {}
	            	local svePjesme = {}
	            	nadiDobre(string.sub(b,1,40),pjesme,matches,nil,minOsjetljivost)
            		for _,k in ipairs(matches) do sviLeafovi(k,svePjesme) end
            		for _,k in ipairs(svePjesme) do
            			local svojstva = nadiSvojstva(pjesme,k)
            			pjesma = svojstva[1] 
						pjesmice=pjesmice..pjesma..", " 
            		end

            		pjesmice = "[color=darkred][/color]"..string.sub(pjesmice,1,-3)
					posaljiPoruku(pjesmice, fromID, targetMode)
					return 0


				--Random pjesme
	            elseif string.match(a,"nekaj") or string.match(a,"bilokaj") or string.match(a,"nest") or string.match(a,"random") or string.match(a,"rendom") then
	            	local svojstva = {}
	            	local matches = {}
	            	local svePjesme = {}
	            	local poruka = ""
		       		sviLeafovi({nil,pjesme},svePjesme)		
		       		poruka = poruka.."random: "
					local link = randomElement(svePjesme) 
	      			svojstva = nadiSvojstva(pjesme, link)
	      			poruka = poruka.. "[color=darkred][/color] [url="..link[2].."]".. svojstva[2] .. " - " .. link[1]

	      			posaljiPoruku(poruka, fromID, targetMode)

					return 0
				end





	      		matches ={}						--Lista oblika {key, table}
		      	svePjesme = {}  				--Lista parova oblika {ime_pjesme, url}
		      	svojstva = {}
		      	local poruka = ""

	      		local koef = nadiDobre(a,pjesme,matches,nil,minOsjetljivost)     --Stavi u matches sve grane koje zadovoljavaju key==a
	      		if #matches > 0 then
		      		for _,k in ipairs(matches) do sviLeafovi(k,svePjesme) end      --U svePjesme zapiši sve leafove koji se nalaze
	      			--poruka= poruka.."Match "..math.floor(koef*100).."%: "
	      		else
		       		sviLeafovi({nil,pjesme},svePjesme)		--Ako nema matcheva, onda sve pjesme ikad stavi u svePjesme
		       		poruka = poruka.."random: "
	      		end

	      		link = randomElement(svePjesme)          --link je tipa        {ime_pjesme, url}
	      		svojstva = nadiSvojstva(pjesme, link)    --Vraća svojstva tipa {ime_pjesme, bend, žanr}
	      		poruka = poruka.. "[color=darkred][/color] [url="..link[2].."]".. svojstva[2] .. " - " .. link[1]

	      		posaljiPoruku(poruka, fromID, targetMode)
	      	end

	      	a = string.match(string.lower(message), "^playlista (.+)")
	      	if a~= nil then
	      		local queries = {}
	      		local iznimke = {}
	      		local dalje = ""


	      		local randomFlag = nil
	      		for query in string.gmatch(a, "([^,]+)") do
	      			if string.match(query, " bez ") then
	      				queries[#queries+1] = string.match(query, "([^,]+) bez ")
	      				dalje = string.match(a, " bez (.+)")
		      			break
	      			end
	      			if string.match(query, " shuffle$") then
	   	  				queries[#queries+1] = string.match(query, "([^,]+) shuffle$")
		   	  			break
	      			end
	      			queries[#queries+1] = query
	      		end

	      		if dalje then
		      		for iznimka in string.gmatch(dalje, "([^,]+)") do
		      			if string.match(iznimka, " shuffle$") then
	    	  				iznimke[#iznimke+1] = string.match(iznimka, "([^,]+) shuffle$")
		    	  			break
	      				end
	      				iznimke[#iznimke+1] = iznimka
	      			end
	      		end

	      		randomFlag = string.match(a, " shuffle$")

	      		dajPlaylistu(pjesme,queries, {fromID, fromName, targetMode}, iznimke, randomFlag)
	      	end
	        
	        a = string.match(string.lower(message), "^ispisi youtube playliste")
	        if a~= nil then
	        	citanjePlaylista({fromID,fromName,targetMode})
	        end
    end

    return 0
end

local registeredEvents = {
	onTextMessageEvent = onTextMessageEvent
}



ts3RegisterModule("burzum", registeredEvents)
