---
name: blinker
description: Blink Shell is a professional-grade terminal emulator for iOS that provides persistent remote access and a local Unix-like environment. Use when user asks to connect to remote servers via SSH or Mosh, manage files using SCP or SFTP, and execute local scripts or commands on an iOS device.
homepage: https://github.com/blinksh/blink
---


# blinker

## Overview
Blink Shell is a professional-grade terminal emulator for iOS that prioritizes speed and persistent connectivity. It leverages Mosh (Mobile Shell) to handle unstable mobile networks and SSH for standard remote access. Beyond being a simple terminal, it provides a local Unix-like environment with built-in utilities for file management, networking, and scripting (Python/Lua), specifically tailored to work within iOS sandbox constraints.

## Core CLI Usage

### Remote Connections
*   **SSH**: Standard secure shell access.
    `ssh user@host`
*   **Mosh**: Preferred for mobile use as it handles roaming and packet loss.
    `mosh user@host`
*   **Configuration**: Use the `config` command to manage Hosts and SSH Keys via the graphical interface.

### File Transfer and Management
Blink uses a specialized version of `curl` to handle various protocols, including `scp` and `sftp`.
*   **SCP via curl**:
    `curl scp://host.name.edu/path/to/file -o local_filename --key $SHARED/id_rsa`
*   **Standard SCP/SFTP**: These commands are available but act as wrappers for the curl implementation.
    `scp user@host:remote_file local_destination`
    `sftp local_file user@host:~/remote_path`
*   **Local Utilities**: Standard commands like `ls`, `cd`, `cp`, `mv`, `rm`, `mkdir`, `tar`, and `grep` are available for local file manipulation.

### Environment and Scripting
Due to iOS sandboxing, the local environment has specific write permissions.
*   **Writable Directories**: You can only write to `~/Documents/`, `~/Library/`, and `~/tmp/`.
*   **Environment Variables**: Use `setenv` to define variables.
    `setenv PATH $PATH:~/Documents/bin`
*   **Scripting**: Execute local logic using `python` or `lua`.
*   **Redirection**: Supports standard redirection (`>`, `<`, `&>`), but note that pipes (`|`) are currently not supported.

## Expert Tips and Best Practices
*   **Persistent Sessions**: Always prefer `mosh` over `ssh` for long-running sessions to avoid disconnection when switching apps or losing cellular signal.
*   **Key Management**: Store your RSA keys via the `config` UI to ensure they are properly indexed for use with the `curl`-based transfer tools.
*   **Keyboard Customization**: Blink allows remapping keys (e.g., Caps Lock to Escape or Control). Use the `config` menu to match your desktop terminal experience.
*   **Gestures**:
    *   **Swipe**: Switch between active terminal sessions.
    *   **Slide Down**: Close the current session.
    *   **Pinch**: Adjust font size (zoom) dynamically.
*   **External Displays**: Use SplitView or external monitor support for multi-tasking between the terminal and documentation.

## Reference documentation
- [Blink Shell README](./references/github_com_blinksh_blink.md)
- [Blink Wiki Home](./references/github_com_blinksh_blink_wiki.md)