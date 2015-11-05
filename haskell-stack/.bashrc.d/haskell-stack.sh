if which stack >/dev/null; then

    # https://github.com/commercialhaskell/stack/blob/master/doc/shell_autocompletion.md
    eval "$(stack --bash-completion-script "$(which stack)")"

    # If there's no ghci on the path, define a wrapper to invoke stack ghci instead.
    if ! which ghci >/dev/null; then
        # This is a bit hacky, but can run with or without options to ghci.
        ghci () {
            # Note: Intentionally uses * instead of @.
            stack ghci ${*:+--ghc-options "$*"}
        }
    fi

fi
