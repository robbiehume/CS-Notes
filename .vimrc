" Mapping explanation
"    https://dev.to/iggredible/basic-vim-mapping-5ahj

" Tab insert spaces?
"    (https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim)

" Resources
"    Useful vimrc: (https://github.com/amix/vimrc)
"    https://github.com/DJMcMayhem/dotFiles/blob/2f91270f2e88ddd9a916c8d81702dcb2e043f5c7/.vimrc#L283

" Useful commands:
"  :help key-notation


"" Commands that need to be edited with ctrl, alt, etc. depending on system:
" alt-j / ctrl-j
" alt-p
" alt-f
" alt-e


"if !has('nvim')
"    set ttymouse=xterm2
"endif


syntax on
set number
"set showmatch       " show matching beginning bracket / parantheses when you input a closing one
set ignorecase
set smartcase
set incsearch       " incremental search
set hlsearch        " highlight search
set laststatus=2
"set autoindent
"set smartindent
"set cursorline
set history=1000

""  Underline instead of highlight search terms
"hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline

set tabstop=4
set shiftwidth=4
filetype plugin indent on
set expandtab

"set cursorline

" Set leader to ',' instead of '\'
let mapleader = ","

nnoremap <leader><space> :noh<CR>

" Map ';' to ':' so you don't have to hit the shift key when running commands
nnoremap ; :

" Allows for scroll and cursor click
"    With this set, need to use Shift or Shift-Alt to copy highlighted text with cursor
"    In order to paste, need to enter insert mode and do Shift-Insert or Shift-Left_Click (or wheel click?)
set mouse=a
set clipboard=unnamed

"nnoremap sp :set paste<CR>
"nnoremap snp :set nopaste<CR>

"nnoremap nu :set number<CR>
"nnoremap nnu :set nonumber<CR>

nnoremap ftn :set ft=nginx<CR>

" Ctrl-S to turn syntax highlighting on / off
nmap <C-S> :syntax on<CR>
nmap <C-S-F> :syntax off<CR>

" Ctrl-J to turn json formatting on; should we do alt-j instead?
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
" Or Ctrl-p instead?
"nnoremap  "0p
"nnoremap  "0P
nnoremap <C-p> "0p

" Alt-p to paste from register while in insert mode (it pastes before the cursor)
imap ^[p ^R0

" Swap current line with line below / above it
nnoremap ml ddp
nnoremap md ddp
nnoremap mu kddpk

" Enter normal mode if 'jk' or 'kj' is typed in any other mode
inoremap jk <ESC>
inoremap kj <ESC>
inoremap jj <ESC>
inoremap kk <ESC>
inoremap JK <ESC>
inoremap KJ <ESC>
inoremap JJ <ESC>
inoremap KK <ESC>

"vnoremap jk <ESC>
"vnoremap kk <ESC>
vnoremap kj <ESC>

cnoremap kj <C-C>
cnoremap jk <C-C>

cnoremap w<CR> w!<CR>
cnoremap wq<CR> wq!<CR>
nnoremap qq :q!<CR>
nnoremap ww :w!<CR>
nnoremap www :w !
nnoremap wwq :wq!<CR>
nnoremap xx :wq!<CR>
"nnoremap wrn :w | ! sudo service nginx restart | sudo service nginx status<CR>
"nnoremap wrs :w ! sudo service server restart; sudo service server status<CR>

" Save and stop current vim process
nnoremap zw :w!<CR> <C-Z>
nnoremap wz :w!<CR> <C-Z>
nnoremap wwz :w!<CR> <C-Z>
cnoremap wz<CR> w!<CR> <C-Z>

" Stop current vim process
nnoremap zz <C-Z>

" Alt-F to W (move forward one word)
nnoremap ^[f W

" Go to matching bracket / parentheses
nnoremap mb %

" Move to middle of the file
nnoremap gm 50%

" Comment out multiple lines
"     Must select the beginning of each line you want to comment by doing Ctrl-V
vmap cc <S-I>#<ESC>

" Comment / uncomment out current line
nnoremap cc <S-I>#<ESC>
nnoremap cd ^s<ESC>

" Comment out multiple lines: javascript/ java style (//)
"     Must select the beginning of each line you want to comment by doing Ctrl-V
vmap cj <S-I>//<ESC>

" Comment / uncomment javascript / java style (//)
nnoremap cj <S-I>//<ESC>

" Comment / uncomment html (<!-- ... -->)
nnoremap ch <S-I><!-- <ESC><S-A> --><ESC>
nnoremap chh <S-I><!-- <ESC><S-A> --><ESC>
nnoremap chd ^dw<ESC>g_dws<BS>

" Cut line and enter insert mode
nnoremap di cc

" Keep new cursor position on visual copy
vnoremap y m`y<C-O>

" Delete character under cursor and enter insert mode (don't copy character)
nnoremap s "_dli

" Shift-Backspace to delete forwards
"imap ^H ^[[3~

" Change current word
"     It will delete the word the current cursor is on, then type what you want to replace
"     Then go to Normal mode and press `.` to replace the next occurrence
"     Can press `n` to go to the next highlighted occurrence and skip the current one without replacing it
nnoremap <silent> ff :let @/=expand('<cword>')<CR>*``cgn
nnoremap ffh cgn

" Replace ' with " on current line(s)
" :s/"/'/g

" Replace all instances of currently highlighted text (https://www.reddit.com/r/vim/comments/19sm9v/replace_all_instances_of_currently_highlighted/)
nnoremap rh :%s///g<left><left>

"" Delete word and enter insert mode
"      used to be caw instead of ciw
nnoremap <silent> dw ciw

" Ctrl-Space or ,+Enter to add new line from insert mode
"     Can also do Alt-o / O
"imap <leader><CR> <Esc>o
imap <C-@> <Esc>o

" Ctrl-H to search / highlight current word under cursor
nnoremap <C-H> *N

" Alt-E to reload file
nnoremap ^[e :e!<CR>G

" Press i while text is highlighted in visusal mode to delete it and enter insert mode
vnoremap i di

" Run current file from terminal
nnoremap <leader>r :w<CR>:!%:p<CR>

" Rerun last command-line change (a command invoked with ':'; ex: :/s/old/new/
nnoremap r: @:<CR>
nnoremap <leader>: @:<CR>

" Press ",." to rerun mapping
"     Can re-run it n amount of times: "n,."
let @j = "."
nnoremap <leader>. @j

"Make it easier to indent a visual selection several times.
xnoremap > >gv
xnoremap < <gv

"Prevents '.swp' files from being placed in the current directory
"set backupdir=~/.vim/Backups,.
"set directory=~/.vim/Backups,.

" Shortcut to open new tab
nnoremap <leader>t :tabedit<space>

" Move around in insert mode
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

"(R)eplace all
nnoremap ^[r yw:%s/\<<C-r>"\>//g<left><left>
"nnoremap ^[r y:%s/<-r>"/new text/g

"Select entire line (minus EOL) with 'vv', entire file (characterwise) with 'VV'
xnoremap <expr> V mode() ==# "V" ? "gg0voG$h" : "V"
xnoremap <expr> v mode() ==# "v" ? "0o$h" : "v"

"Make basic movements work better with wrapped lines
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

"Make backspace delete in normal
nnoremap <BS>    <BS>x
xnoremap <BS>    x
inoremap <C-b> <C-o>db

" Set filetype syntax based on file extension
au BufRead,BufNewFile *.service setfiletype systemd
au BufRead,BufNewFile *homepage*.conf setfiletype nginx
au BufRead,BufNewFile *digest*.conf setfiletype nginx
au BufRead,BufNewFile *bestbets*.conf setfiletype nginx
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

" * To 'unset' an option, just do :set <option>!
" * Replace all tabs with spaces: :%retab
    " must have: set expandtab ts=4 sw=4 ai
" * To indent multiple lines: enter visual mode then select the lines the do >
    " can do 2> or any other number to do multiple tabs
    " can also just do `2>>` (no visual mode) to tab 2 lines starting from the current one (current + next)
