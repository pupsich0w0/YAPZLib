YAPZLib = YAPZLib or {}
YAPZLib.Delay = {}
YAPZLib.Delay.Tab = {}

YAPZLib.Delay.Process = function()
	for i=#YAPZLib.Delay.Tab, 1, -1 do
		local delayedFunc = YAPZLib.Delay.Tab[i]
		local ticks = delayedFunc.ticks
		if ticks then
			delayedFunc.ticks = ticks - 1
			if delayedFunc.ticks <= 0 then
				delayedFunc.func(unpack(delayedFunc.args))
				table.remove(YAPZLib.Delay.Tab, i)
			end
		end
		if #YAPZLib.Delay.Tab == 0 then
			Events.OnTick.Remove(delayFunc)
		end
	end
end

YAPZLib.Delay.Add = function(func, ticks, args)
	table.insert(YAPZLib.Delay.Tab, { func = func, ticks = ticks, args = args })
	Events.OnTick.Add(YAPZLib.Delay.Process)
end