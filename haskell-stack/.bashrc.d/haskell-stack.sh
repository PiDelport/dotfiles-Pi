if which stack >/dev/null; then

    # https://github.com/commercialhaskell/stack/blob/master/doc/shell_autocompletion.md
    eval "$(stack --bash-completion-script "$(which stack)")"

fi
