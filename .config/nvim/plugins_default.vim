" vim:foldenable:foldmethod=marker
" <C-w>f ~/.config/nvim/init.vim

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" auto install plug{{{
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

call plug#begin('~/.config/nvim/plugged')
"}}}
Plug 'vim-syntastic/syntastic' "{{{
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
        set relativenumber " re-set it
        let s:syntastic_on = 0
    else
        SyntasticCheck
        let s:syntastic_on = 1
    endif
endfunction
noremap <silent> <Leader>S  :call ToggleSyntasticMode()<cr>
"}}}
Plug 'vim-airline/vim-airline' "{{{
" set noshowmode
" set laststatus=0
" set statusline=\ %n\ %F\ %r\ %Y
" let g:airline_symbols_ascii = 1 " no fancy symbols
let g:airline#extensions#disable_rtp_load = 1
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['whitespace','tabline','coc']
let g:airline_section_x = ''
let g:airline_section_y = '%y'
" let g:airline_section_c = '%-0.15{expand("%:p:h")}/%t %{SyntasticStatuslineFlag()}'
" let g:airline_section_x = '%y %z'

noremap <silent> <Leader>A :AirlineToggle<cr>
"<- airline themes ->
Plug 'vim-airline/vim-airline-themes'
" (=^‥^=) ω＾|
" let g:airline_mode_map = {
"     \ '__'     : '-',
"     \ 'c'      : '＾● ⋏ ●＾',
"     \ 'i'      : '｡＾･ｪ･＾｡',
"     \ 'ic'     : '｡＾･ｪ･＾｡',
"     \ 'ix'     : '｡＾･ｪ･＾｡',
"     \ 'n'      : '  ㅇㅅㅇ ',
"     \ 'multi'  : '  ㅇㅅㅇ ',
"     \ 'ni'     : '  ㅇㅅㅇ ',
"     \ 'no'     : '  ㅇㅅㅇ ',
"     \ 'R'      : ' (=･ｪ･=? ',
"     \ 'Rv'     : ' (=･ｪ･=? ',
"     \ 's'      : ' (=･ｪ･=? ',
"     \ 'S'      : ' (=･ｪ･=? ',
"     \ '^S'     : ' (=･ｪ･=? ',
"     \ 't'      : ' ( ^..^)ﾉ',
"     \ 'v'      : '(=^.ω.^=)',
"     \ 'V'      : '(=^.ω.^=)',
"     \ ''     : '(=^.ω.^=)',
"     \ }
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

" let g:airline_mode_map = {
"     \ '__'     : '-',
"     \ 'c'      : 'COMMAND',
"     \ 'i'      : 'INSERT ',
"     \ 'ic'     : 'INSER-C',
"     \ 'ix'     : 'INSERT ',
"     \ 'n'      : 'NORMAL ',
"     \ 'multi'  : 'NORMAL ',
"     \ 'ni'     : 'NORMAL ',
"     \ 'no'     : 'NORMAL ',
"     \ 'R'      : 'REPLACE',
"     \ 'Rv'     : 'REPLACE',
"     \ 's'      : 'REPLACE',
"     \ 'S'      : 'REPLACE',
"     \ '^S'     : 'REPLACE',
"     \ 't'      : 'Term   ',
"     \ 'v'      : 'VISUAL ',
"     \ 'V'      : 'V-LINE ',
"     \ ''     : 'V-BLOCK',
"     \ }

" let g:airline_theme_patch_func = 'AirlineThemePatch'
" function! AirlineThemePatch(palette)
"   if g:airline_theme == 'serene'
"     for colors in values(a:palette.inactive)
"       let colors[3] = 245
"     endfor
"   endif
" endfunction

set noshowmode
if !empty(glob("~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/myserene.vim"))
  let g:airline_theme = 'mylucius'
else
  let g:airline_theme = 'lucius'
endif

"endif}}}
Plug 'rafaqz/ranger.vim' "{{{
"}}}
Plug 'tpope/vim-surround' "{{{
"}}}
Plug 'tpope/vim-commentary' "{{{
"}}}
Plug 'Yggdroot/indentLine' "{{{
let g:indentLine_char = '|'
autocmd FileType man,help IndentLinesDisable
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
nnoremap <silent> "" :<C-u>CocList -A --normal yank<cr>
"}}}
" Plug 'Raimondi/delimitMate'{{{
" au filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", '`':'`'}
" let g:delimitMate_autoclose = 1
" let g:delimitMate_matchpairs = "(:),[:],{:}"
" let g:delimitMate_jump_expansion = 1
" let g:delimitMate_expand_space = 1
" let g:delimitMate_expand_cr = 2
" let g:delimitMate_expand_inside_quotes = 1
"}}}
Plug 'tpope/vim-repeat' "{{{
"}}}
" Plug 'justinmk/vim-sneak' "{{{
" map f <Plug>Sneak_s
" map F <Plug>Sneak_S
" " map t <Plug>Sneak_t
" " map T <Plug>Sneak_T
" nnoremap <silent> t :<C-U>call sneak#wrap('',           2, 0, 0, 1)<CR>
" nnoremap <silent> T :<C-U>call sneak#wrap('',           2, 1, 0, 1)<CR>
" xnoremap <silent> t :<C-U>call sneak#wrap(visualmode(), 2, 0, 0, 1)<CR>
" xnoremap <silent> T :<C-U>call sneak#wrap(visualmode(), 2, 1, 0, 1)<CR>
" onoremap <silent> t :<C-U>call sneak#wrap(v:operator,   2, 0, 0, 1)<CR>
" onoremap <silent> T :<C-U>call sneak#wrap(v:operator,   2, 1, 0, 1)<CR>
"}}}
Plug 'ap/vim-css-color' "{{{
"}}}
call plug#end()
