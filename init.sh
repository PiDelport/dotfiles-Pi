# Helper script: Set up a new installation

# bash-rc-dir
grep -qF '. ~/.bashrc.d/init' ~/.bashrc || {
    echo 'Adding to ~/.bashrc'
    >>~/.bashrc echo
    >>~/.bashrc echo '. ~/.bashrc.d/init'
}

# ssh-config-dir
~/.ssh/config-update.sh

# hg-common
grep -qF '~/.hgrc.common' ~/.hgrc || {
    echo 'Adding to ~/.hgrc'
    >>~/.hgrc echo '~/.hgrc.common'
}

# git-common
grep -qF 'path = ~/.gitconfig.common' ~/.gitconfig || {
    echo 'Adding to ~/.gitconfig'
    >>~/.gitconfig echo '[include]'
    >>~/.gitconfig echo 'path = ~/.gitconfig.common'
}

