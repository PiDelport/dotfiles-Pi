scriptencoding utf-8

" Personal settings

set autoindent
set autoread
set expandtab
set formatoptions+=r
set hlsearch
set ignorecase
set incsearch
set keywordprg=:help
set laststatus=2
set linebreak
set list
set listchars=tab:»·,trail:·,extends:»,precedes:«,conceal:…,nbsp:␣
set modeline
set nojoinspaces
set nowrap
set secure
set shiftwidth=4
set showcmd
set smartcase
set smarttab
set wildmenu
set wildmode=longest,full

" Terminal-specific
if !has('gui_running')
  set background=dark
  set mouse=a
endif

" Minor / miscellaneous

set clipboard+=unnamed
set diffopt+=context:10
set foldcolumn=2
set foldlevel=2
