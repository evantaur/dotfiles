" Vim color scheme based on Helix's Merionette theme
set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "merionette"

hi Normal guifg=#cebabf guibg=#190f0f 

" Highlight groups
hi Comment guifg=#d2505f gui=italic
hi Constant guifg=#ff7550
hi Function guifg=#8ea84d gui=bold
hi Keyword guifg=#eb842b
hi String guifg=#cebabf
hi Type guifg=#65aba3
hi Variable guifg=#cebabf
hi Error guifg=#eb842b
hi Warning guifg=#6db269

" UI components
hi CursorLine guibg=#2c1617
hi CursorLineNr guifg=#d2505f guibg=#2c1617
hi StatusLine guifg=#d2505f guibg=#190f0f
hi StatusLineNC guifg=#622b30 guibg=#190f0f
hi LineNr guifg=#ce8b9f guibg=#190f0f
hi Pmenu guifg=#cebabf guibg=#442022
hi Visual guibg=#704144
hi EndOfBuffer guifg=#cebabf
