" Mapping explanation
"    https://dev.to/iggredible/basic-vim-mapping-5ahj

" Tab insert spaces?
"    (https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim)

syntax on
set number
set ignorecase
set smartcase
set incsearch
set hlsearch
set laststatus=2
set autoindent
set smartindent
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
"    https://unix.stackexchange.com/questions/139578/copy-paste-for-vim-is-not-working-when-mouse-set-mouse-a-is-on
set mouse=a

"nnoremap sp :set paste<CR>
"nnoremap snp :set nopaste<CR>

nnoremap nu :set number<CR>
nnoremap nnu :set nonumber<CR>

nnoremap ftn :set ft=nginx<CR>

" Turn syntax highlighting on / off
nmap ^S :syntax on<CR>
nmap ^S^F :syntax off<CR>

" Redo last undo
nnoremap rr <c-r>

" Move to beginning / end of line
nnoremap fh 0
nnoremap fl $

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

" Enter normal mode if 'jk' or 'kj' is typed in any other mode 
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

" Alt-F to W (move forward one word)
nnoremap ^[f W

" Comment out multiple lines
"     Must select the beginning of each line you want to comment by doing Ctrl-V
vmap cc <S-I>#<ESC>

" Shift-Backspace to delete forwards
imap ^H ^[[3~

" Change current word
"     It will delete the word the current cursor is on, then type what you want to replace
"     Then go to Normal mode and press `.` to replace the next occurrence
"     Can press `n` to go to the next highlighted occurrence and skip the current one without replacing it
nnoremap <silent> ff :let @/=expand('<cword>')<cr>*``cgn

" Ctrl-Space or ,+Enter to add new line from insert mode
imap <leader><cr> <Esc>o
imap <C-@> <Esc>o

" Ctrl-H to search / highlight current word under cursor 
nnoremap <C-H> *N

" Alt-E to reload file
nnoremap ^[e :e!<CR>

" Set filetype syntax based on file extension
au BufRead,BufNewFile *.service setfiletype systemd

" Keeps past edits so you can undo to past changes from previous vim sessions
"    Must create ~/.undodir first 
try
        set undodir=~/.undodir
        set undofile
catch
endtry

