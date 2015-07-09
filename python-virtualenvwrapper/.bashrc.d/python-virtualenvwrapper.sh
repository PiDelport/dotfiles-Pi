# Helpers for working with virtualenvwrapper.
#
# See http://virtualenvwrapper.readthedocs.org/


# Python 3 variants of the usual virtualenv-creating commands.
#
alias mkproject3='mkproject --python="$(which python3)"'
alias mktmpenv3='mktmpenv --python="$(which python3)"'
alias mkvirtualenv3='mkvirtualenv --python="$(which python3)"'
