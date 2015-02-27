# Convenience commands for working with SSH multiplexing master processes.
#
# Note: This requires a configured ControlPath.
#
# (For more details, see the ssh_config manual page's ControlMaster section.)

# Check or start a master process.
sshmaster () {
    : ${@:?"Usage: sshmaster [user@]hostname"}
    if ! ssh -O check "$@"; then
        ssh -fMN "$@"
        # Check again, to display the status.
        ssh -O check "$@"
    fi
}

# Stop an existing master process.
sshmaster_exit () {
    : ${@:?"Usage: sshmaster_exit [user@]hostname"}
    ssh -O exit "$@"
}

# Shortcuts for Bitbucket and GitHub.
sshbb () { sshmaster hg@bitbucket.org; }
sshgh () { sshmaster git@github.com; }
sshbb_exit () { sshmaster_exit hg@bitbucket.org; }
sshgh_exit () { sshmaster_exit git@github.com; }
