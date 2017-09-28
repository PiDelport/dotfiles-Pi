# Mercurial utilities

# See https://bitbucket.org/snippets/pjdelport/5oxe/mercurial-common-hgignore-patterns

hgignore_python () {
cat <<EOF
syntax: glob

# Python bytecode
*.pyc
*.pyo
__pycache__

# setuptools-generated
*.egg-info/
.eggs/
build/
dist/

# Tox working directory
.tox

# pytest cache directory
.cache/
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


# Local .hg/hgrc snippets

hgrc_username () {
cat <<EOF
[ui]
username = Pi Delport <pjdelport@gmail.com>
EOF
}

hgrc_flake8 () {
cat <<EOF
[hooks]
pretxncommit.flake8 = flake8
EOF
}


# Find and list Mercurial repos under a path
___hg_find_repos () {
    find "${@:-.}" -type d -name .hg -prune -printf '%h\n'
}

# State summary of all Mercurial repos under a path
___hg_summary () {
    ___hg_find_repos "$@" | (
        while read repo; do
            if hg -R "$repo" path default -q; then
                hg -R "$repo" summary --remote | grep -E '^(commit|update|phase|remote): ' | grep -v 'commit: (clean)\|update: (current)\|remote: (synced)' | xargs --no-run-if-empty echo "$repo:" &
            fi
        done
        wait
    )
}
