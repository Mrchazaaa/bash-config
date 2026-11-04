# Resolve the default configuration when this file is sourced.
STARTTMUX_CONFIG="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/sessions.json"

_starttmux_read_sessions() {
    if ! command -v jq >/dev/null 2>&1; then
        printf 'starttmux requires jq to read its JSON configuration.\n' >&2
        return 1
    fi

    # Validate before creating sessions, then emit one name:directory per line.
    jq -er '
        if type == "array" and length > 0 and all(.[];
            type == "object" and
            (.name | type == "string" and test("^[A-Za-z0-9_-]+$")) and
            (.directory | type == "string" and length > 0 and (test("[\r\n]") | not))
        ) then
            .[] | .name + ":" + .directory
        else
            error("Expected a nonempty array of objects with name and directory strings; names may contain letters, numbers, underscores, and hyphens")
        end
    ' "$1"
}

# Accept parsed name:directory records as separate arguments.
_starttmux_sessions() {
    if [ "$#" -eq 0 ]; then
        printf 'At least one session is required.\n' >&2
        return 1
    fi
    local entry name dir target="${1%%:*}"
    for entry in "$@"; do
        name="${entry%%:*}"
        dir="${entry#*:}"
        # Expand home-directory prefixes without evaluating shell code.
        case "$dir" in
            '~'|'$HOME') dir="$HOME" ;;
            '~/'*) dir="$HOME/${dir:2}" ;;
            '$HOME/'*) dir="$HOME/${dir:6}" ;;
        esac
        tmux has-session -t "=$name" 2>/dev/null || tmux new-session -d -s "$name" -c "$dir" || return
    done
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "=$target"
    else
        tmux attach -t "=$target"
    fi
}

starttmux() {
    if [ "$#" -gt 1 ]; then
        printf 'Usage: starttmux [sessions.json]\n' >&2
        return 1
    fi

    local data
    data=$(_starttmux_read_sessions "${1:-$STARTTMUX_CONFIG}") || return 1
    local sessions=()
    mapfile -t sessions <<< "$data"
    _starttmux_sessions "${sessions[@]}"
}
