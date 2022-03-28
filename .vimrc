set number
set ignorecase
set smartcase
set incsearch
set hlsearch
set laststatus=2
set autoindent

set tabstop=4

"set mouse=a

nnoremap sp :set paste<CR>
nnoremap snp :set nopaste<CR>

inoremap jk <ESC>
inoremap kj <ESC>

vnoremap jk <ESC>
vnoremap kj <ESC>

cnoremap kj <C-C>
cnoremap jk <C-C>

nnoremap qqq :q!<CR>


try
        set undodir=~/tempRobbie/.undodir
        set undofile
catch
endtry

