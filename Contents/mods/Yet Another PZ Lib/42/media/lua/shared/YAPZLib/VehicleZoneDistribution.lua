YAPZLib = YAPZLib or {}
YAPZLib.VehicleZoneDistribution = {}
YAPZLib.VehicleZoneDistribution.VanillaZones = {}

local vanillaZones = { "parkingstall", "trailerpark", "bad", "medium", "good", "luxuryDealership", "sport", "junkyard", "trafficjams", "police", "prison", "fire", "ranger", "mccoy", "carpenter", "postal", "spiffo", "ambulance", "radio", "fossoil", "scarlet", "massgenfac", "transit", "network3", "kyheralds", "lectromax", "knoxdisti", "advertising", "airportshuttle", "airportservice", "farm", "business", "normalburnt", "specialburnt", "trades", "delivery", "professional", "middleClass", "struggling", "evacuee" }

for _, zoneName in ipairs(vanillaZones) do
	YAPZLib.VehicleZoneDistribution.VanillaZones[zoneName] = true
end

YAPZLib.VehicleZoneDistribution.NilSpawnZones = function(vehicleName, vanillaOnly)
	if not VehicleZoneDistribution then return end
	local zones
	if vanillaOnly then
		zones = YAPZLib.VehicleZoneDistribution.VanillaZones
	else
		zones = VehicleZoneDistribution
	end
	if not zones then return end
	for zoneName, _ in pairs(zones) do
		VehicleZoneDistribution[zoneName].vehicles[vehicleName] = nil
	end
end