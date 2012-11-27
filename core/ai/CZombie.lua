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


-- FUNCTIONS --


-- AI --

local pedTarget = {}
local pedTimer = {}
local pedShooting = {}

local zombie = {}

cSetting["finishEffect"] = false
cSetting["finishAlpha"] = 150

cFunc["renderFinishEffect"] = function()
	if(cSetting["finishEffect"] == true) then
		if(cSetting["finishAlpha"] > 50) then
			cSetting["finishAlpha"] = cSetting["finishAlpha"]-1
		end
		if(cSetting["finishAlpha"] < 50) then
			cSetting["finishAlpha"] = cSetting["finishAlpha"]-2
		end
		if(cSetting["finishAlpha"] < 1) then
			cSetting["finishEffect"] = false
		end
		local sx, sy = guiGetScreenSize()
		dxDrawRectangle(0, 0, sx, sy, tocolor(255, 255, 255, cSetting["finishAlpha"]))
	end
end

--addEventHandler("onClientRender", getRootElement(), cFunc["renderFinishEffect"])

cFunc["finishEffect"] = function()
	cSetting["finishEffect"] = true
	cSetting["finishAlpha"] = 150
	
	setGameSpeed(0.5)
	setTimer(function()
		setGameSpeed(1.0)
	end, 1500, 1)
end

local function doPedAttackOtherPlayer(ped)
	if(isTimer(pedTimer[ped])) or (isPedInVehicle(ped)) then
		killTimer(pedTimer[ped])
	end
	if(isElement(ped)) then
		pedTimer[ped] = setTimer(function()
			if(isElement(ped)) and (getElementHealth(ped) > 0) then
				local target = pedTarget[ped]
				if(target) then
					local x, y, z = getElementPosition(ped)
					local x2, y2, z2 = getElementPosition(target)
						if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 2) then
							local block, anim = getPedAnimation(ped)
							if(block == "ped") and (anim == "JOG_maleA") then
								setPedAnimation(ped)
							end
							if(isLineOfSightClear(x, y, z, x2, y2, z2, true, false, false, false, false, false)) then
								if(getElementHealth(target) > 1) then
									if(pedShooting[ped] ~= true) then
										--[[
										local x1, y1 = getElementPosition(ped)
										local x2, y2 = getElementPosition(target)
											local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
											rot = rot-90
											setPedRotation(ped, rot)
											setPedAnimation(ped)
											if(getPedControlState(ped, "fire") ~= true) then
												setPedControlState(ped, "fire", true)
											end
											setPedAimTarget(ped, x2, y2, z2)]]
										setPedControlState(ped, "fire", true)
										pedShooting[ped] = true
										if(getElementData(ped, "zombie:licht") ~= true) then
										else
											local block, anim = getPedAnimation(ped)
											if(block == "ped") and (anim == "handscower")or (getElementData(ped, "zombie:finished") == true) then else
												setPedAnimation(ped, "ped", "handscower", 2000)
												setPedControlState(ped, "fire", false)
												pedShooting[ped] = false
											end
										end
									else
										local x1, y1, z1 = getElementPosition(ped)
										local x2, y2, z2 = getElementPosition(target)
										local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
										rot = rot-90
										setPedRotation(ped, rot)
										setPedAimTarget(ped, x2, y2, z2)
										setPedControlState(ped, "fire", false)
										pedShooting[ped] = false
										if(getElementData(ped, "zombie:licht") ~= true) then else
											local block, anim = getPedAnimation(ped)
											if(block == "ped") and (anim == "handscower") or (getElementData(ped, "zombie:finished") == true) then else
												setPedAnimation(ped, "ped", "handscower", 2000)
												setPedControlState(ped, "fire", false)
												pedShooting[ped] = false
											end
										end
									end
								else
									killTimer(pedTimer[ped])
									pedShooting[ped] = false
									setPedControlState(ped, "fire", false)
								end
							else
								killTimer(pedTimer[ped])
								pedShooting[ped] = false
								setPedControlState(ped, "fire", false)
							end
					else
						local x1, y1, z1 = getElementPosition(ped)
						local x2, y2, z2 = getElementPosition(target)
						local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
						rot = rot-90
						setPedRotation(ped, rot)
						local block, anim = getPedAnimation(ped)
						if(getElementData(ped, "zombie:licht") ~= true) then else
							local block, anim = getPedAnimation(ped)
								if(block == "ped") and (anim == "handscower") or (getElementData(ped, "zombie:finished") == true) then else
								setPedAnimation(ped, "ped", "handscower", 2000)
								setPedControlState(ped, "fire", false)
								pedShooting[ped] = false
							end
						end
						if(block == "ped") and (anim == "JOG_maleA") then else
							if(getElementData(ped, "zombie:licht") ~= true) then
								setPedAnimation(ped, "ped" , "JOG_maleA", -1, true, true, false) -- Joggt
								setPedControlState(ped, "fire", false)
								pedShooting[ped] = false
							else
								local block, anim = getPedAnimation(ped)
								if(block == "ped") and (anim == "handscower") or (getElementData(ped, "zombie:finished") == true) then else
									setPedAnimation(ped, "ped", "handscower", 2000)
									setPedControlState(ped, "fire", false)
									pedShooting[ped] = false
								end
							end
						end
					end
				end
			else
				killTimer(pedTimer[ped])
			end
		end, 250, -1)
	else
		killTimer(pedTimer[ped])
	end
end

local zombie_skin = {
	136,
	137,
	202,
	206,
	95,
}

local z_sound = {}
local z_state = {}

function createAlanZombie(x, y, z, typ)
	local ped = createPed(zombie_skin[math.random(1, #zombie_skin)], x, y, z)
	setElementDimension(ped, getMyID())
	pedTarget[ped] = localPlayer
	table.insert(zombie, ped)
	doPedAttackOtherPlayer(ped)
	setElementData(ped, "ai:zombie", true)
	setElementAlpha(ped, 200)
	if not(typ) then typ = "medium" end
	if(typ == "small") then
		z_state[ped] = 125
		setElementHealth(ped, 30)
	elseif(typ == "medium") then
		z_state[ped] = 175
		setElementHealth(ped, 50)
	elseif(typ == "huge") then
		z_state[ped] = 255
		setElementHealth(ped, 70)
	end
	setPedTargetingMarkerEnabled(false)
	addEventHandler("onClientPedDamage", ped, function()
		setPedAnimation(ped)
		if(getElementData(ped, "zombie:finished") ~= true) then
			cancelEvent()
		end
	end)
	
	addEventHandler("onClientPedWasted", ped, function()
		vanishElement(ped)
		if(getAviableZombies() < 1) then
			cFunc["finishEffect"]()
		end
		callServerFunction("setPlayerData", localPlayer, "morde", tonumber(getElementData(localPlayer, "morde"))+1, true)
	end)
	
	addEventHandler("onClientElementStreamOut", ped, function()
		vanishElement(ped)
	end)
	
	return ped;
end


local function zombieSoundCheck()
	for index, ped in pairs(zombie) do
		if(isElement(ped)) then
			local data = getElementData(ped, "zombie:licht")
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
			zombie[index] = nil
		end
	end
end

local function zombieRenderCheck()
	for index, sound in pairs(z_sound) do
		if(isElement(index)) then
			if(getElementHealth(index) < 1) then
				destroyElement(sound)
				sound = nil
				z_sound[index] = nil
			else
				if(getElementData(index, "zombie:licht") == true) then
					local v = getSoundVolume(sound)
					if(v < 0.9) then
						setSoundVolume(sound, v+0.025)
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
							setPedAnimation(index, "ped", "HIT_front", 1000)
						end
					end
				else	
					local v = getSoundVolume(sound)
					if(v > 0.1) then
						setSoundVolume(sound, v-0.025)
					end
				end
			end
		else
			zombie[index] = nil
		end
	end
end

setTimer(zombieSoundCheck, 100, -1)
addEventHandler("onClientRender", getRootElement(), zombieRenderCheck)

function destroyAlanZombies()
	for index, ped in pairs(zombie) do
		if(isElement(ped)) then
			destroyElement(ped)
		end
	end
end

function getAviableZombies()
	local zombies = 0
	for index, ped in pairs(zombie) do
		if(isElement(ped)) and (getElementHealth(ped) > 1) then
			zombies = zombies+1
		end
	end
	return zombies;
end
addCommandHandler("alzombie", function()
	local x, y, z = getElementPosition(localPlayer)
	createAlanZombie(x, y, z)
end)