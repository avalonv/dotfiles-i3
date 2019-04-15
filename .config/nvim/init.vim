" When installing vim on Void, install "vim-x11" for clipboard support
" (or just use neovim)

set nocompatible                " don't be annoying
filetype plugin indent on       " enable plugins for file type detection
syntax on                       " use syntax highlighting
set showmode                    " show current mode
set backspace=indent,eol,start  " allow backspacing over everything in insert mode.
set tabpagemax=30               " increase max number of tabs (default is 10)
set history=400                 " keep 200 lines of command line history
set showcmd                     " display incomplete commands
set wildmenu                    " display completion matches in a status line
set wildmode=longest,list,full  " bash like autocompletion
set wildignorecase              " ignore case when completing file names
set number                      " show line numbers
set tabstop=4                   " input 4 spaces when <tab> is pressed.
set shiftwidth=4                " CTRL-V <tab> to insert a real tab.
set expandtab                   " ^
set smarttab                    " ^
set hlsearch                    " highlight ALL matches when searchinag
let c_comment_strings=1         " show strings inside C comments
set ttimeout                    " time out for key codes
set ttimeoutlen=100             " wait up to 100ms after Esc for special key
set display=truncate            " show @@@ in the last line if it is truncated.
set background=dark             " don't look awful
set ignorecase                  " ignore case in searches
set smartcase                   " if pattern contains upper case letter, it is case sensitive

" File name, modified flag, line, column, percentage
set ruler
set rulerformat=%40(%15(%f\ %)%m\ \ %l\ %c\ \ %p%%%)

" Only show status line as a separator between buffers
set laststatus=0
set statusline=\ %n\ %F\ %r\ %Y

" Set the window title
set title
set titlestring=vim:\ %F\ %r%m

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" When you reach the beggining/end of the current line, go up/down
" respectively
set whichwrap+=<,>,h,l,[,]

" Explicitly display trailing characters
"set syntax=whitespace
set listchars=tab:>-,trail:␣,extends:>,precedes:<
set list

" Blinking cursor in insert mode
set guicursor=i:blinkon1ver20

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>v

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
noremap Q gq

"quit all, force
noremap dabs :qa!<cr>

" toggle show line numbers
noremap <F9> :set nu!<cr>

" toggle this when you wanna paste some text from a website
noremap <F4> :set paste!<cr>

" disable highlighting for the last search
" (https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting)
nnoremap <F3> :let @/ = ""<cr>

" go to beggining/end of line respectively (in all modes)
inoremap <A-a> <home>
inoremap <A-e> <end>
noremap <A-a> <home>
noremap <A-e> <end>
vnoremap <A-a> <home>
vnoremap <A-e> <end>

" in insert mode, move a word backwards/fowards respectively
inoremap <A-b> <Esc>hbi
inoremap <A-w> <Esc>lwi

" in insert mode, paste the unnamed register (aka whatever you last yanked in vim)
inoremap <A-p> <C-r>"

" go to next/previous tab respectively
noremap <A-.> :tabnext<cr>
noremap <A-,> :tabprevious<cr>

" go to next/previous buffer respectively
noremap gn :bn<cr>
noremap gp :bp<cr>

" insert a new line, from the current character/end of the line respectively
nnoremap oo o<Esc>
nnoremap OO i<cr><Esc>

" copy line, without inserting new line, keep cursor location
noremap yy my<Esc>0y$<Esc>`y
noremap YY my<Esc>^y$<Esc>`y

" the trailing space is intentional
noremap <A-n> :tabedit 

" pressing shift is a lil hard
noremap ; :


"colorscheme elflord
colorscheme default
hi Normal           ctermfg=7           ctermbg=16
hi TabLineFill      ctermfg=16          ctermbg=232          cterm=NONE
hi TabLine          ctermfg=14          ctermbg=232          cterm=NONE
hi TabLineSel       ctermfg=10          ctermbg=232          cterm=Bold
hi Comment          ctermfg=242                              cterm=Italic
hi LineNr           ctermfg=240                              cterm=Bold
hi Function         ctermfg=198                              cterm=Bold
hi Boolean          ctermfg=198                              cterm=Bold

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" stolen from ren :)

call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
let g:airline_symbols_ascii = 1    " i don't like fancy fonts v_v
set noshowmode                     " if the airline loads it will always show the mode

call plug#end()
