""" APPEARANCE

" enable syntax highlighting
syntax on
" and select the colour scheme
colorscheme molokai
" dunno if this actually does anything
set background=dark
" number of visual spaces per tab
set tabstop=4
" number of visual spaces when you press >> or << or ==
set shiftwidth=4

""" BEHAVIOUR

" To define a mapping which uses the 'mapleader' variable, the special string
"<Leader>" can be used.  It is replaced with the string value of 'mapleader'.
"If 'mapleader' is not set or empty, a backslash is used instead.
let mapleader="\<Space>"
" auto tab completion
set autoindent
" auto brace and tab completion
inoremap {<CR> {<CR>}<Esc>ko<tab>
" show line numbers
set number
" Use <leader>k and <leader>l to go to the previous and next tab.
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
" Press <leader><space> to turn off search highlight
" So if <leader> is space then this means hit space twice.
nnoremap <leader><space> :nohlsearch<CR>
