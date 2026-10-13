return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{"hrsh7th/nvim-cmp"},
		{"hrsh7th/cmp-nvim-lsp"},
		{"hrsh7th/vim-vsnip"},

		{"mfussenegger/nvim-dap"},

		{"OmniSharp/omnisharp-vim"},
		{"mattn/emmet-vim"},
	},

	config = function()
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
			sources = cmp.config.sources(
				{{name = "nvim_lsp"}},
				{{name = "buffer"}}
			),
			window = {
				documentation = cmp.config.window.bordered(),
				completion = cmp.config.window.bordered(),
			}
		})

		vim.diagnostic.config({
			virtual_text = {
				prefix = "● "
			}
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local buf = args.buf
				local opts = { noremap = true, silent = true, buffer = buf }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

				vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, opts)
			end
		})

		vim.lsp.enable({
			"pyright",
			"gopls",
			"ts_ls",
			"cssls",
			"lua_ls",
			"omnisharp",
			"yamlls"
		}, {
			yamlls = {
				settings = {
					yaml = {
						schemas = {
							["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
							["https://github.com/compose-spec/compose-go/blob/main/schema/compose-spec.json"] = "docker-compose.y*ml",
							["https://spec.openapis.org/oas/3.2/schema/2025-09-17"] = {"openapi*.y*ml", "openapi*.json"}
						}
					}
				}
			}
		})

		-- go fmt on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end
		})
	end
}
