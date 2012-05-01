" F2 to compile; F3 to run
noremap <buffer> <F2> :w<CR>:!clear;g++ -Wall %<CR>
noremap <buffer> <F3> :!./a.out<CR>

set shiftwidth=4              " Number of spaces (auto)indent
set tabstop=4                 " Number of spaces for tab character
set noexpandtab               " Do not expand tabs to spaces
set cinoptions=l1,m1,(0,W4    " Line up multiline function parameters

call LineLengthLimit(120)
