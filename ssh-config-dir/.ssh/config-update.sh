#!/bin/sh -e
# Rebuild ~/.ssh/config from ~/.ssh/config.d/*.conf

if [ -f ~/.ssh/config ]; then
    # If ~/.ssh/config exists, compare it: if there's no difference, just exit;
    # otherwise, prompt to continue.
    if cat ~/.ssh/config.d/*.conf | diff -u ~/.ssh/config -; then
        echo '~/.ssh/config is up to date.'
        exit
    else
        echo
        read -p 'Confirm rebuilding ~/.ssh/config? [Enter to confirm, ^C or EOF to cancel] ' _
    fi
else
    # Otherwise, if it does not exist, create it (without world-readability).
    umask 007
    touch ~/.ssh/config
    echo '~/.ssh/config created.'
fi

cat ~/.ssh/config.d/*.conf >~/.ssh/config
echo '~/.ssh/config rebuilt.'
