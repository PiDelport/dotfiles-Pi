# Helpers for working with virtualenvwrapper.
#
# See http://virtualenvwrapper.readthedocs.org/


# Harmonise virtualenvwrapper with pipenv's default root.
#
# This prevents the surprise of pipenv switching to virtualenvwrapper's default
# value of "~/.virtualenvs" when invoking pipenv after virtualenvwrapper was
# invoked in the same shell session.
#
export WORKON_HOME="$HOME/.local/share/virtualenvs"


# Versioned variants of the usual virtualenv-creating commands.
#
for ver in 2{,.7} 3{,.{5,6,7,8,9,10}}; do
    if test -x "$(which python${ver})"; then
        alias mkproject${ver}='mkproject --python="$(which python'${ver}')"'
        alias mktmpenv${ver}='mktmpenv --python="$(which python'${ver}')"'
        alias mkvirtualenv${ver}='mkvirtualenv --python="$(which python'${ver}')"'
    fi
done
