---
name: art
description: The art skill provides a collection of command-line patterns and tools designed to improve productivity in Bash-centric environments. Use when user asks to master CLI principles, manage files and data, monitor system processes, or optimize shell efficiency.
homepage: https://github.com/jlevy/the-art-of-command-line
---


# art

## Overview
The "art" skill provides a distilled collection of command-line wisdom designed to improve flexibility and productivity for engineers. It focuses on Bash-centric environments (Linux, macOS, and Windows via WSL/Cygwin) and emphasizes the most impactful tools and patterns for interactive use and scripting. Use this skill to move beyond basic commands into professional-grade CLI mastery.

## Core CLI Principles
- **Prefer Bash**: While other shells exist, Bash is the industry standard and is available on almost every system.
- **Read the Manual**: Use `man <command>` for documentation. Use `apropos <keyword>` to find relevant commands.
- **Understand Command Types**: Use `type <command>` to determine if a command is an executable, a shell builtin, or an alias.
- **Redirection Mastery**: 
    - `>` overwrites, `>>` appends.
    - `|` pipes stdout to the next command.
    - `2>&1` redirects stderr to stdout.

## Everyday Efficiency
- **History Search**: Use `ctrl-r` to search through command history. Press it repeatedly to cycle through matches.
- **Line Editing**:
    - `ctrl-a`: Move to beginning of line.
    - `ctrl-e`: Move to end of line.
    - `ctrl-w`: Delete the last word.
    - `ctrl-u`: Delete from cursor to start of line.
    - `alt-b` / `alt-f`: Move backward/forward by word.
- **Job Control**:
    - `&`: Run command in background.
    - `ctrl-z`: Suspend current process.
    - `fg`: Bring suspended/background job to foreground.
    - `bg`: Resume suspended job in background.

## File and Data Management
- **Inspection**: Use `less` for viewing files (it doesn't load the whole file into memory). Use `tail -f` (or `less +F`) to watch log files in real-time.
- **Permissions**: Understand `ls -l` columns. Use `chmod` and `chown` for access control.
- **Disk Usage**: Use `du -hs *` for a human-readable summary of directory sizes. Use `df -h` for disk partition status.
- **Links**: Use `ln -s` for symbolic links. Understand that hard links (`ln`) share the same inode.

## System Debugging and Networking
- **Network**: Use `ip addr` (or `ifconfig`) for interface status, `dig` for DNS lookups, and `traceroute` to find network bottlenecks.
- **Process Monitoring**: Use `top` (or `htop`) to see system resource usage. Use `ps aux` to list all running processes.
- **Connectivity**: Use `ssh` with `ssh-agent` and `ssh-add` for secure, passwordless authentication.

## Expert Tips
- **Xargs**: Use `xargs` to execute commands against a list of items (e.g., `find . -name "*.log" | xargs rm`).
- **Grep**: Master `-i` (ignore case), `-v` (invert match), and context flags `-A`, `-B`, `-C`.
- **Aliases**: Create aliases in `.bashrc` for frequently used complex commands to save keystrokes.

## Reference documentation
- [The Art of Command Line](./references/github_com_jlevy_the-art-of-command-line.md)