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

local Static = {
    tab = {},
    button = {},
    staticimage = {},
    window = {},
    gridlist = {},
    label = {},
    tabpanel = {},
    checkbox = {},
}
addEvent("doAlanGetPlayerStatisticBack", true)


cSetting["binds"] = {
	["E"] = "Toggle Flashlight",
	["F1"] = "Toggle Controlcenter",
	["Mouse 2"] = "Aim Flashlight",
}

-- FUNCTIONS --


cFunc["toggleGui"] = function()
	if(guiGetVisible(Static.window[1]) == false) then
		guiSetVisible(Static.window[1], true)
		showCursor(true)
		triggerServerEvent("doAlanGetPlayerStatistic", localPlayer)
	else
		guiSetVisible(Static.window[1], false)
		showCursor(false)
	end
end

bindKey("F1", "down", cFunc["toggleGui"])


-- REFRESH --

cFunc["refreshGui"] = function(data, ip)
	guiSetText(Static.label[2], "Name: "..getPlayerName(localPlayer))
	guiSetText(Static.label[3], "Playtime: "..getElementData(localPlayer, "playtime"))
	guiSetText(Static.label[4], "First joined: "..getElementData(localPlayer, "firstjoined"))
	guiSetText(Static.label[5], "Shadows killed: "..getElementData(localPlayer, "morde"))
	guiSetText(Static.label[6], "Deaths: "..getElementData(localPlayer, "tode"))
	guiSetText(Static.label[7], "Adminlevel: "..getElementData(localPlayer, "adminlevel"))
	guiSetText(Static.label[8], "Mission: "..getMyMission())
	guiSetText(Static.label[9], "IP: "..ip)
	-- GLOBAL --
	guiSetText(Static.label[10], "Shadows killed: "..data["g:morde"])
	guiSetText(Static.label[11], "Accounts: "..data["g:accounts"])
	guiSetText(Static.label[12], "Deaths: "..data["g:tode"])
	guiSetText(Static.label[13], "Playtime: "..data["g:playtime"])
	guiSetText(Static.label[14], "Staffs: "..data["g:staffs"])
	guiSetText(Static.label[15], "Online staffs: "..data["g:staffsonline"])
	guiSetText(Static.label[17], data["g:maxdeaths"])
	guiSetText(Static.label[19], data["g:maxkills"])
	-- SHADERS --
	
	for i = 1, #Static.checkbox, 1 do
		
		local state = tonumber(gettok(getElementData(localPlayer, "shaders"), i, "|"))
		if(state == 1) then
			guiCheckBoxSetSelected(Static.checkbox[i], true)
		end
	end
end

addEventHandler("doAlanGetPlayerStatisticBack", getLocalPlayer(), cFunc["refreshGui"])

-- TOGGLE SHADER --

cFunc["toggleShader"] = function(id)
	local shaders = {}
	for i = 1, #Static.checkbox, 1 do
		shaders[i] = tonumber(gettok(getElementData(localPlayer, "shaders"), i, "|"))
	end

	if(shaders[id] == 1) then
		shaders[id] = 0
	else
		shaders[id] = 1
	end
	
	callServerFunction("setPlayerData", localPlayer, "shaders", shaders[1].."|"..shaders[2].."|"..shaders[3].."|"..shaders[4].."|"..shaders[5].."|"..shaders[6].."|"..shaders[7].."|"..shaders[8].."|"..shaders[9], true)
	setElementData(localPlayer, "shaders", shaders[1].."|"..shaders[2].."|"..shaders[3].."|"..shaders[4].."|"..shaders[5].."|"..shaders[6].."|"..shaders[7].."|"..shaders[8].."|"..shaders[9], false)
	applyShaders()
end

-- CREATION --


cFunc["createGui"] = function()
	
	local X, Y, Width, Height = getMiddleGuiPosition(404, 401)
	Static.window[1] = guiCreateWindow(X, Y, Width, Height, "Alan Wake Controlcenter", false)
	guiWindowSetSizable(Static.window[1], false)

	Static.staticimage[1] = guiCreateStaticImage(9, 17, 205, 106, ":alanwake/data/images/logo.png", false, Static.window[1])
	Static.label[1] = guiCreateLabel(216, 25, 183, 96, "Welcome to MTA Alan Wake!\nNavigate throught the Tabs.\nIf you need help, use /report.\n\n\nwww.mta-alan-wake.de", false, Static.window[1])
	guiSetFont(Static.label[1], "default-bold-small")
	Static.tabpanel[1] = guiCreateTabPanel(9, 123, 386, 269, false, Static.window[1])

	Static.tab[1] = guiCreateTab("Statistics", Static.tabpanel[1])

	Static.label[2] = guiCreateLabel(12, 41, 172, 15, "Name: -", false, Static.tab[1])
	guiSetFont(Static.label[2], "default-bold-small")
	Static.label[3] = guiCreateLabel(12, 61, 172, 16, "Playtime: -", false, Static.tab[1])
	guiSetFont(Static.label[3], "default-bold-small")
	Static.label[4] = guiCreateLabel(12, 81, 173, 15, "First joined: -", false, Static.tab[1])
	guiSetFont(Static.label[4], "default-bold-small")
	Static.label[5] = guiCreateLabel(12, 100, 173, 15, "Shadows killed: -", false, Static.tab[1])
	guiSetFont(Static.label[5], "default-bold-small")
	Static.label[6] = guiCreateLabel(12, 119, 173, 15, "Deaths: -", false, Static.tab[1])
	guiSetFont(Static.label[6], "default-bold-small")
	Static.label[7] = guiCreateLabel(12, 137, 173, 15, "Adminlevel: -", false, Static.tab[1])
	guiSetFont(Static.label[7], "default-bold-small")
	Static.label[8] = guiCreateLabel(13, 155, 173, 15, "Mission: -", false, Static.tab[1])
	guiSetFont(Static.label[8], "default-bold-small")
	Static.label[9] = guiCreateLabel(13, 173, 173, 15, "IP: -", false, Static.tab[1])
	guiSetFont(Static.label[9], "default-bold-small")
	Static.tabpanel[2] = guiCreateTabPanel(190, 8, 188, 226, false, Static.tab[1])

	Static.tab[2] = guiCreateTab("Global", Static.tabpanel[2])

	Static.label[10] = guiCreateLabel(9, 44, 169, 17, "Shadows killed: -", false, Static.tab[2])
	guiSetFont(Static.label[10], "default-bold-small")
	Static.label[11] = guiCreateLabel(9, 4, 169, 17, "Accounts: -", false, Static.tab[2])
	guiSetFont(Static.label[11], "default-bold-small")
	Static.label[12] = guiCreateLabel(9, 24, 169, 17, "Deaths: -", false, Static.tab[2])
	guiSetFont(Static.label[12], "default-bold-small")
	Static.label[13] = guiCreateLabel(9, 64, 169, 16, "Playtime: -", false, Static.tab[2])
	guiSetFont(Static.label[13], "default-bold-small")
	Static.label[14] = guiCreateLabel(9, 84, 169, 16, "Staffs: -", false, Static.tab[2])
	guiSetFont(Static.label[14], "default-bold-small")
	Static.label[15] = guiCreateLabel(9, 104, 169, 16, "Online staffs: -", false, Static.tab[2])
	guiSetFont(Static.label[15], "default-bold-small")
	Static.label[16] = guiCreateLabel(9, 124, 169, 16, "User with most deaths:", false, Static.tab[2])
	guiSetFont(Static.label[16], "default-bold-small")
	Static.label[17] = guiCreateLabel(9, 141, 169, 16, "None", false, Static.tab[2])
	guiSetFont(Static.label[17], "default-bold-small")
	Static.label[18] = guiCreateLabel(9, 159, 169, 16, "User with most kills:", false, Static.tab[2])
	guiSetFont(Static.label[18], "default-bold-small")
	Static.label[19] = guiCreateLabel(9, 177, 169, 16, "None", false, Static.tab[2])
	guiSetFont(Static.label[19], "default-bold-small")

	Static.tab[3] = guiCreateTab("Credits", Static.tabpanel[2])

	Static.label[20] = guiCreateLabel(6, 2, 178, 193, "Gamemode made by Noneatme\nMapstreamer made by Kreativ~\nSound effects/music from:\n- Exteel (NCSoft)\n- Oni (Rockstar Games)\n\n\n\n\n\nSpecial thanks to\nDawi, [LA]Tobi", false, Static.tab[3])
	guiSetFont(Static.label[20], "default-bold-small")


	Static.label[21] = guiCreateLabel(12, 9, 91, 15, "Local statistics:", false, Static.tab[1])
	guiSetFont(Static.label[21], "default-bold-small")
	Static.label[22] = guiCreateLabel(6, 14, 173, 15, "_________________________________________", false, Static.tab[1])
	guiLabelSetColor(Static.label[22], 0, 255, 149)
	Static.button[1] = guiCreateButton(14, 204, 164, 24, "Close", false, Static.tab[1])
	guiSetProperty(Static.button[1], "NormalTextColour", "FFAAAAAA")

	Static.tab[4] = guiCreateTab("Binds", Static.tabpanel[1])

	Static.gridlist[1] = guiCreateGridList(10, 6, 371, 229, false, Static.tab[4])
	guiGridListAddColumn(Static.gridlist[1], "Bind name", 0.4)
	guiGridListAddColumn(Static.gridlist[1], "Key", 0.4)
	
	for index, key in pairs(cSetting["binds"]) do
		local row = guiGridListAddRow(Static.gridlist[1])
		guiGridListSetItemText(Static.gridlist[1], row, 1, "'"..index.."'", false, false)
		guiGridListSetItemText(Static.gridlist[1], row, 2, key, false, false)
	end
	guiSetFont(Static.gridlist[1], "default-bold-small")
	Static.tab[5] = guiCreateTab("FAQ", Static.tabpanel[1])

	Static.label[23] = guiCreateLabel(9, 3, 310, 21, "In Development", false, Static.tab[5])
	guiSetFont(Static.label[23], "default-bold-small")
	
	
	Static.tab[6] = guiCreateTab("Shaders", Static.tabpanel[1])

	Static.label[24] = guiCreateLabel(7, 4, 264, 16, "Select the shaders you wish to enable/disable.", false, Static.tab[6])
	guiSetFont(Static.label[24], "default-bold-small")
	Static.checkbox[1] = guiCreateCheckBox(11, 29, 134, 18, "Bloom shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[1], "default-bold-small")
	Static.checkbox[2] = guiCreateCheckBox(11, 50, 134, 18, "Roadshine shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[2], "default-bold-small")
	Static.checkbox[3] = guiCreateCheckBox(11, 70, 134, 18, "Contrast shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[3], "default-bold-small")
	Static.checkbox[4] = guiCreateCheckBox(11, 90, 134, 18, "Water shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[4], "default-bold-small")
	Static.checkbox[5] = guiCreateCheckBox(11, 111, 134, 18, "Reflection shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[5], "default-bold-small")
	Static.checkbox[6] = guiCreateCheckBox(11, 132, 134, 18, "DoF Shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[6], "default-bold-small")
	Static.checkbox[7] = guiCreateCheckBox(11, 153, 134, 18, "Snow shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[7], "default-bold-small")
	Static.checkbox[8] = guiCreateCheckBox(11, 174, 134, 18, "Radial Blur shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[8], "default-bold-small")
	Static.checkbox[9] = guiCreateCheckBox(11, 194, 134, 18, "Motion Blur shader", false, false, Static.tab[6])
	guiSetFont(Static.checkbox[9], "default-bold-small")
	Static.label[25] = guiCreateLabel(10, 219, 199, 15, "Warning: Do not enable all shaders.", false, Static.tab[6])
	guiSetFont(Static.label[25], "default-bold-small")
	guiLabelSetColor(Static.label[25], 255, 0, 0)
	Static.label[27] = guiCreateLabel(176, 26, 66, 15, "Preview:", false, Static.tab[6])
	guiSetFont(Static.label[27], "default-bold-small")
	Static.label[28] = guiCreateLabel(4, 9, 307, 16, "____________________________________________", false, Static.tab[6])
	guiLabelSetColor(Static.label[28], 0, 255, 215)
	Static.staticimage[2] = guiCreateStaticImage(176, 71, 185, 105, ":alanwake/data/images/logo.png", false, Static.tab[6])
	
	for i = 1, #Static.checkbox, 1 do
		addEventHandler("onClientGUIClick", Static.checkbox[i], function()
			cFunc["toggleShader"](i)
		end, false)
	end
	-- EVENT HANDLERS --
	
	addEventHandler("onClientGUIClick", Static.button[1], cFunc["toggleGui"], false)
	
	-- FUNC --
	
	guiSetVisible(Static.window[1], false)
end

outputDebugString("Pre Create Controlcenter-GUI")
cFunc["createGui"]()
-- EVENT HANDLERS --