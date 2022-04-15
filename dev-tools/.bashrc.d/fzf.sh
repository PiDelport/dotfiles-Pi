# for fzf: https://github.com/junegunn/fzf

___install_fzf () (
    set -eo pipefail
    which jq >/dev/null || { echo "Please install jq: sudo apt install jq"; return; }
    # https://github.com/junegunn/fzf/releases/latest
    local release="$(curl --fail --no-progress-meter https://api.github.com/repos/junegunn/fzf/releases/latest | jq --raw-output .tag_name)"
    local url="https://github.com/junegunn/fzf/releases/download/${release}/fzf-${release}-linux_amd64.tar.gz"
    cd ~/.local/bin
    curl --fail --location --progress-bar "${url}" | tar --extract --gzip fzf
    echo "Installed ~/.local/bin/fzf"
)

___install_fzf_completion () {
    curl --fail --location --remote-time --progress-bar https://github.com/junegunn/fzf/raw/master/shell/completion.bash --output ~/.bashrc.d/fzf-completion.sh
    echo "Installed ~/.bashrc.d/fzf-completion.sh"
    curl --fail --location --remote-time --progress-bar https://github.com/junegunn/fzf/raw/master/shell/key-bindings.bash --output ~/.bashrc.d/fzf-key-bindings.sh
    echo "Installed ~/.bashrc.d/fzf-key-bindings.sh"
}
