--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]
-- VARIABLES --
local sFunc = {}
local sSetting = {}

-----------------------

-- JOIN HANDLER --

function spawnJoinPlayer(thePlayer, d)
	if not(thePlayer) or (getElementType(thePlayer) ~= "player") then
		thePlayer = source
	end
	
	spawnPlayer(thePlayer, -227.027999,1401.229980,27.765625, 90, 60, 18, getPlayerData(thePlayer, "id"))
	fadeCamera(thePlayer, true, 1.0)
	setCameraTarget(thePlayer, thePlayer)
	if not(d) then
		setTimer(triggerClientEvent, 100, 1, thePlayer, "buildClientMap", thePlayer)
		
	--	giveWeapon(thePlayer, 23, 99999)
		
		loadResourceMap( thePlayer, getThisResource())
	
		setPlayerToMission(thePlayer, getPlayerData(thePlayer, "mission"), nil, getPlayerData(thePlayer, "openworld"))
	end
	
	for i = 1, 20, 1 do
		outputChatBox(" ", thePlayer)
	end
	
	
	loadPlayerWeapons(thePlayer)
	
	showPlayerHudComponent(thePlayer, "crosshair", false)
	
	setElementHealth(thePlayer, 25)
end

sFunc["spawnPlayers"] = function()
	for index, player in next, getElementsByType("player") do
		sFunc["joinHandler"](player)
	end
end


-- EVENT HANDLERS --

--addEventHandler("onPlayerJoin", getRootElement(), sFunc["joinHandler"])
--addEventHandler("onResourceStart", getResourceRootElement(), sFunc["spawnPlayers"])
