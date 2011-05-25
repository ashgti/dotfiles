" no vi compatibility
set nocompatible

" Show position in file
set ruler

" Set to not clear on exti
set t_ti= t_te=

" Show line numbers
set number

" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" Use 4 spaces for tabs, turn on automatic indenting
set tabstop=4
set smarttab
set shiftwidth=4
set autoindent
set expandtab
set backspace=start,indent

" Turn on highlighted search and syntax highlighting
set hlsearch
set incsearch
syntax on

" Turn on line highlighting
" set cursorline " Commented out due to poor performance

" Set leader to comma
let mapleader = ","

" Set up commands for FuzzyFinder and FuzzyFinderTextMate
map <leader>g :FufFile<CR>
map <leader>d :FufDir<CR>
map <leader>f :FufFile<CR>
map <leader>b :FufBuffer<CR>
map <leader>r :FufMruFile<CR>
map <leader>a :Ack<CR>
map <leader>af :AckFile<CR>

" Fuzzy options
" let g:fuzzy_ignore = "*.log"
" let g:fuzzy_matching_limit = 70

" Set up command for NERDTree
map <leader>n :NERDTree<CR>

" Toggle Pastemode
set pastetoggle=<F2>

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

" Invisible characters *********************************************************
set listchars=trail:.,tab:>-,eol:$
set list
:noremap ,i :set list!<CR> " Toggle invisible chars"

" Omni Completion
" *************************************************************
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
" May require ruby compiled in
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete 

set background=dark

" Make shifts keep selection
vnoremap < <gv
vnoremap > >gv

if has('gui_running')
    if has('mac')
        set guifont=Menlo:h14
        set fuoptions=maxvert,maxhorz
    endif
    colorscheme molokai
    set background=dark

    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif