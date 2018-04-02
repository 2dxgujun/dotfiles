set nocompatible
filetype off

set rtp+=$DOTFILES_PATH/vim/bundle/Vundle.vim
call vundle#begin('$DOTFILES_PATH/vim/bundle')

Plugin 'VundleVim/Vundle.vim'

" Javascript
Plugin 'pangloss/vim-javascript'            " Syntax highlighting

" Coding
Plugin 'PeterRincker/vim-argumentative'     " Manipulating and moving between function arguments
Plugin 'Raimondi/delimitMate'               " Auto-completion for quotes, parens, brackets, eto
Plugin 'Valloric/YouCompleteMe'             " Code completion

" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Colorschemes
Plugin 'flazz/vim-colorschemes'
Plugin 'rakr/vim-one'

Plugin 'tpope/vim-fugitive'                 " Git wrapper

Plugin 'ryanoasis/vim-devicons'             " Filetype glyphs/icons, load after other plugins

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

" Toggle NERDTree
map <Leader>n :NERDTreeToggle<CR>
" Sets the window size when the NERD tree is opened
let NERDTreeWinSize = 45

" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

