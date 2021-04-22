[ -n "$(command -v pfetch)" ] && pfetch

[ -n "$(command -v fortune)" ] && fortune -s 2>/dev/null || {
    while true; do
        fortune="$(fortune 2>/dev/null)"
        [ "$(echo "$fortune" | wc -m)" -le 160 ] && break
    done
    printf '%s\n' "$fortune"
}
