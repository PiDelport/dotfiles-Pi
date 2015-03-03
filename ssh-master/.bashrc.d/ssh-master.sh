# Convenience commands for working with SSH multiplexing master processes.
#
# Note: This requires a configured ControlPath.
#
# (For more details, see the ssh_config manual page's ControlMaster section.)

# Check or start a master process in the background.
sshmaster () {
    : ${@:?"Usage: sshmaster [user@]hostname"}
    if ! ssh -O check "$@"; then
        ssh -fMN "$@"
        # Check again, to display the status.
        ssh -O check "$@"
    fi
}

# Stop an existing background master process.
sshmaster_exit () {
    : ${@:?"Usage: sshmaster_exit [user@]hostname"}
    ssh -O exit "$@"
}

# Start a looped foreground master processes. This is intended to maintain a
# persistent session to servers with relatively short connection timeouts.
sshmaster_loop () {
    while true; do
        # Make the loop's activity visible.
        echo "$(date) ssh -MN $@"
        ssh -MN "$@"
        # SSH exits with code 255 for connection errors: loop for that, exit
        # for anything else.
        if test "$?" -ne 255; then break; fi
    done
}

# Shortcuts for Bitbucket and GitHub.
sshbb () { sshmaster hg@bitbucket.org; }
sshgh () { sshmaster git@github.com; }
sshbb_loop () { sshmaster_loop hg@bitbucket.org; }
sshgh_loop () { sshmaster_loop git@github.com; }
sshbb_exit () { sshmaster_exit hg@bitbucket.org; }
sshgh_exit () { sshmaster_exit git@github.com; }
