# Helpers for working with virtualenvwrapper.
#
# See http://virtualenvwrapper.readthedocs.org/


# Versioned variants of the usual virtualenv-creating commands.
#
for ver in 2{,.7} 3{,.{5,6,7,8,9,10}}; do
    if test -x "$(which python${ver})"; then
        alias mkproject${ver}='mkproject --python="$(which python'${ver}')"'
        alias mktmpenv${ver}='mktmpenv --python="$(which python'${ver}')"'
        alias mkvirtualenv${ver}='mkvirtualenv --python="$(which python'${ver}')"'
    fi
done
