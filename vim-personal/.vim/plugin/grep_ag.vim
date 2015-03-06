" The Silver Searcher <http://geoff.greer.fm/ag/> is a great tool for
" searching code.
"
" If it's available, this makes Vim's :grep use it.

if executable('ag')
  let &grepprg = 'ag --column --smart-case $*'
  let &grepformat = '%f:%l:%c:%m'  " See |errorformat|
endif
