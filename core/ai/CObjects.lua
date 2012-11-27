--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme								##
	##           License: See LICENSE in the top level directory	        ##
	##                                                                      ##
	##########################################################################
]]


local cFunc = {}
local cSetting = {}

cSetting["element"] = {}
cSetting["elementCol"] = {}

cSetting["elementThrow"] = {}
cSetting["elementTimer"] = {}

-- FUNCTIONS --

cFunc["throwElement"] = function(theElement, object)
	if(isElement(theElement)) then
		detachElements(theElement)
		destroyElement(object)
		local x, y, z = getElementPosition(localPlayer)
		local x2, y2, z2 = getElementPosition(theElement)
		local dis = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
		setElementVelocity(theElement, (x-x2)/30, (y-y2)/30, 0)
		setVehicleTurnVelocity(theElement, 0, 0, math.random(1, 5)/20)
		
		cSetting["elementTimer"][theElement] = setTimer(cFunc["elementUp"], math.random(3000, 5000), 1, theElement)
	end
end

cFunc["elementUp"] = function(theElement)
	if(isElement(theElement)) then
		local x, y, z = getElementPosition(theElement)
		local rx, ry, rz = getElementRotation(theElement)
		local x2, y2, z2 = getElementPosition(localPlayer)
		if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 40) then
			local object = createObject(1337, x, y, z)
			setElementDimension(object, getMyID())
			setObjectScale(object, 0)
			attachElements(theElement, object)
			setElementAttachedOffsets(theElement, 0, 0, 0, rx, ry, rz)
			
			moveObject(object, 1500, x, y, z+2, 0, 0, 0, "InOutQuad")
			setTimer(cFunc["throwElement"], math.random(1000, 3000), 1, theElement, object)
		else
			cSetting["elementTimer"][theElement] = setTimer(cFunc["elementUp"], 1000, 1, theElement)
		end
	end
end


local z_sound = {}
local z_state = {}

local dyn_id = {
	["muelltonne"] = 1372,
	["gasflasche"] = 1370,
	["einkaufswagen"] = 1349,
	["kiste"] = 2912,
}


function createBadElement(welches, x, y, z, rotx, roty, rotz, typ)
	if(typ == "vehicle") then
		local veh = createVehicle(welches, x, y, z, rotx, roty, rotz)
		cSetting["element"][veh] = true
		setElementDimension(veh, getMyID())
		cSetting["elementTimer"][veh] = setTimer(cFunc["elementUp"], math.random(1000, 3000), 1, veh)
		setElementAlpha(veh, 200)
		setVehicleWheelStates (veh, 2, 2, 2, 2)
		z_state[veh] = 255
		setElementData(veh, "ai:zombie", true, true)
		cSetting["elementCol"][veh] = createColSphere(x, y, z, 3)
		attachElements(cSetting["elementCol"][veh], veh)
		setElementDimension(cSetting["elementCol"][veh], getMyID())
		addEventHandler("onClientColShapeHit", cSetting["elementCol"][veh], function(hi)
			if(hi == flashlight_lamp) then
				setElementData(veh, "zombie:licht", true, false)
			end
		end)
		
		addEventHandler("onClientColShapeLeave", cSetting["elementCol"][veh], function(hi)
			if(hi == flashlight_lamp) then
				setElementData(veh, "zombie:licht", false, false)
			end
		end)
		
		return veh;
	else
		local veh
		if(dyn_id[welches]) then
			veh = createObject(dyn_id[welches], x, y, z, rotx, roty, rotz)
		else
			veh = createObject(welches, x, y, z, rotx, roty, rotz)
		end
		cSetting["element"][veh] = true
		setElementDimension(veh, getMyID())
		cSetting["elementTimer"][veh] = setTimer(cFunc["elementUp"], math.random(1000, 3000), 1, veh)
		setElementAlpha(veh, 200)
		z_state[veh] = 255
		setElementData(veh, "ai:zombie", true, true)
		cSetting["elementCol"][veh] = createColSphere(x, y, z, 3)
		attachElements(cSetting["elementCol"][veh], veh)
		setElementDimension(cSetting["elementCol"][veh], getMyID())
		addEventHandler("onClientColShapeHit", cSetting["elementCol"][veh], function(hi)
			if(hi == flashlight_lamp) then
				setElementData(veh, "zombie:licht", true, false)
			end
		end)
		
		addEventHandler("onClientColShapeLeave", cSetting["elementCol"][veh], function(hi)
			if(hi == flashlight_lamp) then
				setElementData(veh, "zombie:licht", false, false)
			end
		end)
		
		return veh;
	end
end


local function objectSoundCheck()
	for index, ped in pairs(cSetting["element"]) do
		ped = index
		if(isElement(index)) then
			local data = getElementData(index, "zombie:licht")
			if(data == true) then
				if(isElement(z_sound[ped])) then else
					z_sound[ped] = playSound3D("data/sounds/zombie_aim.mp3", 0, 0, 0, true)
					setSoundMaxDistance(z_sound[ped], 50)
					setElementDimension(z_sound[ped], getMyID())
					attachElements(z_sound[ped], ped)
					setSoundVolume(z_sound[ped], 0)
				end
			end
		else
			cSetting["element"][index] = nil
		end
	end
end

cFunc["checkRender"] = function()
	for index, car in pairs(cSetting["element"]) do
		if(isElement(index)) then
			if(getElementData(index, "zombie:licht") == true) then
				local sound = z_sound[index]
				local v = getSoundVolume(sound)
				if(v) then
					if(v < 0.9) then
						setSoundVolume(sound, v+0.025)
					end
				end
				if(z_state[index] > 1) then
					local x, y, z = getElementPosition(flashlight_lamp)
					fxAddSparks(x, y, z, 0, 0, 0, 1, 1, 0, 0, 0, false, 1, 1)
					z_state[index] = z_state[index]-1
					local sx, sy = getScreenFromWorldPosition(x, y, z)
					if(sx) and (sy) then
						dxDrawImage(sx-204/255*z_state[index], sy-204/255*z_state[index], 204/255*z_state[index], 204/255*z_state[index], "data/images/zombie_aim.png", 0, 0, 0, tocolor(255, 255, 255, z_state[index]+50))
					end
				else
					if(getElementData(index, "zombie:finished") ~= true) then
						setElementData(index, "zombie:finished", true, false)
						local x, y, z = getElementPosition(index)
						local s = playSound3D("data/sounds/zombie_finish.mp3", x, y, z, false)
						setSoundMaxDistance(s, 50)
						attachElements(s, index)
						setElementDimension(s, getMyID())
						setElementAlpha(index, 255)
						fxAddSparks(x, y, z, 0, 0, 1, 2, 2, 0, 0, 0, false, 1, 1)
						setElementData(index, "zombie:licht", false)
						destroyElement(cSetting["elementCol"][index])
						vanishElement(index)
						if(isTimer(cSetting["elementTimer"][index])) then
							killTimer(cSetting["elementTimer"][index])
						end
						destroyElement(z_sound[index])
						setElementCollisionsEnabled(index, false)
					else	
						local v = getSoundVolume(sound)
						if(v > 0.1) then
							setSoundVolume(sound, v-0.025)
						end
					end
				end
			else
				if(z_sound[index]) then
					local sound = z_sound[index]
					local v = getSoundVolume(sound)
					if(isElement(sound)) then
						if(v > 0.1) then
							setSoundVolume(sound, v-0.025)
						end
					end
				end
			end
		else
			cSetting["element"][index] = nil
			index = nil
		end
	end
end

setTimer(objectSoundCheck, 100, -1)

cFunc["elementRotCheck"] = function()
	for index, _ in pairs(cSetting["element"]) do
		if(isElementAttached(index)) then
			local ele = getElementAttachedTo(index)
			local _1, _2, _3, rx, ry, rz = getElementAttachedOffsets(index)
			local rx2, ry2, rz2 = math.random(0, 2), math.random(0, 2), math.random(0, 2)
			if(math.random(0, 1) == 1) then
				rx2 = rx2*(-1)
			end
			if(math.random(0, 1) == 1) then
				ry2 = ry2*(-1)
			end
			if(math.random(0, 1) == 1) then
				rz2 = rz2*(-1)
			end
			setElementAttachedOffsets(index, _1, _2, _3, rx, ry+ry2, rz+rz2)
		end
		if(isElement(cSetting["elementCol"][index])) then
			local x, y, z = getElementPosition(index)
			setElementPosition(cSetting["elementCol"][index], x, y, z)
		end
	end
end
setTimer(cFunc["elementRotCheck"], 50, -1)

-- EVENT HANDLERS --

addCommandHandler("badele", function(cmd, ...)
	createBadElement(...)
end)


addEventHandler("onClientRender", getRootElement(), cFunc["checkRender"])