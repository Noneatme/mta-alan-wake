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

addEvent("startPlayerMission", true)
addEvent("doElementActionStart", true)

local mission = 4 

-- FUNCTIONS --

local mrfleischberg



cFunc["missionHandler"] = function(id)
	if(id == mission) then
		cSetting["col1"] = createColSphere(-1.6647118330002, -267.24594116211, 5.4296875, 10)
		setElementDimension(cSetting["col1"], getMyID())
		addEventHandler("onClientColShapeHit", cSetting["col1"], function(h)
			if(h == localPlayer) then
				destroyElement(source)
				local veh = createBadElement(getVehicleModelFromName("Picador"), -57.973400115967, -214.29933166504, 5.0508999824524, 0, 0, 170, "vehicle")
				
				local x, y, z = getElementPosition(veh)
				local cx, cy, cz, crx, cry, crz = getCameraMatrix()
				smoothMoveCamera(cx, cy, cz, crx, cry, crz, x, y-5, z, x, y, z, 2000, true, veh)
				setTimer(function()
					setCameraTarget(localPlayer)
				end, 4000, 1)
			end
		end)
	end
end

cFunc["finishMission5"] = function()
	callServerFunction("setPlayerMission", localPlayer, mission, 5)
end

cFunc["finishMission4"] = function()
	applyDialog("Alan: Okay, lets see.", 3000, true)
	setPedChat(localPlayer, 3000)
	setTimer(cFunc["finishMission5"], 3000, 1)
end

cFunc["finishMission3"] = function()
	applyDialog("Mr.Fleischberg: Please remove the shadows from my company. We can't sell anything anymore! You must turn on the lights.", 5000, true)
	setPedChat(mrfleischberg, 5000)
	setTimer(cFunc["finishMission4"], 5000, 1)
end


cFunc["finishMission2"] = function()
	applyDialog("Alan: Yes. I see you need help. What can I do for you?", 5000, true)
	setPedChat(localPlayer, 5000)
	setTimer(cFunc["finishMission3"], 5000, 1)
end

cFunc["finishMission"] = function()
	applyDialog("Mr.Fleischberg: Thanks god you are here! The Barkeeperin send you, right?", 5000, true)
	setPedChat(mrfleischberg, 5000)
	setTimer(cFunc["finishMission2"], 5000, 1)
end

-- EVENT HANDLERS --

addEventHandler("startPlayerMission", getLocalPlayer(), cFunc["missionHandler"])

addEventHandler("doElementActionStart", getLocalPlayer(), function(theElement)
	if(getElementType(theElement) == "ped") and (getPedName(theElement) == "Mr.Fleischberg") then
		if(getMyMission() == mission) then
			mrfleischberg = theElement
			cFunc["finishMission"]()
		end
	end
end)

-- BAD EFFECT --