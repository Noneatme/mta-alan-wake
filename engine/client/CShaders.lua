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

addEvent("buildClientMap", true)


-- FUNCTIONS --

function applyShaders()
	for i = 1, 9, 1 do
		local state = tonumber(gettok(getElementData(localPlayer, "shaders"), i, "|"))
		triggerEvent("doAlanTriggerShader", localPlayer, i, state)
	end
end

addEventHandler("buildClientMap", localPlayer, applyShaders)


-- EVENT HANDLERS --