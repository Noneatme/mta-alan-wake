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


local marker = {
	createMarker(72.713317871094, -199.66970825195, 13.636931419373, "corona", 1.0, 255, 255, 255, 255),
	createMarker(75.438484191895, -202.01956176758, 13.636931419373, "corona", 1.0, 255, 255, 255, 255)
}


local m_state = {}

for index, m in next, marker do
	m_state[m] = false
	clientElement[m] = m
end

addEventHandler("onClientRender", getRootElement(), function()
	for index, m in next, marker do
		local r, g, b, alpha = getMarkerColor(m)
		if(m_state[m] == false) then
			setMarkerColor(m, r, g, b, alpha-3)
			r, g, b, alpha = getMarkerColor(m)
			if(alpha < 2) then
				m_state[m] = true
				local r, g, b = 255, 255, 255
				setMarkerColor(m, r, g, b, alpha)
			end
		else
			setMarkerColor(m, r, g, b, alpha+3)
			r, g, b, alpha = getMarkerColor(m)
			if(alpha > 253) then
				m_state[m] = false
			end
		end
	end
end)

-- MARKER --

local outmarker = createMarker(-229.09048461914, 1401.2463378906, 27.765625, "corona", 1.0, 255, 255, 255)
setElementToMap(outmarker)
setElementInterior(outmarker, 18)

local inmarker = createMarker(59.571922302246, -193.58407592773, 1.758896112442, "corona", 1.0, 255, 255, 255)
setElementToMap(inmarker)

--58.711074829102, -193.5753326416, 1.495236158371
addEventHandler("onClientMarkerHit", outmarker, function(h)
	if(h == localPlayer) then
		local x, y, z = tonumber(getElementData(localPlayer, "lastx")), tonumber(getElementData(localPlayer, "lasty")), tonumber(getElementData(localPlayer, "lastz"))
		if not(x) then x = 0 end
		if not(y) then y = 0 end
		if not(z) then z = 0 end
		if(x == 0) and (y == 0) and (z == 0) then
			callServerFunction("setInPosition", localPlayer, 57.132209777832, -193.60748291016, 1.4676456451416, 0)
		else
			callServerFunction("setInPosition", localPlayer, x, y, z, 0)
		end
	end
end)

addEventHandler("onClientMarkerHit", inmarker, function(h)
	if(h == localPlayer) then
		callServerFunction("setInPosition", localPlayer, -226.38140869141, 1401.1900634766, 27.765625, 18)
		toogleBadEffect(false)
		callServerFunction("setPlayerMission", localPlayer, 1, 2)
		destroyAlanZombies()
		callServerFunction("resetPlayerPosition", localPlayer)
	end
end)


cFunc["randomInteraction1"] = function(ped, block, anim, time)
	local block2, anim2 = getPedAnimation(ped)
	setPedAnimation(ped, block, anim, -1, true, false)
	setTimer(function()
		setPedAnimation(ped, block2, anim2, -1, true, false)
	end, time, 1)
end

-- RADIO --

-- -223.84817504883, 1408.4221191406, 27.706981658936

local radiosound = playSound3D("http://noneatme.vps20642.alfahosting-vps.de/alanwake/radio_sound.mp3", -223.84817504883, 1408.4221191406, 27.706981658936, true)
setElementInterior(radiosound, 18)
setElementToMap(radiosound)
setSoundVolume(radiosound, 0.5)
--setSoundMaxDistance(radiosound, 5)
-- PEDS --

local p = createAnimPed(172, -222.7822265625, 1403.5197753906, 27.7734375, 90, 18, "BAR", "Barcustom_loop", true, true)
setTimer(cFunc["randomInteraction1"], 20000, -1, p, "BAR", "Barserve_bottle", 2000)
setInteractState(p, true)
setElementData(p, "ped:name", "Barkeeperin")
setElementToMap(p)

local rand_fahrzeuge_pos = {
	{48.816192626953, -195.00556945801, 1.4674253463745, 90},
	{49.057224273682, -189.04873657227, 1.4674253463745, 90},
	{49.009208679199, -181.24909973145, 1.4674253463745, 90},
	{47.681510925293, -168.41383361816, 1.4674253463745, 0},
	{53.8743019104, -168.16236877441, 1.4674253463745, 0},
	{62.428100585938, -168.17875671387, 1.4674253463745, 0},
	{67.120460510254, -168.15774536133, 1.4674253463745, 0},
	{73.188621520996, -168.25360107422, 1.4674253463745, 0},
}

local rand_veh_models = {
	543,
	554,
	600,
	478,
	422
}

	-- FAHRZEUGE --
for index, table in pairs(rand_fahrzeuge_pos) do
	if(math.random(0, 1) == 1) then
		local rot = table[4]
		if(math.random(0, 1) == 1) then
			rot = rot+180
		end
		local veh = createVehicle(rand_veh_models[math.random(1, #rand_veh_models)], table[1], table[2], table[3], 0, 0, rot)
		setElementToMap(veh)
		setElementFrozen(veh, true)
		setVehicleLocked(veh, true)
	end
end
	
if(getRealTime().hour < 21) then
	local p = createAnimPed(66, -225.76278686523, 1395.2117919922, 28.359519958496, 0, 18, "POOL", "POOL_Idle_Stance", true, true)
	setInteractState(p, true)
	setElementData(p, "ped:name", "Pool Guy")
	local ob = createObject(338, 0, 0, 0)
	setElementInterior(ob, 18)
	setElementToMap(ob)
	setElementToMap(p)
	exports.bone_attach:attachElementToBone(ob,p,12,0,0,0,0,-90,0)
	
	-- RANDOM PETS --
	
	local r = math.random(1, 2)
	if(r == 1) then
		local p = createAnimPed(randomZiviSkins[math.random(1, #randomZiviSkins)], -228.7163848877, 1404.1485595703, 27.969809341431, 360, 18, "ped", "SEAT_idle", false, true, true)
		setElementInterior(p, 18)
		setElementToMap(p)
		setElementData(p, "ped:name", "Civilian")
	end
	
	local r = math.random(1, 2)
	if(r == 1) then
		local p = createAnimPed(randomZiviSkins[math.random(1, #randomZiviSkins)], -228.67723083496, 1404.6927734375, 27.999809341431, 180, 18, "ped", "SEAT_idle", false, true, true)
		setElementToMap(p)
		setElementData(p, "ped:name", "Civilian")
	end
	
	local r = math.random(1, 2)
	if(r == 1) then
		local p = createAnimPed(randomZiviSkins[math.random(1, #randomZiviSkins)], -228.77090454102, 1407.0994384766, 27.999809341431, 180, 18, "ped", "SEAT_idle", false, true, true)
		setElementToMap(p)
		setElementData(p, "ped:name", "Civilian")
	end
	
	local r = math.random(1, 2)
	if(r == 1) then
		local p = createAnimPed(randomZiviSkins[math.random(1, #randomZiviSkins)], -228.80561828613, 1406.3373535156, 27.999809341431, 0, 18, "ped", "SEAT_idle", false, true, true)
		setElementToMap(p)
		setElementData(p, "ped:name", "Civilian")
	end
	
	local r = math.random(1, 2)
	if(r == 1) then
		local p = createAnimPed(randomZiviSkins[math.random(1, #randomZiviSkins)], -228.77537536621, 1408.7607177734, 27.999809341431, 0, 18, "ped", "SEAT_idle", false, true, true)
		setElementToMap(p)
		setElementData(p, "ped:name", "Civilian")
	end
	
	local r = math.random(1, 2)
	if(r == 1) then
		local p = createAnimPed(randomZiviSkins[math.random(1, #randomZiviSkins)], -228.58763122559, 1411.746484375, 27.999809341431, 180, 18, "ped", "SEAT_idle", false, true, true)
		setElementToMap(p)
		setElementData(p, "ped:name", "Civilian")
	end
end
