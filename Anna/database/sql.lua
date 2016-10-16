local bazaLoc = "~/Anna"

local function shellKomanda(komanda)
  local handle = io.popen(komanda .. " 2>&1")
	tmp = handle:read("*a")
	handle:close()
	if string.match(tmp, "\n$") then tmp = string.sub(tmp,1,-1) end
	return tmp
end

function sqlQuery(query)
  tmpQuery,_ = string.gsub(query, "\"", "")
  tmpQuery,_ = string.gsub(tmpQuery, "&", "")
  tmpQuery,_ = string.gsub(tmpQuery, "|", "")
  tmpQuery,_ = string.gsub(tmpQuery, "$", "")
  tmpQuery,_ = string.gsub(tmpQuery, "`", "")
  
  if string.match(tmpQuery,"^[.]") then return shellKomanda("sqlite3 "..bazaLoc.." ".."\""..tmpQuery.."\"") end

  if not string.match(tmpQuery,";$") then tmpQuery = tmpQuery..";" end
  return shellKomanda("sqlite3 "..bazaLoc.." \"".. tmpQuery.."\"")
end

function izbrisiSve(tabla)
  return sqlQuery("DELETE FROM "..tabla..";")
end

function izbrisiTablicu(tabla)
  return sqlQuery("DROP TABLE "..tabla..";")
end

function stvoriTablicu(tabla)
  return sqlQuery("CREATE "..tabla..";")
end

function dodajRed(tabla, podaci)
    local query = "INSERT INTO "..tabla.. " VALUES ("
    local podaciQuery = ""

    for _,vrijednost in pairs(podaci) do 
    	if type(vrijednost)=="string" then podaciQuery = podaciQuery.."\'"..vrijednost.."\',"
    	elseif type(vrijednost)=="number" then podaciQuery = podaciQuery..vrijednost..","
    	else return "Krivi tip podataka" end
    end    
	return sqlQuery(query..string.sub(podaciQuery,1,-2)..");")
end