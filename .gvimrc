if has('gui_macvim')
    set showtabline=2  " タブを常に表示
    set imdisable  " IMを無効化
    set transparency=30  " 透明度を指定
    set antialias
    set guifont=Monaco:h14
    colorscheme macvim
    set lines=90 columns=200
    "ポップアップ補完メニュー色設定（通常の項目、選択されている項目、スクロールバー、スクロールバーのつまみ部分）
endif

if has("gui_running")
  "set fuoptions=maxvert,maxhorz
  "au GUIEnter * set fullscreen
endif
startinsert
standout
colorscheme railscasts
"ポップアップ補完メニュー色設定（通常の項目、選択されている項目、スクロールバー、スクロールバーのつまみ部分）
"highlight Pmenu ctermbg=8 guibg=#606060
"highlight PmenuSel ctermbg=12 guibg=#FF1493
"highlight PmenuSbar ctermbg=0 guibg=#404040
hi Pmenu guibg=#666666
hi PmenuSel guibg=#5985D9 guifg=#EEEEEE
hi PmenuSbar guibg=#333333
"hi PmenuThumb guibg=#aaaaaa
hi Search term=standout ctermfg=0 ctermbg=14 guifg=#333333 guibg=#FFE835

