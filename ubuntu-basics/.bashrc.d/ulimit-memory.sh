# Soft-limit the default maximum virtual memory to 1 GiB (2^20 KiB)
# to soften the blow from accidental runaway processes.
ulimit -S -v $((2**20))
