# Helpers for managing a system in terms of explicitly wanted packages.
#
# The idea is to use the "wanted" user tag as a separate layer on top of
# Aptitude's manual/automatic installation flag. This allows packages to be
# installed and removed ad hoc, and only later synchronized back to the wanted
# state.


# Mark or unmark packages as wanted.
___aptitude_want () {
    sudo aptitude add-user-tag wanted "$@"
}
___aptitude_remove_want () {
    sudo aptitude remove-user-tag wanted "$@"
}


# Schedule wanted packages for installation.
___aptitude_install_wanted () {
    sudo aptitude --schedule-only install '?user-tag(wanted)'
}

# Mark everything except the wanted packages as automatically-installed.
___aptitude_markauto () {
    sudo aptitude --schedule-only markauto '~i !?user-tag(wanted)'
}


# Synchronize the installed packages with the wanted packages.
# This installs missing packages, and removes unnecessary ones.
#
# Note that this will only schedule the actions, and launch interactive
# Aptitude session to review and apply (or cancel) the pending actions.
#
___aptitude_sync_wanted () {
    ___aptitude_install_wanted
    ___aptitude_markauto
    sudo aptitude
}
