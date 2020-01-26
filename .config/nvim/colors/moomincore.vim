" im gay

hi clear Normal
hi clear

if exists("syntax_on")
  syntax reset
endif

set background=dark

let colors_name = "moomincore"
hi Boolean             ctermfg=198  guifg=#FF0087                             cterm=Bold    gui=Bold
hi Comment             ctermfg=14   guifg=#735787                             cterm=Italic  gui=Italic
hi Conditional         ctermfg=11   guifg=#F5A2BB                             cterm=Bold    gui=Bold
hi Constant            ctermfg=116  guifg=#87D7D7
hi CursorLineNr        ctermfg=8    guifg=#766D7F  ctermbg=NONE guibg=#08000D
hi Folded              ctermfg=255  guifg=#FFFFFF  ctermbg=234  guibg=#131116
hi Function            ctermfg=12   guifg=#00B3B3                             cterm=Bold    gui=Bold
hi Label               ctermfg=5    guifg=#AAA6E1
hi LineNr              ctermfg=238  guifg=#444444  ctermbg=NONE guibg=#08000D cterm=NONE    gui=NONE
hi Normal              ctermfg=255  guifg=#FFFFFF  ctermbg=NONE guibg=#08000D
hi Number              ctermfg=111  guifg=#87AFFF
hi PreProc             ctermfg=12   guifg=#00B3B3
hi SignColumn                                      ctermbg=NONE guibg=#08000D
hi Special             ctermfg=7    guifg=#DFA8FF
hi Statement           ctermfg=11   guifg=#F5A2BB
hi String              ctermfg=13   guifg=#FF6666
hi TabLine             ctermfg=14   guifg=#735787  ctermbg=232  guibg=#050009 cterm=NONE    gui=NONE
hi TabLineFill         ctermfg=16   guifg=#000000  ctermbg=232  guibg=#050009 cterm=NONE    gui=NONE
hi TabLineSel          ctermfg=6    guifg=#74D7EC  ctermbg=232  guibg=#050009 cterm=NONE    gui=NONE
hi Type                ctermfg=4    guifg=#00C777
hi pythonBuiltin       ctermfg=11   guifg=#F5A2BB                             cterm=Bold    gui=Bold
hi pythonStatement     ctermfg=6    guifg=#74D7EC
hi Pmenu               ctermfg=11                  ctermbg=233                cterm=NONE    gui=NONE
hi PmenuSel            ctermfg=0                   ctermbg=6
hi WildMenu            ctermfg=0                   ctermbg=6                  cterm=NONE
hi StatusLine          ctermfg=0                   ctermbg=11
hi NonText             ctermfg=7                                              cterm=NONE    gui=NONE
hi Search              ctermfg=16                  ctermbg=3                  cterm=NONE
hi Error               ctermfg=9                   ctermbg=NONE               cterm=undercurl
hi cType               ctermfg=2
" vim/neovim currently don't support configuring individual underline/curl
" colors
hi SpellBad            ctermfg=NONE                ctermbg=NONE               cterm=undercurl
hi MatchParen          ctermfg=3                   ctermbg=NONE               cterm=bold,underline

hi! link SpellCap SpellBad
hi! link pythonBuiltin Function
hi! link Identifier Normal
hi! link SpecialChar Normal
hi! link Repeat Conditional
hi! link pythonException pythonBuiltin
hi! link pythonFunction  Function

" recommended terminal colors:
hi color0  guifg=#00001A ctermfg=0
hi color1  guifg=#A2003F ctermfg=1
hi color2  guifg=#00807F ctermfg=2
hi color3  guifg=#FBBA56 ctermfg=3
hi color4  guifg=#00C777 ctermfg=4
hi color5  guifg=#AAA6E1 ctermfg=5
hi color6  guifg=#74D7EC ctermfg=6
hi color7  guifg=#DFA8FF ctermfg=7
hi color8  guifg=#766D7F ctermfg=8
hi color9  guifg=#F62BED ctermfg=9
hi color10 guifg=#57236D ctermfg=10
hi color11 guifg=#F5A2BB ctermfg=11
hi color12 guifg=#00B3B3 ctermfg=12
hi color13 guifg=#FF6666 ctermfg=13
hi color14 guifg=#735787 ctermfg=14
hi color15 guifg=#FFFFFF ctermfg=15
