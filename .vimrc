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
" Use Ctrl+Shift+l and Ctrl+Shift+k to go to the next and previous tab.
nnoremap <C-S-l> :tabn<CR>
nnoremap <C-S-k> :tabp<CR>
inoremap <C-S-l> <Esc>:tabn<CR>i
inoremap <C-S-k> <Esc>:tabp<CR>i
" redraw only when we need to.
" Buggy, sometimes I want it to draw and it doesn't.
" set lazyredraw
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
" Press <leader>q to quit all tabs.
nnoremap <leader>q :tabonly<CR>:q<CR>	

" run make and open output in horizontal split below current frame
" <bar> is the | symbol, which is used to execute more than one command at a time.
" The second (and subsequent) command(s) are only executed if the prior command succeeds. NOT a Unix pipe!

" The exclamation mark prevents make from jumping to the first error. This solves two issues:
" 1. Where closing the quickfix menu would open the file with the first error in the tab you invoked this command from, 
" which is bad if it's in a library. Even Ctrl-w+Enter didn't work in this case.
" 2. Where a compilation with a short output (e.g. a successful one) would usually (but not always for some reason) 
" require me to press Enter an extra time. Sometimes I wouldn't see the issue, but 90% of the time I did.
" set cmdheight=4 is therefore unnecessary

" So with this setup, you always need exactly two enter key presses.
" In the quickfix window, DO NOT press enter to go to the error, because it will open that file in the tab you invoked this command from, 
" regardless of what file was actually open there.
" Instead, either close the quickfix window if you don't care about the error, OR, 
" type Ctrl-w+Enter to open the error in a new horizontal split.
" The title of the tab you had open and the title of the newly split tab will somehow be swapped, which is wrong, 
" but the files themselves are correct, so no problem.
" Ctrl-w+direction to switch focus to another frame, keeping the quickfix window open.
nnoremap <C-b> :make!<bar>:copen<CR><CR>
" TODO: This only opens the quickfix window in a split in the tab you had open. 
" Assumes you will immediately fix the error. Maybe that's a good thing.
" Can I just open this in tab 1? See if I want it, if the current setup is fine, then forget it.

