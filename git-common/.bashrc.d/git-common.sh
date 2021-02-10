alias g=git
# Re-use the git command's completion.
# See /usr/share/bash-completion/completions/git (or similar)
__load_completion git && __git_complete g __git_main


___git_pjdelport@gmail.com () {
    git config --local user.name 'Pi Delport'
    git config --local user.email 'pjdelport@gmail.com'
}
