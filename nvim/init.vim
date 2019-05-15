"=========================================
"setting neovim start
"=========================================
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

" dein {{{
let s:dein_cache_dir = g:cache_home . '/nvim/dein'

" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

    " Auto Download
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif

    " dein.vim をプラグインとして読み込む
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

" dein.vim settings
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

if dein#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)

    let s:toml_dir = g:config_home . '/nvim/dein'

    call dein#load_toml(s:toml_dir . '/plugins.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})
    if has('nvim')
        call dein#load_toml(s:toml_dir . '/neovim.toml', {'lazy': 1})
    endif
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    call dein#end()
    call dein#save_state()
    " session
    call dein#add('xolox/vim-misc')
    call dein#add('xolox/vim-session')
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif
" }}}

"setting neovim end

"denite.nvim設定
nnoremap [denite] <Nop>
nmap <C-u> [denite]
nnoremap <silent> [denite]b :Denite buffer<CR>
nnoremap <silent> [denite]c :Denite changes<CR>
nnoremap <silent> [denite]f :Denite file<CR>
nnoremap <silent> [denite]g :Denite grep<CR>
nnoremap <silent> [denite]h :Denite help<CR>
nnoremap <silent> [denite]l :Denite line<CR>
nnoremap <silent> [denite]t :Denite tag<CR>
nnoremap <silent> [denite]m :Denite file_mru<CR>
nnoremap <silent> [denite]u :Denite menu<CR>
nnoremap <silent> [denite]r :Denite -resume<CR>

nnoremap <silent> fj :<C-u>DeniteCursorWord grep:.<CR>

"=========================================
"setting from vimrc
"=========================================
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
set noswapfile
set nobackup
set backupskip+=/home/tmp/*,/private/tmp/*
" 行末・行頭から次の行へ移動可能に
set whichwrap+=h,l,<,>,[,],b,s
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set clipboard=unnamed
set clipboard+=unnamedplus
set list
set ignorecase
set splitright

"set wildignorecase
"set wildmode=full,full

"Ctrl+cでノーマルモード
imap <C-c> <esc>

"NerdTreeのタブ移動
nnoremap <C-n> gt
nnoremap <C-p> gT

map <F8> :tabdo e!<CR>
imap <F8> :tabdo e!<CR>

map <F7> :vsplit<CR>

"検索後のハイライトを消す
nnoremap <F3> :noh<CR>

set backspace=indent,eol,start

"function Setnumber_toggle()
"  if &number
"    setlocal nonumber
"  else
"    setlocal number
"  endif
"endfunction
"nnoremap <silent> <C-m> :call Setnumber_toggle()<CR>

map <F9> :set paste<CR>
map <F10> :set nopaste<CR>
imap <F9> <C-O>:set paste<CR>
imap <F10> <nop>
set pastetoggle=<F10>

"カラースキーム設定
set termguicolors
colorscheme molokai
syntax on
" 256色
set t_Co=256
" truecolor
set termguicolors
" 背景色
set background=dark
"カラースキーム微調整
hi Comment ctermfg=102
hi Visual  ctermbg=3 guibg=#7d8200
hi CursorLine ctermbg=238 guibg=#4c4c4c
hi LineNr ctermfg=15 guifg=#babcbc
hi Constant ctermfg=99 guifg=#8542ff

"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

" 検索した時のハイライトを消す
nnoremap <F3> :noh<CR>

"=========================================
":Synfoで現在のカーソル下の色設定を表示する
"=========================================
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
"=========================================
"plugin settings
"=========================================
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" デフォルトでツリーを表示させる
autocmd VimEnter * execute 'NERDTree'
" <C-e>でNERDTreeをオンオフ いつでもどこでも
"nmap <silent> <C-e>      :NERDTreeTabsToggle<CR>
"vmap <silent> <C-e> <Esc>:NERDTreeTabsToggle<CR>
"omap <silent> <C-e>      :NERDTreeTabsToggle<CR>
"imap <silent> <C-e> <Esc>:NERDTreeTabsToggle<CR>
"cmap <silent> <C-e> <C-u>:NERDTreeTabsToggle<CR>
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

"ctrl-pでfzf.vimの:Filesを開く
nmap <silent> <C-p> :Files<CR>
"ctrl-aでfzf.vimの:Agを開く
nmap <silent> <C-a> :Ag<CR>
"fzf設定
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

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

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

let g:nerdtree_tabs_open_on_console_startup=1

"htmlインデント設定
let g:html_indent_inctags = "html,body,head,tbody"

" Markdown設定
let g:vim_markdown_folding_disabled = 1
au BufRead,BufNewFile *.md set filetype=markdown

nmap <silent> <C-d> <Plug>DashSearch

"=========================================
"setting deoplete and neosnippets
"=========================================
let g:neosnippet#snippets_directory = '$HOME/.config/nvim/snippets/'
"=========================================
"python用設定
"=========================================
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

"let g:jedi#auto_initialization = 1
"let g:jedi#rename_command = "<leader>R"
"let g:jedi#popup_on_dot = 1
"autocmd FileType python let b:did_ftplugin = 1
"
" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
  endfunction
