call plug#begin()

Plug 'github/copilot.vim'
Plug 'mattn/emmet-vim'
Plug 'nordtheme/vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'

call plug#end()

colorscheme nord

set number
set relativenumber
set tabstop=2
set shiftwidth=2
set clipboard=unnamedplus
set scrolloff=999
set nowrap

augroup togglerulertype
	autocmd!
	autocmd InsertEnter * set norelativenumber
	autocmd InsertLeave * set relativenumber
augroup END

noremap <C-z> <Nop>

nnoremap <C-j> 4j
nnoremap <C-k> 4k

inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap < <><left>
inoremap (<CR> (<CR>)<ESC>O<TAB>
inoremap {<CR> {<CR>}<ESC>O<TAB>
inoremap [<CR> [<CR>]<ESC>O<TAB>
inoremap <<CR> <<CR>><ESC>O<TAB>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>

vnoremap <C-c> "+y
vnoremap <C-x> "+x
vnoremap <C-v> "+p

let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
