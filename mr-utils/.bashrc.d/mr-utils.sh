# Shortcuts for the myrepos <http://myrepos.branchable.com/> tool.

# Run "hg in", showing changes only.
#
# Any arguments replace the default "-qj" options passed to mr, so that for
# example "mr_hg_in -j" will show mr's full, non-quiet output.
mr_hg_in () {
    # Note: "hg in" exits with success for incoming changes and failure for no
    # changes, so to get "mr -q" to show the former instead of the latter, we
    # have to negate the exit code.
    #
    # ("hg in" will also simply fail for non-hg repositories, but the negation
    # will make "mr -q" suppress those error messages too.)
    mr "${@:-"-qj"}" run sh -c '! hg in --color=always'
}

# As above, but for "hg out".
mr_hg_out () {
    mr "${@:-"-qj"}" run sh -c '! hg out --color=always'
}

# As above, but for git.
#
# Note that these git commands don't give a useful exit status, so we use grep
# to get a status based on the presence or absence of command output, instead.
#
mr_git_in () {
    mr "${@:-"-qj"}" run sh -c '! git fetch --all --dry-run 2>&1 | grep -v "^Fetching " | grep .'
}
mr_git_out () {
    mr "${@:-"-qj"}" run sh -c '! git push --all --dry-run 2>&1 | grep -v "^Everything up-to-date$" | grep .'
}

# Find and "mr register" all hg/git repositories below the given path(s).
mr_reg_all () {
    find "${@:-.}" -type d '(' -name .hg -o -name .git ')' -prune -print0 | xargs -0 dirname --zero | xargs -0 -n1 mr register
}
