set nocompatible
set directory=$HOME/.vim
set backupdir=$HOME/.vim
set clipboard=unnamed,unnamedplus
set number
set hidden
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent
set showmatch
set smartcase
set nowrapscan
set mouse=a
set ttymouse=xterm2
set noswapfile
set nobackup
" 行末・行頭から次の行へ移動可能に
set whichwrap+=h,l,<,>,[,],b,s
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double

"Ctrl+cでノーマルモード
imap <C-c> <esc>

"NerdTreeのタブ移動
nnoremap <C-n> gt
nnoremap <C-p> gT

function Setnumber()
  if &number
    setlocal nonumber
  else
    setlocal number
  endif
endfunction
nnoremap <silent> <C-m> :call Setnumber()<CR>

map <F9> :set paste<CR>
map <F10> :set nopaste<CR>
imap <F9> <C-O>:set paste<CR>
imap <F10> <nop>
set pastetoggle=<F10>

"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/Users/joea/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/Users/joea/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"htmlタグ対応ハイライト
NeoBundle 'valloric/matchtagalways'
"MatchTagAlwaysのオプション機能ONにする
let g:mta_use_matchparen_group = 1

"MatchTagAlwaysを使用するファイルタイプ
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'php' : 1,
    \ 'html.erb' : 1,
    \}

" Add or remove your Bundles here:
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Shougo/unite.vim'
let g:neocomplete#enable_at_startup = 1
let g:neosnippet#enable_snipmate_compatibility = 1
"インサートモードでバックスペース、カーソル移動時にneocompleteの補完を消す
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><Left>  neocomplete#cancel_popup() . "\<Left>"
inoremap <expr><Right> neocomplete#cancel_popup() . "\<Right>"
inoremap <expr><Up>    pumvisible() ? "\<Up>"    : neocomplete#cancel_popup() . "\<Up>"
inoremap <expr><Down>  pumvisible() ? "\<Down>"  : neocomplete#cancel_popup() . "\<Down>"

let g:neocomplete#enable_insert_char_pre = 1

" ------------------------------------------------------------
" NeoSnippetの設定
" Plugin key-mappings.
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"
" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
"set snippet file dir
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/,~/.vim/snippets'

"Unite設定
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file<CR>

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" デフォルトでツリーを表示させる
autocmd VimEnter * execute 'NERDTree'
" <C-e>でNERDTreeをオンオフ いつでもどこでも
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

" Rails向けのコマンドを提供する
NeoBundle 'tpope/vim-rails'

" Ruby向けにendを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'

" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" ログファイルを色づけしてくれる
NeoBundle 'vim-scripts/AnsiEsc.vim'

" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

" emmet-vim
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-Z>'

"surround.vim
NeoBundle 'surround.vim'

"(などの自動補完
NeoBundle 'Raimondi/delimitMate'
"ステータスライン色付け
"========================================
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"lightline.vim end
"=======================================
"Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'


"html5,css3,scss
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'JulesWang/css.vim'
NeoBundle 'cakebaker/scss-syntax.vim'
"DBをさわれる
NeoBundle 'vim-scripts/dbext.vim'
" 環境に合わせてクライアントプログラムを変更
" (ver.20.0 からはデフォルトでsqlite3)
let g:dbext_default_SQLITE_bin = 'sqlite3'
" プロファイルの定義
"let g:dbext_default_profile_MySQL_test = 'type=SQLSRV:integratedlogin=1:dbname=myDB'
"let g:dbext_default_profile_SQLServer_test = 'type=SQLSRV:integratedlogin=1:dbname=myDB'
let g:dbext_default_profile_sqlite = 'type=SQLITE:dbname=/dbpath/test.db'
"デフォルトで使用するプロファイルを指定
let g:dbext_default_profile = 'sqlite'

"htmlインデント設定
let g:html_indent_inctags = "html,body,head,tbody"

" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

"python補完
NeoBundle 'davidhalter/jedi-vim'
"python関連設定(タブ幅など)
"autocmd FileType python setl autoindent
"autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4


" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

syntax on
colorscheme molokai
set t_Co=256
hi Comment ctermfg=102
hi Visual  ctermbg=3
hi CursorLine ctermbg=238


"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない


function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! Synfo call s:get_syn_info()

if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif
