# Helpers for working with virtualenvwrapper.
#
# See http://virtualenvwrapper.readthedocs.org/


# Use a local package directory to find up-to-date versions of setuptools and
# pip when creating virtualenvs.
#
# For convenience, ~/.cache/pip-wheelhouse should match the wheel-dir
# configured in pip.conf.
#
alias mkproject='mkproject --extra-search-dir="$HOME/.cache/pip-wheelhouse"'
alias mktmpenv='mktmpenv --extra-search-dir="$HOME/.cache/pip-wheelhouse"'
alias mkvirtualenv='mkvirtualenv --extra-search-dir="$HOME/.cache/pip-wheelhouse"'


# Python 3 variants of the usual virtualenv-creating commands.
#
alias mkproject3='mkproject --python="$(which python3)"'
alias mktmpenv3='mktmpenv --python="$(which python3)"'
alias mkvirtualenv3='mkvirtualenv --python="$(which python3)"'
