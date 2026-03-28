---
name: coreutils
description: This tool provides a cross-platform Rust implementation of GNU coreutils that functions as a drop-in replacement for standard system utilities. Use when user asks to build the utilities from source, install the multicall binary, generate shell completions, or handle cross-platform command-line operations.
homepage: https://github.com/uutils/coreutils
---

# coreutils

## Overview

The uutils coreutils project is a cross-platform reimplementation of the GNU coreutils in Rust. It serves as a drop-in replacement for the standard GNU utilities, aiming for exact output matching (stdout and error codes) while providing better error messages, improved performance, and native support for Linux, macOS, and Windows. This skill helps you navigate the specific installation, building, and usage patterns unique to the Rust implementation, such as multicall binary dispatching and feature-based compilation.

## Installation and Setup

### Building from Source
Use Cargo to build the most portable common core set of utilities:
```bash
cargo build --release
```
To include platform-specific utilities, specify the target feature:
```bash
cargo build --release --features unix
# or
cargo build --release --features macos
# or
cargo build --release --features windows
```

### Installing the Multicall Binary
The multicall binary allows you to access all utilities through a single executable. Install it via Cargo:
```bash
cargo install --path . --locked
```
Once installed, you can call utilities as subcommands:
```bash
coreutils ls -la
coreutils cat file.txt
```

## Generating Shell Completions

The `uudoc` tool (or the `coreutils completion` command) generates shell completions for bash, zsh, fish, powershell, and elvish.

### Using uudoc
1. Install the documentation tool:
   ```bash
   cargo install --bin uudoc --features uudoc --path .
   ```
2. Generate completion for a specific utility and shell:
   ```bash
   uudoc completion ls bash > /usr/local/share/bash-completion/completions/ls
   ```

### Using the coreutils binary
If using the multicall binary, generate completions directly:
```bash
coreutils completion ls zsh > ~/.zsh/completions/_ls
```

## Common CLI Patterns and Best Practices

### Handling Cross-Platform Differences
While uutils aims for GNU compatibility, use the `--features` flag during compilation to ensure platform-specific tools like `chcon` (SELinux) or specific `ls` behaviors are available on your target OS.

### Performance and Extensions
- **Progress Bars**: Some uutils tools include extensions not found in GNU, such as the `--progress` flag for long-running operations.
- **Small Binaries**: If disk space is a concern, optimize the build for size:
  ```bash
  cargo build --profile=release-small
  ```

### Testing Compatibility
If you encounter a behavior difference between uutils and GNU coreutils, it is treated as a bug. Verify the version and report issues via the GitHub tracker. To run the test suite:
```bash
cargo test
# Run platform-specific tests
cargo test --features unix
```



## Subcommands

| Command | Description |
|---------|-------------|
| base32 | Base32 encode or decode FILE, or standard input, to standard output. |
| base64 | Base64 encode or decode FILE, or standard input, to standard output. |
| basenc | basenc encode or decode FILE, or standard input, to standard output. |
| cat | Concatenate FILE(s) to standard output. |
| chmod | Change the mode of each FILE to MODE. With --reference, change the mode of each FILE to that of RFILE. |
| chown | Change the owner and/or group of each FILE to OWNER and/or GROUP. With --reference, change the owner and group of each FILE to those of RFILE. |
| cp | Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY. |
| cut | Print selected parts of lines from each FILE to standard output. |
| df | Show information about the file system on which each FILE resides, or all file systems by default. |
| du | Estimate file space usage |
| env | Set each NAME to VALUE in the environment and run COMMAND. If no COMMAND is specified, print the resulting environment. |
| head | Print the first 10 lines of each FILE to standard output. With more than one FILE, precede each with a header giving the file name. With no FILE, or when FILE is -, read standard input. |
| ls | List information about the FILEs (the current directory by default). Sort entries alphabetically if none of -cftuSUX nor --sort is specified. |
| mv | Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY. |
| numfmt | Reformat NUMBER(s), or the numbers from standard input if none are specified. |
| rm | Remove (unlink) the FILE(s). |
| sort | Write sorted concatenation of all FILE(s) to standard output. |
| tac | Write each FILE to standard output, last line first. With no FILE, or when FILE is -, read standard input. |
| tail | Print the last 10 lines of each FILE to standard output. With more than one FILE, precede each with a header giving the file name. |
| uniq | Filter adjacent matching lines from INPUT (or standard input), writing to OUTPUT (or standard output). |
| uptime | Print the current time, the length of time the system has been up, the number of users on the system, and the average number of jobs in the run queue over the last 1, 5 and 15 minutes. Processes in an uninterruptible sleep state also contribute to the load average. If FILE is not specified, use /var/run/utmp. |

## Reference documentation
- [uutils coreutils README](./references/github_com_uutils_coreutils.md)
- [uutils coreutils Wiki Home](./references/github_com_uutils_coreutils_wiki.md)