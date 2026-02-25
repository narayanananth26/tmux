#!/usr/bin/env bash
# List and search active tmux key bindings.
# Usage:
#   bindings.sh              — interactive fzf picker (or paged list)
#   bindings.sh <pattern>    — grep filter across all tables
#   bindings.sh -t <table>   — restrict to a specific key table
#   bindings.sh -l           — list all available key tables

set -euo pipefail

TABLES=(prefix copy-mode-vi root)

usage() {
    cat <<EOF
Usage: $(basename "$0") [options] [pattern]

Options:
  -t <table>   Filter to a specific key table (prefix, copy-mode-vi, root)
  -l           List all available key tables
  -h           Show this help

Examples:
  $(basename "$0")                    List all bindings interactively
  $(basename "$0") copy               Search for 'copy' across all tables
  $(basename "$0") yank               Search for 'yank'
  $(basename "$0") -t prefix          Show only prefix bindings
  $(basename "$0") -t copy-mode-vi y  Find 'y' binding in copy-mode-vi
EOF
}

list_tables() {
    tmux list-keys | awk '{print $3}' | sort -u
}

get_bindings() {
    local table="$1"
    if [[ -n "$table" ]]; then
        tmux list-keys -T "$table" 2>/dev/null | sed "s/^/[$table] /"
    else
        for t in "${TABLES[@]}"; do
            tmux list-keys -T "$t" 2>/dev/null | sed "s/^/[$t] /"
        done
    fi
}

TABLE=""
PATTERN=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -t) TABLE="$2"; shift 2 ;;
        -l) list_tables; exit 0 ;;
        -h|--help) usage; exit 0 ;;
        *) PATTERN="$1"; shift ;;
    esac
done

OUTPUT="$(get_bindings "$TABLE")"

if [[ -z "$OUTPUT" ]]; then
    echo "No bindings found${TABLE:+ for table '$TABLE'}."
    exit 1
fi

if [[ -n "$PATTERN" ]]; then
    echo "$OUTPUT" | grep -i "$PATTERN" || { echo "No matches for '$PATTERN'."; exit 1; }
elif command -v fzf >/dev/null 2>&1; then
    echo "$OUTPUT" | fzf \
        --no-sort \
        --prompt="tmux bindings> " \
        --header="Type to filter | Ctrl-C to quit"
else
    echo "$OUTPUT" | less -S
fi
