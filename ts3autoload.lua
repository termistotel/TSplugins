--
-- TeamSpeak 3 autoload
--

-- The autoload mechanism will check every subdirectory of plugins/lua_plugin/
-- and load the file init.lua inside the subdirectory if it exists.
-- To give users some control which modules should be loaded, an optional file
-- plugins/lua_plugin/modules.txt can list those subdirectory which should be loaded,
-- one subdirectory name per line. Lines can be commented out by a prefixed "--".
-- If modules.txt does not exist, all subdirectories are loaded.


logedIn = {}

function logPrint(msg)
	local tmp = ts3.getCurrentServerConnectionHandlerID()
	if tmp then
      for i,k in ipairs(logedIn) do
		  ts3.requestSendPrivateTextMsg(tmp, msg, k)
	  end
	end
	print(msg)
end

-- USAGE:
--[[
    require "modulename"
    unrequire( "modulename" )
--]]

local function unrequire(m)
    package.loaded[m] = nil
    _G[m] = nil
end



local function loadModules()
	local modulesToLoad = {}  -- Module directories we want to load
	local f = io.open(ts3.getConfigPath() .. "luaconfig.ini", "r")
	if f ~= nil then  -- luaconfig.ini exists
		local modulesSectionFound = false
		local n = 1
		local line = nil
		repeat
			line = f:read("*lines")
			-- Ignore empty lines and lines starting with "#"
			if line ~= nil and line ~= "" and string.sub(line, 1, 1) ~= "#" then
				if line == "[Modules]" then  -- Find start of Modules section
					modulesSectionFound = true
				elseif modulesSectionFound then
					--modulesToLoad[n] = line
					if string.sub(line, 1, 1) == "[" then
						break  -- Start of next section detected
					end
					if string.sub(line, 1, 5) ~= "size=" then  -- Ignore size=<n> entry
						-- Parse line in the form of "1\on=testmodule"
						local pos1 = string.find(line, "\\")
						local pos2 = string.find(line, "=")
						if pos1 ~= nil and pos2 ~= nil then
							local onOff = string.sub(line, pos1+1, pos2-1)  -- on|off
							if onOff == "on" then
								local moduleName = string.sub(line, pos2+1)  -- Module name
								modulesToLoad[n] = moduleName
								n = n + 1
							end
						end
					end
				end
			end
		until line == nil
		f:close()
	else  -- luaconfig.ini does not exist, load modules from all subdirectories
        
        --ime = ts3.getClientSelfVariableAsString(1, 1)
        local handle = io.popen("echo $BOTNAME")
		ime = handle:read("*a")
		logPrint("Hello! My name is "..ime)
		ime=string.sub(ime, 1, string.len(ime)-1)
		handle:close()
        

--        if not ime then
   
			-- Get all subdirectories within plugins/lua_plugin
			local subdirs = ts3.getDirectories(ts3.getResourcesPath() .."plugins/lua_plugin/"..ime)
			-- Loop through subdirectories and try to load file <moduleDir>/init.lua
			local n = 1
			for subdir in subdirs:gmatch("%w+") do
				modulesToLoad[n] = subdir
				n = n + 1
--			end

        end


	end
    
    -- Load reload module
    local module ="reload/init"
	logPrint("LOAD: " .. module)

	if pcall(unrequire, module) ~= true then -- require normalni
		logPrint("Failed to unload module: " .. module)
	end

	if pcall(require, module) ~= true then
	            logPrint("Failed to load module: " .. module)
	end


    -- Load summon
    if (ime == "Anna") then
      local module ="summon"
      logPrint("LOAD: " .. module)

	  if pcall(unrequire, module) ~= true then -- require normalni
	    logPrint("Failed to unload module: " .. module)
	  end

	  if pcall(require, module) ~= true then
	    logPrint("Failed to load module: " .. module)
	  end
    end


	-- Load modules
	for k,v in pairs(modulesToLoad) do
		local module =ime .."/" .. v .. "/init"
		logPrint("LOAD: " .. module)

		if pcall(unrequire, module) ~= true then -- require normalni
			logPrint("Failed to unload module: " .. module)
		end

		if pcall(require, module) ~= true then
	        logPrint("Failed to load module: " .. module)
		end
	end
	
	
end


local function unload(module)
	if pcall(unrequire, module) ~= true then
		ts3.printMessageToCurrentTab("Failed to unload module: " .. module)
		logPrint("Failed to unload module: " .. module)
		return 1
	else 
		logPrint("Unload "..module)
		return 0
	end
end



-- Automatically load modules once this package is initialized
ts3autoload = {
	loadModules = loadModules,
	unload = unload
}
