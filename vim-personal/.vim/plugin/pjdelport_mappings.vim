" Personal shortcut mappings

" Save and Kill shortcuts
nnoremap <C-S> :wall<CR>
nnoremap <C-K> :confirm qall<CR>

" Make and Quickfix shortcuts
nnoremap <F5> :wall \| make<CR>
nnoremap <C-Q> :copen<CR>

" Miscellaneous shortcuts
nnoremap du :diffupdate<CR>
nnoremap gc :tabclose<CR>

" Disable search highlighting on clear.
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Insert-mode shortcuts
inoremap <C-L> <Right>
" Emacs-style
inoremap <C-F> <Right>
inoremap <C-B> <Left>
