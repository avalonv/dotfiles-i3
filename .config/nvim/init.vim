" vim:foldenable:foldmethod=marker
" TODO:
" plugins to test:
" nerdcommenter
" disable airline extensions

"******** SETTINGS ******** {{{

" quite a few of these are set by default, but I prefer to have them here anyways
filetype plugin indent on                               " enable plugins for file type detection
syntax on                                               " use syntax highlighting
set nocompatible                                        " don't be annoying
set backspace=indent,eol,start                          " allow backspacing over everything in insert mode.
set tabpagemax=30                                       " increase max number of tabs (default is 10)
set history=1000                                        " lots of command line history
set wildmenu
" set wildmode=longest,list,full                          " bash like autocompletion (superseded by popup menu)
set wildignorecase                                      " ignore case when completing file names
set wildignore=*.o,*.obj,*.out                          " ignore the following types when autocompleting filenames
set number                                              " show line numbers
set tabstop=8                                           " input 4 spaces when <tab> is pressed.
set shiftwidth=4                                        " CTRL-V <tab> to insert a real tab.
set expandtab
set smarttab
set hlsearch                                            " highlight matches while searching
set incsearch
set mouse=vi                                            " enable mouse support in visual and insert modes
set ttimeout                                            " time out for key codes
set ttimeoutlen=50                                      " wait up to 100ms after Esc for special key
set timeoutlen=700                                      " wait up to 700ms to complete a sequence of commands
set display=truncate                                    " show @@@ in the last line if it is truncated.
set background=dark                                     " don't hurt my eyes
set ignorecase                                          " ignore case in searches
set smartcase                                           " if pattern contains upper case letter, it is case sensitive
set title                                               " Set the window title
set titlestring=vim:\ %F\ %r%m
set scrolloff=5                                         " scroll offset
set nrformats-=octal                                    " do not recognize octal numbers for Ctrl-A and Ctrl-X
set whichwrap+=<,>,h,l,[,]                              " go up/down when you reach the start/end of the current line
set list                                                " explicitly display trailing characters
set listchars=tab:>·,trail:␣,extends:>,precedes:<,nbsp:+
set guicursor=i:blinkon1ver20                           " blinking cursor in insert mode
set nocursorline                                        " highlight the current line (disabled bc hogs resources)
set autoindent                                          " autoindent (duh)
set autoread                                            " ask to update file when it detects edits done outside of vim
set autochdir                                           " auto change working directory
set hidden                                              " don't ask to save buffers when closing them, hide them
set splitright                                          " open new windows on the right by default
set nofoldenable                                        " initially disable folding
set foldlevel=0                                         " Autofold everything by default
set foldmethod=marker
set foldnestmax=1                                       " only fold outer functions
"set lazyredraw                                          " don't redraw screen while macros are running
set confirm                                             " confirm quit
set numberwidth=3                                       " smaller line number width
set complete=.,w,b,u,t,spell                            " enable english word suggestions when 'spell is on
set updatetime=300                                      " smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c                                        " don't give |ins-completion-menu| messages.
set relativenumber
set statusline=\ %n\ %F\ %r\ %Y
set belloff=all
set spellsuggest=15                                     " never give more than 15 spell suggestions
set showmode
set ruler

if has("nvim-0.3")
    set signcolumn=yes                                      " always show gutter on the left
endif
if has("nvim-0.4")
    set wildoptions=pum                                     " use ins-completion like pop menu for wildmenu
endif

let c_comment_strings=1                                 " show strings inside C comments
let python_highlight_all=1                              " use full python syntax highlighting
"}}}
"******** PLUGINS ********* {{{
" auto install plug{{{
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
"}}}
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline' "{{{
set noshowmode
set noruler " no gods no masters
" set laststatus=0
" set statusline=\ %n\ %F\ %r\ %Y
" let g:airline_symbols_ascii = 1 " no fancy symbols
let g:airline#extensions#disable_rtp_load = 1
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['whitespace','tabline','coc']
let g:airline#extensions#tabline#buffers_label = 'B:'
let g:airline#extensions#tabline#tabs_label = 'T:'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buf_label_first = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_section_x = ''
let g:airline_section_y = '%y'
" let g:airline_section_c = '%-0.15{expand("%:p:h")}/%t %{SyntasticStatuslineFlag()}'
" let g:airline_section_x = '%y %z'

noremap <silent> <Leader>A :AirlineToggle<cr>
"<- airline themes ->
Plug 'vim-airline/vim-airline-themes'
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'COMM',
    \ 'i'      : 'INSE',
    \ 'ic'     : 'IN-C',
    \ 'ix'     : 'INSE',
    \ 'n'      : 'NORM',
    \ 'multi'  : 'NORM',
    \ 'ni'     : 'NORM',
    \ 'no'     : 'NORM',
    \ 'R'      : 'REPL',
    \ 'Rv'     : 'REPL',
    \ 's'      : 'REPL',
    \ 'S'      : 'REPL',
    \ '^S'     : 'REPL',
    \ 't'      : 'Term',
    \ 'v'      : 'VISU',
    \ 'V'      : 'VI-L',
    \ ''     : 'VI-B',
    \ }

" let g:airline_theme_patch_func = 'AirlineThemePatch'
" function! AirlineThemePatch(palette)
"   if g:airline_theme == 'serene'
"     for colors in values(a:palette.inactive)
"       let colors[3] = 245
"     endfor
"   endif
" endfunction

if !empty(glob("~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/myserene.vim"))
  let g:airline_theme = 'mylucius'
else
  let g:airline_theme = 'lucius'
endif

"}}}
Plug 'rafaqz/ranger.vim' "{{{
"}}}
Plug 'tpope/vim-surround' "{{{
"}}}
Plug 'tpope/vim-commentary' "{{{
"}}}
Plug 'Yggdroot/indentLine' "{{{
let g:indentLine_char = '|'
autocmd FileType man,help IndentLinesDisable
autocmd TermOpen * IndentLinesDisable
" append to ~/.config/nvim/plugged/ranger.vim/plugin/ranger.vim:
"  setlocal norelativenumber
"  setlocal nonumber
"  setlocal signcolumn=no
"  IndentLinesDisable
"}}}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} "{{{
let g:coc_global_extensions = [
            \  'coc-emoji', 'coc-eslint', 'coc-yank', 'coc-prettier',
            \  'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
            \  'coc-css', 'coc-pyls', 'coc-pairs', 'coc-json', 'coc-yaml']


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" default:

"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" modified for delimitMate (see https://github.com/Raimondi/delimitMate/issues/111):
" imap <expr> <CR> pumvisible()
"             \ ? "\<C-y>"
"             \ : '<Plug>delimitMateCR'

" for 'coc-pairs' (see https://github.com/neoclide/coc-pairs/issues/13#issuecomment-478998416):
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" show yank history
" nnoremap <silent> "" :<C-u>CocList -A --normal yank<cr>
"}}}
Plug 'tpope/vim-repeat' "{{{
"}}}
Plug 'lilydjwg/colorizer' "{{{
"}}}
Plug 'tpope/vim-eunuch' "{{{
"}}}
call plug#end()
"}}}
"*** FUNCTIONS/COMMANDS *** {{{

" https://vi.stackexchange.com/a/456/1111
function! RmTrailing()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

command! RmTrailing call RmTrailing()

"help me
" split windows to the right if wide enough
function! CheckColumnLenght()
    if &columns > 140
        set splitright
        wincmd L
    else
        set splitbelow
        wincmd K
    endif
endfunction

function! <SID>BetterRegister()
    let more = &more
    set nomore
    redraw!
    registers
    echohl Question | echon "\nPlease press the register name" | echohl None
    let &more = more
    while 1
        let ch = getchar()
        if ch !~# '\v[0-9]+'
            continue
        else
            redraw!
            return nr2char(ch)
        endif
    endwhile
endfunction

function! <SID>BetterMark()
    let more = &more
    set nomore
    redraw!
    marks
    echohl Question | echon "\nPlease press the mark name" | echohl None
    let &more = more
    while 1
        let ch = getchar()
        if ch !~# '\v[0-9]+'
            continue
        else
            redraw!
            return nr2char(ch)
        endif
    endwhile
endfunction

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif


command! ChmodX !chmod +x %

command! SingleCompile !gcc -W -o "%:r"_temp.out %

if !has("nvim")
    command! Config edit ~/.vimrc
else
    command! Config edit ~/.config/nvim/init.vim
endif

" if !has("nvim")
"     command! SudoWrite w !sudo tee % > /dev/null
" else
    " https://github.com/neovim/neovim/issues/1716 (just use eunuch.vim for
    " now)
    " command! SudoWrite w :term sudo tee % > /dev/null
" endif

command! CopyDir silent !echo "$(pwd)" | xclip -selection clipboard
command! CopyFullPath silent !echo '%:p' | xclip -selection clpboard

" stolen from justinmk
command! InsertDate           norm! i<c-r>=strftime('%Y/%m/%d %H:%M:%S')<cr>
command! InsertDateYYYYMMdd   norm! i<c-r>=strftime('%Y%m%d')<cr>

" get hightlight group for word under cursor
command! GetHlGroup echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
"}}}
"******** AUTOCMDS ******** {{{
"
" open help windows on the right
" https://stackoverflow.com/a/21843502/8225672
" autocmd FileType help wincmd K
" autocmd FileType help call CheckColumnLenght()

" open new windows on the right by default (https://github.com/neovim/neovim/issues/8350)
" disabled because this causes weird bugs with certain windows unless you add
" ":noautocmd" to everything
" if has("nvim-0.3")
"     autocmd WinNew * wincmd L
" endif

" enable fold markers for these files
autocmd FileType c,c++ setlocal foldmethod=syntax
autocmd FileType python,sh setlocal foldmethod=indent
autocmd FileType txt,conf,vim setlocal foldmethod=marker

" https://www.reddit.com/r/vim/comments/48zclk/i_just_found_a_simple_method_to_read_pdf_doc_odt/
" Read-only docs through pandoc (requires pandoc)
autocmd BufReadPre *.docx,*.rtf,*.odp,*.odt silent setlocal readonly
autocmd BufReadPost *.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout

" Read-only .doc through antiword
autocmd BufReadPre *.doc silent setlocal readonly
autocmd BufReadPost *.doc silent %!antiword "%"

" Read-only pdf through pdftotext (requires poppler-utils)
autocmd BufReadPre *.pdf silent setlocal readonly
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78

" remove line numbers when entering terminal:
autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
autocmd TermClose * setlocal number relativenumber signcolumn=yes

autocmd FileType markdown,txt setlocal spell
"}}}
"******** MAPPINGS ******** {{{
map <space> <leader>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>v

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
noremap Q gq

" go to next/previous tab respectively
noremap  <silent> <M-.> <esc>:tabnext<cr>
inoremap <silent> <M-.> <esc>:tabnext<cr>
noremap  <silent> <M-,> <esc>:tabprevious<cr>
inoremap <silent> <M-,> <esc>:tabprevious<cr>

" open new tab/edit new file
noremap <C-w>e <esc>:edit<space>
noremap <silent> <C-w>N :tabnew<cr>

" I want https://github.com/neovim/neovim/issues/8350 !!!!
noremap <silent> <C-w>n :new<cr>:wincmd L<cr>
noremap <silent> <C-w>f <C-w>f<C-w>L

" delete buffer
noremap <silent> <C-w>D <esc>:bdelete<cr>

" move all buffers to tabs
" https://superuser.com/a/430324/900060
" :h sball
noremap <Leader>t <esc>:buffers<cr>:tab sball

" open terminal
noremap <silent> <Leader>T <esc>:vsplit term://bash<cr>

" stop reading input in terminal
tnoremap <M-w> <C-\><C-n>

" go to next/previous/last buffer respectively
noremap <silent> gp :bnext<cr>
noremap <silent> go :bprevious<cr>
noremap <silent> gl <esc>:buffer #<cr>

" list buffers
noremap <C-w>b <esc>:buffers<cr>:buffer<space>

" quit/delbuffer
noremap  <silent> <M-Q> <esc>:q<cr>
inoremap <silent> <M-Q> <esc>:q<cr>
cnoremap <silent> <M-Q> <esc>:q<cr>

" toggle line numbers
noremap <silent> <Leader>l <esc>:set relativenumber!<cr>:set nu!<cr>

" toggle spell
noremap <silent> <Leader>s <esc>:set spell!<cr>

" disable highlighting for the last search
" (https://stackoverflow.com/a/657484/8225672)
map <silent> <F1> :nohlsearch<cr>
imap <silent> <F1> <esc>:nohlsearch<cr>a

" toggle case insensitive searches
map <Leader>i :set ignorecase!<cr>

" copy selection clipboard
noremap + "+y
noremap ++ "+yy
vnoremap + "+y
vnoremap ++ "+yy
xnoremap + "+y
xnoremap ++ "+yy

" increase/decrease indentation
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" emulate arrow in keys insert mode
inoremap <M-h> <left>
inoremap <M-j> <down>
inoremap <M-k> <up>
inoremap <M-l> <right>

" move faster
noremap <C-j> 5j
noremap <C-k> 5k

" pasting over a selection in visual mode doesn't replace the unnamed
" register with the selection
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>

" don't save characters deleted with x the unnamed register
noremap x "_x
noremap X "_X

" regular s is pretty useless, change it to d{elete} but without overwriting
" the unnamed register
noremap s  "_d
noremap S  "_D
noremap ss "_dd

" c{hange} without overwriting the unnamed register
noremap c "_c
noremap C "_C
noremap cc "_cc

" copy from cursor to end of the line
" see :help Y
nnoremap Y y$

" find and replace
" in visual mode, replace only within selection, non linewise
" https://stackoverflow.com/a/1104144/8225672
nnoremap <M-r> :%s:::gc<left><left><left><left>
vnoremap <M-r> :s:\%V::gc<left><left><left><left>

" filter selection with shell commands
" https://stackoverflow.com/a/2600768/8225672
vnoremap <M-c> :!eval<space>

" insert a new line, from the current character/end of the line respectively
nnoremap oo o<Esc>
nnoremap OO i<cr><Esc>

" coc sometimes interfere with <M-A>
inoremap <M-0> <C-o>^
inoremap <M-a> <C-o>A
inoremap <M-b> <C-o>b
inoremap <M-w> <C-o>w

" move lines up or down
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <silent> <M-J> :m .+1<CR>==
nnoremap <silent> <M-K> :m .-2<CR>==
inoremap <silent> <M-J> <Esc>:m .+1<CR>==gi
inoremap <silent> <M-K> <Esc>:m .-2<CR>==gi
vnoremap <silent> <M-J> :m '>+1<CR>gv=gv
vnoremap <silent> <M-K> :m '<-2<CR>gv=gv

" compile a single c file
noremap <Leader>cc :write<cr>:SingleCompile<cr>

" open/close one fold (zA does it recursively)
" zR opens all folds, zM closes all
noremap zz za

" copy file path to clipboard
noremap  <leader>yp :CopyFullPath<cr>
noremap  <leader>yd :CopyDir<cr>

" execute everything to the right of the cursor as ex commands
noremap <silent> <leader>: y$:<C-r>"<cr>

" guess correct spelling and apply it to all matches
noremap Z= z=1<cr>:silent spellrepall<cr><cr>

" bind <M-key> to arrow keys in ex mode
:cnoremap <M-l> <right>
:cnoremap <M-h> <left>
:cnoremap <M-j> <down>
:cnoremap <M-k> <up>

" inoremap <c-r> <c-r>="\<lt>c-r>" . <SID>BetterRegister()<cr>
nnoremap <expr> <leader>" <SID>BetterRegister()
nnoremap <expr> <leader>@ <SID>BetterRegister()

nnoremap <expr> <leader>' <SID>BetterMark()
nnoremap <expr> <leader>` <SID>BetterMark()
"}}}
"********* COLORS ********* {{{

" see :h group-name
" also see https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
" for gui colors
" <C-w>f ~/.config/nvim/colors/moomincore.vim
if !empty(glob("~/.config/nvim/colors/moomincore.vim"))
    colorscheme moomincore
endif

hi clear CursorLine " highlight ONLY the linenr
" hi clear SpellBad

hi CursorLine ctermbg=233 ctermfg=NONE
hi VertSplit ctermfg=6 ctermbg=0 cterm=NONE

" syntax highlight "+,%,=,<>,-,^,*" etc in certain files
" https://stackoverflow.com/a/18943408/8225672
autocmd FileType python call <SID>def_base_syntax()
function! s:def_base_syntax()
  syntax match commonOperator "\(+\|%\|=\|/\|<\|>\|-\|\^\|\*\)"
  syntax match baseDelimiter "\(\[\|\]\|\.\|,\)"
  syntax match myParens "\((\|)\)"
  hi link commonOperator Statement
  hi link baseDelimiter Statement
  hi link myParens Special
endfunction
"}}}
"********* notes **********"{{{
" Stuff I want to Remember (cuz brain is dumb, mostly regexes and gcommands
" and shit)
"→ use <C-f> to edit the current command or search pattern
"→ use g<C-a> on a Block selection with 1s to create a incrementing list
"→ /(^\|.\)noremap \+<\(silent>\)\@!.*\(:\) (a regex example with lookaheads for when I need to
" find mappings that should be <silent>)
"→ get spell files https://github.com/neovim/neovim/issues/2804#issuecomment-109901018
"→ regex to find lines of code, exclude all empty lines and comments: ^\(\s\+#\|#\)\@!.\+$
"}}}
