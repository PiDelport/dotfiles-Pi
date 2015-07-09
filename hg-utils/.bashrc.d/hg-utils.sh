# Mercurial utilities

# Shortcuts for the myrepos <http://myrepos.branchable.com/> tool:

# Run "hg in", showing changes only.
#
# Any arguments replace the default "-qj" options passed to mr, so that for
# example "mr_hg_in -j" will show mr's full, non-quiet output.
mr_hg_in () {
    # Note: "hg in" exits with success for incoming changes and failure for no
    # changes, so to get "mr -q" to show the former instead of the latter, we
    # have to negate the exit code.
    #
    # ("hg in" will also simply fail for non-hg repositories, but the negation
    # will make "mr -q" suppress those error messages too.)
    mr "${@:-"-qj"}" run sh -c '! hg in --color=always'
}

# As above, but for "hg out".
mr_hg_out () {
    mr "${@:-"-qj"}" run sh -c '! hg out --color=always'
}

# Find and mr register all Mercurial repositories below the given path(s).
mr_reg_all () {
    find "${@:-'.'}" -type d -name .hg -o -name .git -prune -print0 | xargs -0 dirname --zero | xargs -0 -n1 mr register
}


# See https://bitbucket.org/snippets/pjdelport/5oxe/mercurial-common-hgignore-patterns

hgignore_python () {
cat <<EOF
syntax: glob

# Python bytecode
*.pyc
*.pyo
__pycache__

# distutils / setuptools
*.egg
*.egg-info/
.eggs/
build/
dist/

# Tox
.tox
EOF
}

hgignore_android () {
cat <<EOF
syntax: glob

# Local-only
local.properties

# Build output
.gradle/
build/

# Android Studio
*.iml
.idea/

# Gradle Wrapper
gradle/wrapper
gradlew
gradlew.bat
EOF
}
