# Experimenting with zswap
#
# Also note:
#
# - sudo sysctl vm.swappiness=100
#
# - https://help.ubuntu.com/community/SwapFaq#How_do_I_add_a_swap_file.3F

___zswap_on () {
    sudo -v

    #sudo sh -c "echo >'/sys/module/zswap/parameters/max_pool_percent' 50"
    sudo sh -c "echo >'/sys/module/zswap/parameters/compressor' lz4"
    sudo sh -c "echo >'/sys/module/zswap/parameters/zpool' z3fold"

    sudo sh -c "echo >'/sys/module/zswap/parameters/enabled' 1"
}

___zswap_show () {
    grep . /sys/module/zswap/parameters/*
}

___zswap_status () {
    sudo -v

    stored_pages="$(sudo cat '/sys/kernel/debug/zswap/stored_pages')"
    pool_total_size="$(sudo cat '/sys/kernel/debug/zswap/pool_total_size')"

    echo "stored_pages = $(( "${stored_pages}" * 2**12 / 2**20)) MiB, pool_total_size = $(( "${pool_total_size}" / 2**20)) MiB"
}

___zswap_status_loop () {
    echo "$(date '+%c') - $(___zswap_status)"
    while sleep "${1:-1}"; do
        echo "$(date '+%c') - $(___zswap_status)"
    done
}
