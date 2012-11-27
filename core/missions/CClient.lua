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

-- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! --
-- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! ---- SPOILER ALARM! --


local ax, ay = 1600, 900


-- FUNCTIONS --

cSetting["mission_target"] = {
	[1] = "Go to the Restaurant, fast!",
	[2] = "Talk to the women at the bar.",
	[3] = "Go to the farm and find Mr.Zett.",
	[4] = "Find the owner of the fleischberg company.",
	[5] = "Destroy the shadows in Mr.Fleischbergs company.",
	[6] = "...",
}


cSetting["dutyEnabled"] = true

cFunc["drawDuty"] = function()
	if(cSetting["dutyEnabled"] == true) then
		local sx, sy = guiGetScreenSize()

		-- --
		-- QUADRAT --
		dxDrawRectangle(sx/2-(680/ax*sx), sy/2-(20/ay*sy), 200/ax*sx, 250/ay*sy, tocolor(0, 0, 0, 100))
		dxDrawImage(sx/2-(680/ax*sx), sy/2-(20/ay*sy), 200/ax*sx, 250/ay*sy, "data/images/rahmen.png")
		-- TEXT --
		
		dxDrawText("Mission target["..getElementData(localPlayer, "mission").."]", sx/2-(490/ax*sx), sy/2+(10/ay*sy), sx/2-(680/ax*sx), sy/2-(20/ay*sy), tocolor(255, 255, 255, 200), 1.5/ax*sx, "default-bold", "center", "center")
		-- QUADRAT UNTER TEXT --
		
		dxDrawRectangle(sx/2-(680/ax*sx), sy/2+(10/ay*sy), 200/ax*sx, 1/ay*sy, tocolor(0, 0, 0, 150))
		
		-- DUTY --
		local description 
		if(isOpenworldMission() ~= 1) then
			description = cSetting["mission_target"][tonumber(getElementData(localPlayer, "mission"))]
		else
			description = "Explore the open world to find missions."
		end
		dxDrawText(description ,  sx/2-(675/ax*sx), sy/2+(400/ay*sy), 300/ax*sx, 250/ay*sy, tocolor(255, 255, 255, 200), 1.5/ax*sx, "default-bold", "left", "center", false, true)
	end
end

addCommandHandler("enableduty", function()
	cSetting["dutyEnabled"] = not cSetting["dutyEnabled"]
end)


-- EVENT HANDLERS --


addEventHandler("onClientRender", getRootElement(), cFunc["drawDuty"])


