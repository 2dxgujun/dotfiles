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

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
