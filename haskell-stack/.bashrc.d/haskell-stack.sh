if which stack >/dev/null; then

    # https://github.com/commercialhaskell/stack/blob/master/doc/shell_autocompletion.md
    eval "$(stack --bash-completion-script "$(which stack)")"

    # If there's no ghci on the path, define a wrapper to invoke stack ghci instead.
    if ! which ghci >/dev/null; then
        # This is a bit hacky, but can run with or without options to ghci.
        ghci () {
            # Note: Intentionally uses * instead of @.
            stack ghci ${*:+--ghci-options "$*"}
        }
    fi

    # Same for ghc and runghc / runhaskell, but these can actually use @ for correct quoting.
    if ! which ghc >/dev/null; then
        ghc () {
            stack ghc ${@:+-- "$@"}
        }
    fi
    if ! which runghc >/dev/null; then
        runghc () {
            stack runghc ${@:+-- "$@"}
        }
    fi
    if ! which runhaskell >/dev/null; then
        runhaskell () {
            stack runhaskell ${@:+-- "$@"}
        }
    fi

fi


# Create a symlinked .stack-work directory under ~/.cache/stack-work
cachestack () {
    local dir=~/.cache/stack-work/"$(basename "$PWD")"
    if test -e "$dir"; then
        echo "$dir exists!"
    elif test -e ".stack-work"; then
        echo ".stack-work exists!"
    else
        mkdir -p "$dir" && ln -s "$dir" .stack-work
    fi
}

# Migrate an existing .stack-work directory to ~/.cache/stack-work
cachestack_convert () {
    mv --no-target-directory .stack-work .stack-work-temp && cachestack && mv .stack-work-temp/* .stack-work && rmdir .stack-work-temp
}
