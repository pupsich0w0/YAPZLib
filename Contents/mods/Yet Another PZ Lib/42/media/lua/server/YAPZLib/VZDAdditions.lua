YAPZLib = YAPZLib or {}
YAPZLib.VZDAdditions = {}

YAPZLib.VZDAdditions.DoAngledVehicleSpawnPosition = function(vehicle)
	if not YAPZLib.Vehicle.CheckChunk(vehicle) then return end
	local zone, zoneName = YAPZLib.Vehicle.GetVehicleZone(vehicle)
	if zone ~= nil then
		if VehicleZoneDistribution[zoneName] ~= nil then
			if VehicleZoneDistribution[zoneName].positionAngles ~= nil and not VehicleZoneDistribution[zoneName].randomAngle then
				if VehicleZoneDistribution[zoneName].positionAngles[3] ~= true then
					local angles = VehicleZoneDistribution[zoneName].positionAngles
					local angle = angles[ZombRand(#angles)+1]
					YAPZLib.Vehicle.SetRotate(vehicle, angle)
				end
			end
		end
	end
end

YAPZLib.VZDAdditions.DoAngledVehicleSpawnPositionBetween = function(vehicle)
	if not YAPZLib.Vehicle.CheckChunk(vehicle) then return end
	local zone, zoneName = YAPZLib.Vehicle.GetVehicleZone(vehicle)
	if zone ~= nil then
		if VehicleZoneDistribution[zoneName] ~= nil then
			if VehicleZoneDistribution[zoneName].positionAngles ~= nil and not VehicleZoneDistribution[zoneName].randomAngle then
				if VehicleZoneDistribution[zoneName].positionAngles[3] == true then
					local angle = ZombRandFloat(VehicleZoneDistribution[zoneName].positionAngles[1], VehicleZoneDistribution[zoneName].positionAngles[2])
					YAPZLib.Vehicle.SetRotate(vehicle, angle)
				end
			end
		end
	end
end

YAPZLib.VZDAdditions.DoMissingParts = function(vehicle)
	local zone, zoneName = YAPZLib.Vehicle.GetVehicleZone(vehicle)
	if zone ~= nil then
		if VehicleZoneDistribution[zoneName] ~= nil then
			if VehicleZoneDistribution[zoneName].vehicleWithoutPartsChance ~= nil and VehicleZoneDistribution[zoneName].percentOfMissingParts ~= nil then
				local partsCount = vehicle:getPartCount()
				local missingParts = {}
				missingParts.count = 0
				if not vehicle:isGoodCar() and not vehicle:isBurnt() then
					if ZombRand(100) + 1 <= VehicleZoneDistribution[zoneName].vehicleWithoutPartsChance then
						while (missingParts.count * 100) / partsCount < VehicleZoneDistribution[zoneName].percentOfMissingParts do
							for i = 0, vehicle:getPartCount() - 1 do
								if (missingParts.count * 100) / partsCount >= VehicleZoneDistribution[zoneName].percentOfMissingParts then return end
								local part = vehicle:getPartByIndex(i)
								if part then
									if ZombRand(100) + 1 <= 1 then
										if not missingParts[part:getId()] then
											local uninstall = part:getTable("uninstall")
											if uninstall then
												if uninstall.requireUninstalled then
													local childPart = vehicle:getPartById(uninstall.requireUninstalled)
													if childPart then
														YAPZLib.Vehicle.RemovePart(vehicle, childPart)
														missingParts[uninstall.requireUninstalled] = true
														missingParts.count = missingParts.count + 1
													end
													YAPZLib.Vehicle.RemovePart(vehicle, part)
													missingParts[part:getId()] = true
													missingParts.count = missingParts.count + 1
												else
													YAPZLib.Vehicle.RemovePart(vehicle, part)
													missingParts[part:getId()] = true
													missingParts.count = missingParts.count + 1
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

Events.OnSpawnVehicleEnd.Add(YAPZLib.VZDAdditions.DoAngledVehicleSpawnPosition)
Events.OnSpawnVehicleEnd.Add(YAPZLib.VZDAdditions.DoAngledVehicleSpawnPositionBetween)
Events.OnSpawnVehicleEnd.Add(YAPZLib.VZDAdditions.DoMissingParts)