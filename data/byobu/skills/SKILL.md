---
name: byobu
description: Byobu is a terminal multiplexer enhancement that provides persistent remote sessions, window management, and real-time system status monitoring. Use when user asks to maintain persistent terminal sessions, manage multiple windows or panes, monitor system health, or configure terminal status notifications.
homepage: https://github.com/dustinkirkland/byobu
---


# byobu

## Overview

Byobu is a sophisticated enhancement layer for terminal multiplexers like Tmux and GNU Screen. It transforms a standard terminal into a powerful DevOps environment by providing intuitive keyboard shortcuts and a customizable status bar. Use this skill to maintain persistent remote sessions, organize multiple terminal windows, and monitor system health (CPU, RAM, uptime) without leaving the command line.

## Core CLI Commands

- `byobu`: Launch or re-attach to a Byobu session.
- `byobu-config`: Open the menu-driven configuration utility (requires `python-newt`).
- `byobu-enable`: Configure Byobu to start automatically every time you log in.
- `byobu-disable`: Stop Byobu from starting automatically on login.
- `byobu-ctrl-a`: Toggle the behavior of `Ctrl-a` between Screen-mode (command prefix) and Emacs-mode (move to beginning of line).
- `byobu-silent`: Launch a session without the status notifications for a cleaner interface.

## Essential Keybindings

Byobu relies heavily on Function keys to simplify window management:

- **F2**: Create a new window.
- **F3 / F4**: Navigate to the previous or next window.
- **F5**: Refresh the status bar and reload profiles.
- **F6**: Detach from the current session (processes continue running in the background).
- **F7**: Enter scrollback/copy mode (use arrows to navigate history).
- **F8**: Rename the current window.
- **F9**: Open the configuration menu to toggle status notifications and change escape sequences.
- **Shift-F2**: Split the current window horizontally (create a new pane).
- **Ctrl-F2**: Split the current window vertically (create a new pane).
- **Shift-F3 / Shift-F4**: Move focus between split panes.
- **Ctrl-F6**: Kill the current pane.

## Expert Tips and Patterns

### Persistent Remote Workflows
When working on remote servers, always start a `byobu` session. If your SSH connection drops, your processes (compilations, database migrations, etc.) will continue. Simply reconnect and run `byobu` to resume exactly where you left off.

### Customizing the Status Line
Use the **F9** menu to enable specific status indicators. High-utility indicators include:
- `load_average`: Monitor system stress.
- `reboot_required`: Essential for server maintenance.
- `updates_available`: Track pending package updates (supports `apt`, `dnf`, and `apk`).
- `disk`: Monitor available space on the root partition.

### Session Management
If you need to manage multiple distinct sessions, use the underlying multiplexer flags:
- `byobu -S session_name`: Start a named session.
- `byobu -ls`: List all active sessions.

### Bash Timer
Recent versions of Byobu include a bash timer that displays the runtime of the previous command in the prompt. This is useful for benchmarking scripts and long-running tasks without needing to prefix them with `time`.

## Reference documentation

- [Byobu Main Repository README](./references/github_com_dustinkirkland_byobu.md)
- [Byobu Commit History and Feature Updates](./references/github_com_dustinkirkland_byobu_commits_master.md)