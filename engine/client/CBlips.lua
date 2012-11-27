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

local blips = {
	createBlip(60.119342803955, -193.63447570801, 7.1185846328735, 49, 2, 255, 0, 0, 255, 0, 99999.0), -- Restaurant
	createBlip(-0.34234631061554, -255.68467712402, 5.4296875, 51, 2, 255, 0, 0, 255, 0, 99999.0), -- Fleischberg Company
	createBlip(-59.484344482422, 21.529996871948, 3.109395980835, 42, 2, 255, 0, 0, 255, 0, 99999.0), -- Farm
}

for index, b in pairs(blips) do
	setElementToMap(b)
end	