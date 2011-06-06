" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" If you are using a modern DVI viewer, then it is possible to do what is called forward and inverse searching. 
let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'

let g:Tex_UseEditorSettingInDVIViewer = 1
