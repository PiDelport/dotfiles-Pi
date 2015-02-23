" An operator to sort lines.
function! SortOperator(type)
  '[,']sort
  set operatorfunc&
endfunction

" Mnemonic: o for "order".
" (Note: This masks the built-in |go| command.)
nnoremap <silent> go :set operatorfunc=SortOperator<CR>g@
vnoremap <silent> go :sort<CR>
