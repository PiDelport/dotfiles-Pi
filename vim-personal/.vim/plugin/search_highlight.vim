" Search-highlight the word under the cursor.
nnoremap <silent> <Leader>* :let @/ = '\V\<' . escape(expand('<cword>'), '\') . '\>' <Bar> set hlsearch<CR>
nnoremap <silent> <Leader>g* :let @/ = '\V' . escape(expand('<cword>'), '\') <Bar> set hlsearch<CR>
