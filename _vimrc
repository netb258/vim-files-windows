"----------------------------------- General Settings -----------------------------------

"Disable strict vi compatability
set nocompatible

"Enable colors and plugins
syntax on
filetype on
filetype plugin on
filetype indent on
set synmaxcol=1000 "Maximum columns to highlight

"Plugins directory
call pathogen#infect('PATH_TO_PLUGINS')

"My preferred colors (solarized or xoria256)
colorscheme solarized

"Show relative line number on the side
set number
set relativenumber

"Tabs and spaces
set tabstop=2
set shiftwidth=2
set expandtab

"Stop automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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

"I'm loading matchit here, because loading it later fucks with the mappings on line 175
runtime macros/matchit.vim

"Enable command and file-name completion with <tab>
set wildmenu
set wildmode=list:longest,full

"Remember more commands and searches
set history=100 

"Always show status line
set laststatus=2

"Shows what column I'm on
set ruler

"Do not highlight the current line
set nocursorline

"I don't want the preview-window (when doing code completion)
set completeopt-=preview

"----------------------------------- Custom Mappings ------------------------------------

"My Leader is space
let mapleader="\<space>"

"Map control-v to paste from clipboard (normal mode pastes with indent, insert doesn't)
noremap <c-v> "+pv`]=`>
inoremap <c-v> <c-r><c-p>+
cnoremap <c-v> <c-r>+

"Well I'm using <c-v> for pasting, so cv can take it's place for visual block mode
nnoremap cv <c-q>

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

"Quickly move between lines:
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

"Make yanking distant lines easier:
nmap yj y<Plug>(easymotion-j)
nmap yk y<Plug>(easymotion-k)

"Make deleting distant lines easier:
nmap dj d<Plug>(easymotion-j)
nmap dk d<Plug>(easymotion-k)

"Quick search motion
map <leader><leader> <Plug>(easymotion-bd-w)

"Make n/N consistent
noremap <expr> n 'Nn'[v:searchforward]
noremap <expr> N 'nN'[v:searchforward]

"Change VIM's default regexp scheme, now all characters are literals in searches
"If I want to togge this I can simply press backspace and type small v
noremap / /\V
noremap ? ?\V

"I mainly use the star for searching, so I don't want the added jump
nnoremap <silent> * :let @/="\\<" . expand("<cword>") . "\\>"<cr>:set hlsearch<cr>

"Make * available in visual mode
vnoremap <silent> * y:let @/=@"<cr>:set hlsearch<cr>

"A little shortcur for *cgn
nnoremap c* *Ncgn

"I want the current search highlight to be cleared when I hit escape
nnoremap <silent> <esc> :noh<cr><esc>

"Global search across all files in all subdirectories (might want to do :lw and :bp)
nnoremap <leader>/ :lvim  **/*<left><left><left><left><left>

"Mapping to show the undo tree
nnoremap <Leader>u :UndotreeToggle<CR>

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

"Resize splits easier
nnoremap + <c-w>>
nnoremap - <c-w><
nnoremap _ <c-w>+
nnoremap <c-_> <c-w>-

"With this: Just record a scratch macro with qq, then play it back with backspace
nnoremap <bs> @q

"Makes the above mapping work in visual mode (can't happen without the norm command)
"I also want all macros to start at the beginning of the line for this mode
vnoremap <silent> <bs> :norm ^@q<cr>

"Make the q register start out empty
nnoremap Q qqqqq

"Make dot available in visual mode
vnoremap <silent> . :norm .<cr>

"Bring the current line down
nnoremap gl yy<c-o>p

"Bring the current paragraph down
nnoremap gL y}<c-o><c-o>p

"Clone paragraph
nnoremap cp y}}p

"Clone visual selection
vnoremap cp y`>p

"Mappings for 'change inside/around next pair'
xnoremap i% <esc>%:execute "normal! vi" . getline('.')[col('.')-1]<cr>
onoremap i% :execute "normal vi%"<cr>
xnoremap a% <esc>%v%
onoremap a% :execute "normal va%"<cr>

"Clear search highlight when saving a file
nnoremap <silent> <plug>(nohlsearch) :<c-u>nohlsearch<cr>

"The above mapping is triggered by an autocommand (not a key press)
augroup nohlsearch_on_bufwritepost
    autocmd!
    autocmd BufWritePost * call feedkeys("\<plug>(nohlsearch)")
augroup END

"I search for something with / and instantly replace it with <leader>s
nnoremap <leader>s :%s///g<left><left>

"More intuative code completion
inoremap <c-space> <c-x><c-o>

"Eval the whole buffer (fireplace)
nnoremap <leader>e :%Eval<cr>
vnoremap <leader>e :Eval<cr>

"Reload the current namespace (fireplace)
nnoremap <leader>r :Require!<cr>

"Adds a convenient debugging macro for Clojure:
inoremap <c-d> (defmacro dbg[x] `(let [x# ~x] (println "dbg:" '~x "=" x#) x#))

"Store relative line number jumps in the jumplist.
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

"Show a list of my most used files and directories.
nnoremap <leader>p :<c-u>CtrlPLauncher<cr>

"Makes a single 'x' not repeatable and not saved in the default register. 
nmap <silent> \x :<c-u>call NoPasteNoDotX()<CR>
nmap <expr> x <SID>RepeatXorNot()

"If the command comes from an 'execute' inside a function, it won't be repeated.
function NoPasteNoDotX()
  silent execute ':normal! "_x'
endfunction

"If a count has been supplied, throw a normal 'x', otherwise we use 'NoPasteNoDotX'.
function s:RepeatXorNot()
  if v:count1 > 1
    return 'x'
  else
    return '\x'
  endif
endfunction

"----------------------------------- Plugins and GUI ------------------------------------

"Disable the matchparens plugin by default
let loaded_matchparen = 1
"It will be enabled only for lisp files
autocmd Filetype clojure,scheme,hy,lisp unlet! g:loaded_matchparen | runtime plugin/matchparen.vim

"Gvim options
set guioptions-=T "I don't want the gui tool bar
set guioptions-=m "I don't want the gui menu bar
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
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll)$',
\ }
"let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}

"Set vim-slime to connect with ConEmu
let g:slime_target = "conemu"

"VIM airline settings:
let g:airline_theme = 'solarized'
call airline#parts#define_accent('mode', 'none')
let g:airline_solarized_normal_gray = 1
let g:airline_solarized_dark_inactive_border = 1
let g:airline_detect_modified=0                    "Don't want different colors for modified files.
let g:airline#extensions#whitespace#enabled = 0    "Don't do whitespace checks (they distract me).
let g:airline_mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ '' : 'S',
\ }

"Airline separators:
let g:airline_symbols = {}
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.linenr = '|'

"Tabline settings:
let g:airline#extensions#tabline#enabled = 1     "Show buffers and tabs.
let g:airline#extensions#tabline#tab_nr_type = 1 "Put a number in-front of the tabs.
"Don't show buffers/tabs if opened only one file is opened.
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2
"Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

"A shorthand for calling VimShell.
cabbrev shell VimShell

"Resize the GUI window to align with ConEmu
function Stay()
  set lines=37
  set columns=160
  winpos 0 -5
endfunction

"Canvenient mapping that calls the above function
nnoremap <leader>s :call Stay()<cr>

"Simple command to bring up nerd tree
command! TREE NERDTreeToggle
cabbrev tree TREE

"Quickly open a command prompt in the currect directory
command! CMD let d=expand("%:p:h") | execute '!start cmd /k cd "' . d . '"'
cabbrev cmd CMD

"Shortcuts for starting clojure programs from VIM:
command! CLOJURE let f=expand("%") | let d=expand("%:p:h") | execute '!start cmd /k cd "' . d . '" & clojure "' . f . '"'
cabbrev clojure CLOJURE

command! CLOJUREC let f=expand("%") | let d=expand("%:p:h") | execute '!start cmd /k cd "' . d . '" & clojurec "' . f . '"'
cabbrev clojurec CLOJUREC
