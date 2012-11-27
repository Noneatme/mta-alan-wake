--[[
	##########################################################################
	##																		##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme								##
	##           License: See LICENSE in the top level directory			##
	##																		##
	##########################################################################
]]

local cFunc = {}
local cSetting = {}


-- FUNCTIONS --

cSetting["spawnPos"] = {
	{75.149795532227, -257.50140380859, 1.578125, 10, {{61.723865509033, -274.41528320313, 1.578125}, {45.422103881836, -269.32263183594, 1.8601140975952}, {43.362258911133, -244.60765075684, 1.6872730255127}}}, -- Fleischberg
	{1.9132058620453, -148.32807922363, 0.609375, 10, {{-6.8740787506104, -162.88485717773, 1.1598454713821}, {-11.427165985107, -151.41841125488, 1.4958293437958}, {-9.3794469833374, -138.65495300293, 1.5248975753784}}}, -- Farm 1
	{-30.96852684021, -202.85145568848, 1.5830504894257, 10,{{-62.068744659424, -207.02694702148, 1.7431743144989}, {-63.179828643799, -195.70509338379, 1.7071142196655}, {-51.616901397705, -178.26493835449, 2.6947946548462}}}, -- Strasse
	{-106.79080200195, -79.919258117676, 3.1171875, 10,{{-123.09882354736, -67.711570739746, 3.1171875}, {-118.24500274658, -51.414485931396, 3.109395980835}, {-101.58703613281, -56.576229095459, 3.1171875}, {-69.312072753906, -85.271987915039, 3.1171875}}},
	{-54.044731140137, 22.186372756958, 3.1171875, 10,{{-71.143241882324, 26.829656600952, 3.1171875}, {-48.147811889648, 26.073558807373, 3.1171875}, {-36.057144165039, 13.050615310669, 3.1171875}, {-29.501945495605, 24.518333435059, 3.1171875}}},
	{-88.155014038086, -349.54516601563, 1.4296875, 10,{{-100.18714904785, -328.49182128906, 1.4296875}, {-85.569702148438, -331.15029907227, 1.421875}, {-78.119903564453, -379.3408203125, 5.4285583496094}, {-96.371475219727, -389.78414916992, 1.4296875}}}, -- Fleischberge ingangshalle
--	{,{}},
--	{,{}},
--	{,{}},
--	{,{}},
}

cSetting["col"] = {}

-- EVENT HANDLERS --

function spawnZombieStack(anzahl, table)
	local lastzombie
	for i = 1, anzahl, 1 do
		local x, y, z = table[i][1], table[i][2], table[i][3]
		lastzombie = createAlanZombie(x, y, z)
	end
	setGameSpeed(0.2)
	local x, y, z = getElementPosition(lastzombie)
	local cx, cy, cz, crx, cry, crz = getCameraMatrix()
	smoothMoveCamera(cx, cy, cz, crx, cry, crz, x, y-5, z, x, y, z, 2000, true, lastzombie)
	
	setTimer(function()
		setCameraTarget(localPlayer)
		setGameSpeed(1)
	end, 4000, 1)
end


cFunc["refreshZombieSpawns"] = function()
	for index, col in pairs(cSetting["col"]) do
		col = index
		if(isElement(col)) then
			destroyElement(col)
			col = nil
			cSetting[index] = nil
		end
	end
	for index, table1 in pairs(cSetting["spawnPos"]) do
		local col = createColSphere(table1[1], table1[2], table1[3], table1[4])
		setElementToMap(col)
		cSetting["col"][col] = true
		
		addEventHandler("onClientColShapeHit", col, function(he)
			if(he == localPlayer) then
				setTimer(spawnZombieStack, 2000, 1, #table1[5], table1[5])
				destroyElement(col)
				toogleBadEffect(true)
				setTimer(function()
					toogleBadEffect(false)
				end, math.random(2500, 4000), 1)
			end
		end)
	end
end

setTimer(cFunc["refreshZombieSpawns"], 30*60*1000, -1)

cFunc["refreshZombieSpawns"]()