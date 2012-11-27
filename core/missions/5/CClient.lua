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

local mission = 5

cSetting["lightswitch"] = createObject(2886, 939.19964599609, 2147.7788085938, 1011.4689331055, 0, 0, 180)
setElementToMap(cSetting["lightswitch"])
setElementData(cSetting["lightswitch"], "description", "Press 'E' to\nactivate")
setElementInterior(cSetting["lightswitch"], 1)
setActionObject(cSetting["lightswitch"], true, false, mission)

-- setActionObject(objekt, status, reaktivierbar, mission)
-- FUNCTIONS --

cFunc["missionHandler"] = function(id)
	if(id == mission) then
		cSetting["badeles"] = {
			createBadElement(1558, 933.11187744141, 2128.6298828125, 1010.5974121094),
			createBadElement(1558, 933.08117675781, 2129.81640625, 1010.5974121094),
			createBadElement(1558, 933.05291748047, 2131.0905761719, 1010.5974121094),
			createBadElement(1372, 951.31304931641, 2138.5100097656, 1010.1560058594, 0, 0, 270),
			createBadElement(1372, 951.3125, 2136.759765625, 1010.1560058594, 0, 0, 270),
		}
		for index, ob in pairs(cSetting["badeles"]) do
			setElementInterior(ob, 1)
		end
		
	end
end


-- EVENT HANDLERS --

addEventHandler("startPlayerMission", getLocalPlayer(), cFunc["missionHandler"])


addEventHandler("doElementActionStart", getLocalPlayer(), function(theElement)
	if(getElementType(theElement) == "ped") and (getPedName(theElement) == "Mr.Fleischberg") then
		if(isObjectActivated(cSetting["lightswitch"])) and (getMyMission() == mission) then
			applyDialog("Mr.Fleischberg: Thank you so much! You helped me a lot.", 5000, 1)
			callServerFunction("setPlayerMission", localPlayer, getMyMission(), getMyMission()+1, true)
		end
	end
end)

-- BAD EFFECT --