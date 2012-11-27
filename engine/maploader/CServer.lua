--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme & Kreativ                   ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]

function loadResourceMap( player, resource )
	local resourceName = getResourceName( resource )
		if resourceName then
		local metaRoot = xmlLoadFile(':'..resourceName..'/meta.xml')
			if metaRoot then
				for i, v in ipairs( xmlNodeGetChildren( metaRoot ) ) do 
					if xmlNodeGetName( v ) == 'map' then
					local mapPath = xmlNodeGetAttribute(v,'src')
					local mapRoot = xmlLoadFile(':'..resourceName..'/'..mapPath)
						if mapRoot then
						local mapContent = {}
							for i, v in ipairs( xmlNodeGetChildren( mapRoot ) ) do 
							local typ = xmlNodeGetName( v )
								if typ == 'object' then
								table.insert( mapContent, { typ, -- 1
															xmlNodeGetAttribute(v,'interior'), -- 2
															xmlNodeGetAttribute(v,'alpha'), -- 3
															xmlNodeGetAttribute(v,'doublesided'), -- 4
															xmlNodeGetAttribute(v,'model'), -- 5
															xmlNodeGetAttribute(v,'scale'), -- 6
															xmlNodeGetAttribute(v,'dimension'), -- 7
															xmlNodeGetAttribute(v,'posX'), -- 8
															xmlNodeGetAttribute(v,'posY'), -- 9
															xmlNodeGetAttribute(v,'posZ'), -- 10
															xmlNodeGetAttribute(v,'rotX'),-- 11
															xmlNodeGetAttribute(v,'rotY'), -- 12
															xmlNodeGetAttribute(v,'rotZ') } ) -- 13
								end
							end
						triggerClientEvent(player, 'onServerSendMapContent', player, mapContent )
						xmlUnloadFile( mapRoot )
						end
					end
				end
			xmlUnloadFile( metaRoot )
			end
		end
end

-- BETA

--[[
addCommandHandler('leni', function( p )
	loadResourceMap( p, getResourceFromName('rugusxv3'))
end)]]