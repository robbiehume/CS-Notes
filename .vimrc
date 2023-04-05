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

nnoremap nu :set number<CR>
nnoremap nnu :set nonumber<CR>

inoremap jk <ESC>
inoremap kj <ESC>

vnoremap jk <ESC>
vnoremap kj <ESC>

cnoremap kj <C-C>
cnoremap jk <C-C>

nnoremap qq :q!<CR>
nnoremap ww :w<CR>
nnoremap wwq :wq<CR>

try
        set undodir=~/.undodir
        set undofile
catch
endtry

