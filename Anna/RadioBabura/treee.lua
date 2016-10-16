unrequire("strMatch")
require("strMatch")

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

local function stvoriTablicu(tablica, keyevi, razina)
	if keyevi[razina+2] == nil then
		tablica[string.lower(keyevi[razina])]=keyevi[razina+1]
		return 0
	elseif tablica[string.lower(keyevi[razina])] == nil then
		tablica[string.lower(keyevi[razina])]={}
	end
	stvoriTablicu(tablica[string.lower(keyevi[razina])],keyevi, razina+1)
end


function ucitajPjesme(fajl)	
--Ucitavanje pjesama iz fajla
	local pjesme = {}
	
	file = io.open (fajl, "r")
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

	return pjesme
end


--a je upit koji se traži, table je grana po kojoj se traži, acc je akumulator koji se napuni s dobrim odgovorima (bit će izbrisan)
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

function sviLeafovi(node,acc,blacklist)
	if (type(node[2])~="table") then
		if not inList(node[1], blacklist) then acc[#acc+1]=node end
		return 0
	end
	for key, t in pairs(node[2]) do
		if not inList(key, blacklist) then sviLeafovi({key,t},acc) end
	end
	return nil
end

function nadiSvojstva(table,node)
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