--Osnovne QOL funkcije

local function primjeniFunTablica(fun,tablica)
	local tmp = {}
	for i,val in pairs(tablica) do
		tmp[i] = fun(val)
	end
	return tmp
end

local function tableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function TableConcat(t1,t2)
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

--VEKTORIZACIJA
local function parcijalePrimitive(as)
	if (as=="") or (as==nil) then return {} end
	local slovo = string.sub(as,1,1)
	local ostatak = string.sub(as,2)
	local tmp = {slovo}
	for i,val in pairs(parcijalePrimitive(ostatak)) do
		tmp[#tmp+1] = slovo..val
	end
	return tmp
end

local function parcijaleSve(as)
	if (as=="") or (as==nil) then return {} end
	return TableConcat(parcijalePrimitive(as), parcijaleSve(string.sub(as,2)))
end

local function vectorizePerfectOld(as, acc)
	if acc == nil then acc = {} end
	for i, val in pairs(parcijaleSve(as)) do
		if acc[val] == nil then acc[val] = 1 else acc[val] = acc[val] + 1 end
	end
	return acc
end

function vectorizePerfect(s, acc)
	if (s == "") or (s == nil) then return acc end
	if acc == nil then acc = {} end
	local tmpS = s

	while tmpS ~= "" do
		if acc[tmpS] == nil then acc[tmpS]=1 else acc[tmpS] = acc[tmpS] +1 end
		tmpS = string.sub(tmpS,1,-2)
	end
	return vectorizePerfect(string.sub(s,2),acc)
end

function vectorizeSimple(s,acc)
	if (s == "") or (s == nil) then return acc end
	slovo = string.sub(s,1,1)
	ostatak = string.sub(s,2)
	if acc== nil then
		acc={}
		acc[slovo]=1
		return vectorizeSimple(ostatak, acc)
	end

	if acc[slovo]==nil then
		acc[slovo]=1
		return vectorizeSimple(ostatak, acc)
	end

	acc[slovo] = acc[slovo] + 1
	return vectorizeSimple(ostatak,acc)

end

function vectorizeOptimal1(s,acc)
	if (s == "") or (s == nil) then return acc end
	slovo = string.sub(s,1,1)
	dva = string.sub(s,1,2)
	ostatak = string.sub(s,2)
	if acc== nil then acc={} end

	if acc[slovo]==nil then acc[slovo]=1 else acc[slovo] = acc[slovo] +1 end

	if slovo == dva then return vectorizeOptimal1(ostatak,acc) end
	if acc[dva]==nil then acc[dva]=1 else acc[dva] = acc[dva] +1 end

	return vectorizeOptimal1(ostatak,acc)

end

function vectorizeOptimal2(s,acc)
	if (s == "") or (s == nil) then return acc end
	slovo = string.sub(s,1,1)
	dva = string.sub(s,1,2)
	tri = string.sub(s,1,3)
	ostatak = string.sub(s,2)
	if acc== nil then acc={} end

	if acc[slovo]==nil then acc[slovo]=1 else acc[slovo] = acc[slovo] +1 end

	if slovo == dva then return vectorizeOptimal2(ostatak,acc) end
	if acc[dva]==nil then acc[dva]=1 else acc[dva] = acc[dva] +1 end

	if dva == tri then return vectorizeOptimal2(ostatak,acc) end
	if acc[tri]==nil then acc[tri]=1 else acc[tri] = acc[tri] +1 end

	return vectorizeOptimal2(ostatak,acc)
end

--VEKTORSKE OPERACIJE
local function oduzmi(a,b)
	c = {}
	for k,val in pairs(b) do
		c[k] = val
	end
	for k,val in pairs(a) do
		if c[k] == nil then
			c[k] = -val
		else
			c[k] = c[k] - val
		end	
	end
	return c
end

local function zbroji(a,b)
	c = {}
	for k,val in pairs(b) do c[k] = val	end
	for k,val in pairs(a) do
		if c[k] == nil then c[k] = val else c[k] = c[k] + val end
	end
	return c
end

local function scalProd(v1,v2)
	local acc = 0
	for i,k in pairs(v1) do
		if v2[i] ~= nil then
			acc = acc + k*v2[i]
		end
	end
	return acc
end

local function norma(v1)
	return math.sqrt(scalProd(v1,v1))
end


--Funkcije sličnosti
function slicnost(v1,v2)
	return scalProd(v1,v2)/norma(v1)/norma(v2)
end

function strMatchSimple(s1,s2)
	return slicnost(vectorizeSimple(s1), vectorizeSimple(s2))
end

function strMatchOptimal1(s1,s2)
	return slicnost(vectorizeOptimal1(s1), vectorizeOptimal1(s2))
end

function strMatchOptimal2(s1,s2)
	return slicnost(vectorizeOptimal2(s1), vectorizeOptimal2(s2))
end

function strMatchPerfect(s1,s2)
	return slicnost(vectorizePerfect(s1), vectorizePerfect(s2))
end
