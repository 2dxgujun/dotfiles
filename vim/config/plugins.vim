set rtp+=$DOTFILES_PATH/vim/bundle/Vundle.vim

filetype off

call vundle#begin('$DOTFILES_PATH/vim/bundle')

Plugin 'VundleVim/Vundle.vim'

Plugin 'pangloss/vim-javascript'            " Syntax highlight for Javascript
Plugin 'posva/vim-vue'                      " Syntax highlight for Vue.js components
Plugin 'prettier/vim-prettier'              " Javascript code formatter

Plugin 'rhysd/vim-clang-format'             " Clang formatter

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

" ----------------------- vim-javascript -----------------------

let g:javascript_plugin_jsdoc = 1       " Enable syntax highlighting for JSDocs

" ------------------------- vim-vue ----------------------------

au BufRead,BufNewFile *.wpy setlocal filetype=vue.html.javascript.css     " Syntax highlight for *.wpy
au BufEnter *.wpy :syntax sync fromstart          " Fix syntax highlighting in *.wpy
let g:vue_disable_pre_processors = 1              " Fix vim slows down when using this plugin

" ----------------------- vim-prettier -------------------------

nmap <C-_> <Plug>(Prettier)
imap <C-_> <Plug>(Prettier)i
let g:prettier#exec_cmd_async = 1                 " Force async
let g:prettier#quickfix_auto_focus = 0            " Disable auto focus on the quickfix when there are errors

let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#prose_wrap = 'preserve'

" ---------------------- vim-clang-format ----------------------

let g:clang_format#style_options = {
    \ "AccessModifierOffset": -4,
    \ "AllowShortIfStatementsOnASingleLine": "true",
    \ "AlwaysBreakTemplateDeclarations": "true",
    \ "Standard": "C++11"
    \ }

au FileType c,h,cc,cpp nnoremap <C-_> :ClangFormat<CR>
au FileType c,h,cc,cpp inoremap <C-_> :ClangFormat<CR>i

" ----------------------- YouCompleteMe ------------------------

let g:ycm_global_ycm_extra_conf = $DOTFILES_PATH.'/vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_warning_symbol = '>'
let g:ycm_error_symbol = '>>'
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
let g:ycm_key_list_stop_completion = ['<C-y>']        " Note <Esc> will break direction key
let g:ycm_key_detailed_diagnostics = '<leader>d'
let g:ycm_key_invoke_completion = '<leader><Space>'   " Trigger semantic completion
let g:ycm_show_diagnostics_ui = 0                     " Turn off diagnostic feature, it's really slow
noremap <silent> <F2> :call ToggleYcmAutoTrigger()<CR>

func! ToggleYcmAutoTrigger()
  if (g:ycm_auto_trigger == 1)
    let g:ycm_auto_trigger = 0
  else
    let g:ycm_auto_trigger = 1
  endif
endfunc

" ------------------------- Lightline ---------------------------

set noshowmode " Get rid of mode information

func! LightlineMode()
  return expand('%:t') == '__Tagbar__' ? 'STRUCTURE' :
        \ expand('%:t') =~ 'NERD_tree' ? 'FILETREE' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunc

func! LightlineFilename()
  return expand('%:t') == '__Tagbar__' ? '' :
        \ expand('%:t') =~ 'NERD_tree' ? '' :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunc

func! LightlineRelativepath()
  return expand('%:t') == '__Tagbar__' ? '' :
        \ expand('%:t') =~ 'NERD_tree' ? '' :
        \ expand('%:t') !=# '' ? expand('%:f') : '[No Name]'
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
      \   'relativepath': 'LightlineRelativepath',
      \   'lineinfo': 'LightlineLineinfo',
      \   'percent': 'LightlinePercent',
      \   'fileformat': 'LightlineFileformat',
      \   'fileencoding': 'LightlineFileencoding',
      \   'filetype': 'LightlineFiletype'
      \ },
      \ 'subseparator': { 'left': '', 'right': 'ǀ' }
      \ }

" -------------------------- CtrlP --------------------------

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
