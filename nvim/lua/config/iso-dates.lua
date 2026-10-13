vim.api.nvim_create_autocmd("FileType", {
	pattern = {"python", "javascript", "typescript", "go", "lua", "sh"},
	callback = function()
		local noremap = { noremap = true }

		if vim.bo.filetype == "python" then
			vim.keymap.set("i", "<Leader>dd", "datetime.datetime.now().strftime(\"%Y-%m-%d\")", noremap)
			vim.keymap.set("i", "<Leader>dt", "datetime.datetime.now().strftime(\"%Y-%m-%dT%H:%M:%S\")", noremap)
			vim.keymap.set("i", "<Leader>Dd", "datetime.datetime.now(datetime.timezone.utc).strftime(\"%Y-%m-%d\")", noremap)
			vim.keymap.set("i", "<Leader>Dt", "datetime.datetime.now(datetime.timezone.utc).strftime(\"%Y-%m-%dT%H:%M:%S\")", noremap)
		elseif vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
			-- TODO
		elseif vim.bo.filetype == "go" then
			vim.keymap.set("i", "<Leader>dd", "time.Now().Format(\"2006-01-02\")", noremap)
			vim.keymap.set("i", "<Leader>dt", "time.Now().Format(\"2006-01-02T15:04:05\")", noremap)
			vim.keymap.set("i", "<Leader>Dd", "time.Now().UTC().Format(\"2006-01-02\")", noremap)
			vim.keymap.set("i", "<Leader>Dt", "time.Now().UTC().Format(\"2006-01-02T15:04:05\")", noremap)
		elseif vim.bo.filetype == "lua" then
			vim.keymap.set("i", "<Leader>dd", "os.date(\"%Y-%m-%d\")", noremap)
			vim.keymap.set("i", "<Leader>dt", "os.date(\"%Y-%m-%dT%H:%M:%S\")", noremap)
			vim.keymap.set("i", "<Leader>Dd", "os.date(\"!%Y-%m-%d\")", noremap)
			vim.keymap.set("i", "<Leader>Dt", "os.date(\"!%Y-%m-%dT%H:%M:%S\")", noremap)
		elseif vim.bo.filetype == "sh" then
			vim.keymap.set("i", "<Leader>dd", "$(date \"+%F\")", noremap)
			vim.keymap.set("i", "<Leader>dt", "$(date \"+%FT%T\")", noremap)
			vim.keymap.set("i", "<Leader>Dd", "$(date -u \"+%F\")", noremap)
			vim.keymap.set("i", "<Leader>Dt", "$(date -u \"+%FT%T\")", noremap)
		end
	end
})
