--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]

clientElement = {}

-- FUNCTIONS --

addEvent("buildClientMap", true)


-- EVENT HANDLERS --

addEventHandler("buildClientMap", getLocalPlayer(), function()
	for index, element in pairs(clientElement) do
		setElementDimension(element, getElementData(source, "id"))
	end
end)


function setElementToMap(theElement, state)
	if(theElement ~= nil) then
		if not(state) then state = true end
		if(state == true) then
			clientElement[theElement] = theElement
		else
			clientElement[theElement] = nil
		end
	end
end