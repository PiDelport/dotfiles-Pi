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
                docker_args+=(--volume /var/run/docker.sock:/var/run/docker.sock) ;;
            *)
                echo "rundocker: unrecognised RUNDOCKER_WITH value: ${tag@Q}"; return 1;;
        esac
    done

    docker run -i --rm "${docker_args[@]}" "$@"
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

dotenv-linter () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker dotenvlinter/dotenv-linter "$@";
}

hadolint () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker hadolint/hadolint hadolint "$@";
}

# https://github.com/RedCoolBeans/dockerlint
dockerlint () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker redcoolbeans/dockerlint "$@";
}

dockerfile_lint () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker projectatomic/dockerfile-lint dockerfile_lint "$@";
}

dockerfilelint () {
    RUNDOCKER_WITH='ro nonet user cwd' rundocker replicated/dockerfilelint "$@";
}

dockfmt () {
    RUNDOCKER_WITH='nonet user cwd' rundocker jess/dockfmt "$@";
}

structurizr () {
    # https://structurizr.com/help/lite
    echo "structurizr will listen at: http://localhost:8080/"
    rundocker --volume "$PWD":/usr/local/structurizr --publish '127.0.0.1:8080:8080' structurizr/lite;
}

shellcheck () {
    # https://github.com/koalaman/shellcheck
    RUNDOCKER_WITH='ro nonet user cwd' rundocker koalaman/shellcheck "$@"
}
