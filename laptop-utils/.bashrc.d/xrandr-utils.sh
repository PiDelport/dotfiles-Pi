# xrandr shortcuts for display wrangling.
#
# Calibration links:
#
# http://www.lagom.nl/lcd-test/contrast.php
# http://www.lagom.nl/lcd-test/gamma_calibration.php
# http://www.lagom.nl/lcd-test/black.php
# http://www.lagom.nl/lcd-test/white.php
#
# https://en.wikipedia.org/wiki/File:Gamma_correction_test_picture.png


# Helper for setting or showing xrandr gamma.
___xrandr_gamma () {
    local hint_text="$(xrandr --verbose | grep '^.*connected\|^	Gamma:')"
    local usage=$'Usage: ___xrandr_gamma OUTPUT [VALUE]\n'"$hint_text"

    local output="${1:?"$usage"}"
    local value="${2}"

    if [ -n "$value" ]; then
        xrandr --output "$output" --gamma "$value:$value:$value"
    else
        echo "$hint_text"
    fi
}

# Helper for setting or showing xrandr properties.
___xrandr_prop () {
    local hint_text="$(xrandr --properties | grep '^.*connected\|^	[^	]*:')"
    local usage=$'Usage: ___xrandr_prop OUTPUT PROPERTY [VALUE]\n'"$hint_text"

    local output="${1:?"$usage"}"
    local property="${2:?"$usage"}"
    local value="${3}"

    if [ -n "$value" ]; then
        xrandr --output "$output" --set "$property" "$value"
    else
        xrandr --properties | grep '^.*connected\|^	'"$property"  # XXX: No regex escaping.
    fi
}


# Gamma shortcuts.
___xrandr_gamma_lvds () { ___xrandr_gamma LVDS1 "$@"; }
___xrandr_gamma_hdmi () { ___xrandr_gamma HDMI1 "$@"; }

# Useful settings for home (as of early 2019):
___xrandr_gamma_calibrated () {
    ___xrandr_gamma_lvds 1.3  # Ideapad Z570 onboard display.
    ___xrandr_gamma_hdmi 1.75  # Hisense D36 TV, with contrast low (10–30, default 50).
}

# For adjusting the Ideapad Z570 onboard display brightness.
# (Because Ubuntu doesn't detect the backlight right?)
___xrandr_backlight () { ___xrandr_prop LVDS1 Backlight "$@"; }

