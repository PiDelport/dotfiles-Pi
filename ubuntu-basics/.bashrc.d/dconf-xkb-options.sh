___dconf_xkb_options_read () {
    dconf read /org/gnome/desktop/input-sources/xkb-options
}

___dconf_xkb_options_write () {
    dconf write /org/gnome/desktop/input-sources/xkb-options "$@"
}

___dconf_xkb_options_help () {
cat <<EOF
___dconf_xkb_options_write "['compose:menu', 'caps:escape', 'numpad:microsoft']"
EOF
}
