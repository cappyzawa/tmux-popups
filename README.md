# tmux-popups

Simple popup command launcher as TPM plugin.

## Requirements

- tmux 3.2+

## Installation

Add to your `.tmux.conf`:

```tmux
set -g @plugin 'cappyzawa/tmux-popups'
```

Then press `prefix + I` to install.

## Usage

Define popup commands with `@popup_<key>`:

```tmux
set -g @popup_g 'lazygit'
set -g @popup_G 'gh dash'
set -g @popup_k 'k9s'
```

This creates:
- `prefix + g` → opens lazygit in popup
- `prefix + G` → opens gh dash in popup
- `prefix + k` → opens k9s in popup

## Configuration

### Popup size

```tmux
set -g @popup_width '80%'   # default: 80%
set -g @popup_height '80%'  # default: 80%
```

### Shell

```tmux
set -g @popup_shell 'zsh -ic'  # default: zsh -ic
```

> [!NOTE]
> Popup windows close automatically when the process inside them exits.
> While a popup is open, other pane operations are blocked (tmux behavior).
