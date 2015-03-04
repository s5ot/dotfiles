"-------------------------------------------------------------------------------
"" 基本設定 Basics
"-------------------------------------------------------------------------------
set nocompatible                 " Vimっす。vi互換なしっす。
set noswapfile                   " スワップファイル作らない
set noundofile                   " Undoファイル作らない
set nobackup                     " バックアップ取らない
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set autoread                     " 他で書き換えられたら自動で読み直す
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set vb t_vb=                     " ビープをならさない
set hidden                       " 保存していなくても別のファイルを表示できるようにする
set t_Co=256
colorscheme railscasts

" OSのクリップボードを使用する
set clipboard=unnamed,autoselect

" コピーした文字で、繰り返し上書きペーストしたい
vnoremap <silent> <C-p> "0p<CR>

"コロンセミコロン入れ変え
noremap ; :
noremap : ;

"ポップアップ補完メニュー色設定（通常の項目、選択されている項目、スクロールバー、スクロールバーのつまみ部分）
hi Pmenu guibg=#666666
hi PmenuSel guibg=#99ccff guifg=#666666
hi PmenuSbar guibg=#333333

"スペースキーは一画面移動にしてみる試み
"https://sites.google.com/site/fudist/Home/vim-nihongo-ban/tips#TOC-5
nnoremap <SPACE>   <PageDown>
nnoremap <S-SPACE> <PageUp>
map      g<SPACE>  G
nnoremap <M-SPACE> i<SPACE><ESC><Right>

vnoremap <SPACE>   <C-d>
vnoremap <S-SPACE> <C-u>

"-------------------------------------------------------------------------------
" NeoBundle
"-------------------------------------------------------------------------------
filetype off                   " Required!
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
" その他
NeoBundle 'Shougo/vimproc',  {
                        \ 'build' : {
                        \     'mac' : 'make -f make_mac.mak',
                        \    },
                        \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tpope/vim-endwise.git'
"NeoBundle 'ruby-matchit'
NeoBundle 'vim-scripts/dbext.vim'

" 補完
NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/neosnippet'

" コメント
"NeoBundle 'tomtom/tcomment_vim'　　
NeoBundle 'surround.vim'

"" railsサポート
"NeoBundle 'taichouchou2/vim-rails'　　
NeoBundle 'romanvbabenko/rails.vim'
NeoBundle 'ujihisa/unite-rake'
NeoBundle 'basyura/unite-rails'

" reference環境
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
NeoBundle 'thoughtbot/vim-rspec'

" vim-scripts リポジトリ (1)
"NeoBundle "rails.vim"
"NeoBundle "bufferlist.vim"
NeoBundle "YankRing.vim"

" github の任意のリポジトリ (2)
"NeoBundle "gmarik/vundle"
NeoBundle "tpope/vim-fugitive"
NeoBundle 'ujihisa/quickrun'
"NeoBundle 'scrooloose/nerdtree'
NeoBundle 'https://github.com/vim-scripts/Align.git'
NeoBundle 'https://github.com/scrooloose/syntastic.git'
"let g:syntastic_mode_map = { 'mode': 'passive',  'active_filetypes': ['ruby'] }
"let g:syntastic_ruby_checkers = ['rubocop']

" github 以外のリポジトリ (3)
"NeoBundle "git://git.wincent.com/command-t.git"
" Syntax + 自動compile
NeoBundle 'kchmck/vim-coffee-script'
" js BDDツール
NeoBundle 'claco/jasmine.vim'
" indentの深さに色を付ける
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle "pangloss/vim-javascript"
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'einars/js-beautify'
NeoBundle 'Shougo/vimfiler'
NeoBundle "wookiehangover/jshint.vim"



"------------------------------------
" golang
"------------------------------------
if $GOROOT != ''
    set runtimepath+=$GOROOT/misc/vim
endif
"golint
if $GOPATH != ''
    set runtimepath+=$GOPATH/src/github.com/golang/lint/misc/vim
endif
autocmd BufWritePost, FileWritePost *.go execute 'Lint' | cwindow
NeoBundleLazy 'Blackrush/vim-gocode',  {"autoload": {"filetypes": ['go']}}
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'

" ファイルタイプ判定をon
filetype plugin indent on

" Installation check.
if neobundle#exists_not_installed_bundles()
        echomsg 'Not installed bundles : ' .
                                \ string(neobundle#get_not_installed_bundle_names())
        echomsg 'Please execute ":NeoBundleInstall" command.'
        "finish
endif

call neobundle#end()


"-------------------------------------------------------------------------------
" ステータスライン StatusLine
"-------------------------------------------------------------------------------
set laststatus=2 " 常にステータスラインを表示

"ステータスラインに文字コードと改行文字を表示する
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif

function! GetB()
  let c = matchstr(getline('.'),  '.',  col('.') - 1)
  let c = iconv(c,  &enc,  &fenc)
  return String2Hex(c)
endfunction
" help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

"-------------------------------------------------------------------------------
" 表示 Apperance
"-------------------------------------------------------------------------------
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示
"set list              " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex      " 印字不可能文字を16進数で表示

" 全角スペースの表示
"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
"match ZenkakuSpace /　/


"-------------------------------------------------------------------------------
" インデント Indent
"-------------------------------------------------------------------------------
set autoindent   " 自動でインデント
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent      " Cプログラムファイルの自動インデントを始める

"-------------------------------------------------------------------------------
" 検索設定 Search
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

"-------------------------------------------------------------------------------
" エンコーディング関連 Encoding
"-------------------------------------------------------------------------------
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング

autocmd BufRead, BufNewFile *.html set ft=html
autocmd BufRead, BufNewFile *.js set ft=javascript
autocmd BufRead, BufNewFile, BufReadPre *.coffee  set filetype=coffee

" 以下のファイルの時は文字コードをutf-8に設定
autocmd FileType svn :set fileencoding=utf-8
autocmd FileType javascript :set fileencoding=utf-8 sw=2 ts=2 sts=2
autocmd FileType css :set fileencoding=utf-8
autocmd FileType html :set fileencoding=utf-8 sw=2 ts=2 sts=2
autocmd FileType xml :set fileencoding=utf-8
autocmd FileType java :set fileencoding=utf-8
autocmd FileType scala :set fileencoding=utf-8
autocmd FileType ruby :set fileencoding=utf-8 sw=2 ts=2 sts=2
autocmd FileType coffee :set fileencoding=utf-8 sw=2 ts=2 sts=2
autocmd FileType go :set fileencoding=utf-8 sw=4 ts=4 sts=4

" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932


"-------------------------------------------------------------------------------
"" カラー関連 Colors
"-------------------------------------------------------------------------------
"ハイライト on
syntax enable

"-------------------------------------------------------------------------------
" 編集関連 Edit
"-------------------------------------------------------------------------------
" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Tabキーを空白に変換
set expandtab

" コンマの後に自動的にスペースを挿入
 inoremap , ,<Space>

" XMLの閉タグを自動挿入
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge

"-------------------------------------------------------------------------------
" BufferList
"-------------------------------------------------------------------------------
" Ctrl-Lを押した時にバッファの一覧を開く
:map <silent> <C-L> :call BufferList()<CR>
nnoremap <silent> <C-L> :call BufferList()<CR>
let g:qb_hotkey = "<silent> <C-L>"

"-------------------------------------------------------------------------------
" neocomplcache
"-------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化

"-------------------------------------------------------------------------------
" unite.vim
"-------------------------------------------------------------------------------
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1

" インサート／ノーマルどちらからでも呼び出せるようにキーマップ
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

"-------------------------------------------------------------------------------
" NERDTree
"-------------------------------------------------------------------------------
"nnoremap <silent> <Leader>n :NERDTreeToggle<CR>

"------------------------------------
" indent_guides
"------------------------------------
" インデントの深さに色を付ける
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
au FileType coffee,ruby,python IndentGuidesEnable
nmap <silent><Leader>ig <Plug>IndentGuidesToggle

"------------------------------------
" Unite-rails.vim
"------------------------------------
"{{{
function! UniteRailsSetting()
  nnoremap <buffer><C-H><C-H><C-H>  :<C-U>Unite rails/view<CR>
  nnoremap <buffer><C-H><C-H>       :<C-U>Unite rails/model<CR>
  nnoremap <buffer><C-H>            :<C-U>Unite rails/controller<CR>

  nnoremap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
  nnoremap <buffer><C-H>s           :<C-U>Unite rails/spec<CR>
  nnoremap <buffer><C-H>m           :<C-U>Unite rails/db -input=migrate<CR>
  nnoremap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
  nnoremap <buffer><expr><C-H>g     ':e '.b:rails_root.'/Gemfile<CR>'
  nnoremap <buffer><expr><C-H>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
  nnoremap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
  nnoremap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
  nnoremap <buffer><C-H>h           :<C-U>Unite rails/heroku<CR>
endfunction
aug MyAutoCmd
  au User Rails call UniteRailsSetting()
aug END
"}}}

"------------------------------------
" Simple-Javascript-Indenter
"------------------------------------
" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
"" " この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1

"------------------------------------
" maksimr/vim-jsbeautify
"------------------------------------
"map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-j> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-j> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-j> :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <c-j> :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-j> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-j> :call RangeCSSBeautify()<cr>

"------------------------------------
" Unite bookmark Enterでcd
"------------------------------------
autocmd FileType vimfiler call unite#custom_default_action('directory', 'cd')

"------------------------------------
" vimfiler
"------------------------------------
let g:vimfiler_as_default_explorer=1

source $VIMRUNTIME/macros/matchit.vim
