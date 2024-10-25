# tmux-yank-lite

A minimal clipboard integration plugin for tmux. This plugin supports copying to the system clipboard using either xclip (in X environments) or socat (for remote clipboard access).

## Background

This plugin was developed to solve a common challenge in a mixed-environment development setup. I use Debian GNU/Linux sid as my development environment on my host PC.

I often forced to work with Windows and macOS due to corporate requirements. The need to efficiently copy text from tmux sessions in the Debian GNU/Linux sid virtual machine to the Windows/macOS host clipboard led to the development of this minimal solution.

By leveraging socat for host clipboard access when X is not available, this plugin enables seamless clipboard integration across these different environments, making it easier to work with multiple operating systems simultaneously.

## Features

- Automatically detects the appropriate clipboard method:
  - Uses xclip when X is running
  - Uses socat when X is not running but a clipboard listener is available on localhost:12345
- Single key binding (`y`) in copy mode
- Designed for tmux 3.x
- Zero configuration needed - automatically adapts to your environment

## Requirements

- xclip
- socat

## Installation

Add this line to your `~/.tmux.conf`:

```bash
run-shell ~/.tmux/plugins/tmux-yank-lite/yank-lite.tmux
```

Reload tmux configuration:

```bash
$ tmux source-file ~/.tmux.conf
```

### Using [TPM](https://github.com/tmux-plugins/tpm)

1. Add this line to your `~/.tmux.conf`:
```bash
set -g @plugin 'zinrai/tmux-yank-lite'
```

2. Press `prefix` + <kbd>I</kbd> to install the plugin

## Usage

1. Enter tmux copy mode (`prefix` + <kbd>[</kbd>)
2. Select text
3. Press <kbd>y</kbd> to copy to clipboard

## Setting up Clipboard Listener for Remote Access

If you're using this plugin in a non-X environment (like through SSH), you'll need to set up a clipboard listener on the host machine. Here's how to do it:

* Windows: [echoclip](https://github.com/zinrai/echoclip)
* macOS: [echoclip-daemon](https://github.com/zinrai/echoclip-daemon)

## Troubleshooting

The plugin will automatically detect the best available method for clipboard access:

1. If you're in an X session with xclip installed:
   - The plugin will use xclip
   - No additional configuration needed

2. If you're not in an X session:
   - The plugin will try to connect to localhost:12345
   - Make sure your clipboard listener is running on the host machine

3. If neither method is available:
   - The plugin will not configure any key bindings
   - Check the installation of required tools (xclip or socat)

## License

This project is licensed under the MIT License - see the [LICENSE](https://opensource.org/license/mit) for details.
