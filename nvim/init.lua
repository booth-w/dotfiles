local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- dependencies
	{"nvim-lua/plenary.nvim"},

	-- lsp
	{"neovim/nvim-lspconfig"},

	-- autocomplete
	{"hrsh7th/nvim-cmp"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/vim-vsnip"},

	-- treesitter
	{"nvim-treesitter/nvim-treesitter"},

	-- telescope
	{"nvim-telescope/telescope.nvim"},
	{"nvim-telescope/telescope-file-browser.nvim"},

	-- harpoon
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2"
	},

	-- surround (cs, ys, ds)
	{"tpope/vim-surround"},

	-- lazygit
	{"kdheepak/lazygit.nvim"},

	-- git gutter
	{"airblade/vim-gitgutter"},

	-- c# lsp
	{"OmniSharp/omnisharp-vim"},

	-- copilot
	{"github/copilot.vim"},

	-- emmet
	{"mattn/emmet-vim"},

	-- toggler
	{"nguyenvukhang/nvim-toggler"},

	-- markdown
	{"preservim/vim-markdown"},

	-- markdown preview
	{"MeanderingProgrammer/render-markdown.nvim"},

	-- swap file diff
	{"chrisbra/recover.vim"},

	-- indent lines
	{"lukas-reineke/indent-blankline.nvim"},

	-- colourise text colours
	{"norcalli/nvim-colorizer.lua"},

	-- trailing whitespace
	{"ntpeters/vim-better-whitespace"},

	-- nord theme
	{"nordtheme/vim"},
})

vim.opt.title = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.scrolloff = 999

vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.formatoptions = "qlj"

vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"
vim.opt.foldminlines = 0

vim.opt.termguicolors = true

-- disable intro
vim.opt.shortmess:append("I")

-- trailing whitespace
vim.g.better_whitespace_guicolor="#BF616A"

local noremap = { noremap = true }

vim.keymap.set({"n", "i"}, "<C-c>", "<Esc>", noremap)
vim.keymap.set("", "<C-z>", "<Nop>", noremap)

vim.keymap.set("", "<C-j>", "4j", noremap)
vim.keymap.set("", "<C-k>", "4k", noremap)

vim.keymap.set("n", "<C-a>", "ggVG", noremap)

vim.keymap.set("n", "<C-A-j>", "ddjP==", noremap)
vim.keymap.set("n", "<C-A-k>", "ddkP==", noremap)

vim.keymap.set("n", "g{", "f{V%", noremap)

vim.keymap.set("n", "<A-z>", ":set wrap!<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", noremap)
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", noremap)
vim.keymap.set("n", "<Leader>fw", ":Telescope grep_string<CR>", noremap)
vim.keymap.set("n", "<Leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", noremap)

vim.keymap.set("n", "<Leader>lg", ":LazyGit<CR>", noremap)

vim.keymap.set("i", "(", "()<left>", noremap)
vim.keymap.set("i", "[", "[]<left>", noremap)
vim.keymap.set("i", "{", "{}<left>", noremap)
vim.keymap.set("i", "<", "<><left>", noremap)

vim.keymap.set("i", "(<CR>", "(\n)<ESC>O", noremap)
vim.keymap.set("i", "[<CR>", "[\n]<ESC>O", noremap)
vim.keymap.set("i", "{<CR>", "{\n}<ESC>O", noremap)
vim.keymap.set("i", "<<CR>", "<\n><ESC>O", noremap)

vim.keymap.set("i", "\"", "\"\"<left>", noremap)
vim.keymap.set("i", "'", "''<left>", noremap)
vim.keymap.set("i", "`", "``<left>", noremap)

vim.keymap.set("i", "<C-BS>", "<C-w>", noremap)

vim.keymap.set("v", "<C-c>", '"+y', noremap)
vim.keymap.set("v", "<C-x>", '"+d', noremap)
vim.keymap.set("v", "<C-v>", '"+p', noremap)

vim.keymap.set("c", "<C-j>", "<C-n>", noremap)
vim.keymap.set("c", "<C-k>", "<C-p>", noremap)

vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-TAB>", "<Plug>(copilot-accept-line)", noremap)
vim.keymap.set("i", "<M-TAB>", "<Plug>(copilot-accept-word)", noremap)

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	command = "set norelativenumber"
})

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set relativenumber"
})

-- re-overwrite ftplugin stuff
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

-- iso dates
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"python", "javascript", "typescript", "go", "lua", "sh"},
	callback = function()
		if vim.bo.filetype == "python" then
			vim.keymap.set("i", "<Leader>dd", "datetime.datetime.now().strftime(\"%Y-%m-%d\")", { noremap = true })
			vim.keymap.set("i", "<Leader>dt", "datetime.datetime.now().strftime(\"%Y-%m-%dT%H:%M:%S\")", { noremap = true })
			vim.keymap.set("i", "<Leader>Dd", "datetime.datetime.now(datetime.timezone.utc).strftime(\"%Y-%m-%d\")", { noremap = true })
			vim.keymap.set("i", "<Leader>Dt", "datetime.datetime.now(datetime.timezone.utc).strftime(\"%Y-%m-%dT%H:%M:%S\")", { noremap = true })
		elseif vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
			-- todo
		elseif vim.bo.filetype == "go" then
			vim.keymap.set("i", "<Leader>dd", "time.Now().Format(\"2006-01-02\")", { noremap = true })
			vim.keymap.set("i", "<Leader>dt", "time.Now().Format(\"2006-01-02T15:04:05\")", { noremap = true })
			vim.keymap.set("i", "<Leader>Dd", "time.Now().UTC().Format(\"2006-01-02\")", { noremap = true })
			vim.keymap.set("i", "<Leader>Dt", "time.Now().UTC().Format(\"2006-01-02T15:04:05\")", { noremap = true })
		elseif vim.bo.filetype == "lua" then
			vim.keymap.set("i", "<Leader>dd", "os.date(\"%Y-%m-%d\")", { noremap = true })
			vim.keymap.set("i", "<Leader>dt", "os.date(\"%Y-%m-%dT%H:%M:%S\")", { noremap = true })
			vim.keymap.set("i", "<Leader>Dd", "os.date(\"!%Y-%m-%d\")", { noremap = true })
			vim.keymap.set("i", "<Leader>Dt", "os.date(\"!%Y-%m-%dT%H:%M:%S\")", { noremap = true })
		elseif vim.bo.filetype == "sh" then
			vim.keymap.set("i", "<Leader>dd", "$(date \"+%F\")", { noremap = true })
			vim.keymap.set("i", "<Leader>dt", "$(date \"+%FT%T\")", { noremap = true })
			vim.keymap.set("i", "<Leader>Dd", "$(date -u \"+%F\")", { noremap = true })
			vim.keymap.set("i", "<Leader>Dt", "$(date -u \"+%FT%T\")", { noremap = true })
		end
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "<Leader>gt", ":Toc<CR>", { buffer = true, noremap = true })
	end
})

-- nord theme
vim.cmd("colorscheme nord")
vim.cmd("highlight NormalFloat guibg=#3B4252 guifg=#ECEFF4")
vim.cmd("highlight FloatBorder guibg=#2E3440 guifg=#4C566A")

-- toggler
require('nvim-toggler').setup()

-- indent lines
require("ibl").setup()

-- colourise text colours
require("colorizer").setup()

-- telescope
local ts_actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
require("telescope").setup({
	defaults = {
		mappings = {
			["n"] = {
				["<C-c>"] = ts_actions.close
			},
			["i"] = {
				["<C-c>"] = function() vim.cmd("stopinsert") end
			}
		}
	},
	extensions = {
		file_browser = {
			mappings = {
				["n"] = {
					["l"] = "select_default",
					["<C-h>"] = "preview_scrolling_left",
					["<C-j>"] = "preview_scrolling_down",
					["<C-k>"] = "preview_scrolling_up",
					["<C-l>"] = "preview_scrolling_right"
				},
				["i"] = {
					["<C-h>"] = "preview_scrolling_left",
					["<C-j>"] = "preview_scrolling_down",
					["<C-k>"] = "preview_scrolling_up",
					["<C-l>"] = "preview_scrolling_right"
				}
			},
			grouped = true
		}
	}
})

require("telescope").load_extension("file_browser")

-- harpoon
local harpoon = require("harpoon")

harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true
	}
})
local list = harpoon:list()

vim.keymap.set("n", "<Leader>a", function() list:add() end, noremap)
vim.keymap.set("n", "<A-h>", function() list:select(1) end, noremap)
vim.keymap.set("n", "<A-j>", function() list:select(2) end, noremap)
vim.keymap.set("n", "<A-k>", function() list:select(3) end, noremap)
vim.keymap.set("n", "<A-l>", function() list:select(4) end, noremap)
vim.keymap.set("n", "<A-;>", function() harpoon.ui:toggle_quick_menu(list) end, noremap)
vim.keymap.set("n", "q", function() harpoon.ui:toggle_quick_menu(list) end, noremap)

-- lsp
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-j>"] = cmp.mapping.select_next_item({behvior = cmp.SelectBehavior.Select}),
		["<C-k>"] = cmp.mapping.select_prev_item({behvior = cmp.SelectBehavior.Select}),
		["<C-S-j>"] = cmp.mapping.scroll_docs(4),
		["<C-S-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<TAB>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{name = "nvim_lsp"}
	}, {
		{name = "buffer"}
	}),
	window = {
		documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered(),
	}
})

vim.diagnostic.config({
	virtual_text = true
})

vim.lsp.enable({
	"pyright",
	"gopls",
	"ts_ls",
	"cssls",
	"lua_ls",
	"omnisharp"
})
