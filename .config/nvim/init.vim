" vim:foldenable:foldmethod=marker
" TODO:
" change line 265 to have the search/replace enter insert mode in command
" line mode
" plugins to test:
" spelunker.vim
" sneak
" nerdcommenter
" /(^\|.\)noremap \+<\(silent>\)\@!.*\(:\)
" kqqnwi<silent><esc>q:set nowrapscan<cr>100@q
" disable airline extensions
" enable tabline
" find out how to hide buffers using <C-w> shortcuts

"******** SETTINGS ******** {{{

filetype plugin indent on                               " enable plugins for file type detection
syntax on                                               " use syntax highlighting
set nocompatible                                        " don't be annoying
set backspace=indent,eol,start                          " allow backspacing over everything in insert mode.
set tabpagemax=30                                       " increase max number of tabs (default is 10)
set history=1000                                        " lots of command line history
" set wildmode=longest,list,full                          " bash like autocompletion (superseded by popup menu)
set wildignorecase                                      " ignore case when completing file names
set wildignore=*.o,*.obj,*.out                          " ignore the following types when autocompleting filenames
set number                                              " show line numbers
set tabstop=8                                           " input 4 spaces when <tab> is pressed.
set shiftwidth=4                                        " CTRL-V <tab> to insert a real tab.
set expandtab
set smarttab
set hlsearch                                            " highlight matches while searching
set mouse=vi                                            " enable mouse support in visual and insert modes
set ttimeout                                            " time out for key codes
set ttimeoutlen=100                                     " wait up to 100ms after Esc for special key
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
set signcolumn=yes                                      " always show gutter on the left
set numberwidth=3                                       " smaller line number width
set complete=.,w,b,u,t,spell                            " enable english word suggestions when 'spell is on
set updatetime=300                                      " smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c                                        " don't give |ins-completion-menu| messages.
set relativenumber
set statusline=\ %n\ %F\ %r\ %Y
set splitright

if has("nvim-0.4")
    set wildoptions=pum                                     " use ins-completion like pop menu for wildmenu
endif

let c_comment_strings=1                                 " show strings inside C comments
let python_highlight_all = 1                            " use full python syntax highlighting
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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

command! Nvimrc edit ~/.config/nvim/init.vim

command! ChmodX !chmod +x %

command! SingleCompile !gcc -W -o "%:r"_temp.out %

command! CopyDir silent !xclip -selection clipboard "$(pwd)"
command! CopyFullPath silent !clip -selection clpboard '%:p'

" stolen from justinmk
command! InsertDate           norm! i<c-r>=strftime('%Y/%m/%d %H:%M:%S')<cr>
command! InsertDateYYYYMMdd   norm! i<c-r>=strftime('%Y%m%d')<cr>

" get hightlight group for word under cursor
command! GetHlGroup echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"

" open help windows on the right
" https://stackoverflow.com/a/21843502/8225672
autocmd FileType help wincmd K
" autocmd FileType help call CheckColumnLenght()

" open new windows on the right by default (https://github.com/neovim/neovim/issues/8350)
autocmd WinNew * wincmd L

" enable fold markers for these files
autocmd FileType vim,c,c++ setlocal foldmethod=syntax
autocmd FileType python,sh setlocal foldmethod=indent
autocmd FileType txt,conf setlocal foldmethod=marker

" https://www.reddit.com/r/vim/comments/48zclk/i_just_found_a_simple_method_to_read_pdf_doc_odt/
" requires pandoc
autocmd BufReadPre *.docx,*.rtf,*.odp,*.odt silent setlocal nomodifiable
autocmd BufReadPost *.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout

" Read-only .doc through antiword
autocmd BufReadPre *.doc silent setlocal nomodifiable
autocmd BufReadPost *.doc silent %!antiword "%"

" Read-only pdf through pdftotext (requires poppler-utils)
autocmd BufReadPre *.pdf silent setlocal nomodifiable
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78

" remove line numbers when entering terminal:
autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
autocmd TermClose * setlocal number relativenumber signcolumn=yes

autocmd FileType markdown,txt setlocal spell
"}}}
"******** MAPPINGS ******** {{{

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

" move all buffers to tabs
" https://superuser.com/a/430324/900060
" :h sball
noremap <Leader>t <esc>:buffers<cr>:tab sball

" open terminal
noremap <silent> <Leader>T <esc>:vsplit term://bash

" stop reading input in terminal
tnoremap <M-w> <C-\><C-n>

" go to next/previous/last buffer respectively
noremap <silent> go :bnext<cr>
noremap <silent> gp :bprevious<cr>
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
nnoremap <M-r> :%s///gc<left><left><left><left>
vnoremap <M-r> :s/\%V//gc<left><left><left><left>

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
noremap <silent> <leader>yf :CopyFullPath<cr>
noremap <silent> <leader>yd :CopyDir<cr>

" execute everything to the right of the cursor as ex commands
noremap <silent> <leader>: y$:<C-r>"<cr>


"}}}
"******** COLOURS ********* {{{

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
"******** PLUGINS ********* {{{
" <C-w>f ~/.config/nvim/plugins_default.vim
if !empty(glob("~/.config/nvim/plugins_default.vim"))
    source ~/.config/nvim/plugins_default.vim
endif
"}}}
