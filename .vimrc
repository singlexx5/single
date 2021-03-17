" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" You can also specify a different font, overriding the default font
"if has('gui_gtk2')
"  set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
"else
"  set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
"endif

" If you want to run gvim with a dark background, try using a different
" colorscheme or running 'gvim -reverse'.
" http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/ has examples and
" downloads for the colorschemes on vim.org

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/gvimrc
if filereadable("/etc/vim/gvimrc.local")
  source /etc/vim/gvimrc.local
endif


" note  when use the command line and use Ctrl-Q + Ctrl-X will show [^X]

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
behave mswin

" set full screen
if has("win32")
        autocmd GUIEnter * simalt ~x
endif
autocmd BufRead   *.c,*.h call InitCPrint()
autocmd BufRead   *.py,*.pyw set expandtab
autocmd BufNew    *.py,*.pyw set expandtab
if has("autocmd")
        "autocmd FileType python set complete+=k/$VIMRUNTIME/pydiction/pydiction isk+=.,(
endif " has("autocmd")

" Remove menu bar
set guioptions-=m
" Remove toolbat
set guioptions-=T

" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" set gui
colo ron
syntax on


" set GUI font
set guifont=Courier_New:h10:cANSI
"set fileencodings=gb2312
"set guifont=Consolas:h14:cANSI


" set gvim setting
set background=dark
set backspace=indent,eol,start
set hlsearch
set incsearch
set nocompatible
set ruler
set secure
set showcmd


"Window setting
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l


" tab setting
set shiftwidth=4
set tabstop=4


" set expendtab
"set et
set guitablabel=%N/\ %t\%M


"Set tabpages mapping
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt
map <M-0> 10gt
map <C-Tab> gt


"Color setting
highlight Comment ctermfg=DarkCyan
highlight Search term=reverse ctermbg=4 ctermfg=7
highlight Pmenu guibg=brown gui=bold


"Mapping
nmap ;a    :TlistToggle<CR>
nmap <C-G> :vimgrep <C-R><C-W> **/*.[ch]<CR>
nmap <C-D> :vimgrep <C-R>/<BS><BS><HOME><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><DEL><DEL><END>  **/*.[ch]
nmap <C-Q> <C-W>}
nmap ;n    :set number!<Bar>set number?<CR>
nmap ;w    :set wrap!  <Bar>set wrap?<CR>
nmap ;i    :set ignorecase!<CR>
nmap ;fd   :FuzzyFinderFile<CR>
"python
nmap ;ga   :py print tobin(<C-r><C-W>)<CR>
nmap ;gc   :py print showCause(<C-r><C-W>)<CR>
nmap ;gr   :py print showReg()<CR>
nmap ;pb   :py print tobin()<LEFT>
nmap ;py   :py print
nmap ;ps   :OutMessage py bufSample()<CR>
" vimsh Plugin
nmap ;sh   :source $VIM\vimsh\vimsh.vim<CR>
" set current dir
nmap ,cd :cd %:p:h<CR>
" start Sketch Plugin
map <F2> :call ToggleSketch()<CR>
map <F3> :call HighCW()<CR>

map <F11> :silent !ctags -R *<CR>
map <F12> :silent !cscope -R<CR>

" set <F5> to add time stamp
inoremap <F5> #<C-R>=strftime("%c")<CR>

" FuzzyFinder Plugin
"nnoremap <silent> <C-f><C-t> :FuzzyFinderTag!<CR>
nnoremap <silent> <C-]>      :FuzzyFinderTag! <C-r>=expand('<cword>')<CR><CR>
nnoremap <silent> <C-n>      :FuzzyFinderBuffer<CR>

cmap mywin   call MyWin()

"map <F3>      /<C-r>=expand('<cword>')<CR><CR><ESC><ESC>N
"map <F4>      :match NonText /<C-r>=expand('<cword>')<CR>/<CR>

"   Edit another file in the same directory as the current file
"   uses expression to extract path from current file's path
if has("unix")
    nmap ,e :e <C-R>=expand("%:p:h") . "/" <CR>
    nmap ,w :w <C-R>=expand("%:p:h") . "/" <CR>
    nmap ,sp :sp <C-R>=expand("%:p:h") . "/" <CR>
else
    nmap ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
    nmap ,w :w <C-R>=expand("%:p:h") . "\\" <CR>
    nmap ,sp :sp <C-R>=expand("%:p:h") . "\\" <CR>
endif

" vim fencview
let g:fencview_autodetect = 1

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Settings for taglist.vim
" let Tlist_Use_Right_Window=1
" let Tlist_Auto_Open=0
" let Tlist_Enable_Fold_Column=0
" let Tlist_Compact_Format=0
" let Tlist_WinWidth=28
" let Tlist_Exit_OnlyWindow=1
" let Tlist_File_Fold_Auto_Close = 1


"c debug msg ==> move to CPrint()
"nmap <C-P> oprintf("\n[%4d]%s",__LINE__,__FILE__);<ESC>
"imap <C-P> printf("\n[%4d]%s",__LINE__,__FILE__);
"
function! Auto_Highlight_Cword()
  exe "let @/='\\<".expand("<cword>")."\\>'"
endfunction

function! HighCW()
  if !exists("s:currentcursor")
        let s:currentcursor=getpos(".")
        exe "let @/='\\<".expand("<cword>")."\\>'"
        set hlsearch
  elseif s:currentcursor!=getpos(".")
        let s:currentcursor=getpos(".")
        exe "let @/='\\<".expand("<cword>")."\\>'"
  else
        set nohlsearch
        unlet s:currentcursor
  endif
endfunction

function! MyWin()
        exe "set lines?"
        exe "set columns?"
endfunction

" :iab #i #includ
" need to find why #inc cant use.
function! InitCPrint()
  exe "iab #i    #include"
  exe "iab u8    unsigned char"
  exe "iab u16   unsigned short"
  exe "iab u32   unsigned long"
  exe "iab s8    char"
  exe "iab s16   short"
  exe "iab s32   long"
  exe "iab vu8   volatile unsigned char"
  exe "iab vu16  volatile unsigned short"
  exe "iab vu32  volatile unsigned long"

  if !exists("s:cprint")
        let s:cprint=0
        exe 'nmap <C-P> oprintf("[%4d]%s\n",__LINE__,__FILE__);<ESC>'
        exe 'imap <C-P> printf("[%4d]%s\n",__LINE__,__FILE__);'
  endif
endfunction

function! CPrint()
  if s:cprint==0
        let s:cprint=1
        echo 'set print format to FILE [FUNCTOION][LINE]'
        exe 'nmap <C-P> oprintf("%20s [%20s][%4d]\n",__FILE__,__FUNCTION__,__LINE__);<ESC>'
        exe 'imap <C-P> printf("%20s [%20s][%4d]\n",__FILE__,__FUNCTION__,__LINE__);'
  else
        let s:cprint=0
        echo 'set print format to [LINE]FILE'
        exe 'nmap <C-P> oprintf("[%4d]%s\n",__LINE__,__FILE__);<ESC>'
        exe 'imap <C-P> printf("[%4d]%s\n",__LINE__,__FILE__);'
  endif
endfunction


" set diffexpr=MyDiff()
" function! MyDiff()
"   let opt = '-a --binary '
"   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"   let arg1 = v:fname_in
"   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"   let arg2 = v:fname_new
"   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"   let arg3 = v:fname_out
"   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"   let eq = ''
"   if $VIMRUNTIME =~ ' '
"     if &sh =~ '\<cmd'
"       let cmd = '""' . $VIMRUNTIME . '\diff"'
"       let eq = '"'
"     else
"       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"     endif
"   else
"     let cmd = $VIMRUNTIME . '\diff'
"   endif
"   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
" endfunction

function! ChFontSize(font,fontsize)
        if a:font == 0
                execute "set guifont=Courier_New:h".a:fontsize.":cANSI"
        elseif a:font == 1
                execute "set guifont=Consolas:h".a:fontsize.":cANSI"
        endif
endfunction

function! Listing()
  let i=line("$")
  let pre = ' '
  while (i > 0)
    if match(i, '^9*$') == 0
      let pre = pre . '0'
    endif
    call setline(i, pre . i . "\t" . getline(i))
    let i=i-1
  endwhile
endfunction

function! TabMessage(cmd)
 redir => message
 silent execute a:cmd
 redir END
 tabnew
 silent put=message
 set nomodified
endfunction

function! OutMessage(cmd)
 redir => message
 silent execute a:cmd
 redir END
 silent put=message
endfunction

"Usage
":TabMessage highlight


command! -bar -range=% Reverse <line1>,<line2>g/^/m0
" REVERSE line ordering, and move those lines to the top of the file.
command! -nargs=* Chf call ChFontSize(<f-args>)
command! -nargs=+ Calc :r! python -c "from math import *; print <args>"
command! -range -nargs=* FmtTable python FmtTable(<f-line1>,<f-line2>,<f-args>)
command! -range -nargs=* BufferP python bufferP(<f-line1>,<f-line2>,<f-args>)
command! -nargs=+ -complete=command OutMessage call OutMessage(<q-args>)
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)


"" https://github.com/sontek/dotfiles/
"" ==========================================================
"" Dependencies - Libraries/Applications outside of vim
"" ==========================================================
"" Pep8 - http://pypi.python.org/pypi/pep8
"" Pyflake
"" Ack
"" Rake & Ruby for command-t
"" nose, django-nose
"
"" ==========================================================
"" Plugins included
"" ==========================================================
"" Pathogen
""     Better Management of VIM plugin
""
"" GunDo
""     Visual Undo in vim with diff's to check the difference
""
"" Pytest
""     Runs your Python tests in Vim.
""
"" Commant-T
""     Allows easy search and opening of files within a given path
""
"" Snipmate
""     Configurable snippets to avoid re-typing common comand
""
"" PyFlake
""     Underlines and displays errors with Python on-the-fly
""
"" Fugitive
""    Interface with git from vim
""
"" Git
""    Syntax highlighting for git config file
""
"" Minibufexpl
""    Visually display what buffers are currently opened
""
"" Pydoc
""    Opens up pydoc within vim
""
"" Surround
""    Allows you to surround text with open/close tag
""
"" Py.test
""    Run py.test test's from within vim
""
"" MakeGreen
""    Generic test runner that works with nose
""
"" ==========================================================
"" Shortcut
"" ==========================================================
"set nocompatible              " Don't be compatible with vi
"let mapleader=","             " change the leader to be a comma vs slash
"" let ; be the same as :
"noremap ; :
"
"" Seriously, guys. It's not like :W is bound to anything anyway.
"command! W :w
"
"" sudo write this
"cmap W! w !sudo tee % >/dev/null
"
"" Toggle the task
"map <leader>td <Plug>TaskList
"let tlTokenList = ["FIXME", "TODO", "XXX", "[ACTION]", "ACTION"]
"
"" Username and date
"iabbrev ldis ?_?
"iabbrev jay@ jay@meangrape.com
"iabbrev mg/ http://meangrape.com/
"iabbrev px/ http://poxmonger.com/
"iabbrev xxsig <Esc>:r ![ -n "$SUDO_USER" ] && echo "$SUDO_USER `date '+\%Y\%m\%d'`" \|\| echo "$USER `date '+\%Y\%m\%d'`"<CR>I<BS><Esc>A
"
"" Toggle the taglist
"map <leader>t :TlistToggle<CR>
"
"" Use Exuberant ctag
"let g:Tlist_Ctags_Cmd = "~/bin/ctags"
"
"" Taglist on the right side
"let g:Tlist_Use_Right_Window = 1
"
"" Set size of Taglist window
"let g:Tlist_WinWidth = 25
"
"" Tell Taglist how to speak wiki
"let tlist_vimwiki_settings = 'wiki;h:Headers'
"
""" EnhancedCommentify
"let g:EnhCommentifyUseAltKeys = 'yes'
"vmap <Leader>c <Plug>VisualComment
"vmap <Leader>C <Plug>VisualDeComment
"
"
"
""====================================
""VimWiki
""====================================
"let g:vimwiki_list = [{'path': '~/vimwiki',
"    \ 'template_path': '~/vimwiki_html/templates',
"    \ 'template_default': 'default',
"    \ 'template_ext': '.tpl'}]
"
"" Run pep8
"let g:pep8_map='<leader>8'
"
"" vim-LaTeX
"let g:tex_flavor='latex'
"
"" run py.test'
"nmap <silent><Leader>pf <Esc>:Pytest file<CR>
"nmap <silent><Leader>pc <Esc>:Pytest class<CR>
"nmap <silent><Leader>pm <Esc>:Pytest method<CR>
"nmap <silent><Leader>pn <Esc>:Pytest next<CR>
"nmap <silent><Leader>pp <Esc>:Pytest previous<CR>
"nmap <silent><Leader>pe <Esc>:Pytest error<CR>
"
"" Run django test
"map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
"
"" ,e brings up my .vimrc
"map <leader>e :sp ~/.vimrc<CR><C-W>_
"" ,E reloads it -- making all changes active (have to save first)
"map <silent> <leader>E :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
"
"" open/close the quickfix window
"" nmap <leader>c :copen<CR>
"" nmap <leader>cc :cclose<CR>
"
"" for when we forget to use sudo to open/edit a file
"cmap w!! w !sudo tee % >/dev/null
"
"
"" open new windows to the bottom & right
"set splitbelow
"set splitright
"
"" Resize splits when the window is resized
"au VimResized * exe "normal! \<c-w>="
"
"" ctrl-jklm changes to that split
"map <c-j> <c-w>j
"map <c-k> <c-w>k
"map <c-l> <c-w>l
"map <c-h> <c-w>h
"
"" and lets make these all work in insert mode too ( <C-O> makes next cmd
""  happen as if in command mode )
"imap <C-W> <C-O><C-W>
"
"" Open NerdTree
"map <leader>n :NERDTreeToggle<CR>
"let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
"
"" Run command-t file search
"map <leader>f :CommandT<CR>
"
"" Ack searching
"nmap <leader>a <Esc>:Ack!
"
"" Load the Gundo window
"map <leader>g :GundoToggle<CR>
"
"" Jump to the definition of whatever the cursor is on
"map <leader>j :RopeGotoDefinition<CR>
"
"" Rename whatever the cursor is on (including references to it)
"map <leader>r :RopeRename<CR>
"
"" Open the command history window
"map <leader>h q:<CR>
"
"" Create a line of = the same sizee as the current line
"nnoremap <leader>= yypVr=
"
"" A comment line
"nmap \com# O# <Esc>68A=<Esc><Home>4<Right>R<Space>
"
"" Use par for cleaning up text
"set formatprg=par\ -w\ 78
"
"" Copy, cut, and paste from OS X system clipboard
"if has("mac")
"    " copy
"    vnoremap <silent> <C-X><C-C> : w !pbcopy<CR>
"    " cut
"    vnoremap <silent> <C-X><C-X> !pbcopy<CR>
"    " paste
"    noremap <silent> <C-X><C-V> :set paste<CR> :r !pbpaste<CR> :set nopaste<CR>
"endif
"
"
"" Useful arrow key
"map <down> <ESC>:bn<CR>
"map <up> <ESC>:bp<CR>
"map <left> <ESC>:tabp<CR>
"map <right> <ESC>:tabn<CR>
"map <M-left> <ESC>:tabf<CR>
"map <M-right> <ESC>:tabl<CR>
"
"" Align text
"nnoremap <leader>Al :left<cr>
"nnoremap <leader>Ac :center<cr>
"nnoremap <leader>Ar :right<cr>
"vnoremap <leader>Al :left<cr>
"vnoremap <leader>Ac :center<cr>
"vnoremap <leader>Ar :right<cr>
"
"
"" Remap read and bang
"nnoremap :! :VimProcBang
"vnoremap :! :VimProcBang
"nnoremap :read! :VimProcRead
"vnoremap :read! :VimProcRead
"
"" Smart mappings on the command line
"cno $c e <C-\>eCurrentFileDir("e")<cr>
"cno $d e ~/Documents/
"cno $h e ~/
"cno $j e ./
"cno $r e ~/repo
"
"" change tab
"map <leader>t2 :setlocal shiftwidth=2<cr>
"map <leader>t4 :setlocal shiftwidth=4<cr>
"map <leader>t8 :setlocal shiftwidth=8<cr>
"
""map <Leader>r :w! <bar> !ruby %<CR>
"
"
"""" Neocomplete https://github.com/Shougo/neocomplcache.git
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
"" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
"" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1
"" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
"" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"    \ }
"
"" Define keyword.
"if !exists('g:neocomplcache_keyword_patterns')
"  let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"" Plugin key-mappings.
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"
"" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
"
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
"" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"
"
"" $q is super useful when browsing on the command line
"cno $q <C-\>eDeleteTillSlash()<cr>
"
"func! Cwd()
"  let cwd = getcwd()
"  return "e " . cwd
"endfunc
"
"func! DeleteTillSlash()
"  let g:cmd = getcmdline()
"  if MySys() == "linux" || MySys() == "mac"
"    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
"  else
"    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
"  endif
"  if g:cmd == g:cmd_edited
"    if MySys() == "linux" || MySys() == "mac"
"      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
"    else
"      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
"    endif
"  endif
"  return g:cmd_edited
"endfunc
"
"func! CurrentFileDir(cmd)
"  return a:cmd . " " . expand("%:p:h") . "/"
"endfunc
"
"
"
"
"" Highlight every other line
""map <leader>H :set hls<CR>/\\n.*\\n/<CR>
"
"
"" ==========================================================
"" Pathogen - Allows us to organize our vim plugin
"" ==========================================================
"" Load pathogen with docs for all plugin
"filetype off
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
"
"" No more F1 for help. Avoid fat-fingering ESC
"inoremap <F1> <ESC>
"nnoremap <F1> <ESC>
"vnoremap <F1> <ESC>
"
"" ==========================================================
"" Basic Setting
"" ==========================================================
"syntax on                     " syntax highlighing
"filetype on                   " try to detect filetype
"filetype plugin indent on     " enable loading indent file for filetype
"set number                    " don't use relative line numbering
"set numberwidth=1             " using only 1 column (and 1 space) while possible
"nmap <F2> :set number!<CR>
"set title                     " show title in console title bar
"set undofile                  " persist undos across restart
"set undodir=~/.vim/.undo,~/tmp,/tmp
"set wildmenu                  " Menu completion in command mode on <Tab>
"set wildmode=full             " <Tab> cycles between all matching choices.
"" Ignore these files when completing
"set wildignore+=.hg,.git,.svn                    " Version control
"set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
"set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
"set wildignore+=*.luac                           " Lua byte code
"set wildignore+=*.o,*.obj                        " compiled object files
"set wildignore+=*.pyc                            " Python byte code
"set wildignore+=*.spl                            " compiled spelling word lists
"set wildignore+=*.sw?                            " Vim swap files
"set wildignore+=*.DS_Store?                      " OSX bullshit
"
"
"
""set nobackup                  " Do not keep backup file
""set noswapfile                " No intermediate swap files, either
"" Don't backup things in /tmp
"set backupskip=/tmp/*,/private/tmp/*"
"set undodir=~/.vim/tmp/undo//     " undo files
"set backupdir=~/.vim/tmp/backup// " backups
"set directory=~/.vim/tmp/swap//   " swap files
"set backup                        " enable backups
"
"
"" Save buffer on losing focus
""au FocusLost * :w
"set autowrite all
"" Opens moves to the existing buffer instead of reopening it
"set switchbuf=useopen,usetab
"
"" Remember cursor position on file
"autocmd BufReadPost * normal `"
"
"" If file starts with a shebang, make it executable
"au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
"
"" don't bell or blink
"set noerrorbells
"set vb t_vb=
"
"set grepprg=ack-grep          " replace the default grep program with ack
"
"
"" Set working directory
"nnoremap <leader>. :lcd %:p:h<CR>
"
"" Disable the colorcolumn when switching modes.  Make sure this is the
"" first autocmd for the filetype here
"autocmd FileType * setlocal colorcolumn=0
"
"""" Insert completion
"" don't select first item, follow typing in autocomplete
"set completeopt=menuone,longest,preview
"set pumheight=6             " Keep a small completion window
"
"" show a line at column 79
"if exists("&colorcolumn")
"    set colorcolumn=79
"endif
"
"""" Moving Around/Editing
"" set cursorline              " have a line indicate the cursor location
"set ruler                   " show the cursor position all the time
"set nostartofline           " Avoid moving cursor to BOL when jumping around
"set virtualedit=block       " Let cursor move past the last char in <C-v> mode
"set scrolloff=3             " Keep 3 context lines above and below the cursor
"set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
"set showmatch               " Briefly jump to a paren once it's balanced
"set nowrap                  " don't wrap text
"set linebreak               " don't wrap textin the middle of a word
"set shiftround              " indent based on multiples of shiftwidth
"set autoindent              " always set autoindenting on
"set smartindent             " use smart indent if there is no indent file
"set tabstop=4               " <tab> inserts 4 space
"set shiftwidth=4            " but an indent level is 2 spaces wide.
"set softtabstop=4           " <BS> over an autoindent deletes both spaces.
"set expandtab               " Use spaces, not tabs, for autoindent/tab key.
"set shiftround              " rounds indent to a multiple of shiftwidth
"set matchpairs+=<:>         " show matching <> (html mainly) as well
"set foldmethod=indent       " allow us to fold on indent
"set foldlevel=99            " don't fold by default
"set foldlevelstart=0
"
"" Space to toggle folds.
"nnoremap <Space> za
"vnoremap <Space> za
"
"" Make zO recursively open whatever top level fold we're in, no matter where the
"" cursor happens to be.
"nnoremap zO zCzO
"
"" Use ,z to "focus" the current fold.
"nnoremap <leader>z zMzvzz
"
"function! MyFoldText() " {{{
"    let line = getline(v:foldstart)
"
"    let nucolwidth = &fdc + &number * &numberwidth
"    let windowwidth = winwidth(0) - nucolwidth - 3
"    let foldedlinecount = v:foldend - v:foldstart
"
"    " expand tabs into spaces
"    let onetab = strpart('          ', 0, &tabstop)
"    let line = substitute(line, '\t', onetab, 'g')
"
"    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
"    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
"    return line . '▒K' . repeat(" ",fillcharcount) . foldedlinecount . '▒K' . ' '
"endfunction
"set foldtext=MyFoldText()
"
"
"""" Matchit
"runtime bundles/matchit/matchit.com
"map <tab> %
"
"" don't outdent hashes
"inoremap # #
"
"" close preview window automatically when we move around
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"
""""" Reading/Writing
"set noautowrite             " Never write a file unless I request it.
"set noautowriteall          " NEVER.
"set noautoread              " Don't automatically re-read changed files.
"set modeline                " Allow vim options to be embedded in files;
"set modelines=5             " they must be within the first or last 5 lines.
"set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.
"
""""" Messages, Info, Status
"set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
"set confirm                 " Y-N-C prompt if closing with unsaved changes.
"set showcmd                 " Show incomplete normal mode commands as I type.
"set report=0                " : commands always print changed line count.
"set shortmess+=aI           " Use [+]/[RO]/[w] for modified/readonly/written.
"set ruler                   " Show some info, even without statuslines.
"set laststatus=2            " Always show statusline, even if only 1 window.
"set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"" Highlight VCS conflict markers
"match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
"
" " displays tabs with :set list & displays when a line runs off-screen
"set list
"set listchars=tab:?▒P,eol:?,trail:▒P,precedes:<,extends:>
"set showbreak=?
"
"" HTML/XML files often have tabs; don't display them
"autocmd filetype html,xml set listchars-=tab:?▒P
"
"
"""" Searching and Pattern
"set gdefault                " Make line global replaces the default
"set virtualedit+=all        " Allow editing where ther is no actual character
"set ignorecase              " Default to using case insensitive searches,
"set smartcase               " unless uppercase letters are used in the regex.
"set smarttab                " Handle tabs more intelligently
"set hlsearch                " Highlight searches by default.
"set incsearch               " Incrementally search while typing a /regex
"set smartcase               " unless uppercase letters are used in the regex.
"
"" Toggle  search highlight
"nnoremap <leader><CR> :set hlsearch! hlsearch? <CR>
"
"" Toggle line numbers and whitespace
"nnoremap <leader><space> :set number!<CR>:set list!<CR>
"
"" Make . more useful
"nmap . .`[
"nmap <M-.> `[<down>.
"vnoremap <silent> . :normal .<CR>
"
"
"
""
"" Don't use vim native regexe
"nnoremap / /\v
"vnoremap / /\v
"
""""" Display
"syntax enable
"" Settings for Solarized git://github.com/altercation/solarized.git
"" Terminal app needs the Solarized color scheme, too
"" https://github.com/tomislav/osx-lion-terminal.app-colors-solarized
"set background=light
""set background=dark
"colorscheme solarized
"let g:solarized_termcolors=256
"let g:solarized_termtrans=0
"
"" ==========================================================
"" Clojure
"" ==========================================================
""let vimclojureRoot=$HOME . ".vim/bundle/vimclojure"
""let vimclojure#HighlightBuiltins=1
""let vimclojure#HighlightContrib=1
""let vimclojure#DynamicHighlighting=1
""let vimclojure#ParenRainbow=1
""let vimclojure#WantNailgun = 0
"
"let classpath = join(
"   \[".",
"   \ "src", "src/main/clojure", "src/main/resources",
"   \ "test", "src/test/clojure", "src/test/resources",
"   \ "classes", "target/classes",
"   \ "lib/*", "lib/dev/*",
"   \ "bin",
"   \ $HOME . ".vim/lib/*"
"   \],
"   \ ":")
"
""au FileType clojure call TurnOnClojureFolding()
""au FileType clojure compiler clojure
"au FileType clojure setlocal report=100000
"
""let g:slimv_leader = '\'
"let g:slimv_keybindings = 2
"
"" Fix the eval mapping.
"au FileType clojure nmap <buffer> \ee \ed
"
"" Indent top-level form.
"au FileType clojure nmap <buffer> <localleader>= v((((((((((((=%
"
"" Use a swank command that works, and doesn't require new app windows.
"au FileType clojure let g:slimv_swank_cmd='!dtach -n /tmp/dvtm-swank.sock -r winch lein swank'
"
"au BufWinEnter Slimv.REPL.clj setlocal winfixwidth
"au BufNewFile,BufRead Slimv.REPL.clj setlocal nowrap
"au BufWinEnter Slimv.REPL.clj normal! zR
"
"
"
"
"" ==========================================================
"" Python
"" ==========================================================
""au BufRead *.py compiler nose
"au BufNewFile,BufRead *.tac set ft=python
"au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"
"" Paste from clipboard
""map <leader>p "+gP
"
"" Quit window on <leader>q
"nnoremap <leader>q :q<CR>
""
"
"" Removes all Brittspace
"function! BrittSpace()
"  %s/\s*$//
"  ''
":endfunction
"
"autocmd FileWritePre * :call BrittSpace()
"autocmd FileAppendPre * :call BrittSpace()
"autocmd FilterWritePre * :call BrittSpace()
"autocmd BufWritePre * :call BrittSpace()
""
"map <F3> :call BrittSpace()<CR>
"map! <F3> :call BrittSpace()<CR>
"
"" For whatever reason, this ocassionally remaps
"" <CR> to inserting  pumvisible() ?
"" Select the item in the list with enter
""inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" tar all open files
"nnoremap <silent> <C-t> :bufdo !tar -rvf archive.tar %
"
"
"" ==========================================================
"" Javascript
"" ==========================================================
"au BufRead *.js set makeprg=jslint\ %
"
"" Don't allow snipmate to take over tab
"autocmd VimEnter * ino <c-j> <c-r>=TriggerSnippet()<cr>
"
"" Use tab to scroll through autocomplete menu
"autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
"autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"
"snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>
"let g:acp_completeoptPreview=1
"
"" ===========================================================
"" FileType specific change
"" ============================================================
"" Mako/HTML
"autocmd BufNewFile,BufRead *.mako,*.mak setlocal ft=html
"au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"" Don't let pyflakes use the quickfix window
"let g:pyflakes_use_quickfix = 0
"
"
"" Add the virtualenv's site-packages to vim path
"python << EOF
"import os.path
"import sys
"import vim
"if 'VIRTUALENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    sys.path.insert(0, project_base_dir)
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    execfile(activate_this, dict(__file__=activate_this))
"EOF
"
"" Load up virtualenv's vimrc if it exist
"if filereadable($VIRTUAL_ENV . '/.vimrc')
"    source $VIRTUAL_ENV/.vimrc
"endif
"
