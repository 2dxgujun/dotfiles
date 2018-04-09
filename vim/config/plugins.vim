set rtp+=$DOTFILES_PATH/vim/bundle/Vundle.vim

filetype off

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

Plugin 'majutsushi/tagbar'                  " Tabbar

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

" ------------------------- Javascript -------------------------

let g:javascript_plugin_jsdoc = 1       " Enable syntax highlighting for JSDocs

" ------------------------- YouCompleteMe -------------------------

let g:ycm_global_ycm_extra_conf = $DOTFILES_PATH.'/vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_warning_symbol = '>'
let g:ycm_error_symbol = '>>'
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
let g:ycm_key_list_stop_completion = ['<C-y>']              " Note <Esc> will break direction key
let g:ycm_key_detailed_diagnostics = '<leader>d'
let g:ycm_key_invoke_completion = '<leader><Space>'         " Trigger semantic completion
"let g:ycm_semantic_triggers = {
"  \ 'c' : ['->', '.', 're!\w{1}']
"  \ }                                             " Trigger semantic completion after typing one characters

" ------------------------- Lightline -------------------------

set noshowmode " Get rid of mode information

func! LightlineMode()
  return expand('%:t') == '__Tagbar__' ? 'Tagbar' :
        \ expand('%:t') =~ 'NERD_tree' ? 'NERDTREE' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunc

func! LightlineFilename()
  return expand('%:t') == '__Tagbar__' ? '' :
        \ expand('%:t') =~ 'NERD_tree' ? '' :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunc

func! LightlineLineinfo()
  return expand('%:t') == '__Tagbar__' ? '' :
        \ expand('%:t') =~ 'NERD_tree' ? '' : printf('%d:%d', line('.'), col('.'))
endfunc

func! LightlinePercent()
  return expand('%:t') == '__Tagbar__' ? '' :
        \ expand('%:t') =~ 'NERD_tree' ? '' : printf('%d%%', line('.') * 100 / line('$'))
endfunc

func! LightlineFileformat()
  return expand('%:t') == '__Tagbar__' ? '' :
        \ expand('%:t') =~ 'NERD_tree' ? '' : &fileformat
endfunc

func! LightlineFileencoding()
  return expand('%:t') == '__Tagbar__' ? '' :
        \ expand('%:t') =~ 'NERD_tree' ? '' : (&fenc !=# '' ? &fenc : &enc)
endfunc

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'relativepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'mode': 'LightlineMode',
      \   'filename': 'LightlineFilename',
      \   'lineinfo': 'LightlineLineinfo',
      \   'percent': 'LightlinePercent',
      \   'fileformat': 'LightlineFileformat',
      \   'fileencoding': 'LightlineFileencoding',
      \   'filetype': 'LightlineFiletype'
      \ },
      \ 'subseparator': { 'left': '', 'right': 'ǀ' }
      \ }

" ------------------------- CtrlP -------------------------

let g:ctrlp_buffer_func = {
    \ 'enter': 'CtrlPBufferEnter',
    \ 'exit':  'CtrlPBufferExit',
    \ }

func! CtrlPBufferEnter()
  set laststatus=0
endfunc

func! CtrlPBufferExit()
  set laststatus=2
endfunc

" ------------------------- NERDTree -------------------------

let NERDTreeWinSize = 31                " Sets the window size when the NERD tree is opened
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

noremap <leader>\ :NERDTreeToggle<CR>
noremap <leader>[ :NERDTreeFocus<CR>

" ------------------------- Tagbar -------------------------

let g:tagbar_width = 31

noremap <leader>] :TagbarOpen fj<CR>
noremap <leader>]] :TagbarToggle<CR>
