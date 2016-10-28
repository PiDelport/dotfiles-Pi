# Docker utilities


# List stale containers, images, and volumes.
___docker_stale_list () {
    docker ps -f status=exited
    echo
    docker images -f dangling=true
    echo
    docker volume ls -f dangling=true
    echo
}


# Remove stale containers, images, and volumes.
___docker_stale_cleanup () {
    docker rm -v $(docker ps -q -f status=exited)
    docker rmi $(docker images -q -f dangling=true)
    docker volume rm $(docker volume ls -q -f dangling=true)
}


# Show a filesystem manifest for an image.
___docker_image_manifest () {
    local usage="Usage: ___docker_image_manifest IMAGE"
    local image="${1:?$usage}"

    # This is just a find invocation, so it won't work on images without find.
    #
    # The -mount option prevents find from descending into special mounts such
    # as /proc and /sys, but should still list everything we're interested in.
    #
    docker run --rm "$image" find / -mount
}

# Show a filesystem diff between two images.
#
# The optional third argument overrides the diff command to invoke.
# Examples: 'diff -u', vimdiff, meld
#
___docker_image_diff () {
    local usage="Usage: ___docker_image_diff IMAGE1 IMAGE2 [diff command]"
    local image1="${1:?$usage}"
    local image2="${2:?$usage}"
    local diff_command="${3:-diff}"
    $diff_command <(___docker_image_manifest "$image1" | sort) <(___docker_image_manifest "$image2" | sort)
}
