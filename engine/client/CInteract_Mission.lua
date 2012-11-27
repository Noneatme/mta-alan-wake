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

addEvent("doElementActionStart", true)

cSetting["d_enabled"] = false
cSetting["d_text"] = ""
cSetting["d_timer"] = false

cSetting["random_zivi_text"] = {
	"Shit day, isn't it?",
	"I think I left my car unlocked.",
	"Uhmm, yea",
	"Nothing to do here.",
	"Hey, who are you?",
	"Beware of the shadows!",
	"So, what time is it?",
	"My grandma died yesterday.",
	"Is it still evening? damn!",
	"How can I help you?",
	"I'm thirsty...",
	"I feel alone..",
	"I'm hearing voices!",
	"Fake. All fake.",
	"I don't know why I'm here.",
	"Can I help you?",
	"I like your clothes.",
	"I have no money...",
	"I'm hungry",
	"So, why I'm here?",
}

-- FUNCTIONS --

cFunc["triggerMissionOutput"] = function(theMission)

end

cFunc["ziviChat"] = function()
	applyDialog("Civilian: "..cSetting["random_zivi_text"][math.random(1, #cSetting["random_zivi_text"])], 5000)
end

cFunc["renderDialog"] = function()
	if(cSetting["d_enabled"] == true) then
		local sx, sy = guiGetScreenSize()
		dxDrawText(cSetting["d_text"], sx/2-(400/aesx*sx), sy/2+(200/aesy*sy), sx/2+(500/aesx*sx), sy/2+(500/aesy*sy), tocolor(255, 255, 255, 200), 1.5/aesx*sx, "default-bold", "center", "center", false, true)
	end
end

function applyDialog(text, zeit, anim)
	if(isTimer(cSetting["d_timer"])) then
		killTimer(cSetting["d_timer"])
	end
	cSetting["d_enabled"] = true
	cSetting["d_text"] = text or "-"
	cSetting["d_timer"] = setTimer(function()
		cSetting["d_enabled"] = false
	end, zeit or 10000, 1)
	if(anim == true) then
		setPedAnimation(localPlayer, "ped", "IDLE_chat", zeit)
	end
end


addEventHandler("onClientRender", getRootElement(), cFunc["renderDialog"])

-- EVENT HANDLERS --

addEventHandler("doElementActionStart", getLocalPlayer(), function(theElement)
	if(getElementType(theElement) == "ped") and (getPedName(theElement) == "Barkeeperin") and (getMyMission() == 2) then
		applyDialog("Barkeepein: The darkness is dangerous. Here, take this flashlight! You can activate it using 'E'. Aim at the shadows to weak them. After that, you can kill them with a gun.\nI don't know what is happening. Please go to the farm and find Mr.Zett!", 20000)
		callServerFunction("setPlayerMission", localPlayer, 2, 3)
		setTimer(function()
		
		end, 1000, 1)
	elseif(getElementType(theElement) == "ped") and (getPedName(theElement) == "Barkeeperin") and (getMyMission() == 3) then
		if(getElementData(localPlayer, "mission3:finish") == true) then
			applyDialog("Barkeepein: Really? Damn! The darkness is very dangerous. Try to find Matt, the owner of the fleischberg company. You will find him in the company.\nYou can use my car! Here, take my keys! The Sadler is located next to the street.", 20000)
			callServerFunction("setPlayerMission", localPlayer, 3, 4)
			callServerFunction("givePlayerCar", localPlayer, getVehicleModelFromName("Sadler"), 62.330909729004, -204.59820556641, 1.3323328495026, 0, 0, 270)
		end
	elseif (getElementType(theElement) == "ped") and (getPedName(theElement) == "Civilian") then
		if(cSetting["d_enabled"] == false) then
			cFunc["ziviChat"]()
		end
	end
end)