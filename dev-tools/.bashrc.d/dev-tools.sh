# Node

___install_node_snap () (
    # XXX 2021-01-26: Use the latest LTS, rather than defaulting to 12.
    sudo snap install node --classic --channel=14/stable
)

if which npm >/dev/null; then
    source <(npm completion)
fi

if which fnm >/dev/null; then
    eval "$(fnm env)"
    eval "$(fnm completions)"
fi

# Docker:

___install_docker-compose () (
    which jq >/dev/null || { echo "Please install jq: sudo apt install jq"; return; }
    set -eo pipefail
    # https://github.com/docker/compose/releases/latest
    local release="$(curl --fail --no-progress-meter https://api.github.com/repos/docker/compose/releases/latest | jq --raw-output .tag_name)"
    local url="https://github.com/docker/compose/releases/download/${release}/docker-compose-$(uname --kernel-name)-$(uname --machine)"
    cd ~/.local/bin

    # NOTE: Take some extra care to save and compare ETags, because of docker-compose's size.
    echo "Downloading ${url}"
    curl --fail --location --remote-time --progress-bar \
        --etag-compare <(test -f 'docker-compose.etag' && cat 'docker-compose.etag') --etag-save 'docker-compose.etag' \
        --output 'docker-compose' "${url}"
    chmod +x 'docker-compose'
    echo "Installed ~/.local/bin/docker-compose"
)

___install_docker-compose_completion () (
    # https://docs.docker.com/compose/completion/
    set -eo pipefail

    # NOTE: Completion seems to be removed from the repository of docker-compose v2; docs still point to 1.29.2?
    url='https://github.com/docker/compose/raw/1.29.2/contrib/completion/bash/docker-compose'
    file=~/.local/share/bash-completion/completions/docker-compose
    echo "Downloading ${url}"
    curl --fail --location --remote-time --progress-bar --create-dirs --output "${file}" "${url}"
    echo "Installed ${file}"
)

# https://github.com/abhinav/restack
___install_git_restack () (
    which jq >/dev/null || { echo "Please install jq: sudo apt install jq"; return; }
    set -eo pipefail
    # https://github.com/abhinav/restack/releases
    local release="$(curl --fail --no-progress-meter https://api.github.com/repos/abhinav/restack/releases/latest | jq --raw-output .tag_name)"
    local url="https://github.com/abhinav/restack/releases/download/${release}/restack_${release#v}_$(uname --kernel-name)_$(uname --machine).tar.gz"
    cd ~/.local/bin
    echo "Downloading ${url}"
    curl --fail --location --progress-bar "$url" | tar --extract --gzip restack
    echo "Installed ~/.local/bin/restack"
)

# GitHub CLI: https://github.com/cli/cli/blob/trunk/docs/install_linux.md

___install_gh () {
    sudo -n apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    sudo -n apt-add-repository https://cli.github.com/packages
    sudo -n apt install -y gh
}

if which gh >/dev/null; then
    source <(gh completion --shell bash)
fi

# Rust:

# cargo make: https://github.com/sagiegurari/cargo-make#shell-completion
___install_makers_completion () {
    local url="https://github.com/sagiegurari/cargo-make/raw/master/extra/shell/makers-completion.bash"
    local file=~/.local/share/bash-completion/completions/makers
    echo "Downloading ${url}"
    curl --fail --location --progress-bar --create-dirs --output "${file}" "${url}"
    echo "Installed ${file}"
}

___install_pipx () {
    python3 -m pip install --user pipx
    echo 'may need: sudo apt install python3-venv'
}

if which pipx >/dev/null; then
    source <(register-python-argcomplete pipx)
fi

___install_aws () (
    sudo -v
    # https://github.com/aws/aws-cli/tree/v2#installation
    cd ~/Downloads
    curl -LR https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
    unzip awscli-exe-linux-x86_64.zip
    sudo aws/install
    echo 'complete -C aws_completer aws' | sudo tee /usr/local/share/bash-completion/completions/aws
)

# Elm:

# https://github.com/elm/compiler/blob/master/installers/linux/README.md
___install_elm () (
    cd ~/.local/bin
    curl -L -o elm.gz 'https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz'
    gunzip elm.gz
    chmod +x elm
)
