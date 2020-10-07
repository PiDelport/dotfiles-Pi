
# Set various gsettings preferences of mine.
___gsettings_set () {
    # See xkeyboard-config(7)
    #
    # compose:menu      Make Menu key Compose
    # caps:escape       Make Caps Lock an additional Esc
    # numpad:microsoft  Make Shift work with numpad navigation keys
    #
    gsettings set org.gnome.desktop.input-sources xkb-options "['compose:menu', 'caps:escape', 'numpad:microsoft']"

    # Sensible workspace-scoped Alt-Tab
    gsettings set org.gnome.shell.app-switcher current-workspace-only 'true'

    # Include date & week numbers in the top toolbar clock & calendar.
    gsettings set org.gnome.desktop.calendar show-weekdate 'true'
    gsettings set org.gnome.desktop.interface clock-show-date 'true'

    # Enable limited visual bell
    gsettings set org.gnome.desktop.wm.preferences visual-bell 'true'
    gsettings set org.gnome.desktop.wm.preferences visual-bell-type 'frame-flash'

}


# Install and enable https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet
___gnome_shell_extension_system_monitor_install () {
    sudo apt install gnome-shell-extension-system-monitor
    gnome-shell-extension-tool -e system-monitor@paradoxxx.zero.gmail.com
}
