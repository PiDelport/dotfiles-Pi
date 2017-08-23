scriptencoding utf-8

" Personal settings

if !has("nvim")
  " For classic Vim only (Neovim has these as default)
  set autoindent
  set autoread
  set hlsearch
  set incsearch
  set laststatus=2
  set modeline
  set smarttab
  set wildmenu
endif

set expandtab
set formatoptions+=r
set ignorecase
set keywordprg=:help
set linebreak
set list
set listchars=tab:»·,trail:·,extends:»,precedes:«,conceal:…,nbsp:␣
set nojoinspaces
set nowrap
set secure
set shiftwidth=4
set showcmd
set smartcase
set wildmode=longest,full

" Terminal-specific
"
" Note: neovim-qt doesn't support has('gui_running') like Classic Vim does,
" so for now, let's differentiate by looking for xterm instead.
"
" See:
" https://github.com/equalsraf/neovim-qt/issues/102
" https://github.com/equalsraf/neovim-qt/issues/94
"
if has ('nvim') && $TERM =~# '^xterm'
  " Neovim
  set background=dark
elseif !has ('nvim') && !has('gui_running')
  " Classic Vim
  set background=dark
  set mouse=a
endif

" Minor / miscellaneous

set clipboard+=unnamed
set diffopt+=context:10
set foldcolumn=2
set foldlevel=2
