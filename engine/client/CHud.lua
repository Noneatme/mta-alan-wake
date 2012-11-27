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


cFunc["applyHud"] = function()
	cSetting["shader"] = dxCreateShader("data/shaders/texturshader.fx")
	dxSetShaderValue(cSetting["shader"], "Tex", dxCreateTexture("data/images/radar.png"))
	engineApplyShaderToWorldTexture(cSetting["shader"], "radardisc")
	
	showPlayerHudComponent("health", false)
end


cFunc["applyHud"]()


cFunc["drawHud"] = function()
	if(getElementData(localPlayer, "kinomodus") ~= true) then
		local sx, sy = guiGetScreenSize()
		local x, y = sx/2, sy/2
		
		-- HEALTH --
		local health = getElementHealth(localPlayer)*4
		dxDrawRectangle(x+(600/aesx*sx), y+(400/aesy*sy), 150/aesx*sx, 15/aesy*sy, tocolor(0, 255, 0, 100))
		
		dxDrawRectangle(x+(600/aesx*sx), y+(400/aesy*sy), (150/aesx*sx)/100*health, 15/aesy*sy, tocolor(0, 255, 0, 200))
		
		-- TASCHENLAMPE --
		local alpha = 150
		if(lampstate == false) then
			alpha = 0
		end
		dxDrawRectangle(x+(600/aesx*sx), y+(370/aesy*sy), 150/aesx*sx, 15/aesy*sy, tocolor(255, 255, 255, 100))
		
		dxDrawRectangle(x+(600/aesx*sx), y+(370/aesy*sy), (alpha/aesx*sx), 15/aesy*sy, tocolor(255, 255, 255, 200))
		
		for i = 1, 50, 1 do
			dxDrawImage(x+(600/aesx*sx), y+(400/aesy*sy), 150/aesx*sx, 15/aesy*sy, "data/images/rahmen.png", 0, 0, 0, tocolor(0, 0, 0, 255))
			dxDrawImage(x+(600/aesx*sx), y+(370/aesy*sy), 150/aesx*sx, 15/aesy*sy, "data/images/rahmen.png", 0, 0, 0, tocolor(0, 0, 0, 255))
		end
		
		-- WAFFEN --
		local weapon = getPedWeapon(localPlayer)
		if(weapon ~= 0) then
			-- AMMO --
			local clipammo, totalammo = getPedAmmoInClip(localPlayer), getPedTotalAmmo(localPlayer)
			dxDrawText(clipammo.." / "..totalammo-clipammo, x+(645/aesx*sx), y+(340/aesy*sy), x+(600/aesx*sx), y+(400/aesy*sy), tocolor(0, 0, 0, 200), 1.5/aesx*aesx, "default-bold")
			dxDrawText(clipammo.." / "..totalammo-clipammo, x+(646/aesx*sx), y+(341/aesy*sy), x+(600/aesx*sx), y+(400/aesy*sy), tocolor(255, 255, 255, 200), 1.5/aesx*aesx, "default-bold")
		end
	end
end

addEventHandler("onClientPreRender", getRootElement(), cFunc["drawHud"])
-- EVENT HANDLERS --