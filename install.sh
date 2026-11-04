#!/usr/bin/env bash
set -euo pipefail

main() {
    local repository='https://github.com/Mrchazaaa/bash-config.git'
    local destination="${HOME:?HOME must be set}/.config/bash-config"
    local bashrc="$HOME/.bashrc"
    local loader='source "$HOME/.config/bash-config/init.sh"'

    if ! command -v git >/dev/null 2>&1; then
        printf 'Error: git is required. Install it and run this installer again.\n' >&2
        return 1
    fi

    if [[ -e "$destination" || -L "$destination" ]]; then
        if [[ ! -d "$destination/.git" ]] ||
            [[ "$(git -C "$destination" remote get-url origin)" != "$repository" ]] ||
            [[ ! -f "$destination/init.sh" ]]; then
            printf 'Error: %s already exists and is not the expected bash-config checkout.\n' "$destination" >&2
            return 1
        fi
        printf 'Using existing checkout at %s\n' "$destination"
    else
        mkdir -p "$HOME/.config"
        git clone "$repository" "$destination"
    fi

    if [[ ! -f "$bashrc" ]] || ! grep -Fqx -- "$loader" "$bashrc"; then
        printf '\n%s\n' "$loader" >> "$bashrc"
        printf 'Added bash-config to %s\n' "$bashrc"
    else
        printf 'bash-config is already configured in %s\n' "$bashrc"
    fi

    printf 'Installation complete. Open a new Bash shell or run: source ~/.bashrc\n'
}

main "$@"
