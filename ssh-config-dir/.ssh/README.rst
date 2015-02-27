================================
OpenSSH config directory support
================================

OpenSSH does not support any transclusion syntax or mechanism for its config
file.

These scripts support some semblance of a modular config file by generating
``~/.ssh/config`` from the concatenation of all the ``*.conf`` files in the
``~/.ssh/conf.d/`` directory. This allows different dotfiles packages to
provide config snippets, which then get combined.

Usage
=====

Just run ``~/.ssh/config-diff.sh`` and ``~/.ssh/config-update.sh`` as appropriate.

Config file conventions
=======================

The files under ``~/.ssh/conf.d/`` are simply combined in lexicographic
filename order. So, as a minimal naming convention, dotfiles packages should
use the following file names:

``0-*.conf``
    Reserved for the header.

``1-*.conf``
    Global configuration.

``2-*.conf``
    Per-host configuration.

To keep the final config readable, files should start with an empty line.
