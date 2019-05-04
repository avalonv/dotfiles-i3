" When installing vim on Void, install "vim-x11" for proper clipboard support
" (or just use neovim)
" read:
" https://stackoverflow.com/questions/20579142/toggle-function-in-vim
" :help less

set nocompatible                                        " don't be annoying
filetype plugin indent on                               " enable plugins for file type detection
syntax on                                               " use syntax highlighting
set noshowmode                                          " don't show current mode
set backspace=indent,eol,start                          " allow backspacing over everything in insert mode.
set tabpagemax=30                                       " increase max number of tabs (default is 10)
set history=1000                                        " lots of command line history
set showcmd                                             " display incomplete commands
set wildmenu                                            " display completion matches in a status line
set wildmode=longest,list,full                          " bash like autocompletion
set wildignorecase                                      " ignore case when completing file names
set number                                              " show line numbers
set tabstop=4                                           " input 4 spaces when <tab> is pressed.
set shiftwidth=4                                        " CTRL-V <tab> to insert a real tab.
set expandtab
set smarttab
set hlsearch                                            " highlight matches while searching
let c_comment_strings=1                                 " show strings inside C comments
set mouse=vi                                            " enable mouse suppport in visual and insert modes
set ttimeout                                            " time out for key codes
set ttimeoutlen=100                                     " wait up to 100ms after Esc for special key
set display=truncate                                    " show @@@ in the last line if it is truncated.
set background=dark                                     " don't hurt my eyes
set ignorecase                                          " ignore case in searches
set smartcase                                           " if pattern contains upper case letter, it is case sensitive
set ruler                                               " file name, modified flag, line, column, percentage
set rulerformat=%40(%15(%f\ %)%m\ \ %l\ %c\ \ %p%%%)
set title                                               " Set the window title
set titlestring=vim:\ %F\ %r%m
set scrolloff=5                                         " scroll offset
set scroll=20                                           " number of lines to scroll down with Ctrl-D
set nrformats-=octal                                    " do not recognize octal numbers for Ctrl-A and Ctrl-X
set whichwrap+=<,>,h,l,[,]                              " go up/down when you reach the start/end of the current line
set list                                                " explicitly display trailing characters
set listchars=tab:>\ ,trail:␣,extends:>,precedes:<,nbsp:+
set guicursor=i:blinkon1ver20                           " blinking cursor in insert mode
set nocursorline                                        " highlight the current line (disabled bc hogs resources)
set bufhidden=delete                                    " delete buffers that become hidden from the buffer list
set autoindent                                          " autoindent (duh)
set autoread                                            " ask to update file when it detects edits done outside of vim


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

" https://vi.stackexchange.com/a/456/1111
function! RmTrailing()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

command RmTrailing call RmTrailing()

" open multiple tabs at once
" https://vi.stackexchange.com/a/2110
fun! OpenMultipleTabs(pattern_list)
    for p in a:pattern_list
        for c in glob(l:p, 0, 1)
            execute 'tabedit ' . l:c
        endfor
    endfor
endfun

" open columns on the right if wide enough
fun! CheckColumnLenght()
    if &columns > 166
        set splitright
        wincmd L
    else
        set splitbelow
        wincmd K
    endif
endfun

command! -bar -bang -nargs=+ -complete=file Tabedit call OpenMultipleTabs([<f-args>])

" like :!chmod 744
command MakeExe call setfperm("%","rwxr--r--")

" open help windows on the right
" https://stackoverflow.com/a/21843502/8225672
autocmd FileType help wincmd L
autocmd FileType help call CheckColumnLenght()
"cabbrev h vert help
"cabbrev H abo help

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>v

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
noremap Q gq

" switch between windows
noremap  <A-w> <esc><C-W><C-W>
inoremap <A-w> <esc><C-W><C-W>
noremap  <A-W> <esc><C-W>W
inoremap <A-W> <esc><C-W>W

" go to next/previous tab respectively
noremap  <silent> <A-.> <esc>:tabnext<cr>
noremap  <silent> <A-,> <esc>:tabprevious<cr>
inoremap <silent> <A-.> <esc>:tabnext<cr>
inoremap <silent> <A-,> <esc>:tabprevious<cr>

" open new tab
noremap <A-n> :Tabedit<space>
noremap <A-N> :tabedit<space>

" move all buffers to tabs
" https://superuser.com/a/430324/900060
" :h sball
noremap <Leader>T :tab sball

" open terminal
noremap <Leader>t <esc>:vsplit term://bash

" exit terminal mode
tnoremap <A-w> <C-\><C-n>

" go to next/previous buffer respectively
noremap <silent> gn :bn<cr>
noremap <silent> gp :bp<cr>

" quit
noremap  <A-Q> :q<cr>
inoremap <A-Q> <esc>:q<cr>
vnoremap <A-Q> <esc>:q<cr>

" toggle relative line numbers
noremap <silent> <Leader>l <esc>:set relativenumber!<cr>

" toggle show line numbers
noremap <silent> <Leader>n <esc>:set nu!<cr>

" disable highlighting for the last search
" (https://stackoverflow.com/a/657484/8225672)
map <silent> <F1> :let @/ = ""<cr>

" toggle case insensitve searches
map <Leader>i :set ignorecase!<cr>

" toggle this when you wanna paste some text from a website
map <F8> :set paste!<cr>

" increase/decrease indentation
noremap <Tab> >>
noremap <S-Tab> <<

" emulate arrow in keys insert mode
inoremap <A-h> <left>
inoremap <A-j> <down>
inoremap <A-k> <up>
inoremap <A-l> <right>

" paste last [y]ank
noremap <A-p> "0p
inoremap <A-p> <C-r>0

" (if you wanna delete something saving it to the yank register:
noremap <A-d> "0d

" in insert mode, go to matching bracket
inoremap <A-%> <Esc>%i

" find and replace
" in visual mode, replace only selection, non linewise
" https://stackoverflow.com/a/1104144/8225672
nnoremap <A-r> :%s///gc<left><left><left><left>
vnoremap <A-r> :s/\%V//gc<left><left><left><left>

" filter selection with shell commands
" https://stackoverflow.com/a/2600768/8225672
vnoremap <A-c> :!eval<space>

" insert a new line, from the current character/end of the line respectively
nnoremap oo o<Esc>
nnoremap OO i<cr><Esc>

" paste from register history
inoremap <A-F1> <Esc>"1pi
inoremap <A-F2> <Esc>"2pi
inoremap <A-F3> <Esc>"3pi
inoremap <A-F4> <Esc>"4pi
nnoremap <A-F1> <Esc>"1p
nnoremap <A-F2> <Esc>"2p
nnoremap <A-F3> <Esc>"3p
nnoremap <A-F4> <Esc>"4p

" backspace WORD, but don't append to register
" (https://stackoverflow.com/a/3638557/8225672)
nnoremap <A-BS> "_dB<Esc>

" don't save characters deleted with x to history
noremap x "_x
noremap X "_X

" copy from cursor to end of the line
" see :help Y
nnoremap Y y$

" move lines up or down
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <silent> <A-J> :m .+1<CR>==
nnoremap <silent> <A-K> :m .-2<CR>==
inoremap <silent> <A-J> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-K> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-J> :m '>+1<CR>gv=gv
vnoremap <silent> <A-K> :m '<-2<CR>gv=gv

" move word under cursor left/right
" https://vim.fandom.com/wiki/Swapping_characters%2C_words_and_lines
nnoremap <silent> <A-H> "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>:nohlsearch<CR>
nnoremap <silent> <A-L> "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR>:nohlsearch<CR>

" see :h group-name
colorscheme default
highlight clear CursorLine " highlight ONLY the linenr
hi CursorLineNr     ctermfg=8
hi LineNr           ctermfg=238                              cterm=NONE
hi TabLineFill      ctermfg=16          ctermbg=232          cterm=NONE
hi TabLine          ctermfg=14          ctermbg=232          cterm=NONE
hi TabLineSel       ctermfg=10          ctermbg=232          cterm=Bold
hi Comment                                                   cterm=Italic
hi Operator         ctermfg=3
hi Conditional      ctermfg=11                               cterm=Bold
hi Constant         ctermfg=116
hi Type             ctermfg=13
hi PreProc          ctermfg=5 "63
hi String           ctermfg=4
hi Number           ctermfg=111
hi Repeat           ctermfg=11                               cterm=Bold
hi Label            ctermfg=5
hi Function         ctermfg=10                               cterm=Bold
hi Boolean          ctermfg=198                              cterm=Bold
hi Special          ctermfg=10 "222
hi SpecialChar      ctermfg=2
hi Statement        ctermfg=11

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" this bit was stolen from ren :)

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
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-syntastic/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" don't automatically run syntastically, only toggle it via keybindings
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let s:syntastic_on = 0
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }
function! ToggleSyntasticMode()
    if s:syntastic_on
        SyntasticReset
        let s:syntastic_on = 0
    else
        SyntasticCheck
        let s:syntastic_on = 1
    endif
endfunction
noremap <silent> <Leader>S  :call ToggleSyntasticMode()<cr>

Plug 'vim-airline/vim-airline'
set laststatus=0
set statusline=\ %n\ %F\ %r\ %Y
let g:airline_symbols_ascii = 1 " no fancy symbols
let g:airline_extensions = ['whitespace']
"let g:airline_section_b = '%-0.10{getcwd()}'
let g:airline_section_b = '%n %-0.10{expand("%:p:h:t")}/'
let g:airline_section_c = '%t %{SyntasticStatuslineFlag()}'
let g:airline_section_x = '%y'
noremap <silent> <Leader>A :AirlineToggle<cr>

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'myserene'
"let myserene=expand('~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/myserene.vim')
"if !filereadable(myserene)
"  let g:airline_theme = 'myserene'
"else
"  let g:airline_theme = 'serene'
"endif

Plug 'ap/vim-css-color'

Plug 'rafaqz/ranger.vim'
" open ranger (files are opened in new tab)
noremap <silent> <Leader>R :RangerTab<cr>

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

call plug#end()
