" Helper Functions ---------------------------------------------------

function! ReloadCscopeDb()
  exe "set nocsverb"
  exe "cs reset"
  exe "set csverb"
endfunction

let g:csquick_on = 0
function! ToggleCscopeQuickfix()
  if g:csquick_on == 0
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    let g:csquick_on = 1
  else
    set cscopequickfix=
    let g:csquick_on = 0
  endif
endfunction

" C => F2 to compile; F3 to run
function! CompileC()
	map <buffer> <F2> :w<CR>:!clear;gcc -Wall %<CR>
	map <buffer> <F3> :!./a.out<CR>
endfunction

" TODO: use make
" C++ => F2 to compile; F3 to run
function! CompileCpp()
  map <buffer> <F2> :w<CR>:!clear;g++ -Wall %<CR>
  map <buffer> <F3> :!./a.out<CR>
endfunction

" Grep will sometimes skip displaying the file name if you search in a singe file.
" This will confuse Latex-Suite. Set your grep program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Highlight line if it goes past specified column
function! LineLengthLimit()
	highlight OverLength ctermbg=darkred ctermfg=white guibg=#ffd9d
	match OverLength /\%121v.\+/
	if has("colorcolumn")
		set colorcolumn=120
	" else
	" 	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120.\+', -1)
	endif
endfunction

" Default configuration for all file types
function! IndentFtDefault()
	set shiftwidth=2							" Number of spaces (auto)indent
	set tabstop=2									" Number of spaces for tab character
	set softtabstop=2
endfunction

" Strongly typed languages (i.e. Java, C, C++)
function! IndentFtOne()
  set shiftwidth=4							" Number of spaces (auto)indent
  set tabstop=4									" Number of spaces for tab character
  set noexpandtab								" Do not expand tabs to spaces
  set cinoptions=l1,m1,(0,W4		" Line up multiline function parameters
	call LineLengthLimit()
endfunction

" Weakly typed languages (i.e. PHP, Python)
function! IndentFtTwo()
	set expandtab									" Expand tabs to spaces
	call LineLengthLimit()
endfunction

" Paste for Windows
function! Getclip()
	let reg_save = @@
	let @@ = system('getclip')
	setlocal paste
	exe 'normal p'
	setlocal nopaste
	let @@ = reg_save
endfunction

" Copy for Windows
function! Putclip(type, ...) range
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
	call system('putclip', @@)
	let &selection = sel_save
	let @@ = reg_save
endfunction

" Enable cscope functionality for autocomplete
function! EnableScope()
	if has("cscope")
		set csprg=/usr/bin/cscope
		set csto=0
		set cst
		set nocsverb " add any database in current directory, if not keep going upwards
					" in the directory tree until you find a cscope.out file
		if $CSCOPE_DB != ""
			cs add $CSCOPE_DB
		else
			let dir = getcwd()
			while dir != ""
				let f = dir . "/cscope.out"
				if filereadable (f)
		execute "cs add " . f
		break
				endif
				let dir = substitute (dir, "/[^/]*$", "", "")
			endwhile
		endif
		set csverb
	endif
endfunction

" General options ----------------------------------------------------

" Basic config
colorscheme desert    " Color scheme to use
syntax on             " Enable syntax highlighting

" General sets
set nocompatible			" Use vim defaults
set laststatus=2			" Always show status line
set scrolloff=5		    " Number of lines to keep below when scrolling
set showcmd				  	" Display incomplete commands
set hlsearch          " Highlight searches
set incsearch         " Do incremental searches
set ruler             " Show the cursor position all the time
set visualbell t_vb= 	" Turn off the visual bell
set number					  " Show line numbers
set ignorecase				" Ignore case when searching
set smartcase 				" Case-sensitive if there's at least one capital letter in needle
set title					    " Show title in console title bar
set ttyfast					  " Smoother changes
set smartindent				" Smart indent
set shiftround				" Smart '>' & '<' indentation! With 3 spaces, press '>', insert 1 space, not 4.
set cindent					  " Cindent
set history=1000 			" Remember more history
set undolevels=5000 	" Remember more undos
set cmdheight=2				" Set command window height to reduce number of 'Press ENTER...' prompts
set mouse=a           " Allow mouse to be used. Works on Ubuntu gvim AND terminal vim; not on Mac
set autochdir         " Automatically change directories when switching windows
set tags=tags;/				" Look in the current dir and up tree towards root until a tag file is found
set autoread          " Automatically reload changed files on disk (useful for git branch switching)
"set autowrite        " Automatically write buffers to file when switching to another buffer (i.e. :next, etc)
"set nrformats=alpha	" Allow incrementing letters
"set noignorecase			" Don't ignore case when searching
"set ttyscroll=0			" Turn off scrolling
"set nostartofline		" Don't jump to first character when paging
"set autoindent				" Always set autoindenting on

" Make backspace work in Windows
set nocp
map <BS> ^H
set backspace=indent,eol,start
fixdel

" Better window splitting start locations
set splitbelow
set splitright

" Store temporary files in a central spot
" Check if the backup directory exists; if it doesn't, create it
set backupdir=~/.vim_backups//
silent execute '!mkdir -p ~/.vim_backups'
set directory=~/.vim_backups//

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
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap gg ggzz
" nnoremap G Gzz
" nnoremap j jzz
" nnoremap k kzz

" let [jk] go down and up by display lines instead of real lines. Let g[jk]
" do what [jk] normally does
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Scroll down/up in insert mode without displacing cursor
inoremap <C-y> <C-o><C-y>
inoremap <C-e> <C-o><C-e>

" Use alt+hjkl to navigate between split windows in Ubuntu terminal vim
nnoremap j  <C-w>j
nnoremap k  <C-w>k
nnoremap h  <C-w>h
nnoremap l  <C-w>l

" Use alt+<>-= to resize split windows in Ubuntu terminal vim
nnoremap ,  <C-w><
nnoremap .  <C-w>>
nnoremap =  <C-w>+
nnoremap -  <C-w>-

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
noremap <space> i<space><esc><right>
noremap <cr> o<esc>

" Visual-mode indentation shifting: don't de-select after shift, keep selected.
vnoremap < <gv
vnoremap > >gv

" Use escape to cancel highlight
nnoremap <silent> <ESC> :noh<cr><ESC>

" Yank to end of line
noremap Y y$

" Paste with respect to current line's indent. Will be overriden by Yankring.
nnoremap P [p
nnoremap p ]p

" Shortcuts for system clipboard access for Ubuntu gvim and terminal vim. Will be overwritten by Yankring.
nnoremap gp "*]p
nnoremap gP "*[P
nnoremap gY "+Y
vnoremap gy "+y
" Copy and paste to clipboard capabilities for Windows
" vnoremap <silent> gy :call Putclip(visualmode(), 1)<CR>
" nnoremap <silent> gy :call Putclip('n', 1)<CR>
" nnoremap <silent> gp :call Getclip()<CR>

" Shortcut for writing to file with insufficient permissions
cnoremap w!! w !sudo tee % >/dev/null

" Shortcuts for cscope functionality
noremap <C-c><C-c> :exe ":cs find c " . expand("<cword>")<CR>
noremap <C-c><C-g> :exe ":cs find g " . expand("<cword>")<CR>
noremap <C-c><C-d> :exe ":cs find d " . expand("<cword>")<CR>
noremap <C-c><C-e> :exe ":cs find e (^\|[^a-zA-Z_])" . expand("<cword>") . "([^a-zA-Z_]\|$)"<CR>
noremap <C-c><C-a> :exe ":cs find e function " . expand("<cword>") . "([^a-zA-Z_]\|$)"<CR>
noremap <C-c><C-b> :exe ":cs find s " . expand("<cword>")<CR>
noremap <C-c><C-f> :cs find f<SPACE>
noremap <C-c><C-t> :exe ":cs find t " . expand("<cword>")<CR>
noremap <C-c><C-r> :call <SID>ReloadCscopeDb()<CR>
noremap <C-c><C-x> :call <SID>ToggleCscopeQuickfix()<CR>

" Autocommands ----------------------------------------

" this autocommand jumps to the last known position in a file just afer opening it
" works if the '"' mark is set:
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Turn off syntax highlighting for diff view
autocmd FilterWritePre * if &diff | syntax off | endif

" Compilation with F2. Run with F3.
autocmd Filetype c call CompileC()
autocmd Filetype cpp call CompileCpp()
autocmd Filetype scheme call CompileScheme()
autocmd Filetype tex call CompileTex()

" Indentation based on filetype
call IndentFtDefault()
autocmd FileType c,cpp,java,make call IndentFtOne()
autocmd FileType php,javascript call IndentFtTwo()

" Highlight extra whitespace at end of a line
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Vundle setup ---------------------------------------------

filetype off												" Use vundle for plugin management

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle; required
Bundle 'gmarik/vundle'

" Bundles to manage

" Navigation and browsing
Bundle 'scrooloose/nerdtree'

" Source control
Bundle 'tpope/vim-git'

" filetype plugin on								" Enable plugins
filetype plugin indent on						" Use custom filetype indentation rules in .vim/ftplugin/<lang>.vim

" Gvim options ----------------------------------------------

" Turn off scrollbars and other unnecessary menu items. The initial += is a bug workaround
" set guioptions+=LlRrbT
" set guioptions-=LlRrbT
"
" Disallow menu access using the Alt key
" set winaltkeys=no

" Miscellaneous -----------------------------------------------------

" Enable cscope if avaiable
call EnableScope()

" Fixes issue with content not displaying on startup
redraw!
