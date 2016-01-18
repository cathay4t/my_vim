set nocompatible

"===================Tips========================="
"==ctags=="
"C-] - go to definition
"C-T - Jump back from the definition.
"C-W -> ] * Open the definition in a horizontal split
":ta    - Search the tag
"ctags for cpp_std and qt cpp
"autocmd FileType cpp set tags+=~/.vim/tags/cpp
"autocmd FileType cpp set tags+=~/.vim/tags/qt4
"
autocmd FileType c,cpp set tags+=~/.ctag_files/system_c
autocmd FileType c,cpp set tags+=~/.ctag_files/lsm_c
autocmd FileType cpp set tags+=~/.ctag_files/qt5
autocmd FileType c,cpp set tags+=./tags;/

"alt-]  * open the definition in a vertical split

map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"regenerate ctags for current folder and recursively
"--extra=+q is for C++ to qualify member function/variable with its class
"type.
function! s:Cregen()
    execute ":!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q ."
endfunction
nnoremap <silent> <leader>g :call <SID>Cregen()<cr>

"
"==copy=="
"Need vim --version has "+xterm_clipboard", RHEL 6 don't
"%y *   copy to X11 clipboard
"*p     paste X11 clipboard
"==visual selection=="
"Ctrl-v for a vertical block

"==shortcuts=="
"K	#jump to the manpage of it
"C-O #jump to last cursor location
"C-i #jump to next cursor location
"Toggle case 'HellO' to 'hELLo' with g~ then a movement.
"Uppercase 'HellO' to 'HELLO' with gU then a movement.
"Lowercase 'HellO' to 'hello' with gu then a movement.

"==folding=="
"za toggle
"zA toggle all level
"zr reduces one fold level
"zR open all fold
"zm fold one more level
"zM clode all folds

"==cscope=="
"0 or s: Find this C symbol
"1 or g: Find this definition
"2 or d: Find functions called by this function
"3 or c: Find functions calling this function
"4 or t: Find this text string
"6 or e: Find this egrep pattern
"7 or f: Find this file
"8 or i: Find files #including this file

"==general=="
" % stand for current file name, useful for vs
" set nomodifiable # stop entering modify/edit mode. "vim -M" is the same
" to stop vim to read configurations, use "vim -u NONE"

"==file specified vim configuration=="
" Add this line at the end of file. :help modeline
"       # vim: set filetype=config:

"== spell check =="
" set spell
" zg    add to word list
" z=    list all sugests
" ]s    next spell check
" zug   undo zg
" to update spell after manual edit:
" silent mkspell! ~/.vim/spell/en.utf-8.add

" enable modline
set modeline

" Disable backup auto creating
set nobackup

" no visual bell
set novisualbell
" No error bell
set noerrorbells
" No flash the screen on error
set t_vb=

" don't indent when pasting
:set pastetoggle=<F1>

" set backspace can remove indent and works
set backspace=indent,eol,start

" disable incremental search
set incsearch

" disable highlight search
set nohlsearch

" Enable mouse
set mouse=a
" Disable mouse
"set mouse=

" set clipbrad to system clipboard
" set clipboard=unnamedplus

" color theme
set t_Co=256

set background=light

" syntax highlighting
syntax on
map <F5>    :syntax sync fromstart<CR>

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
"set viminfo='10,\"100,:20,%,n~/.viminfo
" Restore cursor and folds when load for certain type of file
" :mksession is more powerfull. Will check later
"autocmd Filetype config,sh,perl,c,cpp autocmd BufWinLeave ?* mkview
"autocmd Filetype config,sh,perl,c,cpp autocmd BufWinEnter ?* silent loadview

"indent issue
filetype plugin indent on

"set ts=4
"set sts=4
"set tabstop=4
"set shiftwidth=4
"set expandtab

"auto remove whitespace at the end of line before :w,
"it also save email signiture spliter "-- "
function s:RemoveWhiteSpace()
    let save_cursor = getpos(".")
    %s/\s\+$//e
    if &filetype == 'mail'
        %s/^--$/-- /e
        %s/^> --$/> -- /e
    endif
    call setpos(".", save_cursor)
endfunction
autocmd Filetype vim,xml,perl,c,cpp,python,sh,wiki,markdown,nroff,make,config
    \ autocmd BufWritePre * :call <SID>RemoveWhiteSpace()

"soft colorcolumn, vim 7.3+ only, short cmd: set cc=78
"set tw=78
if version >=703
    "autocmd Filetype c,cpp,perl,python,sh,expect,mail,moin set colorcolumn=78
    setlocal colorcolumn=78
endif

"set hard word wrap at 72 for email
set wrap
autocmd Filetype markdown,diff,gitcommit,c,cpp,python,perl set spell

set nu
" display tab as >-------
set list
set listchars=tab:>-,extends:>

" keep 10 above for scroll down
set scrolloff=10

" autocomplet as bash
set wildmode=longest,list
set wildmenu

map     <F12>   :set nohlsearch! hlsearch?<CR>
map     <F9>    :set cursorline! cursorline? <CR>
              \ :set cursorcolumn! cursorcolumn?<CR>
map     <F2>    :set nospell! spell?<CR>
nnoremap <silent> <leader>n :set nonu! nu?<cr>
nnoremap <silent> <leader>w :call <SID>RemoveWhiteSpace()<cr>

nnoremap <silent> <leader>c :%y+<cr>
vnoremap <silent> <leader>c "+y
nnoremap <silent> <leader>p "+gP
vnoremap <silent> <leader>p "+gP
vnoremap <silent> <LeftRelease> "+y<LeftRelease>

function! s:InsertLGPL()
    execute ":r ~/.vim/license/lgpl.txt"
endfunction
command Ilgpl :call <SID>InsertLGPL()

function! s:InsertGPL()
    execute ":r ~/.vim/license/gpl.txt"
endfunction
command Igpl :call <SID>InsertGPL()

"function! s:InsertConvertTimeStrPy()
"    execute ":r ~/.vim/convert_time_str.py"
"endfunction
"command Icts :call <SID>InsertConvertTimeStrPy()
"
"function! s:InsertReadConfigPy()
"    execute ":r ~/.vim/read_conf.py"
"endfunction
"command Irc :call <SID>InsertReadConfigPy()
"
"function! s:InsertPersonalHeader()
"    execute ":r ~/.vim/personal_header.sh"
"endfunction
"command Iph :call <SID>InsertPersonalHeader()
"
"function! s:InsertPersonalHeaderC()
"    execute ":r ~/.vim/personal_header.c"
"endfunction
"command Iphc :call <SID>InsertPersonalHeaderC()
"
"function! s:InsertBashFunction(function_name)
"    let save_cursor = getpos(".")
"    let codes=system("sed -e s/FunctionName/"
"        \. shellescape(a:function_name)
"        \. "/g ~/.vim/function_sample.sh")
"    call append(".",split(codes,"\n"))
"    normal 
"    call setpos(".", save_cursor)
"    normal 4jw
"endfunction
"command! -nargs=1 Ibf :call <SID>InsertBashFunction('<args>')
"
"function! s:InsertPythonFunction(function_name)
"    let codes=system("sed -e s/FunctionName/"
"        \. shellescape(a:function_name)
"        \. "/g ~/.vim/template/function_sample.py")
"    call append(".",split(codes,"\n"))
"    normal 4jw
"endfunction
"command! -nargs=1 Iyf :call <SID>InsertPythonFunction('<args>')

hi CursorLine   cterm=NONE ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermfg=white guibg=darkred guifg=white

"For cscope
if filereadable("cscope.out")
    cs add cscope.out
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif
set csverb
set cscopetag
set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-

"OmniCppComplete
filetype plugin on
set ofu=syntaxcomplete#Complete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

"taglist
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 0
let Tlist_Auto_Open=0
let Tlist_WinWidth = 28
let Tlist_Compact_Format = 1
let Tlist_Enable_Fold_Column = 0
command Tl TlistToggle
nnoremap <silent> <leader>t :TlistToggle<cr>
autocmd Filetype perl,c,cpp,python,sh autocmd BufWritePre ?* :TlistUpdate

" DrawIt
"   <left>       move and draw left
"   <right>      move and draw right, inserting lines/space as needed
"   <up>         move and draw up, inserting lines/space as needed
"   <down>       move and draw down, inserting lines/space as needed
"   <s-left>     move left
"   <s-right>    move right, inserting lines/space as needed
"   <s-up>       move up, inserting lines/space as needed
"   <s-down>     move down, inserting lines/space as needed
"   <space>      toggle into and out of erase mode
"   >            draw -> arrow
"   <            draw <- arrow
"   ^            draw ^  arrow
"   v            draw v  arrow
"   <pgdn>       replace with a \, move down and right, and insert a \
"   <end>        replace with a /, move down and left,  and insert a /
"   <pgup>       replace with a /, move up   and right, and insert a /
"   <home>       replace with a \, move up   and left,  and insert a \
"   \>           draw fat -> arrow
"   \<           draw fat <- arrow
"   \^           draw fat ^  arrow
"   \v           draw fat v  arrow
"   \a           draw arrow based on corners of visual-block
"   \b           draw box using visual-block selected region
"   \e           draw an ellipse inside visual-block
"   \f           fill a figure with some character
"   \h           create a canvas for \a \b \e \l
"   \l           draw line based on corners of visual block
"   \s           adds spaces to canvas
"   <leftmouse>  select visual block
"<s-leftmouse>  drag and draw with current brush (register)
"   \ra ... \rz  replace text with given brush/register
"   \pa ...      like \ra ... \rz, except that blanks are considered
"                to be transparent

" Markdown
au BufRead,BufNewFile *.md set filetype=markdown

function! s:UpdateKonsoleTab()
    if expand("%:t") != '__Tag_List__'
        execute ":silent !/home/fge/bin/update_konsole_tab set '%:t'"
        execute ':redraw!'
    endif
endfunction

" Update konsole tab with current edit filename
"autocmd BufReadPost * :call <SID>UpdateKonsoleTab()
"autocmd WinEnter * :call <SID>UpdateKonsoleTab()
"autocmd VimLeavePre * :silent !/home/fge/bin/update_konsole_tab clean
"nnoremap <silent> <leader>u :call <SID>UpdateKonsoleTab()<cr>

let &titlestring = expand("%:t")
if &term == "screen" || &term == "xterm"
  set title
endif

let g:_cs_linux_0=
    \ 'ts=8 sts=8 sw=8 tw=80 wrap noet'
let g:_cs_linux_1=
    \ 'cindent fo=tcqlron cino=:0,l1,t0,g0,(0'
let g:_cs_linux_73_0=
    \ 'cc=80'
let g:_cs_linux=
    \ g:_cs_linux_0.' '.
    \ g:_cs_linux_1.' '.
    \ g:_cs_linux_73_0

let g:_mode_line_c_linux = [""]
call add (g:_mode_line_c_linux,
    \ '/* vim: set '.
    \ substitute(g:_cs_linux_0, ":", "\\\\:", "g").
    \ ' : */')
call add (g:_mode_line_c_linux,
    \ '/* vim: set '.
    \ substitute(g:_cs_linux_1, ":", "\\\\:", "g").
    \ ' : */')
call add (g:_mode_line_c_linux,
    \ '/* vim: set '.
    \ substitute(g:_cs_linux_73_0, ":", "\\\\:", "g").
    \ ' : */')

let g:_cs_kr_0 =
    \ 'ts=8 sts=4 sw=4 tw=80 wrap et'
let g:_cs_kr_1 =
    \ 'fo=tcroq cindent cinoptions=(0,:0,l1,t0,L3'
let g:_cs_kr_73_0  =
    \ 'cc=80'
let g:_cs_kr=
    \ g:_cs_kr_0.' '.
    \ g:_cs_kr_1.' '.
    \ g:_cs_kr_73_0

let g:_mode_line_c_kr = [""]
call add (g:_mode_line_c_kr,
    \ '/* vim: set '.
    \ substitute(g:_cs_kr_0, ":", "\\\\:", "g").
    \ ' : */')
call add (g:_mode_line_c_kr,
    \ '/* vim: set '.
    \ substitute(g:_cs_kr_1, ":", "\\\\:", "g").
    \ ' : */')
call add (g:_mode_line_c_kr,
    \ '/* vim: set '.
    \ substitute(g:_cs_kr_73_0, ":", "\\\\:", "g").
    \ ' : */')

let g:_cs_gnu_0=
    \ 'ts=2 sts=2 sw=2 tw=79 wrap et cindent fo=tcql'
let g:_cs_gnu_1=
    \ 'cino=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1'
let g:_cs_gnu_73_0=
    \ 'cc=79'
let g:_cs_gnu=
    \ g:_cs_gnu_0.' '.
    \ g:_cs_gnu_1.' '.
    \ g:_cs_gnu_73_0

let g:_mode_line_c_gnu = [""]
call add (g:_mode_line_c_gnu,
    \ '/* vim: set '.
    \ substitute(g:_cs_gnu_0, ":", "\\\\:", "g").
    \ ' : */')
call add (g:_mode_line_c_gnu,
    \ '/* vim: set '.
    \ substitute(g:_cs_gnu_1, ":", "\\\\:", "g").
    \ ' : */')
call add (g:_mode_line_c_gnu,
    \ '/* vim: set '.
    \ substitute(g:_cs_gnu_73_0, ":", "\\\\:", "g").
    \ ' : */')

function! s:ModeLineCLinux()
    normal G
    put = g:_mode_line_c_linux
    let &modified = 1
endfunction
command Mcl :call <SID>ModeLineCLinux()

function! s:ModeLineCKr()
    normal G
    put = g:_mode_line_c_kr
    let &modified = 1
endfunction
command Mck :call <SID>ModeLineCKr()

function! s:ModeLineCGNU()
    normal G
    put = g:_mode_line_c_gnu
    let &modified = 1
endfunction
command Mcg :call <SID>ModeLineCGNU()

function! s:SetLinuxCodeStyle()
    exec 'setlocal '.g:_cs_linux
endfunction
command Csl :call <SID>SetLinuxCodeStyle()

function! s:SetKRCodeStyle()
    exec 'setlocal '.g:_cs_kr
endfunction
command Csk :call <SID>SetKRCodeStyle()

function! s:SetGNUCodeStyle()
    exec 'setlocal '.g:_cs_gnu
endfunction
command Csg :call <SID>SetGNUCodeStyle()

function! s:ImportLicense(license_name)
    let file_path="~/.vim/license/" . a:license_name . ".txt"
    execute 'r ' . file_path
endfunction
command! -nargs=1 L :call <SID>ImportLicense('<args>')

"autocmd Filetype gitcommit,config,sh,c,cpp,perl,markdown
"    \ :call <SID>SetKRCodeStyle()
au FileType make setlocal noexpandtab
au BufRead,BufNewFile *.am setlocal noexpandtab
set sts=4 expandtab cc=80

autocmd VimLeave * call system("xclip -o | xclip -selection c")
