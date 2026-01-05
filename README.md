# tmux-popups

tmux popup utilities as TPM plugin.

## Installation

Add to your `.tmux.conf`:

```tmux
set -g @plugin 'cappyzawa/tmux-popups'
```

Then press `prefix + I` to install.

## Usage

Press `prefix + f` to open a popup shell aligned to the current pane.

## Configuration

### Key binding

```tmux
set -g @popup_key 'f'  # default: f
```
