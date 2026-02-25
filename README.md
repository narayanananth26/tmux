# Super based Tmux config

## Features

- **Prefix `C-a`** (Ctrl+A) instead of default C-b
- **Vi mode** for copy/paste and pane selection
- **Mouse support** for panes and scrolling
- **Session persistence** with tmux-resurrect and tmux-continuum
- **tmux-yank** for system clipboard integration
- **SessionX** (`prefix + o`) – session/window management with FZF and Zoxide
- **Floax** (`prefix + p`) – floating pane with 80% size
- **tmux-thumbs** – quick hint-based selection
- **tmux-fzf** and **tmux-fzf-url** – FZF for windows and URL opening
- **Pane borders** with index and current command in status
- **1M history** limit, renumber-windows, set-clipboard on

## Configuration Structure

```
~/.config/tmux/
├── tmux.conf         # Main entry, sources modules and TPM
├── settings.conf     # Shell, mouse, prefix, base-index, vi mode
├── keybindings.conf  # Prefix keybinds (split, resize, nav, etc.)
├── plugins.conf      # TPM plugins and plugin options
├── appearance.conf   # Status bar, pane borders, colors
└── bindings.sh       # Helper: list and search active key bindings
```

## Key Bindings (after prefix `C-a`)

| Key | Action |
|-----|--------|
| `H` / `L` | Previous / next window |
| `h` / `j` / `k` / `l` | Select pane (vi-style) |
| `s` / `v` | Split vertical / horizontal (keep cwd) |
| `z` | Zoom (maximize) pane |
| `,` / `.` / `-` / `=` | Resize pane (repeatable) |
| `r` | Rename window |
| `R` | Reload config |
| `c` | Kill pane |
| `x` | Swap pane down |
| `S` | Choose session |
| `*` | Toggle synchronize-panes |
| `o` | SessionX (session/window picker) |
| `p` | Floax (floating pane) |

**Copy mode:** `prefix + [` → `v` to begin selection → `y` to yank to clipboard → `Enter` to copy and exit.

## Bindings Helper

`bindings.sh` queries the live tmux key tables so results always reflect the current running config.

```bash
# Interactive fzf picker across all tables
~/.config/tmux/bindings.sh

# Search for a pattern
~/.config/tmux/bindings.sh copy
~/.config/tmux/bindings.sh yank

# Restrict to a key table
~/.config/tmux/bindings.sh -t prefix
~/.config/tmux/bindings.sh -t copy-mode-vi

# Combine table + pattern
~/.config/tmux/bindings.sh -t copy-mode-vi y

# List all available key tables
~/.config/tmux/bindings.sh -l
```

> Must be run from inside a tmux session.

## Installation

1. **Symlink or set TMUX_CONFIG**

   Ensure tmux loads from this dir. Either:

   ```bash
   ln -sf ~/.config/tmux/tmux.conf ~/.tmux.conf
   ```

   Or in `~/.tmux.conf`:

   ```bash
   source-file ~/.config/tmux/tmux.conf
   ```

2. **Install TPM** (Tmux Plugin Manager)

   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

3. **Install plugins**

   Start tmux, then press `prefix + I` (capital I) to install plugins.

## Prerequisites

- [tmux](https://github.com/tmux/tmux)
- [TPM](https://github.com/tmux-plugins/tpm) (installed to `~/.tmux/plugins/tpm`)
- Optional: [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide) for SessionX
