return {
	"kdheepak/lazygit.nvim",
	config = function()
		local noremap = { noremap = true, silent = true }
		vim.keymap.set("n", "<Leader>lg", ":LazyGit<CR>", noremap)
	end
}
