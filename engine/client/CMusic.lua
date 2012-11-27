--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]


-- MUSIC BY ROCKSTAR GAMES FROM THE GAME 'ONI'

local cFunc = {}
local cSetting = {}


cSetting["music"] = playSound("http://noneatme.vps20642.alfahosting-vps.de/alanwake/mus_om03.mp3", true)

setSoundVolume(cSetting["music"], 0.5)
-- FUNCTIONS --


cFunc["checkSound"] = function()
	if(getElementInterior(localPlayer) == 0) then
		if(getSoundVolume(cSetting["music"]) ~= 0.5) then
			setSoundVolume(cSetting["music"], 0.5)
		end
	else
		if(getSoundVolume(cSetting["music"]) == 0.5) then
			setSoundVolume(cSetting["music"], 0)
		end
	end
end


setTimer(cFunc["checkSound"], 50, -1)

-- EVENT HANDLERS --