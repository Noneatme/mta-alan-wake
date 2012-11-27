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

local mission = 3

-- FUNCTIONS --

cFunc["schliesseMissionAb"] = function()
	toggleAllControls(true)
	setCameraTarget(localPlayer)
	applyDialog("He's death. I need to go to the Barkeeperin!", 10000)
	setElementData(localPlayer, "mission3:finish", true)
end


cFunc["missionHandler"] = function(id)
	if(id == mission) then
		applyDialog("Barkeepein: I don't know what is happening. Please go to the farm and find Mr.Zett!", 10000)
		cSetting["missionBlip"] = createBlip(-94.104049682617, -45.418796539307, 3.1171875, 0, 2, 255, 0, 0, 255, 0, 9999.0)
		cSetting["missionCol"] = createColSphere(-94.104049682617, -45.418796539307, 3.1171875, 10)
		cSetting["dr.zett"] = createPed(161, -94.104049682617, -45.418796539307, 3.1171875)
		cSetting["tractor"] = createVehicle(getVehicleModelFromName("Tractor"), -102.14572906494, -54.168914794922, 3.1522579193115, 0, 0, 196)
		setElementDimension(cSetting["dr.zett"], getMyID())
		setElementDimension(cSetting["missionCol"], getMyID())
		setElementDimension(cSetting["missionBlip"], getMyID())
		setElementDimension(cSetting["tractor"], getMyID())
		setElementHealth(cSetting["dr.zett"], 0)
		addEventHandler("onClientColShapeHit", cSetting["missionCol"], function(he)
			if(he == localPlayer) and (getAviableZombies() < 1) then
				destroyElement(cSetting["missionBlip"])
				destroyElement(cSetting["missionCol"])
				local x, y, z, x2, y2, z2 = getCameraMatrix()
				smoothMoveCamera(x, y, z, x2, y2, z2,-95.978645324707, -46.163200378418, 3.1171875, -94.104049682617, -45.418796539307, 2.1171875, 1000)
				toggleAllControls(false)
				applyDialog("Alan: Shit!", 1000)
				setTimer(cFunc["schliesseMissionAb"], 3000, 1)
			end
		end)
	end
end

-- EVENT HANDLERS --

addEventHandler("startPlayerMission", getLocalPlayer(), cFunc["missionHandler"])

-- BAD EFFECT --