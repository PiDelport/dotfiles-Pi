# Run a transient docker image.
#
# Accepts a list of tag values in RUNDOCKER_WITH, as a shortcut to setting
# various docker command-line options.
#
# (This is meant to be used by command definitions: see below.)
#
rundocker () {
    if test ! 0 -lt "$#"; then
        echo "Usage: RUNDOCKER_WITH='ro nonet user cwd' rundocker [docker run args …]"
        echo
        echo 'RUNDOCKER_WITH options:'
        echo '  ro       --read-only'
        echo '  nonet    --network none'
        echo '  user     --user "$(id -u):$(id -g)"'
        echo '  cwd      --volume "$PWD":/run/pwd --workdir /run/pwd'
        echo '  dockerd  --volume /var/run/docker.sock:/var/run/docker.sock'
        return 1
    fi

    local -a docker_args=()

    # --tty is incompatible with redirecting the docker client standard input:
    # only add it if the standard input is a TTY.
    test -t 0 && docker_args+=(--tty)

    local tag
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
                docker_args+=(
                    --volume /var/run/docker.sock:/var/run/docker.sock
                    # Run as the the "docker" group, for non-root compatibility
                    --group-add "$(getent group docker | cut --delimiter ':' --field 3)"
                );;
            *)
                echo "rundocker: unrecognised RUNDOCKER_WITH value: ${tag@Q}"; return 1;;
        esac
    done

    docker run -i --rm "${docker_args[@]}" "$@"
}

# rundocker completion: complete Docker image names.
# Depends on Docker's completion: see /usr/share/bash-completion/completions/docker (or similar)
_complete_docker_images () {
    # Make sure Docker's completion is loaded, or abort.
    __load_completion docker || return "$?"
    # Set some context, like the _docker completion function does.
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword
    # Jump straight to completing images.
    __docker_complete_images --repo --tag --id
}
complete -F _complete_docker_images rundocker

# Command definitions:

docker-dive () {
    # docker-dive build
    RUNDOCKER_WITH='nonet user cwd dockerd' rundocker --env DOCKER_BUILDKIT wagoodman/dive "$@"
}
complete -F _complete_docker_images docker-dive

dotenv-linter () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker dotenvlinter/dotenv-linter "$@"
}

hadolint () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker hadolint/hadolint hadolint "$@"
}

# https://github.com/RedCoolBeans/dockerlint
dockerlint () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker redcoolbeans/dockerlint "$@"
}

dockerfile_lint () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker projectatomic/dockerfile-lint dockerfile_lint "$@"
}

dockerfilelint () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker replicated/dockerfilelint "$@"
}

dockfmt () {
    RUNDOCKER_WITH='nonet user cwd' rundocker jess/dockfmt "$@"
}

structurizr () {
    # https://structurizr.com/help/lite
    echo "structurizr will listen at: http://localhost:8080/"
    rundocker --volume "$PWD":/usr/local/structurizr --publish '127.0.0.1:8080:8080' structurizr/lite
}

shellcheck () {
    # https://github.com/koalaman/shellcheck
    RUNDOCKER_WITH='ro nonet user cwd' rundocker koalaman/shellcheck "$@"
}

which fzf >/dev/null || fzf () {
    # https://github.com/junegunn/fzf
    # https://github.com/backplane/conex/tree/main/fzf

    # NOTE: To support piped input like "ls | fzf", we can't use Docker's "--tty" option,
    # but we *can* manually bind-mount the host pseudo-terminal where fzf will look for it.
    #
    # To do this, we look up the terminal attached to standard error.
    # This matches what fzf implements here:
    #
    # - openTtyIn(): https://github.com/junegunn/fzf/blob/0.30.0/src/tui/light_unix.go#L50
    # - ttyname(): https://github.com/junegunn/fzf/blob/0.30.0/src/tui/ttyname_unix.go#L13
    #
    # NOTE: We do this only when standard input is *not* a terminal,
    # to prevent conflicting with rundocker's "--tty".

    local -a tty_volume=()
    test -t 0 || tty_volume+=(--volume "$(readlink '/proc/self/fd/2')":/dev/tty)

    RUNDOCKER_WITH='ro nonet user cwd' rundocker "${tty_volume[@]}" \
        --env FZF_DEFAULT_COMMAND \
        --env FZF_DEFAULT_OPTS \
         backplane/fzf "$@"
}
