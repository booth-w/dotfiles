return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true

		local noremap = { noremap = true, silent = true }
		vim.keymap.set("i", "<C-TAB>", "<Plug>(copilot-accept-line)", noremap)
		vim.keymap.set("i", "<M-TAB>", "<Plug>(copilot-accept-word)", noremap)
	end
}
