# Run a transient docker image.
#
# Accepts a list of tag values in RUNDOCKER_WITH, as a shortcut to setting
# various docker command-line options.
#
# (This is meant to be used by command definitions: see below.)
#
rundocker () {
    local tag
    local -a docker_args=()
    for tag in $RUNDOCKER_WITH; do
        case "$tag" in
            ro)
                docker_args+=(--read-only) ;;
            nonet)
                docker_args+=(--network none) ;;
            user)
                docker_args+=(--user "$(id -u):$(id -g)") ;;
            cwd)
                docker_args+=(--volume "$PWD":/run/pwd --workdir /run/pwd) ;;
            dockerd)
                docker_args+=(--volume /var/run/docker.sock:/var/run/docker.sock) ;;
            *)
                echo "rundocker: unrecognised RUNDOCKER_WITH value: ${tag@Q}"; return 1;;
        esac
    done

    docker run -it --rm "${docker_args[@]}" "$@"
}

# rundocker completion: complete Docker image names.
# Depends on Docker's completion: see /usr/share/bash-completion/completions/docker (or similar)
_rundocker () {
    # Make sure Docker's completion is loaded, or abort.
    __load_completion docker || return "$?"
    # Set some context, like the _docker completion function does.
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword
    # Jump straight to completing images.
    __docker_complete_images --repo --tag --id
}
complete -F _rundocker rundocker


# Command definitions:

dotenv-linter () { RUNDOCKER_WITH='ro nonet user cwd' rundocker dotenvlinter/dotenv-linter "$@"; }
