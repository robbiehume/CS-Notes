" Mapping explanation
"    https://dev.to/iggredible/basic-vim-mapping-5ahj

" Tab insert spaces?
"    (https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim)

" Resources
"    Useful vimrc: (https://github.com/amix/vimrc)

syntax on
set number
set showmatch       " show matching beginning bracket / parantheses when you input a closing one
set ignorecase
set smartcase
set incsearch       " incremental search
set hlsearch        " highlight search
set laststatus=2
"set autoindent
"set smartindent
"set cursorline
set history=500

set tabstop=4
set shiftwidth=4
filetype plugin indent on
set expandtab

"set cursorline

" Set leader to ',' instead of '\'
let mapleader = ","

nnoremap <leader><space> :noh<cr>

" Map ';' to ':' so you don't have to hit the shift key when running commands
nnoremap ; :

" Allows for scroll and cursor click
"    With this set, need to use Shift or Shift-Alt to copy highlighted text with cursor
"    In order to paste, need to enter insert mode and do Shift-Insert or Shift-Left_Click (or wheel click?)
"    https://unix.stackexchange.com/questions/139578/copy-paste-for-vim-is-not-working-when-mouse-set-mouse-a-is-on
set mouse=a

"nnoremap sp :set paste<CR>
"nnoremap snp :set nopaste<CR>

"nnoremap nu :set number<CR>
"nnoremap nnu :set nonumber<CR>

nnoremap ftn :set ft=nginx<CR>

" Turn syntax highlighting on / off
nmap ^S :syntax on<CR>
nmap ^S^F :syntax off<CR>

" Ctrl-J to turn json formatting on
nmap <C-J> :%!jq .<CR>G

" Redo last undo
nnoremap rr <c-r>

" Move to beginning / end of line
nnoremap fh ^
nnoremap fl g_

" Can do ',dd' to cut line(s) to different paste registry
"   Do ',pp' to paste
nnoremap <leader>d "_d
xnoremap <leader>d "_d
nnoremap <leader>p "_dp
xnoremap <leader>p "_dp

" Alt-p to paste from copy register (helpful if you delete something after copying)
"     Alt-P for paste before cursor
nnoremap ^[p "0p
nnoremap ^[P "0P

" Alt-p to paste from register while in insert mode (it pastes before the cursor)
imap ^[p ^R0

" Swap current line with line below it
nnoremap ml ddp

" Enter normal mode if 'jk' or 'kj' is typed in any other mode 
inoremap jk <ESC>
inoremap kj <ESC>
inoremap jj <ESC>
inoremap kk <ESC>

"vnoremap jk <ESC>
vnoremap kk <ESC>
vnoremap kj <ESC>

cnoremap kj <C-C>
cnoremap jk <C-C>

nnoremap qq :q!<CR>
nnoremap ww :w<CR>
nnoremap wwq :wq<CR>
nnoremap www :w !

" Alt-F to W (move forward one word)
nnoremap ^[f W

" Comment out multiple lines
"     Must select the beginning of each line you want to comment by doing Ctrl-V
vmap cc <S-I>#<ESC>

" Comment / uncomment out current line
nnoremap cc <S-I>#<ESC>
nnoremap cd ^s<ESC>

" Cut line and enter insert mode
nnoremap di cc

" Shift-Backspace to delete forwards
imap ^H ^[[3~

" Change current word
"     It will delete the word the current cursor is on, then type what you want to replace
"     Then go to Normal mode and press `.` to replace the next occurrence
"     Can press `n` to go to the next highlighted occurrence and skip the current one without replacing it
nnoremap <silent> ff :let @/=expand('<cword>')<cr>*``cgn

" Ctrl-Space or ,+Enter to add new line from insert mode
"     Can also do Alt-o / O
imap <leader><cr> <Esc>o
imap <C-@> <Esc>o

" Ctrl-H to search / highlight current word under cursor
nnoremap <C-H> *N

" Alt-E to reload file
nnoremap ^[e :e!<CR>

" Press i while text is highlighted in visusal mode to delete it and enter insert mode
vnoremap i di

" Set filetype syntax based on file extension
au BufRead,BufNewFile *.service setfiletype systemd
au BufRead,BufNewFile *log_format.conf setfiletype nginx

" Keeps past edits so you can undo to past changes from previous vim sessions
"    Must create ~/.undodir first 
try
        set undodir=~/.undodir
        set undofile
catch
endtry


"""""""""""""""""""""
"" NOTES
"""""""""""""""""""""

" to 'unset' an option, just do :set <option>!
" Replace all tabs with spaces: :%retab
    " must have: set expandtab ts=4 sw=4 ai
