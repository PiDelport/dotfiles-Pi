=======================
Piët Delport's dotfiles
=======================

This is my personal repository of Unix configuration files or *dotfiles*,
designed to be checked out under a home directory and installed as symbolic
links.

Every direct subdirectory of this repository identifies a topic or *package* of
paths to be installed relative to the root of the target home directory. All or
only some packages may be installed, as needed.

Installation
============

This layout can be used and managed by multiple tools.

Using plain shell
-----------------

A quick and dirty way to install the links is using the ``cp`` command's
``--symbolic-link`` feature. For example, as a ``bash`` script::

    #!/bin/bash -e

    shopt -s dotglob
    cd "$(dirname "$0")"
    cp -rsi "$PWD"/*/* -t "$HOME"

(Note that ``bash`` requires the ``dotglob`` option to match dotfiles. Without
it, only non-dotfiles will get installed.)

Using stow
----------

See:

* `GNU Stow <http://www.gnu.org/software/stow/>`_
* "`Using GNU Stow to manage your dotfiles`__" (Brandon Invergo, 2013-04-04)

__ http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html

Stow works best if the repository is checked out to a direct subdirectory of
target home directory, like ``~/pjdelport-dotfiles``.

To install links for all packages::

    stow -v */ -n

To remove installed links::

    stow -v -D */ -n

Using Bookkeeper
----------------

See:

* https://pypi.python.org/pypi/Bookkeeper
* https://github.com/hkupty/bookkeeper


Post-installation steps
=======================

bash-rc-dir
    See ``.bashrc.d/README.rst`` for a snippet to add to your ``.bashrc``.

ssh-config-dir
    See ``.ssh/README.rst``, and run ``~/.ssh/config-update.sh``.

hg-common
    See ``~/.hgrc.common``, and include it from ``~/.hgrc``.

git-common
    See ``~/.gitconfig.common``, and include it from ``~/.gitconfig``.
