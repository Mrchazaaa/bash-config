starttmux() {
    local sessions=(
        "tm2:$HOME/workspace/tm2-save-tool"
        "sfa:$HOME/workspace/sfa"
        "personal-site:$HOME/workspace/personal-site"
        "vim-config:$HOME/.config/nvim"
        "tmux-config:$HOME/.config/tmux/tmux-config"
    )
    local entry name dir
    for entry in "${sessions[@]}"; do
        name="${entry%%:*}"
        dir="${entry#*:}"
        tmux has-session -t "$name" 2>/dev/null || tmux new-session -d -s "$name" -c "$dir"
    done
    if [ -n "$TMUX" ]; then
        tmux switch-client -t tm2
    else
        tmux attach -t tm2
    fi
}
