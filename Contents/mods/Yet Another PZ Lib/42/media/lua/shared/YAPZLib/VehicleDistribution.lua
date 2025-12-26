YAPZLib = YAPZLib or {}
YAPZLib.VehicleDistribution = {}

YAPZLib.VehicleDistribution.Copy = function(vehicleDistribution)
	if not VehicleDistributions[vehicleDistribution] then return end
	local copy = {
		rolls = VehicleDistributions[vehicleDistribution].rolls,
		items = {},
		junk = {
			rolls = VehicleDistributions[vehicleDistribution].junk.rolls,
			ignoreZombieDensity = VehicleDistributions[vehicleDistribution].junk.ignoreZombieDensity,
			items = {},
		},
	}
	for _, i in ipairs(VehicleDistributions[vehicleDistribution].items) do
		table.insert(copy.items, i)
	end
	for _, j in ipairs(VehicleDistributions[vehicleDistribution].junk.items) do
		table.insert(copy.junk.items, j)
	end
	return copy
end

YAPZLib.VehicleDistribution.Find = function(vehicleDistribution, itemName, doJunk)
	if not VehicleDistributions[vehicleDistribution] then return end
	local distibutionTable
	if doJunk == true then
		distibutionTable = VehicleDistributions[vehicleDistribution].junk.items
	else
		distibutionTable = VehicleDistributions[vehicleDistribution].items
	end
	if not distibutionTable then return end
	for _, i in ipairs(distibutionTable) do
		if i == itemName then
			return true
		end
	end
	return false
end

YAPZLib.VehicleDistribution.Remove = function(vehicleDistribution, itemName, doJunk)
	if not VehicleDistributions[vehicleDistribution] then return end
	local distibutionTable
	if doJunk == true then
		distibutionTable = VehicleDistributions[vehicleDistribution].junk.items
	else
		distibutionTable = VehicleDistributions[vehicleDistribution].items
	end
	if not distibutionTable then return end
	local i = 1
    while i <= #distibutionTable do
        if distibutionTable[i] == itemName then
            table.remove(distibutionTable, i)
            table.remove(distibutionTable, i) 
        else
            i = i + 2
        end
    end
end

YAPZLib.VehicleDistribution.Add = function(vehicleDistribution, itemName, itemChance, doJunk)
	if not VehicleDistributions[vehicleDistribution] then return end
	local distibutionTable
	if doJunk == true then
		distibutionTable = VehicleDistributions[vehicleDistribution].junk.items
	else
		distibutionTable = VehicleDistributions[vehicleDistribution].items
	end
	if not distibutionTable then return end
	table.insert(distibutionTable, itemName)
	table.insert(distibutionTable, itemChance)
end

YAPZLib.VehicleDistribution.AddSpecialLootChance = function(vehicleName, paramValue)
	local vehicle = ScriptManager.instance:getVehicle(vehicleName)
	if vehicle then
		vehicle:Load(vehicleName, table.concat({
			"{",
				"specialLootChance = ", tostring(paramValue), ",",
			"}",
		}, " "))
	end
end