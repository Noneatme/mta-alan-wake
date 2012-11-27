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

addEvent("startPlayerMission", true)


local mission = 1

-- FUNCTIONS --


cFunc["missionHandler"] = function(id)
	if(id == mission) then
		setTimer(function()
			addBadEffect()
			fadeCamera(true)
		end, 1000, 1)
		createAlanZombie(-3.270895242691, -212.8650970459, 1.6273478269577)
		createAlanZombie(-4.8425951004028, -205.01252746582, 1.5500428676605)
		createAlanZombie(3.402529001236, -195.17335510254, 1.5397613048553)
	end

end

-- EVENT HANDLERS --

addEventHandler("startPlayerMission", getLocalPlayer(), cFunc["missionHandler"])

-- BAD EFFECT --

function addBadEffect()
	if isTimer(badEffectTimer) then
		killTimer(badEffectTimer)
	else
		toogleBadEffect(true)
	end
--	badEffectTimer = setTimer(toogleBadEffect,000,1,false)
end


local sx, sy = guiGetScreenSize()
local interface = {}
local images = {}

local effectStates = {cl=1,sxx,syy,state=false}

function toogleBadEffect(state)
	effectStates.state = state
end

function render()
		if effectStates.state then
			if effectStates.cl > 0.1 then
			 effectStates.cl = effectStates.cl - 0.01
			end
		 dxUpdateScreenSource(screen)
		 dxDrawImage(0,0,sx,sy,interface.shader)
		 effectStates.realState = true
		elseif effectStates.realState then
			if effectStates.cl < 1 then
			 effectStates.cl = effectStates.cl + 0.01
			else
			 effectStates.realState = false
			end
		 dxUpdateScreenSource(screen)
		 dxDrawImage(0,0,sx,sy,interface.shader)
		end
	local tick = getTickCount()
	dxSetShaderValue(interface.shader,'pX',1/sx*math.random(0,10)/10*(1/effectStates.cl)+sx*tick%30/10)
	dxSetShaderValue(interface.shader,'pY',1/sy*math.random(0,10)/10*(1/effectStates.cl)+sy*tick%30/10)
	dxSetShaderValue(interface.shader,'cr',effectStates.cl)
	dxSetShaderValue(interface.shader,'cb',effectStates.cl)
	dxSetShaderValue(interface.shader,'cg',effectStates.cl)
end

addEventHandler('onClientResourceStart',resourceRoot,function()
	interface.shader = dxCreateShader("data/shaders/badeffect.fx")
	screen = dxCreateScreenSource(sx,sy)
	dxUpdateScreenSource(screen)
	dxSetShaderValue(interface.shader,'screenSource',screen)
	dxSetShaderValue(interface.shader,'cr',1)
	dxSetShaderValue(interface.shader,'cg',1)
	dxSetShaderValue(interface.shader,'cb',1)
	dxSetShaderValue(interface.shader,'pX',1/sx)
	dxSetShaderValue(interface.shader,'pY',1/sy)
	addEventHandler('onClientHUDRender',root,render)
end)