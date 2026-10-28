return {
	"nordtheme/vim",
	config = function()
		vim.cmd("colorscheme nord")
		vim.cmd("highlight NormalFloat guibg=#3B4252 guifg=#ECEFF4")
		vim.cmd("highlight FloatBorder guibg=#2E3440 guifg=#4C566A")
	end
}
