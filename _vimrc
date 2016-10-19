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

"Shows what column I'm on
set ruler

"Highlight the current line
set cursorline

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

"Search mappings
map <c-n> <Plug>(easymotion-bd-n)

"When there are too many hits, while searching, I can just press <c-n> and pick the right one
cmap <c-n> <cr><c-n>

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

"Global search across all files in all subdirectories (might want to do :lw and :bp)
nnoremap <leader>/ :lvim  **/*<left><left><left><left><left>

"I want the current search highlight to be cleared when I hit escape
nnoremap <silent> <esc> :noh<cr><esc>

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

"Store relative line number jumps in the jumplist.
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

"The \ key is inconsistent between keyboards, so I'm remapping it to something easy.
inoremap <c-c> \
cnoremap <c-c> \

"----------------------------------- Plugins and GUI ------------------------------------

"Disable the matchparens plugin by default
let loaded_matchparen = 1
"It will be enabled only for lisp files
autocmd Filetype clojure,scheme,lisp unlet! g:loaded_matchparen | runtime plugin/matchparen.vim

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
let g:ctrlp_lazy_update = 350
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}

"Simple command to bring up nerd tree
command! TREE NERDTreeToggle
cabbrev tree TREE

"A quick command to connect to my custom Clojure repl setup
command! NREPL Connect nrepl://localhost:1234
cabbrev nrepl NREPL

"Quickly open a command prompt in the currect directory
command! CMD !start cmd
cabbrev cmd CMD
