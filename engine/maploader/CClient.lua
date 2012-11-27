--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme & Kreativ                   ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]


local mainMapElement = createElement('mainMapElement')

function onServerSendMapContent( mapContent )
	if type( mapContent ) == 'table' then
		if #mapContent ~= 0 then
			for i, content in ipairs( mapContent ) do
				if content[1] == 'object' then
				-- OBJ
				local obj = createObject( content[5], content[8], content[9], content[10], content[11], content[12], content[13] )
				setElementInterior(obj, tonumber(content[2] ))
				setElementAlpha( obj, tonumber(content[3] ))
				setElementDoubleSided( obj, toboolean(content[4])) -- 4
				setObjectScale( obj, tonumber(content[6]) )
				-- PARENT
				setElementParent( obj, mainMapElement )
				setElementDimension(obj, getElementData(localPlayer, "id"))
				end
			end
			
		end
	end
end
addEvent('onServerSendMapContent', true)
addEventHandler('onServerSendMapContent', getRootElement(), onServerSendMapContent)

function toboolean( string )
	if string == 'false' or string == "false" then
		return false
	elseif string == 'true' or string == "true" then
		return true
	end
end

-- BETA
--[[
addCommandHandler('xd', function()
	for i, v in next, getElementsByType( 'object', getElementParent( mainMapElement ) ) do 
		destroyElement( v )
	end
end)]]