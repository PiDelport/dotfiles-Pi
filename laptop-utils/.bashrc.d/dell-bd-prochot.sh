# Helpers to deal with Dell laptops throttling CPU with non-OEM power supplies.
#
# Background:
#
# - https://superuser.com/questions/1160735/stop-dell-from-throttling-cpu-with-power-adapter
# - https://en.wikipedia.org/wiki/Model-specific_register
#
# Requires msr-tools:
#
#       sudo apt install msr-tools

___bd_prochot () (
    local -
    set -euo pipefail
    sudo -v
    local msr="0x$(sudo rdmsr 0x1FC)"
    local msr_bd_prochot_flag="$(( "${msr}" & 0x1 ))"
    local msr_bd_prochot_disabled="$(printf '0x%x\n' "$(( "${msr}" & 0xFFFFFFFE ))")"
    local msr_bd_prochot_enabled="$(printf '0x%x\n' "$(( "${msr}" | 0x1 ))")"
    echo "Current MSR: ${msr} (BD PROCHOT ${msr_bd_prochot_flag})"
    echo
    echo "To disable BD PROCHOT:"
    echo "sudo wrmsr 0x1FC ${msr_bd_prochot_disabled}"
    echo
    echo "To enable BD PROCHOT:"
    echo "sudo wrmsr 0x1FC ${msr_bd_prochot_enabled}"
    echo
)

___disable_bd_prochot () (
    local -
    set -euo pipefail
    sudo -v
    local msr="0x$(sudo rdmsr 0x1FC)"
    local msr_bd_prochot_disabled="$(printf '0x%x\n' "$(( "${msr}" & 0xFFFFFFFE ))")"
    sudo wrmsr 0x1FC "${msr_bd_prochot_disabled}"
    echo "Disabled BD PROCHOT; MSR value: ${msr} → ${msr_bd_prochot_disabled}"
)

# As a dash-compatible one-liner for /etc/rc./local:
#
# wrmsr 0x1FC "$(printf '0x%x\n' "$(( 0x$(rdmsr 0x1FC) & 0xFFFFFFFE ))")"
