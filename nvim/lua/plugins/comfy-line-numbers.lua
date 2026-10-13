return {
	"mluders/comfy-line-numbers.nvim",
	config = function()
		require("comfy-line-numbers").setup({
			labels = (function()
				local labels = {}
				local base = 5
				local max = 99

				for i = 1, max do
					local tempI = i
					local label = ""

					while tempI > 0 do
						local digit = (tempI - 1) % base + 1
						label = tostring(digit) .. label
						tempI = math.floor((tempI - 1) / base)
					end

					labels[i] = label
				end

				return labels
			end)()
		})
	end
}
