return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true
			}
		})
		local list = harpoon:list()

		local noremap = { noremap = true, silent = true }
		vim.keymap.set("n", "<Leader>a", function() list:add() end, noremap)
		vim.keymap.set("n", "<A-h>", function() list:select(1) end, noremap)
		vim.keymap.set("n", "<A-j>", function() list:select(2) end, noremap)
		vim.keymap.set("n", "<A-k>", function() list:select(3) end, noremap)
		vim.keymap.set("n", "<A-l>", function() list:select(4) end, noremap)
		vim.keymap.set("n", "<A-;>", function() harpoon.ui:toggle_quick_menu(list) end, noremap)
	end
}
