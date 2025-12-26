YAPZLib = YAPZLib or {}
YAPZLib.Vehicle = {}

YAPZLib.Vehicle.GetVehicleZone = function(vehicle)
	local vehicleZone = getVehicleZoneAt(vehicle:getX(), vehicle:getY(), vehicle:getZ())
	if vehicleZone ~= nil then
		local zoneName
		if vehicleZone:getName() == "" then
			zoneName = "parkingstall"
		else
			zoneName = vehicleZone:getName()
		end
		return vehicleZone, zoneName
	end
	return nil
end

YAPZLib.Vehicle.CheckChunk = function(vehicle)
	local chunk = vehicle:getChunk()
	if not chunk then return false end
	if not chunk:isNewChunk() then return false end
	return true
end

YAPZLib.Vehicle.RemovePart = function(vehicle, part)
	part:setInventoryItem(nil)
	vehicle:transmitPartItem(part)
end

YAPZLib.Vehicle.SetBatteryCharge = function(vehicle, charge)
	if charge < 0 then return end
	if charge > 1 and charge <= 100 then
		charge = charge / 100
	end
	local battery = vehicle:getBattery()
	if battery then
		local batteryItem = battery:getInventoryItem()
		if batteryItem then
			batteryItem:setUsedDelta(charge)
		end
	end
end

YAPZLib.Vehicle.GetOverallCondition = function(vehicle)
	local sumConditions = 0
	local partCount = vehicle:getPartCount()
	for i = 0, partCount - 1 do
		local part = vehicle:getPartByIndex(i)
		if part then
			local partCondition = part:getCondition()
			sumConditions = sumConditions + partCondition
		end
	end
	return sumConditions / partCount
end

YAPZLib.Vehicle.SetRotate = function(vehicle, angle)
	if tostring(vehicle:getDir()) == "N" or tostring(vehicle:getDir()) == "W" then
		vehicle:setAngles(vehicle:getAngleX(), vehicle:getAngleY() + angle, vehicle:getAngleZ())
	elseif tostring(vehicle:getDir()) == "S" or tostring(vehicle:getDir()) == "E" then
		vehicle:setAngles(vehicle:getAngleX(), vehicle:getAngleY() - angle, vehicle:getAngleZ())
	end
end

YAPZLib.Vehicle.GetSquaresInRadius = function(vehicle, radius)
	local squares = {}
	local vehicleX = vehicle:getX()
	local vehicleY = vehicle:getY()
	for x = vehicleX - radius, vehicleX + radius do
		for y = vehicleY - radius, vehicleY + radius do
			if math.sqrt((x - vehicleX) ^ 2 + (y - vehicleY) ^ 2) <= radius then
				local square = getCell():getGridSquare(x, y, vehicle:getZ())
				if square then
					table.insert(squares, square)
				end
			end
		end
	end
	return squares
end