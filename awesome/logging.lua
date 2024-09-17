naughty = require("naughty")

function log(...)
	local msg = ""
	for i, v in ipairs({...}) do
		msg = msg .. tostring(v) .. "\n"
	end

	naughty.notify({text = tostring(msg), title = "Log", timeout = 0, position = "top_right"})
end
