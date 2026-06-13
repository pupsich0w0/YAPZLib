local __vehicleUtils = require("YAPZLib/VehicleUtils")
local __delay = require("YAPZLib/Utils").delay

local doAngledVehicleSpawnPosition = function(vehicle)
	if not __vehicleUtils.checkChunk(vehicle) then return end
	local zoneName = __vehicleUtils.getVehicleZone(vehicle)
	if not zoneName then return end
	zoneName = zoneName:lower()
	local zoneDist = VehicleZoneDistribution[zoneName]
	if zoneDist and zoneDist.positionAngles ~= nil and not zoneDist.randomAngle then
	if not zoneDist then return end
		if zoneDist.positionAngles[3] ~= true then
			local angles = zoneDist.positionAngles
			local angle = angles[ZombRand(#angles)+1]
			__vehicleUtils.setRotate(vehicle, angle)
		end
	end
end

local doAngledVehicleSpawnPositionBetween = function(vehicle)
	if not __vehicleUtils.checkChunk(vehicle) then return end
	local zoneName = __vehicleUtils.getVehicleZone(vehicle)
	if not zoneName then return end
	zoneName = zoneName:lower()
	local zoneDist = VehicleZoneDistribution[zoneName]
	if zoneDist and zoneDist.positionAngles ~= nil and not zoneDist.randomAngle then
		if zoneDist.positionAngles[3] == true then
			local angle = ZombRandFloat(zoneDist.positionAngles[1], zoneDist.positionAngles[2])
			__vehicleUtils.setRotate(vehicle, angle)
		end
	end
end

local doMissingParts = function(vehicle)
	if not __vehicleUtils.checkChunk(vehicle) then return end
	if vehicle:isGoodCar() or vehicle:isBurnt() then return end
	local zoneName = __vehicleUtils.getVehicleZone(vehicle)
	if not zoneName then return end
	zoneName = zoneName:lower()
	local zoneDist = VehicleZoneDistribution[zoneName]
	if not zoneDist then return end
	if not zoneDist.missingParts then return end
	if not zoneDist.missingParts.chance then zoneDist.missingParts.chance = 16 end
	if not zoneDist.missingParts.percent then zoneDist.missingParts.percent = 8 end
	__vehicleUtils.removeParts(vehicle, zoneDist.missingParts.chance, zoneDist.missingParts.percent)
end

local doMissingPartsDelay = function(vehicle)
	local delay = 5
	if isMultiplayer() then
		if not isServer() then return end
		delay = 10
	end
	
	__delay(doMissingParts, delay, vehicle)
end

Events.OnSpawnVehicleEnd.Add(doAngledVehicleSpawnPositionBetween)
Events.OnSpawnVehicleEnd.Add(doAngledVehicleSpawnPosition)
Events.OnSpawnVehicleEnd.Add(doMissingPartsDelay)