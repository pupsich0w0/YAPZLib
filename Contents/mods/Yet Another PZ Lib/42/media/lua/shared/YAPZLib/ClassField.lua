YAPZLib = YAPZLib or {}
YAPZLib.ClassField = {}

YAPZLib.ClassField.Get = function(obj, fieldName)
	local fieldsNum = getNumClassFields(obj)
	for i=0, fieldsNum-1 do
		local field = getClassField(obj, i)
		if tostring(field):match(fieldName.."$") then
			return field
		end
	end
end

YAPZLib.ClassField.GetValue = function(obj, fieldName)
	local field = YAPZLib.ClassField.Get(obj, fieldName)
	if field then
		local fieldVal = getClassFieldVal(obj, field)
		return fieldVal
	end
end