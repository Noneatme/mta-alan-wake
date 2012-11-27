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



cFunc["spawnEntitys"] = function()
	if(getMyMission() > 4) then -- Fleischberg Mission
		cSetting["entitys"] = {
			createBadElement(1300,194.03385925,-153.52893066,0.94804078,0.00000000,0.00000000,0.00000000), --object(bin1), (1),
			createBadElement(1300,220.17657471,-165.86901855,1.51267290,0.00000000,0.00000000,0.00000000), --object(bin1), (2),
			createBadElement(1224,254.91450500,-159.34924316,1.18523610,0.00000000,0.00000000,0.00000000), --object(woodenbox), (1),
			createBadElement(1344,250.35243225,-81.22100830,1.38634300,0.00000000,0.00000000,180.00000000), --object(cj_dumpster2), (1),
			createBadElement(1344,248.22999573,-81.15547180,1.38634300,0.00000000,0.00000000,179.99450684), --object(cj_dumpster2), (2),
			createBadElement(1344,251.95608521,-25.52318382,1.38634300,0.00000000,0.00000000,179.99450684), --object(cj_dumpster2), (3),
			createBadElement(1344,157.11573792,-24.03804398,1.38634300,0.00000000,0.00000000,179.99450684), --object(cj_dumpster2), (4),
			createBadElement(1344,159.82147217,-20.35340500,1.38634300,0.00000000,0.00000000,359.99450684), --object(cj_dumpster2), (5),
			createBadElement(1344,311.32226562,-184.45812988,1.38634300,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (6),
			createBadElement(1344,211.36405945,-236.39559937,1.38634300,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (7),
			createBadElement(1344,43.51575470,-220.94032288,1.50767136,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (8),
			createBadElement(1300,316.85766602,-45.47254562,0.94804078,0.00000000,0.00000000,0.00000000), --object(bin1), (3),
			createBadElement(1300,214.71412659,-117.18151093,0.92960608,0.00000000,0.00000000,0.00000000), --object(bin1), (4),
			createBadElement(1349,171.13879395,-109.16030121,1.11793613,0.00000000,0.00000000,80.00000000), --object(cj_shtrolly), (1),
			createBadElement(1349,169.95800781,-109.82910156,1.11880076,0.00000000,0.00000000,49.99877930), --object(cj_shtrolly), (2),
			createBadElement(1344,351.69042969,-132.93164062,1.64969063,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (9),
			createBadElement(1344,195.60002136,-236.89309692,1.38634300,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (10),
			createBadElement(1215,83.48355865,-157.64511108,2.15488338,0.00000000,0.00000000,0.00000000), --object(bollardlight), (1),
			createBadElement(1215,115.69419861,-180.58679199,1.04961586,0.00000000,0.00000000,0.00000000), --object(bollardlight), (2),
			createBadElement(1215,100.63563538,-168.87847900,2.10741949,0.00000000,0.00000000,0.00000000), --object(bollardlight), (3),
			createBadElement(1215,100.74658966,-160.95004272,2.10715961,0.00000000,0.00000000,0.00000000), --object(bollardlight), (4),
			createBadElement(1215,145.59516907,-151.43682861,1.14244819,0.00000000,0.00000000,0.00000000), --object(bollardlight), (5),
			createBadElement(1215,242.20217896,-62.02934265,1.14244819,0.00000000,0.00000000,0.00000000), --object(bollardlight), (6),
			createBadElement(1215,257.93487549,-62.78695679,1.14244819,0.00000000,0.00000000,0.00000000), --object(bollardlight), (7),
			createBadElement(1215,223.42353821,38.11747360,2.14244819,0.00000000,0.00000000,0.00000000), --object(bollardlight), (8),
			createBadElement(1344,318.53515625,-45.43750000,1.38798833,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (11),
			createBadElement(1344,-10.74762726,-269.65081787,5.23790550,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (12),
			createBadElement(1344,-27.47786713,-269.97445679,5.23790550,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (13),
			createBadElement(1344,-109.41689301,-355.75280762,1.23790550,0.00000000,0.00000000,359.98901367), --object(cj_dumpster2), (14)
			-- VEHICLES --
			createBadElement(467,168.01422119,-182.86054993,1.44812500,0,0,280.00000000,"vehicle", 105,30,15), --//Oceanic
			createBadElement(448,219.13908386,-180.35868835,1.24834418,0,0,80.00000000,"vehicle",132,4,15), --//Pizzaboy
			createBadElement(606,220.87191772,-238.81356812,1.67183137,0,0,0.00000000,"vehicle",-1,-1,15), --//Luggage Trailer A
			createBadElement(606,219.02023315,-238.88755798,1.67183137,0,0,0.00000000,"vehicle",-1,-1,15), --//Luggage Trailer A
			createBadElement(510,116.09620667,-183.08801270,1.18272424,0,0,0.00000000,"vehicle",42,119,15), --//Mountain Bike
			createBadElement(510,93.72752380,-160.02148438,2.28190184,0,0,270.00000000,"vehicle",42,119,15), --//Mountain Bike
			createBadElement(521,184.88720703,-91.50944519,1.20374370,0,0,0.00000000,"vehicle",115,10,15), --//FCR-900
			createBadElement(572,154.45407104,45.27852631,1.68453991,0,0,30.00000000,"vehicle",100,13,15), --//Mower
			createBadElement(572,125.30686188,-60.55821228,1.22584021,0,0,129.99816895,"vehicle",100,13,15), --//Mower
			createBadElement(572,-110.33413696,-47.18888855,2.75718737,0,0,129.99572754,"vehicle",100,13,15), --//Mower

		}
		
		for index, entity in pairs(cSetting["entitys"]) do
			setElementDimension(entity, getMyID())
			if(getElementType(entity) == "vehicle") then
				setVehicleLocked(entity, true)
			end
		end
	end
end


-- EVENT HANDLERS --

addEventHandler("buildClientMap", localPlayer, cFunc["spawnEntitys"])