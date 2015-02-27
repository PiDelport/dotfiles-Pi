=========================
Bash rc directory support
=========================

This directory contains initialization scripts for interactive Bash shells.

All script files should have a ``.sh`` extension.

To enable
=========

Add something like the following to your ``.bashrc``::

    # Source all *.sh files in the ~/.bashrc.d directory, if it exists.
    if [ -d ~/.bashrc.d ]; then
        for f in ~/.bashrc.d/*.sh; do
            . "$f"
        done
    fi
