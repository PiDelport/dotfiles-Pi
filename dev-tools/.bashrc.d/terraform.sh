# Terraform-related tooling

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
