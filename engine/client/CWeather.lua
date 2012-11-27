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

--[[cSetting["normalWeather"] = {
	[1] = 15,
	[2] = 4,
	[3] = 7
}]]
cSetting["normalWeather"] = {
	[1] = 9,
	[2] = 9,
	[3] = 9
}

-- FUNCTIONS --

cFunc["toggleWeatherCheck"] = function()
	setTime(0, 0)
	setMinuteDuration(1000*1000*1000)
	local time = getRealTime()
	local hour = time.hour
	if(hour < 10) then
		if(math.random(0, 1) == 1) then
			setWeather(9)
		else
			local rand = math.random(1, 3)
			setWeather(cSetting["normalWeather"][rand])
		end
	else
		local rand = math.random(1, 3)
		setWeather(cSetting["normalWeather"][rand])
	end
	setFogDistance(-10)
end

cFunc["toggleWeatherCheck"]()
-- EVENT HANDLERS --