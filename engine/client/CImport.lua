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


cFunc["inportWeapon"] = function()
	local txd = engineLoadTXD("data/models/python.txd")
	engineImportTXD(txd, 348)
	local dff = engineLoadDFF("data/models/python.dff")
	engineReplaceModel(dff, 348)
	
	local txd = engineLoadTXD("data/models/Alan.txd")
	engineImportTXD(txd, 60)
	local dff = engineLoadDFF("data/models/Alan.dff")
	engineReplaceModel(dff, 60)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), cFunc["inportWeapon"])

-- EVENT HANDLERS --