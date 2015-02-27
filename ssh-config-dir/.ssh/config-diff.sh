#!/bin/sh -e
# Compare ~/.ssh/config to ~/.ssh/config.d/*.conf

if [ -f ~/.ssh/config ]; then
    if cat ~/.ssh/config.d/*.conf | diff -u ~/.ssh/config -; then
        echo '~/.ssh/config is up to date.'
    fi
else
    echo "$(basename "$0"): ~/.ssh/config does not exist! Showing built config instead." >&2
    cat ~/.ssh/config.d/*.conf
fi
