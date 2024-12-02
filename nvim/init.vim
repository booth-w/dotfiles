call plug#begin()

Plug 'ntpeters/vim-better-whitespace'
Plug 'github/copilot.vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim'
Plug 'nordtheme/vim'
Plug 'tpope/vim-surround'
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

colorscheme nord

set number
set relativenumber
set tabstop=2
set shiftwidth=2
set scrolloff=999
set nowrap
set foldlevel=99
set foldmethod=indent

augroup togglerulertype
	autocmd!
	autocmd InsertEnter * set norelativenumber
	autocmd InsertLeave * set relativenumber
augroup END

noremap <C-z> <Nop>
noremap <C-j> 4j
noremap <C-k> 4k

nnoremap <silent> <A-z> :set wrap!<CR>
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap < <><left>
inoremap (<CR> (<CR>)<ESC>O
inoremap {<CR> {<CR>}<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap <<CR> <<CR>><ESC>O
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>

vnoremap <C-c> "+y
vnoremap <C-x> "+x
vnoremap <C-v> "+p

let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
