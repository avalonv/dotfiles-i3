" TODO:
" learn more about this g/"\[/normal A ]
" vim:foldenable

"**************************
"******** SETTINGS ********
"**************************
"{{{

filetype plugin indent on                               " enable plugins for file type detection
syntax on                                               " use syntax highlighting
set nocompatible                                        " don't be annoying
set noshowmode                                          " don't show current mode
set backspace=indent,eol,start                          " allow backspacing over everything in insert mode.
set tabpagemax=30                                       " increase max number of tabs (default is 10)
set history=1000                                        " lots of command line history
set wildmode=longest,list,full                          " bash like autocompletion
set wildignorecase                                      " ignore case when completing file names
set number                                              " show line numbers
set tabstop=4                                           " input 4 spaces when <tab> is pressed.
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
set listchars=tab:>\ ,trail:␣,extends:>,precedes:<,nbsp:+
set guicursor=i:blinkon1ver20                           " blinking cursor in insert mode
set nocursorline                                        " highlight the current line (disabled bc hogs resources)
set autoindent                                          " autoindent (duh)
set autoread                                            " ask to update file when it detects edits done outside of vim
set autochdir                                           " auto change working directory
set hidden                                              " don't ask to save buffers when closing them, hide them
set splitright                                          " open new windows on the right by default
set nofoldenable                                        " initially disable folding
set foldmethod=syntax
set foldnestmax=1
set encoding=utf-8                                      " (duh)
"set lazyredraw                                          " don't redraw screen while macros are running
set confirm                                             " confirm quit
set signcolumn=yes                                      " always show gutter on the left
set numberwidth=3                                       " smaller line number width
set complete=.,w,b,u,t,kspell                           " enable english word suggestions when 'spell is on
set updatetime=300                                      " smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c                                        " don't give |ins-completion-menu| messages.
set relativenumber

let c_comment_strings=1                                 " show strings inside C comments
let python_highlight_all = 1                            " use full python syntax highlighting
"}}}

"**************************
"*** FUNCTIONS/COMMANDS ***
"**************************
"{{{

" https://vi.stackexchange.com/a/456/1111
function! RmTrailing()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

command RmTrailing call RmTrailing()

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

" if there is more than one buffer, delete it, else quit
function! CheckNBuffers()
    if len(getbufinfo({'buflisted':1})) > 1
        bdelete
    else
        quit
    endif
endfunction

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

command! MakeExe !chmod +x %

command! SingleCompile !gcc -W -o "%:r"_temp.out %

command! CopyPWD !copyq copy "$(pwd)"

" number of lines to scroll down with Ctrl-D
autocmd VimEnter * set scroll=10

" open help windows on the right
" https://stackoverflow.com/a/21843502/8225672
autocmd FileType help wincmd L
autocmd FileType help call CheckColumnLenght()

"cabbrev h vert help
"cabbrev H abo help

" enable fold markers for these files
autocmd FileType vim,c,c++,python,txt setlocal foldmethod=marker
"}}}

"**************************
"******** MAPPINGS ********
"**************************
"{{{

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>v

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
noremap Q gq

" switch between windows
noremap  <M-w> <esc><C-W><C-W>
inoremap <M-w> <esc><C-W><C-W>
noremap  <M-W> <esc><C-W>W
inoremap <M-W> <esc><C-W>W

" go to next/previous tab respectively
noremap  <silent> <M-.> <esc>:tabnext<cr>
noremap  <silent> <M-,> <esc>:tabprevious<cr>
inoremap <silent> <M-.> <esc>:tabnext<cr>
inoremap <silent> <M-,> <esc>:tabprevious<cr>

" open new tab/buffer
noremap <M-n> :tabnew<cr>:edit<space>
noremap <M-N> :edit<space>

" move all buffers to tabs
" https://superuser.com/a/430324/900060
" :h sball
noremap <Leader>t <esc>:buffers<cr>:tab sball

" open terminal
noremap <Leader>T <esc>:vsplit term://bash

" split window
noremap <Leader>v <esc>:vsplit<cr>

" exit terminal mode
tnoremap <M-w> <C-\><C-n>

" go to next/previous/last buffer respectively
noremap <silent> gn :bnext<cr>
noremap <silent> gp :bprevious<cr>
noremap <silent> gl <esc>:buffer #<cr>

" list buffers
noremap <leader>b <esc>:buffers<cr>:buffer<space>

" quit/delbuffer
noremap  <silent> <M-Q> <esc>:call CheckNBuffers()<cr>
inoremap <silent> <M-Q> <esc>:call CheckNBuffers()<cr>

" toggle relative line numbers
noremap <silent> <Leader>l <esc>:set relativenumber!<cr>

" toggle show line numbers
noremap <silent> <Leader>n <esc>:set nu!<cr>

" disable highlighting for the last search
" (https://stackoverflow.com/a/657484/8225672)
map <silent> <F1> :nohlsearch<cr>
imap <silent> <F1> <esc>:nohlsearch<cr>a

" toggle case insensitive searches
map <Leader>i :set ignorecase!<cr>

" copy to selection clipboard (copyq is a bitch)
map <Leader>* "*y

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

" move lines up or down
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <silent> <M-J> :m .+1<CR>==
nnoremap <silent> <M-K> :m .-2<CR>==
inoremap <silent> <M-J> <Esc>:m .+1<CR>==gi
inoremap <silent> <M-K> <Esc>:m .-2<CR>==gi
vnoremap <silent> <M-J> :m '>+1<CR>gv=gv
vnoremap <silent> <M-K> :m '<-2<CR>gv=gv

" compile a single c file
noremap <silent> <Leader>cc :SingleCompile<cr>

" toggle folding
noremap <silent> <Leader>z :set foldenable!<cr>

" open/close one fold (zA does it recursively)
noremap zz za
"}}}

"**************************
"******** COLOURS *********
"**************************
"{{{

" see :h group-name
" also see https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
" for gui colors
colorscheme moomincore
hi clear CursorLine " highlight ONLY the linenr
hi clear SpellBad

hi SpellBad cterm=underline ctermfg=3
hi MatchParen cterm=bold,italic,underline ctermbg=0 ctermfg=12


" syntax highlight "+,%,=,<>,-,^,*" etc in certain files
" https://stackoverflow.com/a/18943408/8225672
autocmd FileType python call <SID>def_base_syntax()
function! s:def_base_syntax()
  syntax match commonOperator "\(+\|%\|=\|/\|<\|>\|-\|\^\|\*\)"
  syntax match baseDelimiter "\(\[\|\]\|\.\|,\)"
  syntax match myParens "\((\|)\)"
  hi link commonOperator Operator
  hi link baseDelimiter Label
  hi myParens ctermfg=10
endfunction
"}}}

"**************************
"******** PLUGINS *********
"**************************
"{{{

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" auto install plug
if !filereadable(vimplug_exists)
    let choice = confirm("Would you like to install vimplug?", "y/n")
    if choice == 'y'
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

call plug#begin('~/.config/nvim/plugged')

"<- syntax checker/linter ->
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

"<- airline ->
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

"<- airline themes ->
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'myserene'
"let myserene=expand('~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/myserene.vim')
"if !filereadable(myserene)
"  let g:airline_theme = 'myserene'
"else
"  let g:airline_theme = 'serene'
"endif

" highlight colornames/hex
Plug 'ap/vim-css-color'

"<- ranger in vim ->
Plug 'rafaqz/ranger.vim'

Plug 'tpope/vim-surround'

"<- bindings/functions for commenting ->
Plug 'tpope/vim-commentary'

"<- show indentation lines ->
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '|'
autocmd FileType man,help IndentLinesDisable
autocmd TermOpen * IndentLinesDisable

"<- Conquer Of Completion ->
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
let g:coc_global_extensions = [
            \  'coc-emoji', 'coc-eslint', 'coc-yank', 'coc-prettier',
            \  'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
            \  'coc-css', 'coc-json', 'coc-python', 'coc-yaml']


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
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" modified because it interferes with delimitMate
" (see https://github.com/Raimondi/delimitMate/issues/111)
imap <expr> <CR> pumvisible()
                 \ ? "\<C-y>"
                 \ : '<Plug>delimitMateCR'

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
nnoremap <silent> "" :<C-u>CocList -A --normal yank<cr>

" <- auto-closing parens and brackets ->
Plug 'Raimondi/delimitMate'
au filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", '`':'`'}
let g:delimitMate_autoclose = 1
let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_jump_expansion = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_inside_quotes = 1

call plug#end()
"}}}
