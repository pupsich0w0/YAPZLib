YAPZLib = YAPZLib or {}
YAPZLib.Cell = {}

YAPZLib.Cell.IsModded = function(cellX, cellY)
	local dirs = getLotDirectories()
    for i=dirs:size(), 1, -1 do
		local dirName = dirs:get(i-1)
		if dirName ~= "Muldraugh, KY" then
			local lotfile = 'media/maps/'..dirName..'/'..cellX..'_'..cellY..'.lotheader'
			if fileExists(lotfile) then
				return true
			end
		end
	end
	return false
end