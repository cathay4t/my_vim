" color theme
if exists('+termguicolors')

  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
else
  set t_Co=256
endif

let python_no_exception_highlight = 1

set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

hi Normal guifg=#00ff00
hi String guifg=#0070ff
hi LineNr guifg=#00ffab
hi Comment guifg=#0060ff
hi keyword guifg=#e0ee04
hi Constant guifg=#ffaa00
hi ColorColumn guibg=#96877b
hi Type guifg=#f0f000
hi Function guifg=#00bfff
hi Identifier guifg=#02eaf0
hi Special guifg=#f00000
hi Exceptions guifg=#ff5820
hi Error guibg=#ff0000
hi Structure guifg=#ff5800

" Spell
hi SpellLocal guifg=#00ff00 guibg=#000000

" Python only
hi pythonBuiltin guifg=#6a02f0
hi pythonExceptions guifg=#ff5820

let python_highlight_all = 1
