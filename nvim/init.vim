call plug#begin()

Plug 'github/copilot.vim'
Plug 'mattn/emmet-vim'
Plug 'nordtheme/vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'

call plug#end()

colorscheme nord

set number
set relativenumber
set tabstop=2
set shiftwidth=2

augroup togglerulertype
	autocmd!
	autocmd InsertEnter * set norelativenumber
	autocmd InsertLeave * set relativenumber
augroup END

