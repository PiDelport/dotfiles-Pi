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
    set -exo pipefail
    # https://github.com/docker/compose/releases/latest
    local release="$(curl -sS https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)"
    local kernel="$(uname -s)"
    local machine="$(uname -m)"
    local url="https://github.com/docker/compose/releases/download/${release}/docker-compose-${kernel}-${machine}"
    cd ~/.local/bin
    curl -LRC- -o docker-compose "$url"
    chmod +x docker-compose

    curl -L "https://raw.githubusercontent.com/docker/compose/${release}/contrib/completion/bash/docker-compose" -o ~/.bashrc.d/bash-completion-docker-compose.sh
)

# https://github.com/abhinav/restack
___install_git_restack () (
    which jq >/dev/null || { echo "Please install jq: sudo apt install jq"; return; }
    set -exo pipefail
    # https://github.com/abhinav/restack/releases
    local release="$(curl -sS https://api.github.com/repos/abhinav/restack/releases/latest | jq -r .tag_name)"
    local url="https://github.com/abhinav/restack/releases/download/${release}/restack_${release#v}_$(uname -s)_$(uname -m).tar.gz"
    cd ~/.local/bin
    curl -L "$url" | tar -xz restack
)

# GitHub CLI: https://github.com/cli/cli/blob/trunk/docs/install_linux.md

___install_gh () {
    sudo -n apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    sudo -n apt-add-repository https://cli.github.com/packages
    sudo -n apt install -y gh

}

if which gh >/dev/null; then
    #eval "$(gh completion -s bash)"
    source <(gh completion -s bash)
fi

# Rust:

# cargo make: https://github.com/sagiegurari/cargo-make#shell-completion
___install_makers_completion () {
    curl -LR https://github.com/sagiegurari/cargo-make/raw/master/extra/shell/makers-completion.bash -o ~/.local/share/bash-completion/completions/makers
}

___install_pipx () {
    python3 -m pip install --user pipx
    echo 'may need: sudo apt install python3-venv'
}

if which pipx >/dev/null; then
    source <(register-python-argcomplete pipx)
fi
