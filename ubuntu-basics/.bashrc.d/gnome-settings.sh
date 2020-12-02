# Set various gsettings preferences of mine.
___gsettings_set () {
    # See xkeyboard-config(7)
    #
    # compose:menu      Compose key: Menu
    # compose:prsc      Compose key: Print Screen
    # compose:ralt      Compose key: Right Alt
    # caps:escape       Make Caps Lock an additional Esc
    # numpad:microsoft  Make Shift work with numpad navigation keys
    #
    gsettings set org.gnome.desktop.input-sources xkb-options "['compose:menu', 'compose:prsc', 'compose:ralt', 'caps:escape', 'numpad:microsoft']"

    # Add Dvorak keyboard layout
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+dvorak'), ('xkb', 'us')]"

    # Sensible workspace-scoped Alt-Tab
    gsettings set org.gnome.shell.app-switcher current-workspace-only 'true'

    # Natural scrolling for mouse
    gsettings set org.gnome.desktop.peripherals.mouse natural-scroll 'true'

    # Include date & week numbers in the top toolbar clock & calendar.
    gsettings set org.gnome.desktop.calendar show-weekdate 'true'
    gsettings set org.gnome.desktop.interface clock-format '12h'
    gsettings set org.gnome.desktop.interface clock-show-date 'true'
    gsettings set org.gnome.desktop.interface clock-show-weekday 'true'

    # Enable limited visual bell
    gsettings set org.gnome.desktop.wm.preferences visual-bell 'true'
    gsettings set org.gnome.desktop.wm.preferences visual-bell-type 'frame-flash'

    # Enable Night Light
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled 'true'

}


# Install and enable https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet
___gnome_shell_extension_system_monitor_install () {
    sudo apt install gnome-shell-extension-system-monitor
    gnome-shell-extension-tool -e system-monitor@paradoxxx.zero.gmail.com
}
