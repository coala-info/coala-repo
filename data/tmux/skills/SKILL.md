---
name: tmux
description: tmux is a terminal multiplexer that allows you to create, access, and control multiple terminals from a single screen. Use when user asks to create, attach, or detach terminal sessions, manage windows and panes, query session or pane information, programmatically control tmux, or debug tmux issues.
homepage: https://github.com/tmux/tmux
---


# tmux

## Overview
tmux is a terminal multiplexer that allows you to create, access, and control multiple terminals from a single screen. Its primary value lies in its client-server model: you can start a process in tmux, detach from the session, and the process will continue running in the background. You can then reattach to that session from any other terminal or even a different machine. This skill focuses on leveraging tmux for session persistence, advanced layout management, and utilizing its internal formatting engine for automation.

## Core CLI Patterns

### Session Management
The fundamental workflow involves creating named sessions to organize different projects or tasks.
- **Create a named session**: `tmux new-session -s <name>`
- **List active sessions**: `tmux list-sessions` (or `tmux ls`)
- **Attach to a specific session**: `tmux attach-session -t <name>`
- **Detach from current session**: `Prefix + d` (Default prefix is `Ctrl-b`)
- **Kill a session**: `tmux kill-session -t <name>`

### Window and Pane Operations
tmux divides a single screen into multiple windows (tabs) and panes (splits).
- **Split horizontally**: `tmux split-window -h`
- **Split vertically**: `tmux split-window -v`
- **Create new window**: `tmux new-window`
- **Navigate panes**: `tmux select-pane -[U|D|L|R]` (Up, Down, Left, Right)
- **Toggle pane zoom**: `Prefix + z` (Useful for temporarily focusing on one task)

## Expert Tips and Advanced Features

### Using Formats for Automation
tmux has a powerful formatting engine used to extract information about the environment. This is essential for scripts that need to query the state of the terminal.
- **Query current session name**: `tmux display-message -p '#S'`
- **List all panes with their PIDs**: `tmux list-panes -a -F "#{pane_index}: #{pane_pid}"`
- **Check if a session exists**: `tmux has-session -t <name> 2>/dev/null`

### Control Mode (-C)
For AI agents or external tools interacting with tmux, "Control Mode" provides a stream of notifications and allows for programmatic control without parsing the visual UI.
- **Start in control mode**: `tmux -C`
- This mode is intended for applications (like iTerm2 or custom scripts) to use tmux as a backend.

### Clipboard Integration (OSC 52)
Modern tmux supports OSC 52, allowing the terminal to set the system clipboard even over SSH.
- Ensure `set -s set-clipboard on` is in your configuration.
- This allows text copied within a remote tmux session to be available on your local machine's clipboard.

### Debugging
If tmux behaves unexpectedly or fails to start:
- **Verbose logging**: `tmux -v` or `tmux -vv`
- This generates `tmux-server-*.log` and `tmux-client-*.log` in the current directory, which are vital for troubleshooting configuration or terminal compatibility issues.

## Reference documentation
- [tmux Wiki Home](./references/github_com_tmux_tmux_wiki.md)
- [tmux Main Repository](./references/github_com_tmux_tmux.md)
- [tmux Discussions](./references/github_com_orgs_tmux_discussions.md)