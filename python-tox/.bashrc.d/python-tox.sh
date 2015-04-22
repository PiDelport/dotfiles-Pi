# Tox-related helpers.

# Create a symlinked .tox directory under ~/cache/tox
cachetox () {
    local dir=~/.cache/tox/"$(basename "$PWD")"
    if test -e "$dir"; then
        echo "$dir exists!"
    elif test -e ".tox"; then
        echo ".tox exists!"
    else
        mkdir -p "$dir" && ln -s "$dir" .tox
    fi
}

# Migrate an existing .tox directory to ~/cache/tox
cachetox_convert () {
    mv --no-target-directory .tox .tox_temp && cachetox && mv .tox_temp/* .tox && rmdir .tox_temp
}
