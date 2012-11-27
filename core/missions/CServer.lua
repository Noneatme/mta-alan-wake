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


function setPlayerToMission(thePlayer, id)
	triggerClientEvent(thePlayer, "startPlayerMission", thePlayer, id)
	
	if(id == 1) then
		setElementInterior(thePlayer, 0)
		setElementPosition(thePlayer, 6.954824924469, -196.48547363281, 1.6143097877502)
		fadeCamera(thePlayer, false)
	end
end


function setPlayerMission(thePlayer, active, new, openworld)
	if not(openworld) then
		openworld = false
	end
	if(tonumber(getPlayerData(thePlayer, "mission")) == active) then
		setPlayerData(thePlayer, "mission", new, true)
		if(openworld == false) then
			setPlayerData(thePlayer, "openworld", 0)
			setPlayerToMission(thePlayer, new)
		else
			setPlayerData(thePlayer, "openworld", 1)
		end
		if(active == 2) then
			setPlayerData(thePlayer, "flashlight", 1, true)
			giveWeapon(thePlayer, 24, 100)
		end
	end
end


-- EVENT HANDLERS --