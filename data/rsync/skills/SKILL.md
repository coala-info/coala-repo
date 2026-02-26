---
name: rsync
description: rsync is a utility for fast, incremental file synchronization and data transfer between local and remote locations. Use when user asks to synchronize directories, perform incremental backups, mirror file systems, or transfer data securely between hosts.
homepage: https://github.com/RsyncProject/rsync
---


# rsync

## Overview
rsync (Remote Sync) is a powerful utility designed for fast, incremental file transfers. Unlike standard copy commands, rsync minimizes data transfer by comparing the source and destination and only transmitting the parts of files that have changed. It is widely used for maintaining backups, synchronizing web server content, and moving data over high-latency or low-bandwidth network connections.

## Core Usage Patterns

### Basic Local Synchronization
To sync a local directory to another local path while preserving attributes:
`rsync -av /src/directory/ /dest/directory/`

*   `-a` (Archive): Preserves permissions, ownership, timestamps, symlinks, and recursive structure.
*   `-v` (Verbose): Provides details on the files being transferred.

### Remote Synchronization via SSH
rsync uses SSH by default for secure remote transfers:
`rsync -avz -e ssh /local/path/ user@remote_host:/remote/path/`

*   `-z`: Compresses data during transfer to save bandwidth.
*   `-e ssh`: Explicitly specifies the remote shell (usually the default).

### The Trailing Slash Rule
The presence or absence of a trailing slash on the **source** path significantly changes behavior:
*   `rsync -a /src/foo /dest/` -> Creates `/dest/foo/` (copies the directory itself).
*   `rsync -a /src/foo/ /dest/` -> Copies the **contents** of `foo` into `/dest/` (does not create a `foo` subdirectory).

## Expert Tips and Best Practices

### Safety First: Dry Runs
Always test complex commands with `-n` or `--dry-run` to see what would happen without actually moving data:
`rsync -av --dry-run /src/ /dest/`

### Mirroring and Deletion
By default, rsync does not remove files from the destination if they were deleted from the source. To create an exact mirror:
`rsync -av --delete /src/ /dest/`

### Handling Partial Transfers and Progress
For large files or unstable connections, use `-P` (which combines `--progress` and `--partial`):
`rsync -avP /src/large_file.iso /dest/`
*   `--progress`: Shows a real-time transfer bar.
*   `--partial`: Keeps partially transferred files if the connection breaks, allowing the next run to resume where it left off.

### Excluding Files
Use the `--exclude` flag to skip specific files or patterns (e.g., cache or logs):
`rsync -av --exclude='*.log' --exclude='node_modules/' /src/ /dest/`

### Performance Optimization
If you are syncing over a very fast local network (10Gbps+), the `-z` (compression) flag may actually slow down the transfer by bottlenecking the CPU. Skip `-z` for local or high-speed LAN transfers.

## Reference documentation
- [Rsync Project Overview](./references/github_com_RsyncProject_rsync.md)