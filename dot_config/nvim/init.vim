" SETTINGS - GENERAL -------------------------------------------------------------------------------- {{{

set nobackup          " Disables backups
set nowritebackup     " Doesn't write out changes via backup files
set noswapfile        " Disables swap files
set autoread          " When a file has been changed outside vim, read it again

set mouse=a                     " Enables mouse support in all modes
set history=1000                " Number of lines of command history that vim has to remember
set undolevels=100              " Number of undo levels
set fileformats=unix,dos,mac    " Sets file formats

" Filetype
filetype on           " Enables file type detection
filetype plugin on    " Enables plugins and loads plugins for current file type
filetype indent on    " Enables indent files for file types

" Search
set incsearch     " Highlights the first matching word during search
set hlsearch      " Highlights all words during search
set smartcase     " Enables smart case (if search contains upper case characters, override ignorecase)
set infercase     " Adjusts the case of the search based on the case of typed text

" Blank characters
set nolist                  " Disables showing blank characters (can be turned on with <leader>l)
set listchars=space:·       " Space
set listchars+=nbsp:×       " Non-breaking space
set listchars+=tab:▸\       " Tab
set listchars+=trail:+      " Trailing space
set listchars+=eol:¬        " End-of-line
set listchars+=precedes:←   " Indicates that there is text on the previous screen
set listchars+=extends:→    " Indicates that there is text on the next screen

" Wild menu
set wildmenu wildmode=full    " Enables command selection on pressing ctrl+n (insert mode)

" Wrap; linebreak
set nowrap            " Disables wrapping by default, can be turned on and off with <leader>k

set textwidth=200     " Width of the line before inserting <EOL>
set breakindent       " Wrapped lines will continue to be visually indented
set linebreak         " Breaks lines at whole words, does not insert <EOL>s
set showbreak=+++\    " Wrap-broken line prefix

" Indents and tabs
set autoindent smartindent    " Auto-indents new lines

set expandtab                 " Pressing tab will insert spaces instead of <Tab>
set smarttab shiftwidth=2     " Inserts 'shiftwidth' amount of blanks when in front of line, ignoring values below
set tabstop=2                 " Width of an actual <Tab> character
set softtabstop=2             " Number of spaces to be deleted with <BS> and inserted with <Tab> (requires expandtab)

" Folding
set foldmethod=indent     " Set the folding method
set foldenable            " Folds loaded when opening file
set foldnestmax=10        " Maximum nesting (only indent and syntax)
set foldlevel=4           " Folds above the given level will be closed, and opened if below
set foldcolumn=3          " Columns to the side, with symbols indicating folds
set foldignore=           " Folds starting with those characters will get their fold level from surrounding lines (only indent, default is #)

" Other
set confirm                       " Confirm wen exiting out of an unsaved file
set splitbelow splitright         " Fixes splitting of windows
set virtualedit=none              " Free-range cursor (block/insert/all/none)
set virtualedit=all               " Free-range cursor (block/insert/all/none)
set lazyredraw                    " Don't redraw while executing macros

" Persistent undo
set undofile undodir=$XDG_CONFIG_HOME/nvim/undo

" Shortmess flags (default: filnxtToOS)
set shortmess=
set shortmess=n       " Use '[New]' instead of '[New File]'
set shortmess+=x      " shorten format messages, like '[unix format]' to '[unix]'
set shortmess+=o      " Overwrite message for writing a file with subsequent message for writing a file
set shortmess+=s      " Don't give 'search hit TOP, continuing at BOTTOM' messages
set shortmess+=I      " Don't give intro message when starting vim
set shortmess+=q      " use 'recording' instead of 'recording @a'
set shortmess+=W      " Don't give 'written' or '[w]' when writing a file

" }}}
" SETTINGS - UI (COLORS, CURSOR, STATUSBAR, TABLINE) ------------------------------------------------ {{{

" Colors
if &t_Co>2 || has("gui_running")
  syntax enable                   " Enables syntax highlighting
  try
    set termguicolors               " Enables true color, uses guibg and guifg in the rerminal
    colorscheme nord              " Selects color scheme
  catch                           " Don't throw out an error when colorscheme can't be found
  endtry
endif

" Cursor Position
set number relativenumber             " Show line numbers (relative to current position)
set ruler rulerformat=%=%Y\ ·\ %p%%   " Shows current position (requires status bar to be disabled); format is max 18 characters
set cursorline cursorcolumn           " Screen column and line under cursor
set scrolloff=3 sidescroll=6          " Lines and columns of space between cursor and screen boundary

" Statusline and tabline
set laststatus=0 showtabline=1      " Statusbar and tabline (0-never, 1-when more than one window, 2-always)

set statusline=                                             " Clears the status line on .vimrc reload
set statusline+=[%M%R%H%W]\ %F\ ·\ %Y                       " Left side of the status bar
set statusline+=%=                                          " Separator between left and right side
set statusline+=ascii(%b)\ ·\ hex(0x%B)\ ·\ [%l:%c]\ %p%%   " Right side of the status bar

" Other
set showmode      " Show the mode you are in on the last line
set showmatch     " Shows matching brace

" }}}
" AUTOCMD - GENERAL --------------------------------------------------------------------------------- {{{

augroup general
  " Remove all autocommands for the current group
  autocmd!

  " Vertically center the document as you enter insert mode
  autocmd InsertEnter * norm zz

  " Toggles cursor/columnline when changing split focus
  autocmd WinLeave * setlocal nocursorline nocursorcolumn
  autocmd WinEnter * setlocal cursorline cursorcolumn

  " Automatically removes trailing whitespace on write
  autocmd BufWritePre * :%s/\s\+$//e

  " Format options (default: croql)
  autocmd Filetype * setlocal formatoptions-=c  " Don't auto-wrap comments
  autocmd Filetype * setlocal formatoptions-=r  " Don't comment on pressing enter in insert mode
  autocmd Filetype * setlocal formatoptions-=o  " Don't comment on pressing 'o' to enter insert mode
augroup END

" }}}
" AUTOCMD - FILETYPE-SPECIFIC SETTINGS -------------------------------------------------------------- {{{

" vim
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim inoremap <buffer> " "
augroup END

" C, C++
augroup filetype_c_cpp
  autocmd!
  autocmd Filetype c,cpp setlocal cindent
augroup END

" }}}
" BINDINGS - GENERAL, W/ LEADER --------------------------------------------------------------------- {{{
" Comma doesn't work as a mapleader in visual and select modes

let mapleader=','

" hide search highlight
nmap <silent> <leader>/ :nohlsearch<cr>:echo "Search highlight hidden"<cr>

" Save, quit document
nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q<cr>

" Toggle wrapping lines
nmap <silent> <leader>k :setlocal wrap! wrap?<cr>

" Toggle blank characters
nmap <silent> <leader>l :setlocal list! list?<cr>

" Toggle spell checking
nmap <silent> <leader>S :setlocal spell! spell?<cr>

" Toggle statusline
nmap <leader>s0 :setlocal laststatus=0<cr>
nmap <leader>s1 :setlocal laststatus=1<cr>
nmap <leader>s2 :setlocal laststatus=2<cr>

" }}}
" BINDINGS - GENERAL, WO/ LEADER -------------------------------------------------------------------- {{{

" Unmap ex mode key. Not really useful.
nnoremap Q <Nop>

" Assign : functionality to ; to save keystrokes
nnoremap ; :

" Move the line up or down
"vnoremap <silent> <S-Up> :m '<-2<CR>gv=gv
"vnoremap <silent> <S-Down> :m '>+1<cr>gv=gv
nnoremap <silent> <S-Up> v:m '<-2<cr>gv=gv<esc>
nnoremap <silent> <S-Down> v:m '>+1<cr>gv=gv<esc>

" Fold/unfold under cursor
nnoremap <Space> za

" Global replace
nnoremap \ :%s//g<Left><Left>

" Indent in normal and visual mode
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" }}}
" BINDINGS - ON-SCREEN NAVIGATION ------------------------------------------------------------------- {{{
" Most if not all use 'map' or 'noremap' to work in normal, visual, select and operator-pending modes

" Unmap all of the uppercase navigation keys
map H <Nop>
map J <Nop>
map K <Nop>
map L <Nop>

" Move to the top/bottom of the screen (takes into account scrolloff setting)
noremap gj L
noremap gk H

" Jump to matching bracket
noremap gb %

" Move to first/last character in a line
map ^ <Nop>
map $ <Nop>
noremap gh ^
noremap gl $

" center the cursor when moving between searched words
vnoremap n nzzzv
vnoremap N nzzzv

" }}}
" BINDINGS - SPLITS, TABS AND BUFFERS --------------------------------------------------------------- {{{

" Split screen
nmap <silent> <leader>v :vsplit<cr>:echo "Created split"<cr>
nmap <silent> <leader>c :close<cr>:echo "Closed split"<cr>

" Navigation between splits
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Resizing splits
nmap <silent> <C-S-Left> :vertical resize -3<cr>
nmap <silent> <C-S-Right> :vertical resize +3<cr>
nmap <silent> <C-S-Up> :resize +3<cr>
nmap <silent> <C-S-Down> :resize -3<cr>

" Tabs
nmap <silent> <leader>tt :tabnew<cr>:echo "Created new tab"<cr>
nmap <silent> <leader>to :tabonly<cr>:echo "Closed all but current tab"<cr>
nmap <silent> <leader>tc :tabclose<cr>:echo "Closed tab"<cr>
nmap <silent> <leader>tq :tabclose!<cr>:echo "Closed tab without saving changes"<cr>

" Buffers
nmap <silent> <leader>bb :ls<cr>

nmap <leader>ba :badd %d
nmap <leader>bd :bdelete<space>

nmap <silent> <leader>bn :bnext<cr>
nmap <silent> <leader>bp :bprevious<cr>
nmap <silent> <leader>bf :bfirst<cr>
nmap <silent> <leader>bl :blast<cr>

" }}}
" FUNCTIONS & FUNspspaceeION KEYS BINDINGS ---------------------------------------------------------------- {{{

" Source and edit vimrc
map <F2> :source $MYVIMRC<cr>
map <S-F2> :edit $MYVIMRC<cr>

" COMPILERS
map <F5> :call CompileRun()<cr>
imap <F5> <Esc>:call CompileRun()<cr>
vmap <F5> <Esc>:call CompileRun()<cr>

func! CompileRun()
exec "w"
if &filetype == 'c'
  exec "!gcc % -o %<"
  exec "!time ./%<"
elseif &filetype == 'cpp'
  exec "!g++ % -o %<"
  exec "!time ./%<"
elseif &filetype == 'sh'
  exec "!time bash %"
elseif &filetype == 'python'
  exec "!time python3 %"
endif
endfunc

" }}}
" ABBREVIATIONS & AUTO-COMPLETE --------------------------------------------------------------------- {{{

" Abbreviations - replaces small chunks of text as you type, helpful with misspellings or templates

" Sudo write (requires sudo, of course)
cnoreabbrev w!! w !sudo tee % >/dev/null


" return current opened file's directory
cnoremap %d <C-R>=expand('%:h').'/'<cr>

" return current opened file's name
cnoremap %f <C-R>=expand('%:f')<cr>

" Mispellings of save, quit
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Date
inoreabbrev xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" C/C++ template
inoreabbrev ctemplate #include <iostream><cr><cr>int main(void)<cr>{<cr><cr>return 0;<cr>}<esc>3ka

" }}}
" PLUGINS ------------------------------------------------------------------------------------------- {{{

" Built-in plugin, expands % to also include words, like 'if', 'else', 'try', 'catch' etc.
packadd! matchit
" }}}
