vim.opt.title = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = false

vim.opt.colorcolumn = "80"

vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"
vim.opt.foldminlines = 0


-- disable intro
vim.opt.shortmess:append("I")

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	command = "set norelativenumber"
})
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set relativenumber"
})

-- re-overwrite options changed by ftplugin
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = false

		vim.opt_local.scrolloff = 999

		vim.opt_local.wrap = false
		vim.opt_local.linebreak = true

		vim.opt_local.formatoptions = "qlj"

		-- add a space surrounding the comment string (#%s to # %s)
		local cs = vim.opt.commentstring:get()
		if cs ~= "" then
			cs = cs:gsub("([^%s])%%s", "%1 %%s")
			cs = cs:gsub("%%s([^%s])", "%%s %1")
		else
			cs = "# %s"
		end
		vim.opt_local.commentstring = cs
	end
})

-- space-required filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"yaml"},
	callback = function()
		vim.opt_local.expandtab = true
	end
})
