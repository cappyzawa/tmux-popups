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
set -g @popup_l 'gh cd -p 1'
```

This creates:
- `prefix + C-p g` → opens lazygit in popup
- `prefix + C-p l` → opens gh cd in popup

## Configuration

### Prefix key

```tmux
set -g @popup_prefix 'C-p'  # default: C-p
```

### Popup size

```tmux
set -g @popup_width '80%'   # default: 80%
set -g @popup_height '80%'  # default: 80%
```

> [!NOTE]
> Popup windows close automatically when the process inside them exits.
> While a popup is open, other pane operations are blocked (tmux behavior).
