" enable syntax highlighting
syntax on
" and select the colour scheme
colorscheme molokai
" number of visual spaces per tab
set tabstop=4
" number of visual spaces when you press >> or << or ==
set shiftwidth=4
" dunno if this actually does anything
set background=dark
" auto tab completion
set autoindent
" auto brace and tab completion
inoremap {<CR> {<CR>}<Esc>ko<tab>
let mapleader="\<Space>"
" show line numbers
set number
" Use \k and \l to go to the previous and next tab.
nnoremap <leader>l :tabn<CR>
nnoremap <leader>k :tabp<CR>
" highlight matching [{()}]
set showmatch
" jump to the last position when reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" search as characters are entered
set incsearch           
" highlight matches
set hlsearch            
" Press \ and then space to turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
