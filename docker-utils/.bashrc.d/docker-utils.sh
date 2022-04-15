# Docker utilities


# List stale containers, images, and volumes.
___docker_stale_list () {
    docker ps -f status=exited
    echo
    docker images -f dangling=true
    echo
}
___docker_stale_list_volumes () {
    docker volume ls -f dangling=true
}


# Remove stale containers, images, and volumes.
___docker_stale_cleanup () {
    docker rm -v $(docker ps -q -f status=exited)
    docker rmi $(docker images -q -f dangling=true)
}
___docker_stale_cleanup_volumes () {
    docker volume rm $(docker volume ls -q -f dangling=true)
}


# Show a filesystem manifest for an image.
___docker_image_manifest () {
    local usage="Usage: ___docker_image_manifest IMAGE"
    local image="${1:?"$usage"}"

    local container="$(docker container create "$image")"
    docker container export "$container" | tar -tv
    docker container rm "$container" >/dev/null
}

# XXX: Old / alternative version, using find.
# Not all images will support this, but it might be useful if the container export
___docker_image_manifest_find () {
    local usage="Usage: ___docker_image_manifest_find IMAGE"
    local image="${1:?"$usage"}"

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
    local usage="Usage: ___docker_image_diff IMAGE1 IMAGE2 [diff command]  (See also: docker history IMAGE)"
    local image1="${1:?"$usage"}"
    local image2="${2:?"$usage"}"
    local diff_command="${3:-diff}"
    $diff_command <(___docker_image_manifest "$image1") <(___docker_image_manifest "$image2")
}


# List all top-level image repository tags.
#
# This works by listing the RepoTags fields for all unique top-level images.
#
___docker_list_image_tags () {
    docker inspect --format "{{range .RepoTags}}{{println .}}{{end}}" $(docker images -q | uniq) | grep -v '^$'
}


# Refresh images by running "docker pull" on all top-level image tags.
#
___docker_refresh_images () {
    for tag in $(___docker_list_image_tags); do
        docker pull "$tag"
    done
}


# Like ___docker_refresh_images, but pull the tags concurrently.
#
# (This messes up the docker command output, but is quicker for many images.)
#
___docker_refresh_images_concurrently () {
    for tag in $(___docker_list_image_tags); do
        docker pull "$tag" &
    done
    wait
}
