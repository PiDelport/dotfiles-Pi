# Docker utilities


# Remove exited containers and dangling images.
___docker_cleanup () {
    docker rm -v $(docker ps -q -f status=exited)
    docker rmi $(docker images -q -f dangling=true)
}
