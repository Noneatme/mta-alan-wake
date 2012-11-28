--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]

local cFunc = {}
local cSetting = {}


-- FUNCTIONS --


-- MAIN FUNCTION --

cFunc["createExplosion"] = function(x, y, z, dim)
	if not(dim) then
		dim = 0;
	end
	local ob = {}
	local rz = z
	triggerClientEvent("doAlanPlayExploSound", getRootElement(), x, y, z, dim)
	local oldExplo = createExplosion(x, y, z, 5)
	setElementDimension(oldExplo, dim)
	-- SCHWARZER RAUCH --
		ob[1] = createObject(2054, x, y, z)
		for i2 = 1, #ob, 1 do
			if(isElement(ob[i2])) then
				setTimer(destroyElement, 3000, 1, ob[i2])
				setElementCollisionsEnabled(ob[i2], false)
				setElementDimension(ob[i2], dim)
			end
		end
		ob = {}
	-- EXPLOSION --
	for i = 0, 5, 0.5 do
		ob[1] = createObject(2013, x+i, y, z)
		ob[2] = createObject(2013, x-i, y, z)
		ob[3] = createObject(2013, x, y+i, z)
		ob[4] = createObject(2013, x, y-i, z)
		ob[5] = createObject(2013, x, y, z)
		ob[6] = createObject(2013, x-i, y+i, z)
		ob[7] = createObject(2013, x+i, y-i, z)
		ob[8] = createObject(2013, x+i, y+i, z)
		ob[9] = createObject(2013, x-i, y-i, z)
		
		ob[10] = createObject(2013, x+i, y, z+2)
		ob[12] = createObject(2013, x-i, y, z+2)
		ob[13] = createObject(2013, x, y+i, z+2)
		ob[14] = createObject(2013, x, y-i, z+2)
	
		ob[15] = createObject(2013, x, y, z+4)
		for i2 = 1, #ob, 1 do
			if(isElement(ob[i2])) then
				setTimer(destroyElement, 1005, 1, ob[i2])
				setElementCollisionsEnabled(ob[i2], false)
				setElementDimension(ob[i2], dim)
			end
		end
		ob = {}
	end
	-- RAUCH --
	setTimer(function()
		for i = 0, 5, 0.5 do
			local id = 2011
			z = z+0.1
			ob[1] = createObject(id, x+i, y, z)
			ob[2] = createObject(id, x-i, y, z)
			ob[3] = createObject(id, x, y+i, z)
			ob[4] = createObject(id, x, y-i, z)

			for i2 = 1, #ob, 1 do
				if(isElement(ob[i2])) then
					setTimer(destroyElement, 1004, 1, ob[i2])
					setElementCollisionsEnabled(ob[i2], false)
					setElementDimension(ob[i2], dim)
				end
			end
			ob = {}
		end
	
	end, 200, 1)
	-- FUNKTEN --
	setTimer(function()
		local id = 2059
		z = z+0.1
		ob[1] = createObject(id, x-2, y+4, z)
		ob[2] = createObject(id, x+2, y-4, z)
		ob[3] = createObject(id, x+4, y-2, z)
		ob[4] = createObject(id, x-4, y+2, z)
		for i2 = 1, #ob, 1 do
			if(isElement(ob[i2])) then
				setTimer(destroyElement, 1003, 1, ob[i2])
				setElementCollisionsEnabled(ob[i2], false)
				setElementDimension(ob[i2], dim)
			end
		end
		ob = {}
		
	end, 50, 1)
	-- RAUCHBETT --
	
		local id = 2075
		z = rz
		ob[1] = createObject(id, x, y-1, z)
		ob[2] = createObject(id, x, y-2, z)
		ob[3] = createObject(id, x, y+1, z)
		ob[4] = createObject(id, x, y+2, z)
		for i2 = 1, #ob, 1 do
			if(isElement(ob[i2])) then
				setTimer(destroyElement, 2000, 1, ob[i2])
				setElementCollisionsEnabled(ob[i2], false)
				setElementDimension(ob[i2], dim)
			end
		end
	
	for index, obj in pairs(ob) do
		setElementCollisionsEnabled(obj, false)
		setElementDimension(obj, dim)
	end
end

function createAlanExplosion(x, y, z, dim)
	return cFunc["createExplosion"](x, y, z, dim);
end

--[[
	addCommandHandler("expo", function(thePlayer, cmd, x, y, z)
		if(x) then
			cFunc["createExplosion"](x, y, z)
		else
			cFunc["createExplosion"](getElementPosition(thePlayer))
		end
	end)
]]
-- EVENT HANDLERS --