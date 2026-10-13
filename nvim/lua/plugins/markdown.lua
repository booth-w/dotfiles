return {
	{"preservim/vim-markdown",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.keymap.set("n", "<Leader>gt", ":Toc<CR>", { buffer = true, noremap = true })
				end
			})
		end
	},
	{"MeanderingProgrammer/render-markdown.nvim"},
}
