" Recognise *.dockerfile as a file extension too.
au BufRead,BufNewFile *.dockerfile      set filetype=dockerfile

" Recognise Dockerfile.* (e.g. Dockerfile.dapper)
au BufRead,BufNewFile Dockerfile.*      set filetype=dockerfile
