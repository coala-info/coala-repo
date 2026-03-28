---
name: blinker
description: Blink Shell is a professional-grade terminal emulator for iOS and iPadOS that provides high-performance remote connections via SSH and Mosh. Use when user asks to establish persistent remote sessions, manage SSH keys, execute local Unix utilities, or run Python and Lua scripts on a mobile device.
homepage: https://github.com/blinksh/blink
---

# blinker

## Overview

Blink Shell is a professional-grade terminal emulator designed specifically for the iOS/iPadOS ecosystem. It focuses on providing high-performance, stable remote connections by leveraging Mosh (Mobile Shell) and SSH. Unlike basic terminal apps, it offers a local environment with a curated "Unix toolbox," support for hardware keyboards with custom remapping, and specialized file management within the iOS sandbox. This skill helps users navigate the command-line interface, manage persistent connections, and utilize local scripting capabilities.

## Core Connection Commands

### SSH (Secure Shell)
Use for standard remote terminal access.
- **Basic connection**: `ssh user@host`
- **Specify port and key**: `ssh -p 2222 -i id_rsa user@host`
- **Verbose debugging**: Use `-v`, `-vv`, or `-vvv` to troubleshoot connection or authentication failures.

### Mosh (Mobile Shell)
Recommended for mobile environments to handle roaming and intermittent connectivity.
- **Basic connection**: `mosh user@host`
- **Run remote command on start**: `mosh user@host -- tmux attach`
- **Predictive echo**: Mosh provides local echo to hide network latency, which is essential for a fluid typing experience on mobile.

### SSH Key Management
- **Generate keys**: Use the `config` command to access the UI for key generation.
- **Copy keys to server**: `ssh-copy-id identity_file user@host`. Note that this requires password authentication to be temporarily enabled on the remote server if no other keys are present.

## Local Environment and Utilities

### File System Restrictions
Due to iOS sandboxing, you cannot write to the root or home directory. Use the following paths for persistent storage:
- `~/Documents/`: Primary location for user files and scripts.
- `~/Library/`: Configuration and support files.
- `~/tmp/`: Temporary files.

### Built-in Toolbox
Blink includes a subset of Unix utilities. Note that while redirection (`>`, `<`) is supported, pipes (`|`) are currently not available in the native shell.
- **File Operations**: `ls`, `cp`, `mv`, `rm`, `mkdir`, `touch`, `chmod`, `stat`.
- **Network/Transfer**: `curl`, `scp`, `sftp`, `ping`, `nc`.
- **Text Processing**: `cat`, `grep`, `wc`, `ed`.
- **Archiving**: `tar`, `gzip`, `gunzip`, `compress`.

### Scripting
You can execute local logic using:
- **Python**: Run scripts via `python script.py`.
- **Lua**: Run scripts via `lua script.lua`.

## Expert Tips and Shortcuts

- **Configuration UI**: Type `config` to open the settings overlay for themes, fonts, and host definitions.
- **Command History**: Use `Ctrl-r` to trigger a reverse search through your command history.
- **Navigation**: Swipe left/right to switch between active sessions. Use pinch-to-zoom to adjust font size on the fly.
- **Environment Variables**: Use `setenv KEY VALUE` to define variables. Common variables like `PATH`, `PYTHONHOME`, and `SSH_HOME` are pre-configured to point to writable iOS directories.
- **Copy/Paste**: Blink supports standard iOS clipboard integration. Use `scp` or `curl` to move files between the local iOS environment and remote servers.



## Subcommands

| Command | Description |
|---------|-------------|
| blinker_ls | List directory contents |
| cp | Copy SOURCE(s) to DEST |
| grep | Search for PATTERN in FILEs (or stdin) |
| mkdir | Create DIRECTORY |
| mv | Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY |
| python | Run a Python script or module |
| rm | Remove (unlink) FILEs |
| tar | Create, extract, or list files from a tar file |

## Reference documentation
- [Blink Shell README](./references/github_com_blinksh_blink.md)
- [Commanding Your Blink](./references/github_com_blinksh_blink_wiki_Commanding-Your-Blink.md)
- [Create and Access Host](./references/github_com_blinksh_blink_wiki_Create-and-Access-Host.md)