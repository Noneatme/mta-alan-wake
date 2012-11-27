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


addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	triggerServerEvent("doPlayerScriptStart", localPlayer)
	
	showPlayerHudComponent("clock", false)
	showPlayerHudComponent("money", false)
	showPlayerHudComponent("weapon", false)
	showPlayerHudComponent("ammo", false)
end)

-- EVENT HANDLERS --