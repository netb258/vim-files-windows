"Disable strict vi compatability
set nocompatible

"----------------------------------- General Settings -----------------------------------

"Enable filetype plugins
syntax on
filetype on
filetype plugin on
filetype indent on

"Plugins directory.
call pathogen#infect('PLUGIN_DIR')

"My preferred colors (solarized or xoria256)
colorscheme solarized

"Leader mappings
let mapleader="\<space>"

"Search options
set incsearch
set hlsearch
set ignorecase "use case insensitive searching
set smartcase  "^ unless a capital letter is used

"I want to see the line number on the side.
set number

"Tabs and spaces
set tabstop=2
set shiftwidth=2
set expandtab

"Encoding settings
set encoding=utf-8     "Sets the encoding for VIM's buffers and registers.
set fileencoding=utf-8 "Sets the encoding for the actual file being edited.

"Remember more commands and searches
set history=100

"Status line settings
set laststatus=2 "Always show status line
let g:lightline = {"colorscheme": "solarized"} "Use lightline plugin with solarized colors

"Enable the backspace key in insert mode.
set backspace=2

"----------------------------------- Custom Mappings ------------------------------------

"Map leader p to paste from clipboard
noremap <Leader>p "+p
"Map leader y to yank to the clipboard
noremap <Leader>y "+y

"Map leader P to paste from clipboard
noremap <Leader>P "+P
"Map leader Y to yank to the clipboard
noremap <Leader>Y "+Y

"Opening tabs
nnoremap <Leader>t :tabnew<cr>

"Small function to toggle from English to Bulgarian.
function ToggleLang()
  if &keymap == "bulgarian-phonetic"
    set keymap=
  else
    set keymap=bulgarian-phonetic
  endif
endfunction

"Simple mapping to call the function.
nnoremap <Leader>l :call ToggleLang()<cr>

"Disable default easy-motion mappings
let g:EasyMotion_do_mapping = 0

"Bi-directional find motion
map <Leader>f <Plug>(easymotion-s)

"JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"Search mapping
map <Leader>n <Plug>(easymotion-bd-n)
nnoremap <Leader>h :noh<cr>

"Mapping to show the undo tree
nnoremap <Leader>u :GundoToggle<CR>

"---------------------------------- Specific Settings -----------------------------------

"Load ruby utilities on startup
ruby require 'RUBY_SCRIPT'

"I want to be able to jump between these:
set matchpairs=(:),{:},[:],<:>

"I don't want the gui tool bar.
set guioptions-=T

"I don't want backups for every file.
set nobackup
set nowritebackup

"I don't want to highlight matching parenthesis (I do this with % when needed).
let g:loaded_matchparen = 1

"I don't want a special background for the current line (I do this with V as needed).
set nocursorline

"I want pwd to be the same as the file I'm editing.
set autochdir

"Font for gvim.
set guifont=Courier_New:h11:cDEFAULT

"Window size for gvim.
if has("gui_running")
  set lines=47
  set columns=120
endif

"HTML INDENT SETTINGS.
let g:html_indent_inctags = "html,body,head,tbody,li,p"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:SimpleJsIndenter_BriefMode = 1

"Simple command to bring up nerd tree.
command! TREE NERDTreeToggle
cabbrev tree TREE

"This default diff function comes with the windows version of vim.
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
