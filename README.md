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

Default: `shell:$SHELL,lazygit:lazygit`
