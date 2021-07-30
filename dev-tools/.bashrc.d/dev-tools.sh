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
    set -ex
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

# Terraform:

if which terraform >/dev/null; then
    complete -C "$(which terraform)" terraform
fi

___install_terraform () (
    set -ex
    local version='0.14.10'
    cd ~/.local/bin
    local zipfile="terraform_${version}_linux_amd64.zip"
    curl -LROC- "https://releases.hashicorp.com/terraform/${version}/${zipfile}"
    unzip "$zipfile"
    rm "$zipfile"
    chmod +x terraform
)

# https://www.terraform.io/docs/configuration/providers.html#third-party-plugins

# https://github.com/mrolla/terraform-provider-circleci/releases
___install_terraform_provider_circleci () (
    set -ex
    local arch='linux-amd64'
    local release='0.1.0'
    local url="https://github.com/mrolla/terraform-provider-circleci/releases/download/${release}/terraform-provider-circleci-${arch}"
    local plugin_name="terraform-provider-circleci_v${release}"
    mkdir -p ~/.terraform.d/plugins
    cd ~/.terraform.d/plugins
    curl -LRC- -o "$plugin_name" "$url"
    chmod +x "$plugin_name"
)

# https://github.com/wata727/tflint
___install_terraform_tflint () (
    set -ex
    local version='0.7.4'
    cd ~/.local/bin
    curl -LRO "https://github.com/wata727/tflint/releases/download/v${version}/tflint_linux_amd64.zip"
    unzip tflint_linux_amd64.zip
    rm tflint_linux_amd64.zip
)

# https://hub.docker.com/

___install_hub_completion () {
    curl -LRC- https://raw.githubusercontent.com/github/hub/master/etc/hub.bash_completion.sh -o ~/.bashrc.d/hub.bash_completion.sh
}


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
