
set nocompatible

nnoremap <silent> <leader>q :wqa<CR>

"===================Tips========================="
"==ctags=="
"C-] - go to definition
"C-T - Jump back from the definition.
"C-W -> ] * Open the definition in a horizontal split
":ts    - Search
"ctags for cpp_std and qt cpp
"autocmd FileType cpp set tags+=~/.vim/tags/cpp
"autocmd FileType cpp set tags+=~/.vim/tags/qt4
"
autocmd FileType python,c,cpp,rust set tags+=./tags;/
autocmd VimEnter *.rs :call <SID>dual_screen()
autocmd VimEnter *.py :call <SID>dual_screen()
autocmd VimEnter *.c :call <SID>dual_screen()
autocmd FileType c,cpp set tags+=~/.ctag_files/system_c
"autocmd FileType rust set tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi

function s:dual_screen()
    if (winwidth(0) >= 160)
        execute 'rightbelow vsplit' | wincmd b
    endif
endfunction

"alt-]  * open the definition in a vertical split

map <C-\> :vsp <CR>:exec("ts ".expand("<cword>"))<CR>
map <C-l> :exec("ts ".expand("<cword>"))<CR>

function! s:Cregen()
    execute ":!cg"
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
"K    #jump to the manpage of it
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

"let g:xml_syntax_folding=1
"au FileType xml setlocal foldmethod=syntax

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
"
set spell spelllang=en_us
set nospell
set spelllang+=cjk
autocmd Filetype markdown,gitcommit,mail,c,python,rust setlocal spell

"Turn on omni completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

" The below mapping will change the behavior of the <Enter> key when the popup
" menu is visible. In that case the Enter key will simply select the
" highlighted menu item, just as <C-Y> does.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <C-j> <C-x><C-o>

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
set pastetoggle=<F1>

" set backspace can remove indent and works
set backspace=indent,eol,start

" disable incremental search
set incsearch

" disable highlight search
set nohlsearch

" Enable mouse
"set mouse=a
" Disable mouse
set mouse=

set autoindent        " always set autoindenting on

" syntax highlighting
syntax on
runtime color.vimrc

map <F5>    :syntax sync fromstart <CR> :redraw!<CR>

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
"set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

"indent issue
filetype on
filetype plugin indent on

"set ts=4
"set sts=4
"set tabstop=4
"set shiftwidth=4
"set expandtab
"
"hightlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

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
"autocmd Filetype vim,xml,perl,python,sh,wiki,markdown,nroff,make,config,rust,c,cpp
"    \ autocmd BufWritePre * :call <SID>RemoveWhiteSpace()
nnoremap <silent> <leader>w :call <SID>RemoveWhiteSpace()<cr>

nnoremap <silent> <leader>b ::<C-u>call gitblame#echo()<cr>
nnoremap <silent> <leader>m :call <SID>centor_window()<cr>

function s:centor_window()
    if (winnr("$") > 1)
        only
    else
        execute 'topleft' ((&columns - &textwidth) / 2 - 1)
                \. 'vsplit _paddding_' | wincmd p
    endif
endfunction

"soft colorcolumn, vim 7.3+ only, short cmd: set cc=78
"set tw=78
if version >=703
    "autocmd Filetype c,cpp,perl,python,sh,expect,mail,moin set colorcolumn=78
    setlocal colorcolumn=78
endif

set wrap

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

"nnoremap <silent> <leader>c :%y+<cr>
"nnoremap <silent> <leader>i "+yiw<cr>
"vnoremap <silent> <leader>c "+y
"nnoremap <silent> <leader>p "+gP
"vnoremap <silent> <leader>p "+gP
"vnoremap <silent> <LeftRelease> "+y<LeftRelease>

" set clipbrad to system clipboard
function! s:copy_visual_selection_to_clipbroad()
  let [s:lnum1, s:col1] = getpos("'<")[1:2]
  let [s:lnum2, s:col2] = getpos("'>")[1:2]
  :exe ':silent'.s:lnum1.','.s:lnum2'w !copy2clip'
endfunction

" below line only works with gvim where xterm_clipboard enabled
"set clipboard=unnamedplus

nnoremap <silent> <leader>i :call system("$HOME/.vim/bin/save2clip " .
                                         \ expand('<cword>'))<cr>
vnoremap <silent> <leader>c :call <SID>copy_visual_selection_to_clipbroad()<cr>
nnoremap <silent> <leader>c :silent w !copy2clip<cr>
nnoremap <silent> <leader>p :-1r !paste2std<cr>


function! s:InsertLGPL()
    execute ":r ~/.vim/license/lgpl.txt"
endfunction
command Ilgpl :-1call <SID>InsertLGPL()

function! s:InsertGPL()
    execute ":-1r ~/.vim/license/gpl.txt"
endfunction
command Igpl :call <SID>InsertGPL()

function! s:InsertMIT()
    execute ":-1r ~/.vim/license/mit.txt"
endfunction
command Imit :call <SID>InsertMIT()

function! s:InsertBSD()
    execute ":-1r ~/.vim/license/bsd.txt"
endfunction
command Ibsd :call <SID>InsertBSD()

function! s:InsertAp()
    execute ":-1r ~/.vim/license/apache.txt"
endfunction
command Iap :call <SID>InsertAp()
nnoremap <silent> <leader>a :call <SID>InsertAp()<cr>


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

function! s:InsertCNVMeDocument(args)
    let save_cursor = getpos(".")
    let codes=system("~/.vim/script/nvme_doc.py " . shellescape(a:args))
    call append(".",split(codes,"\n"))
    normal 
    call setpos(".", save_cursor)
    normal 4jw
endfunction
command! -nargs=+ Icd :call <SID>InsertCNVMeDocument(<q-args>)

hi CursorLine   cterm=NONE ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermfg=white guibg=darkred guifg=white

"For cscope
"if filereadable("cscope.out")
"    cs add cscope.out
"elseif $CSCOPE_DB != ""
"    cs add $CSCOPE_DB
"endif
"set csverb
"set cscopetag
"set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-

"OmniCppComplete
"filetype plugin on
"set ofu=syntaxcomplete#Complete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview

"tagbar
let g:tagbar_position = 'leftabove vertical'
let g:tagbar_width = '40'
let g:tagbar_hide_nonpublic = 1
nnoremap <silent> <leader>t :TagbarToggle<cr>

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

"function! s:UpdateKonsoleTab()
"    if expand("%:t") != '__Tag_List__'
"        execute ":silent !/home/fge/bin/update_konsole_tab set '%:t'"
"        execute ':redraw!'
"    endif
"endfunction

" Update konsole tab with current edit filename
"autocmd BufReadPost * :call <SID>UpdateKonsoleTab()
"autocmd WinEnter * :call <SID>UpdateKonsoleTab()
"autocmd VimLeavePre * :silent !/home/fge/bin/update_konsole_tab clean
"nnoremap <silent> <leader>u :call <SID>UpdateKonsoleTab()<cr>

"augroup termTitle
"  au!
"    autocmd BufEnter * let &titlestring = "%-1.20F"
"  autocmd BufEnter * set title
"augroup END

set titleold=
if &term == "screen" || &term == "screen.xterm-256color"
    set t_ts=k
    set t_fs=\
endif

let short_hostname=system('hostname -s')

if &term == "screen.xterm-256color" || &term == "alacritty" ||
    \ &term == "xterm-256color" || &term == "screen"
    set title
    if len($SSH_TTY) == 0
        autocmd BufEnter * let &titlestring = "%f"
    else
        autocmd BufEnter * let &titlestring = short_hostname . ": %f"
    endif
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
setlocal sts=4 expandtab cc=80 shiftwidth=4

au FileType yaml setlocal ts=2 sts=2 sw=2

autocmd BufRead,BufNewFile *.[ch]\(pp\)\=
                        \ :call <SID>SetLinuxCodeStyle()
autocmd BufRead,BufNewFile */libstoragemgmt-code/*.[ch]\(pp\)\=
                        \ :call <SID>SetKRCodeStyle()
autocmd BufRead,BufNewFile */irksome-turtle/*.[ch]\(pp\)\=
                        \ :call <SID>SetKRCodeStyle()
autocmd BufRead,BufNewFile */NetworkManager/*.[ch]\(pp\)\=
                        \ :call <SID>SetGNUCodeStyle()
autocmd BufRead,BufNewFile */NetworkManager/*.[ch]\(pp\)\=
                        \ :setlocal cc=100
autocmd BufRead,BufNewFile */udisks/*.[ch]
                        \ :call <SID>SetGNUCodeStyle()
autocmd BufRead,BufNewFile */libblockdev/*.[ch]
                        \ :call <SID>SetGNUCodeStyle()
autocmd BufRead,BufNewFile */multipath-tools/*.[ch]\(pp\)\=
                        \ :call <SID>SetLinuxCodeStyle()
autocmd BufRead,BufNewFile */leetcode_practise/*.[ch]\(pp\)\=
                        \ :call <SID>SetKRCodeStyle()
autocmd BufRead,BufNewFile */fan2.txt :set cc=0
autocmd BufRead,BufNewFile */fan.txt :set cc=0

set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1

let g:rustfmt_autosave = 0
let g:rustfmt_fail_silently = 0
autocmd FileType rust nnoremap <silent> <leader>f :RustFmt<cr>
autocmd FileType rust nnoremap <silent> <leader>s :SyntasticCheck<cr>
autocmd FileType rust nnoremap <silent> <leader>d :i <cr>
autocmd FileType rust inoremap <leader>d {:?}
autocmd FileType rust inoremap <leader>p println!("HAHA {:?}",
let g:rustfmt_options = '--edition 2021'


" syntac check
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }


let g:black_linelength = 79
let g:black_skip_string_normalization = 0
autocmd FileType python nnoremap <silent> <leader>f :Black<cr>
"autocmd Filetype python autocmd BufWritePre ?* :Black

" vim-markdown-toc
command Toc :GenTocGFM

" vim-racer

let g:racer_cmd = "/home/fge/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def-split)
au FileType rust nmap <leader>d <Plug>(rust-doc)

" vim-plugin. Use command `vim +PlugInstall` or `vim +PlugUpdate`.
" PlugClean to remove unlisted plugin
" PlugUpgrade to upgrade vim-plugin itself

let hostname = substitute(system('hostname'), '\n', '', '')

if $USER != 'root' &&
    \(hostname == "Gris-Laptop" ||
    \hostname == "Gris-NUC2" ||
    \hostname == "Gris-WS")

    call plug#begin('~/.vim/plugged')
    Plug 'rust-lang/rust.vim'
    Plug 'mzlogin/vim-markdown-toc'
    "Plug 'racer-rust/vim-racer'
    Plug 'vim-syntastic/syntastic'
    "Plug 'cespare/vim-toml'
    Plug 'zivyangll/git-blame.vim'
    Plug 'psf/black'
    Plug 'preservim/tagbar'
    call plug#end()
endif

" wrap long lines without affecting short lines
" :g/./ normal gqq

autocmd BufRead,BufNewFile today.md setlocal cc=100
autocmd BufRead,BufNewFile */network-roles/*.py :let g:black_linelength=88
autocmd BufRead,BufNewFile */network-roles/*.py :setlocal cc=88
autocmd BufRead,BufNewFile */network-roles/*.py :setlocal tw=88
autocmd BufRead,BufNewFile */netlink/*.rs :setlocal cc=100

" Turn off color
"set t_Co=0
"highlight LineNr NONE
"highlight CursorLine NONE
