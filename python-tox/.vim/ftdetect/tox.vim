" For Tox, the "cfg" filetype's highlighting works a bit better than the
" default "dosini".
au BufRead,BufNewFile tox.ini   if &ft == 'dosini' | let &ft = 'cfg' | endif
