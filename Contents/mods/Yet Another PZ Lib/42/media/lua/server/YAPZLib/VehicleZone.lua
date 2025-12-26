YAPZLib = YAPZLib or {}
YAPZLib.VehicleZone = {}

YAPZLib.VehicleZone.ChangeName = function(zoneX, zoneY, zoneZ, newName, doModdedCheck)
	local vehicleZone = getVehicleZoneAt(zoneX, zoneY, zoneZ)
	if vehicleZone ~= nil then
		local shouldChange = true
		if doModdedCheck then
			shouldChange = not YAPZLib.Cell.IsModded(math.floor(zoneX/256), math.floor(zoneY/256))
		end
		if shouldChange and newName then
			vehicleZone:setName(newName)
			vehicleZone:setOriginalName(newName)
		end
	end
end

YAPZLib.VehicleZone.ChangePosition = function(zoneX, zoneY, zoneZ, newX, newY, doModdedCheck)
	local vehicleZone = getVehicleZoneAt(zoneX, zoneY, zoneZ)
	if vehicleZone ~= nil then
		local shouldChange = true
		if doModdedCheck then
			shouldChange = not YAPZLib.Cell.IsModded(math.floor(zoneX/256), math.floor(zoneY/256))
		end
		if shouldChange then
			if newX ~= nil then
			vehicleZone:setX(newX)
			end
			if newY ~= nil and newX ~= nil then
				local newVehicleZone = getVehicleZoneAt(newX, zoneY, zoneZ)
				newVehicleZone:setY(newY)
			elseif newY ~= nil then
				newVehicleZone:setY(newY)
			end
		end
	end
end

YAPZLib.VehicleZone.ChangeSize = function(zoneX, zoneY, zoneZ, newWidht, newHeight, doModdedCheck)
	local vehicleZone = getVehicleZoneAt(zoneX, zoneY, zoneZ)
	if vehicleZone ~= nil then
		local shouldChange = true
		if doModdedCheck then
			shouldChange = not YAPZLib.Cell.IsModded(math.floor(zoneX/256), math.floor(zoneY/256))
		end
		if shouldChange then
			if newWidht ~= nil then
				vehicleZone:setW(newWidht)
			end
			if newHeight ~= nil then
				vehicleZone:setH(newHeight)
			end
		end
	end
end

YAPZLib.VehicleZone.Remove = function(zoneX, zoneY, zoneZ)
	local vehicleZone = getVehicleZoneAt(zoneX, zoneY, zoneZ)
	if vehicleZone ~= nil then
		local cx = math.floor(zoneX/256)
		local cy = math.floor(zoneY/256)
		local cellData = getWorld():getMetaGrid():getCellData(cx, cy)
		local cellDataZonesField = YAPZLib.ClassField.Get(cellData, "VehiclesZones")
		if cellDataZonesField then
			local cellDataZones = getClassFieldVal(cellData, cellDataZonesField)
			if cellDataZones then
				for i=cellDataZones:size(), 1, -1 do
					local cellDataZone = cellDataZones:get(i-1)
					if cellDataZone:getName() == vehicleZone:getName() and cellDataZone:getX() == zoneX and cellDataZone:getY() == zoneY and cellDataZone:getZ() == zoneZ then
						vehicleZones:remove(cellDataZone)
						break
					end
				end
			end
		end
	end
end

YAPZLib.VehicleZone.Register = function(zoneObjs, doModdedCheck)
	for _, vehicleZone in ipairs(zoneObjs) do
		if vehicleZone.type == "ParkingStall" then
			local shouldRegister = true
			if doModdedCheck then
				shouldRegister = not YAPZLib.Cell.IsModded(math.floor(vehicleZone.x/256), math.floor(vehicleZone.y/256))
			end
			if shouldRegister then
				local newVehicleZone = getWorld():registerVehiclesZone(vehicleZone.name, vehicleZone.type, vehicleZone.x, vehicleZone.y, vehicleZone.z, vehicleZone.width, vehicleZone.height, vehicleZone.properties)
				if newVehicleZone == nil then
					getWorld():registerZone(vehicleZone.name, vehicleZone.type, vehicleZone.x, vehicleZone.y, vehicleZone.z, vehicleZone.width, vehicleZone.height)
				end
			end
		end
	end
end