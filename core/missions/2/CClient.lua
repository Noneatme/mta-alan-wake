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


cFunc["missionHandler"] = function(id)
	if(id == mission) then
		applyDialog("Barkeepein: I don't know what is happening. Please go to the farm and find Mr.Zett!", 10000)
	end
end

-- EVENT HANDLERS --

addEventHandler("startPlayerMission", getLocalPlayer(), cFunc["missionHandler"])

-- BAD EFFECT --