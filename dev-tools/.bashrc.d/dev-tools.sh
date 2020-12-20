# Node

___install_node_snap () (
    sudo snap install node --classic
)

if which npm >/dev/null; then
    source <(npm completion)
fi

# Docker:

___install_docker-compose () (
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
    local version='0.11.13'
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
