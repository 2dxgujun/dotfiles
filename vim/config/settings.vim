set backspace=indent,eol,start                  " Allow backspacing over everything in insert mode
set encoding=utf-8                              " In case $LANG doesn't have a sensible value

syntax on                                       " Syntax highlighting
set background=dark                             " Inquiring plugins want to know
colorscheme one-dark
" set fillchars=vert:\                          " No pipes in vertical split separators
set laststatus=2                                " Always show status bar
set listchars=nbsp:·,tab:▸\ ,trail:·            " Configure how invisible appear
set list                                        " Show invisibles
set modelines=3                                 " Use modeline overrides
set nojoinspaces                                " 1 space, not 2, when joining sentences
set number                                      " Set gutter with line numbers
set scrolloff=1                                 " Minimum number of lines to always show above/below the caret
set showcmd                                     " Show partially typed command sequences
set visualbell                                  " Don't beep
set wildmode=longest,list                       " Autocompleting files: prompt, don't autopick
set wrap                                        " Soft wrap
set viminfo+=n~/.cache/vim/.viminfo             " Store viminfo to another location

" Indentation
set tabstop=2                                   " Spaces inserted by <Tab>
set expandtab                                   " Replace tabs with spaces
set shiftwidth=2                                " Space used for autoindent and commands like >>

" Searching
set gdefault                                    " Global search by default (/g turns it off)
set hlsearch                                    " Highlight results
set incsearch                                   " Search-as-you-type
set ignorecase smartcase                        " Case-insensitive unless we include uppercase

" Enable folding
set foldmethod=indent
set foldlevel=99

" More persistent command history
set history=10000

" Hide away backup and swap files
set backupdir=$HOME/.cache/vim/backup,.,/tmp
set directory=$HOME/.cache/vim/backup,.,/tmp

" Reload file without prompt if it has changed on disk
" Will still prompt if there is unsaved text in the buffer
set autoread

" MacVim checks for autoread when it gains focus; terminal Vim
" must trigger checks. Do so when switching buffers, or after
" 2 secs (the value of updatetime) of pressing nothing
set updatetime=2000
au WinEnter,BufWinEnter,CursorHold * silent! checktime

" There is a pause when leaving insert mode for vim-airline update
set ttimeoutlen=10

" Automatically save changes before switching buffer with some commands,
" like :cnfile
set autowrite
" Autosave
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
au BufLeave,FocusLost * silent! wa

set exrc                                        " Enable pre-directory .vimrc files
set secure                                      " Disable unsafe commands in per-directory .vimrc files
