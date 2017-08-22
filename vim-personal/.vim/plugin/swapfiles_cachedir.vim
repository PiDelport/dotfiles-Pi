" Not needed in Neovim.
if has('nvim')
  finish
endif


" Store swapfiles under ~/.cache/vim instead of the current directory.
function! InitCacheDirectory()
  " If necessary, create it and show a small startup reminder message.
  if !isdirectory(expand('~/.cache/vim'))
    echo 'Creating ~/.cache/vim...'
    call mkdir(expand('~/.cache/vim'), 'p', 0700)
  endif
  set directory-=~/.cache/vim
  set directory^=~/.cache/vim
endfunction
call InitCacheDirectory()
