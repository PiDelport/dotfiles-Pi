" Personal toggle mappings

nnoremap <silent> <Leader>/ :set hlsearch! <Bar> set hlsearch?<CR>
nnoremap <silent> <Leader>i :set ignorecase! <Bar> set ignorecase?<CR>
nnoremap <silent> <Leader>s :set spell! <Bar> set spell?<CR>
nnoremap <silent> <Leader>w :set wrap! <Bar> set wrap?<CR>

" Toggle whitespace sensitivity in diff mode.
nnoremap <silent> dI :if 0 <= index(split(&diffopt, ','), 'iwhite') <Bar> set diffopt-=iwhite <Bar> else <Bar> set diffopt+=iwhite <Bar> endif <Bar> diffupdate<CR>

