" Let Vim detect these files as SSH config files.
" (Note the leading star, so that repository checkouts not directly under the
" home directory are also matched.)
au BufRead,BufNewFile */.ssh/config.d/*.conf    setf sshconfig
