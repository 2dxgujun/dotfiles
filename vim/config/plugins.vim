set nocompatible
filetype off

set rtp+=$DOTFILES_PATH/vim/bundle/Vundle.vim
call vundle#begin('$DOTFILES_PATH/vim/bundle')

Plugin 'VundleVim/Vundle.vim'

Plugin 'pangloss/vim-javascript'            " Javascript syntax highlighting

Plugin 'Valloric/YouCompleteMe'             " Code completion

Plugin 'PeterRincker/vim-argumentative'     " Manipulating and moving between function arguments
Plugin 'Raimondi/delimitMate'               " Auto-completion for quotes, parens, brackets, eto

Plugin 'ctrlpvim/ctrlp.vim'                 " Fuzzy file, buffer, mru, tag, etc finder

Plugin 'scrooloose/nerdtree'                " NERDTree
Plugin 'Xuyuanp/nerdtree-git-plugin'        " Show git status in NERDTree

Plugin 'flazz/vim-colorschemes'             " Colorscheme

Plugin 'tpope/vim-fugitive'                 " Git wrapper

Plugin 'itchyny/lightline.vim'              " Lightline

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

call vundle#end()
filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ----- Javascript

let g:javascript_plugin_jsdoc = 1       " Enable syntax highlighting for JSDocs

" ----- Lightline

set noshowmode " Get rid of mode information
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'subseparator': { 'left': '', 'right': 'ǀ' }
      \ }

" ----- NERDTree

map <C-n> :NERDTreeToggle<CR>           " Toggle NERDTree
let NERDTreeWinSize = 45                " Sets the window size when the NERD tree is opened

