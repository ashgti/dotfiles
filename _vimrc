" no vi compatibility
set nocompatible

" Show position in file
set ruler

" Set to not clear on exti
set t_ti= t_te=

" Set the encoding
set encoding=utf-8

" Show line numbers
set number

" Move the cursor past the end of the line by 1 spot
set virtualedit=onemore

" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set t_vb=
set laststatus=2  " Always show status line.

" Use 2 spaces for tabs, turn on automatic indenting
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set backspace=start,indent

" Set 4 spaces for python
autocmd FileType python set tabstop=2
autocmd FileType python set shiftwidth=2

" Turn on highlighted search and syntax highlighting
set hlsearch
set incsearch
syntax on

" MiniBufExplorer
map <leader>b :MiniBufExplorer<CR>
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows= 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Turn on line highlighting
" set cursorline " Commented out due to poor performance

" Set leader to comma
let mapleader = ","

let g:pep8map='<leader>8'

" Pathogen is for finding bundles
call pathogen#infect() 

" Rainbow
nmap <leader>R :ToggleRainbowParenthesis<CR>

map <leader>a :Ack<CR>
map <leader>af :AckFile<CR>

" Set up command for NERDTree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['.vim$','\~$', '.*\.pyc$', '.*\.o$', '.*\.hi$', '.*\.swp$']

" CommandT options
map <leader>f :CommandT<CR>

" Yankring
let g:yankring_history_dir = '~/.vim/tmp/'
nmap <leader>y :YRShow<cr>

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" For when I forget sudo
cmap w!! w !sudo tee % >/dev/null

" Toggle Pastemode
set pastetoggle=<F2>

" Undo File Stuff
if exists("&undofile")
    set undodir=~/.vim/tmp/undodir
    set undofile
endif

" Backups
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
set backup 

" Make backspace work the way it should
set backspace=2

""  Make backspace and cursor keys wrap accordingly"
set whichwrap+=<,>,h,l

" Make searches case-insensitive
set ignorecase

" Make editing .vimrc easier
map <leader>v :sp ~/.vimrc<CR>
map <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Generate a tags file in the current directory using Exuberant ctags
map <leader>e :silent :! ctags --recurse --sort=yes;sort tags > tmptags;mv tmptags tags<CR>:exe ":echo 'tags generated'"<CR>

filetype plugin indent on

function! AckGrep(command)
  cexpr system("ack -a" . a:command)
  cw
endfunction

command! -nargs=+ -complete=file Ack call AckGrep(<q-args>)

map <leader>a :Ack<space>

" Add a status line by default
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set laststatus=2
" Session saving
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" Omni Completion
" *************************************************************
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

let g:SuperTabDefaultCompletionType = "context"

set background=dark

" Make shifts keep selection
vnoremap < <gv
vnoremap > >gv

set t_Co=256
let g:molokai_original = 1
colorscheme molokai

set background=dark

setlocal spell spelllang=en_us
set nospell

if has('gui_running')
    if has('mac')
        set guifont=Menlo:h14
        set fuoptions=maxvert,maxhorz
    endif

    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R
endif

highlight SpellBad term=underline gui=undercurl guisp=Orange

" Invisible characters *********************************************************
set listchars=trail:.,tab:>-,eol:$
set nolist
:noremap <leader>i :set list!<CR> " Toggle invisible chars"

map <leader>td <Plug>TaskList
map <leader>m <Plug>MakeGreen

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif

  " Run the current file in an interpreter if it has a shebang
  au BufEnter * if match(getline(1) , '^\#!') == 0 |
  \ execute("set makeprg=" . fnameescape(getline(1)[2:] . " %")) |
  \endif
endif

" <leader>r is a shortcut for make
map <leader>r :make<CR>

let g:easytags_cmd = '/usr/local/bin/ctags'
let g:easytags_file = '~/.vim/tmp/tags'
let g:easytags_updatetime_min = 300
