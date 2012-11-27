--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]

local sFunc = {}
local sSetting = {}


-- FUNCTIONS --

sFunc["wastedHandler"] = function()
	local thePlayer = source
	resetPlayerPosition(thePlayer)
	outputChatBox("#FFFFFFYou #FF0000Died. #FFFFFFRespawning in #00FF005 #FFFFFFSeconds.", thePlayer, 0, 255, 0, true)
	setTimer(spawnJoinPlayer, 5000, 1, thePlayer, true)
end


-- EVENT HANDLERS --

addEventHandler("onPlayerWasted", getRootElement(), sFunc["wastedHandler"])