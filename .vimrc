" Mapping explanation
"    https://dev.to/iggredible/basic-vim-mapping-5ahj

set number
set ignorecase
set smartcase
set incsearch
set hlsearch
set laststatus=2
set autoindent
set history=500

set tabstop=4

"set cursorline

" Set leader to ',' instead of '\'
let mapleader = ","

nnoremap <leader><space> :noh<cr>

" Map ';' to ':' so you don't have to hit the shift key when running commands
nnoremap ; :

" Allows for scroll and cursor click
"    With this set, need to use Shift or Shift-Alt to copy highlighted text with cursor
"    In order to paste, need to enter insert mode and do Shift-Insert or Shift-Left_Click (or wheel click?)
set mouse=a

"nnoremap sp :set paste<CR>
"nnoremap snp :set nopaste<CR>

nnoremap nu :set number<CR>
nnoremap nnu :set nonumber<CR>

" Can do ',dd' to cut line(s) to different paste registry
"   Do ',pp' to paste
nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <leader>p "_dp
xnoremap <leader>p "_dp

inoremap jk <ESC>
inoremap kj <ESC>
inoremap jj <ESC>

vnoremap jk <ESC>
vnoremap kj <ESC>

cnoremap kj <C-C>
cnoremap jk <C-C>

nnoremap qq :q!<CR>
nnoremap ww :w<CR>
nnoremap wwq :wq<CR>
nnoremap www :w !

" Comment out multiple lines
"     Must select the beginning of each line you want to comment by doing Ctrl-V
vmap cc <S-I>#<ESC>

" Change current word
"     It will delete the word the current cursor is on, then type what you want to replace
"     Then go to Normal mode and press `.` to replace the next occurrence
"     Can press `n` to go to the next highlighted occurrence and skip the current one without replacing it
nnoremap <silent> ff :let @/=expand('<cword>')<cr>*``cgn

" Ctrl-Space to new line
imap <C-@> <Esc>o

try
        set undodir=~/.undodir
        set undofile
catch
endtry

