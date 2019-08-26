" Must be before any mappings are set
let mapleader=','

" Set up a global SYSTEM variable --------------------------------
let g:SYSTEM = 'other'
if has('win16') || has('win32') || has('win64') || has('win32unix')
  let g:SYSTEM = 'win'
elseif has('mac') || has('maxunix')
  let g:SYSTEM = 'mac'
elseif has('unix')
  " Unix or Cygwin (which " acts like Unix)
  let g:SYSTEM = 'unix'
endif

" Vundle setup ---------------------------------------------

" Use vundle for plugin management
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Bundles to manage -----------------

" Navigation and browsing
Bundle 'scrooloose/nerdtree'
" Source control
Bundle 'tpope/vim-git'
" Syntax highlighting
" Bundle 'scrooloose/syntastic'
" TODO: Disabling airline to debug slowness
" Bundle 'vim-airline/vim-airline'
" Bundle 'vim-airline/vim-airline-themes'
" Improved file finding
Bundle 'kien/ctrlp.vim'
" Improved bracket, parens, quotes, etc... matching
Bundle 'vim-scripts/matchit.zip'
" Matching capability for Python using %
Bundle 'vim-scripts/python_match.vim'
" Solarized coloscheme
Bundle "altercation/vim-colors-solarized"
" Improved indentation for JS
Bundle "pangloss/vim-javascript"

call vundle#end()

" Shortcuts for plugins ---------------------------------------
nnoremap <F2> :NERDTreeToggle<CR>
"nnoremap <F3> :YRShow<CR>
" For some reason, this mapping refuses to work
" nnoremap <F3> :TMiniBufExplorer<CR>
nnoremap <F4> :GundoToggle<CR>
nnoremap <TAB> :MiniBufExplorer<CR>
nnoremap <silent> <leader>t :CtrlP<CR>
nnoremap <silent> <leader>r :CtrlPMRUFiles<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>

" Additional plugin setup --------------------------------------

" neocomplcache ----------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" syntastic ------------------------------

" Specify filetypes active/passive syntax checking should be performed for
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0
let g:syntastic_javascript_checker = "gjslint"
" let g:syntastic_javascript_checker = \"jshint\"
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['sass', 'scss', 'javascript'] }

" vim-latex ----------------------
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'latexmk -pdf -halt-on-error -f $*'
let g:Tex_CompileRule_pdf = 'pdflatex $*'

" command-t ------------------------------------

" Open files in new tabs
" let g:CommandTAcceptSelectionMap = '<C-t>'
" let g:CommandTAcceptSelectionTabMap = '<CR>'

" minibufexplorer++ --------------------------
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1
" let g:miniBufExplorerMoreThanOne = 2
" let g:miniBufExplForceSyntaxEnable = 0
" let g:miniBufExplUseSingleClick = 1

" vim-airline
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

" -----------------------------------------------------------------

" Use custom filetype indentation rules in .vim/ftplugin/<lang>.vim
filetype plugin indent on

" General options ----------------------------------------------------

set t_Co=256          " Needs to be set before settings colorscheme

" Basic config
set background=light
colorscheme solarized " Color scheme to use
syntax enable             " Enable syntax highlighting

" General option sets
set nocompatible      " Use vim defaults
set laststatus=2      " Always show status line
"set scrolloff=999     " Number of lines to keep below when scrolling; large value maintains center
set scrolloff=5
set showcmd           " Display incomplete commands
set hlsearch          " Highlight searches
set noincsearch       " Do incremental searches
set ruler             " Show the cursor position all the time
set number            " Show line numbers
set ignorecase        " Ignore case when searching
set smartcase         " Case-sensitive if there's at least one capital letter in needle
set title             " Show title in console title bar
set ttyfast           " Smoother changes
set smartindent       " Smart indent
set shiftround        " Smart '>' & '<' indentation! With 3 spaces, press '>', insert 1 space, not 4.
set cindent           " Cindent
set history=1000      " Remember more history
set undolevels=5000   " Remember more undos
set cmdheight=2       " Set command window height to reduce number of 'Press ENTER...' prompts
set mouse=a           " Allow mouse to be used. Works on Ubuntu gvim AND terminal vim; not on Mac
set noautochdir       " Disable automatically changing directories when switching windows
set tags=tags;/       " Look in the current dir and up tree towards root until a tag file is found
set autoread          " Automatically reload changed files on disk (useful for git branch switching)
"set switchbuf=usetab,newtab " Switch to existing tab if buffer is open, or create new one if not
"set autowrite        " Automatically write buffers to file when switching to another buffer (i.e. :next, etc)
"set nrformats=alpha  " Allow incrementing letters
"set noignorecase     " Don't ignore case when searching
"set ttyscroll=0      " Turn off scrolling
"set nostartofline    " Don't jump to first character when paging
"set autoindent       " Always set autoindenting on

" Better window splitting start locations
set splitbelow
set splitright

" default indentation rules
set shiftwidth=2      " Number of spaces (auto)indent
set tabstop=2         " Number of spaces for tab character
set softtabstop=2
set expandtab

" Grep will sometimes skip displaying the file name if you search in a singe file.
" This will confuse Latex-Suite. Set your grep program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Set filetypes to ignore
set wildignore=*.o,*~,*.pyc,*.out,*.class,*.swp,*.d,**/ext/**,**/js_prod/**,**/node_modules/**,**/build/**

" Needed on Mac
" set clipboard=unnamed
" Needed on Mac with custom homebrew vim
set backspace=indent,eol,start

set completeopt=menuone,preview

" Remaps ------------------------------------------------------

" Swap ; and :
noremap ; :
noremap : ;

" When jumping to mark, jump directly to the correct column as well as line
noremap ' `
noremap ` '

" Center various navigations/movements
nnoremap <C-e> jzz
nnoremap <C-y> kzz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap gg ggzz
nnoremap G Gzz

" let [jk] go down and up by display lines instead of real lines. Let g[jk]
" do what [jk] normally does
nnoremap k gkzz
nnoremap j gjzz
nnoremap gk kzz
nnoremap gj jzz

" Scroll down/up in insert mode without displacing cursor
inoremap <C-y> <C-o><C-y>
inoremap <C-e> <C-o><C-e>

" Set A-] to open definition in a new tab
" Set C-\ to open definition in a vertical split
noremap <A-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
noremap <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Ctrl-tab to switch next/prev tab
nnoremap <silent><C-S-Tab> :tabp<CR>
nnoremap <silent><C-Tab> :tabn<CR>

" Ctrl-s for smart saving. (Don't write to file if no changes)
nnoremap <silent><C-s> :update<Cr>
inoremap <silent><C-s> <Esc>:update<Cr>

" Ctrl+Backspace to backspace a word
inoremap <C-BS> <C-W>

" Add entry to undo history for each new line while in insert mode
inoremap <cr> <c-g>u<cr>
" noremap <space> i<space><esc><right>
" noremap <cr> o<esc>

" Visual-mode indentation shifting: don't de-select after shift, keep selected.
vnoremap < <gv
vnoremap > >gv

" This mapping is causing strange behaviour with mouse clicking, so disable
" for now
" Use escape to cancel highlight
" nnoremap <silent> <ESC> :noh<CR><ESC>
nnoremap <silent> <C-c> :noh<CR><ESC>

" Yank to end of line
noremap Y y$

" Paste with respect to current line's indent. Will be overriden by Yankring.
nnoremap P [p
nnoremap p ]p

" Shortcut for writing to file with insufficient permissions
cnoremap w!! w !sudo tee % >/dev/null

" Move between split windows more easily
" noremap <C-j> <C-w>j<C-w>_
" noremap <C-h> <C-w>h
" noremap <C-j> <C-w>j
" noremap <C-k> <C-w>k
" noremap <C-l> <C-w>l

" Turn on 'very magic' regex status by default for searches.
" :he /magic for more information
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap %s/ %s/\v

" Mappings to resize split window
nnoremap <C-n> <C-w><
nnoremap <C-m> <C-w>>
nnoremap - <C-w>-
nnoremap + <C-w>+

" Folding commands
nnoremap <leader><space> za
vnoremap <leader><space> zf

nnoremap <leader>p <C-^>

" Autocommands ----------------------------------------

" this autocommand jumps to the last known position in a file just afer opening it
" works if the '"' mark is set:
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Turn off syntax highlighting for diff view
autocmd FilterWritePre * if &diff | syntax off | endif

" Highlight extra whitespace at end of a line
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
highlight SpellBad term=reverse ctermbg=lightGray

match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * let w:ews1=matchadd('ExtraWhitespace', '\s\+$', -1)
autocmd InsertEnter * let w:ews2=matchadd('ExtraWhitespace', '\s\+\%#\@<!$', -1)
autocmd InsertLeave * let w:ews3=matchadd('ExtraWhitespace', '\s\+$', -1)
autocmd BufWinLeave * call clearmatches()


" CScope options ------------------------------------------------

" Enable cscope functionality for autocomplete if available
if has('cscope')
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb " add any database in current directory, if not keep going upwards
        " in the directory tree until you find a cscope.out file
  if $CSCOPE_DB != ''
    cs add $CSCOPE_DB
  else
    let dir = getcwd()
    while dir != ''
      let f = dir . '/cscope.out'
      if filereadable (f)
  execute 'cs add ' . f
  break
      endif
      let dir = substitute (dir, '/[^/]*$', '', '')
    endwhile
  endif
  set csverb

  " Shortcuts for cscope functionality
  function! ReloadCscopeDb()
    exe 'set nocsverb'
    exe 'cs reset'
    exe 'set csverb'
  endfunction

  let g:CSOPE_ON = 0
  function! ToggleCscopeQuickfix()
    if g:CSOPE_ON == 0
      set cscopequickfix=s-,c-,d-,i-,t-,e-
      let g:CSOPE_ON = 1
    else
      set cscopequickfix=
      let g:CSOPE_ON = 0
    endif
  endfunction

  "noremap <C-c><C-c> :exe ':cs find c ' . expand('<cword>')<CR>
  "noremap <C-c><C-g> :exe ':cs find g ' . expand('<cword>')<CR>
  "noremap <C-c><C-d> :exe ':cs find d ' . expand('<cword>')<CR>
  "noremap <C-c><C-e> :exe ':cs find e (^\|[^a-zA-Z_])' . expand('<cword>') . '([^a-zA-Z_]\|$)'<CR>
  "noremap <C-c><C-a> :exe ':cs find e function ' . expand('<cword>') . '([^a-zA-Z_]\|$)'<CR>
  "noremap <C-c><C-b> :exe ':cs find s ' . expand('<cword>')<CR>
  "noremap <C-c><C-f> :cs find f<SPACE>
  "noremap <C-c><C-t> :exe ':cs find t ' . expand('<cword>')<CR>
  "noremap <C-c><C-r> :call <SID>ReloadCscopeDb()<CR>
  "noremap <C-c><C-x> :call <SID>ToggleCscopeQuickfix()<CR>
endif

" Platform specific configuration ------------------------------------

" Shortcuts for system clipboard
nnoremap gy "+y
vnoremap gy "+y
nnoremap gp "+gP
vnoremap gp "+gP

if g:SYSTEM == 'unix' || g:SYSTEM == 'mac'

  " TODO: also set up for windows
  " Store temporary files in a central spot
  set backupdir=~/.vim_backups//
  silent execute '!mkdir -p ~/.vim_backups'
  set directory=~/.vim_backups//

elseif g:SYSTEM == 'win'
  " Paste for Windows
  function! GetClip()
    let reg_save = @@
    let @@ = g:SYSTEMtem('getclip')
    setlocal paste
    exe 'normal p'
    setlocal nopaste
    let @@ = reg_save
  endfunction

  " Copy for Windows
  function! PutClip(type, ...) range
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    if a:type == 'n'
      silent exe a:firstline . "," . a:lastline . "y"
    elseif a:type == 'c'
      silent exe a:1 . "," . a:2 . "y"
    else
      silent exe "normal! `<" . a:type . "`>y"
    endif
    call g:SYSTEMtem('putclip', @@)
    let &selection = sel_save
    let @@ = reg_save
  endfunction

  " Shortcuts for system clipboard
  vnoremap <silent> gy :call PutClip(visualmode(), 1)<CR>
  nnoremap <silent> gy :call PutClip('n', 1)<CR>
  nnoremap <silent> gp :call GetClip()<CR>

  " Make backspace work in Windows
  set nocp
  map <BS> ^H
  set backspace=indent,eol,start
  fixdel
endif

" Global functions -------------------------------------------------------

" TODO: figure out how to invoke this by setting variable in syntax file,
" rather than having to call this function
" Highlight line if it goes past specified column
function! LineLengthLimit(length)
  let g:LINE_LENGTH_LIMIT = a:length
  if has('colorcolumn')
    set colorcolumn=g:LINE_LENGTH_LIMIT
  else
    " au BufWinEnter * let w:m1=matchadd('Search', '\%<' . (g:LINE_LENGTH_LIMIT+1) .'v.\%>' . (g:LINE_LENGTH_LIMIT-3) . 'v', -1)
    " au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>' . g:LINE_LENGTH_LIMIT . 'v.\+', -1)
    highlight OverLength ctermbg=darkred ctermfg=white guibg=#ffe9e9
    au BufWinEnter * let w:ol=matchadd('OverLength', '\%' . (g:LINE_LENGTH_LIMIT+1) .'v\+', -1)
  endif
endfunction

" Fixes issue with content not displaying on startup --------------------
" redraw!

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
