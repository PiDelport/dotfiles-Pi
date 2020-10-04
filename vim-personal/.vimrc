" This must be set before plugin loading starts.
if has('eval')
  let mapleader = ','
endif

filetype plugin indent on

" For now.
run macros/matchit.vim

" For the :Man command
run ftplugin/man.vim
