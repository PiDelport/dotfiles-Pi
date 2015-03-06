#!/bin/sh -e
# Compare ~/.ssh/config to ~/.ssh/config.d/*.conf

if cat ~/.ssh/config.d/*.conf | diff -Nu ~/.ssh/config -; then
    echo '~/.ssh/config is up to date.'
fi
