# Sync directory with Dropbox mirror.
___sync () {
    local source="${1:-$PWD}"
    local target="$HOME/Dropbox/$(realpath --relative-to="$HOME" "$source")"
    if test -f "$source"; then
        # If source is a file, assume we just want to sync the file.
        meld "$source" "$target"
    elif test -d "$target"; then
        if test -d "$target/.git"; then
            echo "git -C ${target@Q} pull --ff-only"
            git -C "$target" pull --ff-only || return $?
        fi
        meld "$source" "$target"
    elif test -e "$target"; then
        echo "${target@Q} already exists, but isn't a directory?"
    else
        echo "${target@Q} does not exist."
        echo
        echo "To create it, run:"
        echo
        echo "mkdir -p ${target@Q}"
        echo
        if test -d "$source/.git" && local origin_url=$(git remote get-url origin); then
            echo
            echo "Or:"
            echo
            echo "git clone ${origin_url@Q} ${target@Q}"
        fi
    fi
}

# Quickly jump to the synced Dropbox mirror directory.
___cd_sync () {
    local target="$HOME/Dropbox${PWD#"$HOME"}"
    cd "$target"
}
