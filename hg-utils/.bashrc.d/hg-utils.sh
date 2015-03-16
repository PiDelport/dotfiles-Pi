# Mercurial utilities

# Shortcuts for the myrepos <http://myrepos.branchable.com/> tool:

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
