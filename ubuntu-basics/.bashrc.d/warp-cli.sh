# Docs:
# https://developers.cloudflare.com/warp-client/setting-up/linux
# https://pkg.cloudflareclient.com/install

___install_warp_cli () {
    set -euxo pipefail
    sudo -v
    curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo apt-key add -
    echo "deb http://pkg.cloudflareclient.com/ $(lsb_release --short --codename) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
    sudo apt update
    sudo apt install cloudflare-warp
}

___warp_register () {
    warp-cli register
}

___warp_always_on () {
    warp-cli enable-always-on
}

___warp_connect () {
    warp-cli connect
}

___warp_disconnect () {
    warp-cli disconnect
}

___warp_status () {
    warp-cli status
}

___warp_stats () {
    warp-cli warp-stats
}

___warp_trace () {
    curl https://www.cloudflare.com/cdn-cgi/trace/
}
