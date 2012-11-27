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

addEvent("doAlanGetPlayerStatistic", true)
local data = {}

cFunc["refreshStats"] = function()
	-- ACCOUNTS --
	local result, numrows = dbPoll(dbQuery(handler, "SELECT * FROM accounts;"), dbpTime)
	data["g:accounts"] = numrows
	-- SHADOWS KILLED --
	local result, numrows = dbPoll(dbQuery(handler, "SELECT SUM(Morde) FROM accounts;"), dbpTime)
	data["g:morde"] = result[1]['SUM(Morde)']
	-- TODE --
	local result, numrows = dbPoll(dbQuery(handler, "SELECT SUM(Tode) FROM accounts;"), dbpTime)
	data["g:tode"] = result[1]['SUM(Tode)']
	-- PLAYTIME --
	data["g:playtime"] = "Bin ich zu faul zu"
	-- STAFFS --
	local result, numrows = dbPoll(dbQuery(handler, "SELECT * FROM accounts WHERE Adminlevel > 0;"), dbpTime)
	data["g:staffs"] = numrows
	-- ONLINE STAFFS --
	local staffs = 0
	for index, player in pairs(getElementsByType("player")) do
		if(tonumber(getPlayerData(player, "adminlevel")) > 0) then
			staffs = staffs +1
		end
	end
	data["g:staffsonline"] = staffs
	-- MOST DEATHS USER --
	local result1, numrows1 = dbPoll(dbQuery(handler, "SELECT MAX(Tode) FROM accounts;"), dbpTime)
	local max = result1[1]['MAX(Tode)']
	local result, numrows = dbPoll(dbQuery(handler, "SELECT * FROM accounts WHERE Tode = '"..max.."';"), dbpTime)
	data["g:maxdeaths"] = result[1]['Name'].."("..max..")"

	-- MOST KILLS --
	local result1, numrows1 = dbPoll(dbQuery(handler, "SELECT MAX(Morde) FROM accounts;"), dbpTime)
	local max = result1[1]['MAX(Morde)']
	local result, numrows = dbPoll(dbQuery(handler, "SELECT * FROM accounts WHERE Morde = '"..max.."';"), dbpTime)
	data["g:maxkills"] = result[1]['Name'].."("..max..")"
end
setTimer(cFunc["refreshStats"], 1000, 1)

addEventHandler("doAlanGetPlayerStatistic", getRootElement(), function()
	local ip = getPlayerIP(source)
	triggerClientEvent(source, "doAlanGetPlayerStatisticBack", source, data, ip)
end)

setTimer(cFunc["refreshStats"], 60000, -1)

-- EVENT HANDLERS --