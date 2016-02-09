"----------------------------------- General Settings -----------------------------------

"Disable strict vi compatability
set nocompatible

"Enable colors and plugins
syntax on
filetype on
filetype plugin on
filetype indent on

"Plugins directory
call pathogen#infect('PLUGINS_DIR')

"My preferred colors (solarized or xoria256)
colorscheme solarized

"Show line number on the side
set number

"Tabs and spaces
set tabstop=2
set shiftwidth=2
set expandtab

"Encoding settings
set encoding=utf-8     "Sets the encoding for VIM's buffers and registers
set fileencoding=utf-8 "Sets the encoding for the actual file being edited

"Search options
set incsearch
set hlsearch
set ignorecase "use case insensitive searching
set smartcase  "^ unless a capital letter is used

"Split options
set splitright
set splitbelow

"Disable backups for every file
set nobackup
set nowritebackup

"Enable the backspace key in insert mode
set backspace=2

"A very important setting that I may change in the future
"It tells VIM to use It's old regex engine, instead of the newer one
set re=1 "I've had performance issues with the newer engine (especially on Ruby files)

"I want to be able to jump between these
set matchpairs=(:),{:},[:],<:>

"Enable command and file-name completion with <tab>
set wildmenu
set wildmode=list:longest,full

"Remember more commands and searches
set history=100 

"Always show status line
set laststatus=2

"Status line settings
set statusline=\ %t      "show filename
set statusline+=\ »\     "small visual separator left
set statusline+=%m       "modified flag
set statusline+=%r       "read only flag
set statusline+=%y       "filetype
set statusline+=%=       "left/right separator
set statusline+=%{strlen(&fenc)?&fenc:'none'}[ "file encoding
set statusline+=%{&ff}]  "file format
set statusline+=\ «      "small visual separator right
set statusline+=\ %P\ \| "percent through file
set statusline+=\ %l\ :  "current line
set statusline+=\ %c\    "current column

"----------------------------------- Custom Mappings ------------------------------------

"My Leader is space
let mapleader="\<space>"

"Map control-v to paste from clipboard
noremap <c-v> "+gp
inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+

"Map control-c to yank to the clipboard
noremap <c-c> "+y

"Opening tabs
nnoremap <Leader>t :tabnew<cr>

"Small function to toggle from English to Bulgarian
function ToggleLang()
  if &keymap == "bulgarian-phonetic"
    set keymap=
  else
    set keymap=bulgarian-phonetic
  endif
endfunction

"Simple mappings to call the function
nnoremap <c-l> :call ToggleLang()<cr>
inoremap <c-l> <c-o>:call ToggleLang()<cr>

"Disable default easy-motion mappings
let g:EasyMotion_do_mapping = 0

"Bi-directional find motion
map <Leader><Leader> <Plug>(easymotion-s)

"JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"Make yanking distant lines easier
nmap yj y<Plug>(easymotion-j)
nmap yk y<Plug>(easymotion-k)

"Make deleting distant lines easier
nmap dj d<Plug>(easymotion-j)
nmap dk d<Plug>(easymotion-k)

"Search mappings
map <Leader>n <Plug>(easymotion-bd-n)

"Change VIM's default regexp scheme, now all characters are literals in searches
"If I want to togge this I can simply press backspace and type small v
noremap / /\V
noremap ? ?\V

"I want the current search highlight to be cleared when I hit escape
nnoremap <silent> <esc> :noh<cr><esc>
inoremap <silent> <esc> <esc>:noh<cr>

"Mapping to show the undo tree
nnoremap <Leader>u :GundoToggle<CR>

"Better tab navigation
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

"With this: Just record a scratch macro with qq, then play it back with backspace
nnoremap <bs> @q

"Makes the above mapping work in visual mode (can't happen without the norm command)
"I also want all macros to start at the beginning of the line for this mode
vnoremap <silent> <bs> :norm ^@q<cr>

"Make the q register start out empty
nnoremap qq qqqqq

"Easier way to clone a paragraph (I think of it as get lines)
noremap gl yap<S-}>p

"Mapping for 'change inside pair'
"This line: matchstr(getline('.'), '\%' . col('.') . 'c.'), gets the char under the cursor
nnoremap <silent> ci% %:call feedkeys("ci" . matchstr(getline('.'), '\%' . col('.') . 'c.'))<cr>
"Mapping for 'change around pair'
nnoremap <silent> ca% %:call feedkeys("ca" . matchstr(getline('.'), '\%' . col('.') . 'c.'))<cr>

"Mapping for 'delete inside pair'
nnoremap <silent> di% %:call feedkeys("di" . matchstr(getline('.'), '\%' . col('.') . 'c.'))<cr>
"Mapping for 'delete around pair'
nnoremap <silent> da% %:call feedkeys("da" . matchstr(getline('.'), '\%' . col('.') . 'c.'))<cr>

"Mapping for 'visual select inside pair'
nnoremap <silent> vi% %:call feedkeys("vi" . matchstr(getline('.'), '\%' . col('.') . 'c.'))<cr>
"Mapping for 'visual select around pair'
nnoremap va% %v%

"Convenient mappings for VimShell
noremap <silent> <leader>e :VimShellSendString<cr>
noremap <silent> <leader>E :%VimShellSendString<cr>

"----------------------------------- Plugins and GUI ------------------------------------

"Include some small ruby utils I wrote
ruby require 'RUBY_UTILS'

"Disable the matchparens plugin by default
let loaded_matchparen = 1
"It will be enabled only for lisp files
autocmd Filetype clojure unlet! g:loaded_matchparen | runtime plugin/matchparen.vim

"Gvim options
set guioptions-=T "I don't want the gui tool bar
set guitablabel=%N:%M%t " Show tab numbers
set guifont=Courier_New:h11:cDEFAULT "Font for gvim

"Window size for gvim
if has("gui_running")
  set lines=45
  set columns=110
  winpos 125 60
endif

"HTML INDENT SETTINGS
let g:html_indent_inctags = "html,body,head,tbody,li,p"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:SimpleJsIndenter_BriefMode = 1

"Control p settings
let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
let g:ctrlp_use_caching = 0

"Simple command to bring up nerd tree
command! TREE NERDTreeToggle
cabbrev tree TREE

"Some abbreviations for long commands
cabbrev qr QuickRun
cabbrev shell VimShell
cabbrev ishell VimShellInteractive --split='split \| resize 15'
cabbrev sclose VimShellClose

"This default diff function comes with the windows version of vim
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
