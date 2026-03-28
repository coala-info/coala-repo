---
name: art
description: This tool provides expert-level command line patterns and high-utility shell workflows for data processing, system debugging, and terminal productivity. Use when user asks to master shell basics, manage files and data, debug system resources, or optimize command line navigation and history.
homepage: https://github.com/jlevy/the-art-of-command-line
---

# art

## Overview
The `art` skill provides a distilled knowledge base for mastering the command line, based on "The Art of Command Line." It transforms general terminal usage into a high-productivity workflow by providing specific, high-utility patterns for data processing, system debugging, and everyday shell interactions. This skill is designed to help users move beyond basic commands into expert-level fluency with Linux and macOS environments.

## Command Line Basics
*   **Shell Mastery**: Prefer Bash for its ubiquity. Use `man bash` to understand shell behavior.
*   **Documentation**: Use `man` for command references (e.g., `man 1` for commands, `man 5` for file formats). Use `apropos` to find relevant manual pages.
*   **Redirection**: 
    *   Use `>` to overwrite and `>>` to append.
    *   Understand the difference between `stdout` (1) and `stderr` (2). Use `2>&1` to redirect errors to standard output.
*   **Job Control**: Use `&` to background tasks, `ctrl-z` to suspend, and `fg`/`bg` to manage active jobs.

## Everyday Productivity
*   **Navigation**: Use `cd -` to return to the previous directory. Use `pushd` and `popd` for stack-based directory management.
*   **History**: Use `ctrl-r` for reverse-searching command history. Use `history` to view past commands and `!$` to refer to the last argument of the previous command.
*   **SSH**: Set up passwordless authentication using `ssh-agent` and `ssh-add`. Use `ssh -t` to force pseudo-terminal allocation for remote commands.

## File and Data Processing
*   **Search**: Use `grep` with flags:
    *   `-i`: Case-insensitive.
    *   `-v`: Invert match (exclude).
    *   `-o`: Show only the matching part.
    *   `-A`, `-B`, `-C`: Show context (After, Before, Center).
*   **Analysis**: 
    *   Use `ls -l` to inspect permissions and ownership.
    *   Use `du -hs *` to identify large files/directories.
    *   Use `head` and `tail -f` (or `less +F`) to monitor log files.
*   **Manipulation**: Use `ln -s` for symbolic links. Understand that `>` truncates files while `>>` preserves existing content.

## System Debugging
*   **Network**: Use `ip` (or `ifconfig`) for interface configuration and `dig` for DNS lookups.
*   **Resources**: Use `df` for disk space and `lsblk` for block device information. Understand `inodes` using `ls -i` or `df -i`.
*   **Processes**: Use `kill` to terminate processes by PID.

## Expert Tips
*   **Brevity**: Focus on specific, short commands rather than long scripts for interactive use.
*   **Explainshell**: When encountering complex nested commands, use tools like `explainshell.com` to break down flags and pipes.
*   **Portability**: While `zsh` or `fish` are powerful for local use, maintain Bash proficiency for working on remote servers.



## Subcommands

| Command | Description |
|---------|-------------|
| art_df | Display information about the amount of available disk space on file systems. |
| art_du | Summarize disk usage of the set of FILEs, recursively for directories. |
| art_find | A tool to search for and list files within a directory structure, specifically tailored for identifying 'art' related project files and documentation. |
| art_ifconfig | Configure a network interface or display information about network interfaces. |
| art_illumina | A simulation tool to generate synthetic Illumina reads |
| chmod | Change file mode bits (BusyBox version). MODE is octal number or [ugoa]{+\|-\|=}[rwxXst]. |
| chown | Change the owner and/or group of FILEs to USER and/or GRP |
| grep | Search for PATTERN in FILEs (or stdin) |
| ip | Network configuration tool for managing addresses, routes, links, tunnels, neighbors, and rules. |
| ln | Create a link LINK or DIR/TARGET to the specified TARGET(s) |
| man | Display manual page |
| rm | Remove (unlink) FILEs |
| tail | Print last 10 lines of FILEs (or stdin). With more than one FILE, precede each with a filename header. |
| top | Show a view of process activity in real time. Read the status of all processes from /proc each SECONDS and show a screenful of them. |
| traceroute | Trace the route to HOST |
| xargs | Run PROG on every item given by stdin |

## Reference documentation
- [The Art of Command Line](./references/github_com_jlevy_the-art-of-command-line.md)
- [Contributing to the Guide](./references/github_com_jlevy_the-art-of-command-line_blob_master_CONTRIBUTING.md)