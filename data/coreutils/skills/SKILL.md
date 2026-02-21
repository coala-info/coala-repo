---
name: coreutils
description: The `coreutils` skill provides access to a comprehensive reimplementation of the GNU coreutils in Rust.
homepage: https://github.com/uutils/coreutils
---

# coreutils

## Overview
The `coreutils` skill provides access to a comprehensive reimplementation of the GNU coreutils in Rust. These tools are the fundamental building blocks for interacting with the filesystem and processing data streams in a Unix-like environment. This implementation is designed to be cross-platform, offering consistent behavior across Linux, macOS, and Windows. Use this skill when you need to automate file operations, transform text data, or query system status using standard command-line interfaces that aim for 1:1 compatibility with GNU counterparts.

## Common CLI Patterns

### File Operations
*   **Listing Files**: Use `ls` to view directory contents. Use `-l` for long format, `-a` for all files (including hidden), and `-h` for human-readable sizes.
*   **Copying and Moving**: Use `cp` and `mv`. For recursive directory copying, use `cp -r`.
*   **Deletion**: Use `rm`. Use `-f` to force and `-r` for recursive deletion of directories.
*   **Permissions**: Use `chmod` to change file modes (e.g., `chmod +x script.sh`) and `chown` to change ownership.

### Text Processing
*   **Reading**: Use `cat` to concatenate and display files. Use `tac` to display files in reverse (last line first).
*   **Filtering**: Use `head` and `tail` to view the beginning or end of files. Use `tail -f` to follow file growth in real-time.
*   **Sorting and Uniqueness**: Use `sort` to order lines and `uniq` to filter out repeated lines.
*   **Extraction**: Use `cut` to extract specific columns or fields from text (e.g., `cut -d',' -f1` for the first column of a CSV).

### System Information
*   **Disk Usage**: Use `df -h` for a summary of filesystem disk space and `du -sh <dir>` for the size of a specific directory.
*   **Environment**: Use `env` to view or run a command in a modified environment.
*   **Basic Info**: Use `arch` for machine architecture, `whoami` for current user, and `uptime` for system run time.

## Expert Tips and Extensions

### Multicall Binary Usage
If the utilities are installed as a single multicall binary, you can invoke them via:
`coreutils <utility> [arguments]`
Example: `coreutils ls -la`

### Progress Bars
The `uutils` implementation often includes a `--progress` flag for long-running operations like `cp` or `mv`, which is an extension not found in standard GNU coreutils. Use this to monitor large file transfers.

### Generating Shell Completions
You can generate shell completion scripts for various shells (bash, zsh, fish, powershell, elvish) using the `uudoc` tool or the multicall binary:
`coreutils completion <utility> <shell>`

### Numerical Formatting
Use `numfmt` to convert numbers to and from human-readable formats (e.g., `numfmt --to=iec 1024` outputs `1.0K`). This is highly useful for piping output from scripts into readable reports.

### Handling Non-UTF8 Data
While `uutils` prioritizes UTF-8, tools like `base32`, `base64`, and `basenc` are essential for encoding and decoding binary data for text-based transmission.

## Reference documentation
- [uutils coreutils README](./references/github_com_uutils_coreutils.md)
- [uutils coreutils Wiki](./references/github_com_uutils_coreutils_wiki.md)