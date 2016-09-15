# Docker utilities


# List stale containers, images, and volumes.
___docker_list_stale () {
    docker ps -f status=exited
    echo
    docker images -f dangling=true
    echo
    docker volume ls -f dangling=true
    echo
}


# Remove stale containers, images, and volumes.
___docker_cleanup_stale () {
    docker rm -v $(docker ps -q -f status=exited)
    docker rmi $(docker images -q -f dangling=true)
    docker volume rm $(docker volume ls -q -f dangling=true)
}
