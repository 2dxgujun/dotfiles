" Hit S in command mode to save.
noremap S :w<CR>

" Set pastetoggle
set pastetoggle=<F11>

" Make Q useful and avoid the confusing Ex mode.
noremap Q <nop>
" Close window.
noremap QQ :q<CR>
" Close a full tab page.
noremap QW :windo bd<CR>
" CLose all.
noremap QA :qa<CR>

" Enable folding with the spacebar
nnoremap <space> za

" Redraws the screen and removes any search highlighting
nnoremap <silent> <leader>c :nohl<CR>