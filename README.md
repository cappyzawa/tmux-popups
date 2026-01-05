# tmux-popups

tmux popup utilities as TPM plugin.

## Requirements

- tmux 3.2+
- fzf (for menu feature)

## Installation

Add to your `.tmux.conf`:

```tmux
set -g @plugin 'cappyzawa/tmux-popups'
```

Then press `prefix + I` to install.

## Usage

| Key | Description |
|-----|-------------|
| `prefix + f` | Open popup shell (pane-aligned) |
| `prefix + F` | Open action menu (fzf) |

## Configuration

### Key bindings

```tmux
set -g @popup_key 'f'       # default: f
set -g @popup_menu_key 'F'  # default: F
```

### Custom actions

Define actions in `label:command` format, comma separated:

```tmux
set -g @popup_actions 'shell:$SHELL,lazygit:lazygit,k9s:k9s,htop:htop'
```

Default: `shell:<default-shell> --login,lazygit:lazygit`

### Popup size

Configure popup dimensions:

```tmux
# Shell popup (prefix + f)
set -g @popup_width 'pane'   # default: pane (current pane width)
set -g @popup_height '40%'   # default: 40%

# Action menu (fzf selector)
set -g @popup_menu_width '60%'   # default: 60%
set -g @popup_menu_height '40%'  # default: 40%

# Action popup (lazygit, etc.)
set -g @popup_action_width '80%'   # default: 80%
set -g @popup_action_height '80%'  # default: 80%
```

Special values:
- `pane` - use current pane's width/height
- `N%` - percentage of terminal size
- `N` - fixed number of columns/rows
