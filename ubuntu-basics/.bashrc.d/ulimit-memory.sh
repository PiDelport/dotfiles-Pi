# Helper: Set the virtual memory limit (in GiB), or show it (in KiB)
___ulimit_virtual () {
    # 1 GiB = 2^20 KiB
    ulimit -S -v ${1:+"$(( $1 * 2**20 ))"}
}
