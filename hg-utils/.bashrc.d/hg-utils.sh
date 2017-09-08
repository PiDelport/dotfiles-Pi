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
