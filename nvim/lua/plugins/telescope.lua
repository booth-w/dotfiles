return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{"nvim-telescope/telescope-file-browser.nvim"},
		{"nvim-telescope/telescope-fzf-native.nvim",
			build = "make"
		},
		{"nvim-telescope/telescope-ui-select.nvim"}
	},

	config = function()
		local ts_actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions

		require("telescope").setup {
			defaults = {
				initial_mode = "normal",
				layout_config = {
					horizontal = {
						width = {
							padding = 0
						},
						height = {
							padding = 0
						}
					}
				},
				mappings = {
					["n"] = {
						["<C-c>"] = "close",
						["l"] = "select_default",
						["<C-h>"] = "preview_scrolling_left",
						["<C-j>"] = "preview_scrolling_down",
						["<C-k>"] = "preview_scrolling_up",
						["<C-l>"] = "preview_scrolling_right"
					},
					["i"] = {
						["<C-c>"] = function() vim.cmd("stopinsert") end,
						["<C-h>"] = "preview_scrolling_left",
						["<C-j>"] = "preview_scrolling_down",
						["<C-k>"] = "preview_scrolling_up",
						["<C-l>"] = "preview_scrolling_right"
					}
				}
			},
			extensions = {
				file_browser = {
					mappings = {
						["n"] = {
							["e"] = "select_default",
							["n"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["."] = fb_actions.toggle_hidden,
						},
					},
					grouped = true
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown {
					}
				}
			}
		}

		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("fidget")

		local noremap = { noremap = true, silent = true }
		vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", noremap)
		vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", noremap)
		vim.keymap.set("n", "<Leader>fw", ":Telescope grep_string<CR>", noremap)
		vim.keymap.set("n", "<Leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", noremap)
		vim.keymap.set("n", "grr", ":Telescope lsp_references<CR>", noremap)
	end
}
