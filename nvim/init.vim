call plug#begin()

" highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'
" colourise hex colors
Plug 'norcalli/nvim-colorizer.lua'
" comments (gc)
Plug 'tpope/vim-commentary'
" copilot
Plug 'github/copilot.vim'
" emmet
Plug 'mattn/emmet-vim'
" mark git changes
Plug 'airblade/vim-gitgutter'
" indent lines
Plug 'lukas-reineke/indent-blankline.nvim'
" lazygit
Plug 'kdheepak/lazygit.nvim'
" lsp
Plug 'neovim/nvim-lspconfig'
" markdown stuff
Plug 'preservim/vim-markdown'
" telescope dependency
Plug 'nvim-lua/plenary.nvim'
" swap diff
Plug 'chrisbra/Recover.vim'
" markdown preview
Plug 'MeanderingProgrammer/render-markdown.nvim'
" telescope
Plug 'nvim-telescope/telescope.nvim'
" treesitter
Plug 'nvim-treesitter/nvim-treesitter'
" treesitter for markdown
Plug 'tree-sitter-grammars/tree-sitter-markdown'
" nord theme
Plug 'nordtheme/vim'
" change surround stuff (cs, ys, ds)
Plug 'tpope/vim-surround'
" vim practice
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

lua require("ibl").setup()

lua <<EOF
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
	})
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig")["pyright"].setup {
	capabilities = capabilities
}
require("lspconfig")["cssls"].setup {
	capabilities = capabilities
}
require("lspconfig")["gopls"].setup {
	capabilities = capabilities
}
EOF

colorscheme nord

set title

set number
set relativenumber

set tabstop=2
set shiftwidth=2

set scrolloff=999

set nowrap
set linebreak

set formatoptions=nl

set foldlevel=99
set foldmethod=indent
set foldminlines=0

set termguicolors

lua require("colorizer").setup()

autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

autocmd CmdlineLeave : echo ""

noremap <C-z> <Nop>

noremap <C-j> 4j
noremap <C-k> 4k

nnoremap <C-a> ggVG

nnoremap <A-j> ddjP==
nnoremap <A-k> ddkP==

nnoremap <silent> <A-z> :set wrap!<CR>

nnoremap <Leader>ff :Telescope find_files<CR>
nnoremap <Leader>fg :Telescope live_grep<CR>

nnoremap <Leader>lg :LazyGit<CR>

inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>

inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap {<CR> {<CR>}<ESC>O
inoremap <<CR> <<CR>><ESC>O

inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>

inoremap <C-BS> <C-w>

vnoremap <C-c> "+y
vnoremap <C-x> "+d
vnoremap <C-v> "+p

autocmd FileType markdown nnoremap <buffer> gt :Toc<CR>

let g:python_recommended_style = 0
let g:markdown_recommended_style = 0

let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
