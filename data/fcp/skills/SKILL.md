---
name: fcp
description: fcp is a high-performance, multi-threaded utility designed to copy files and directories significantly faster than the traditional cp command. Use when user asks to copy large datasets, perform fast recursive directory copies, or leverage copy-on-write capabilities on macOS.
homepage: https://github.com/Svetlitski/fcp
---


# fcp

## Overview

`fcp` (Fast Copy) is a Rust-based utility designed to significantly reduce the time required to copy data compared to the traditional Unix `cp` tool. It achieves superior speed by distributing the workload of directory walking and file copying across all available CPU cores. On macOS, it further accelerates operations by utilizing native copy-on-write (CoW) capabilities. This tool is most effective when dealing with massive datasets, such as source code trees or large binary files, where standard single-threaded copying becomes a bottleneck.

## Usage Patterns

### Basic File Copy
To copy a single file to a new destination (overwrites if the destination exists):
```bash
fcp source_file.dat destination_file.dat
```

### Copying to a Directory
To copy one or more source files or directories into a target directory:
```bash
fcp source1.txt source2.zip path/to/destination_directory/
```

## Expert Tips and Best Practices

### Hardware Optimization
*   **SSD Requirement**: Only use `fcp` on systems with Solid State Drives (SSDs). The tool relies on high IOPS and parallel I/O requests.
*   **Avoid HDDs**: Do not use `fcp` on mechanical Hard Disk Drives (HDDs). The parallelized approach can cause disk head thrashing, leading to significantly worse performance than the standard `cp` command.

### Filesystem Benefits
*   **macOS (APFS)**: `fcp` is exceptionally fast on macOS because it leverages `fclonefileat` and `fcopyfile`. This allows for nearly instantaneous "cloning" of large files without immediately duplicating the data on disk.
*   **Linux**: On Linux, `fcp` provides a 6x to 10x speed improvement for directory trees (like the Linux kernel source) by parallelizing the recursive walk and I/O operations.

### Limitations to Consider
*   **Unix-only**: `fcp` is designed for Unix-like operating systems (Linux, macOS, etc.) and is not compatible with Windows.
*   **Feature Set**: Unlike `cp`, `fcp` does not aim to support every legacy flag (like `--preserve` or `--interactive`). Use it specifically for performance-critical copying tasks rather than complex attribute preservation.

## Reference documentation
- [fcp README](./references/github_com_Svetlitski_fcp.md)
- [fcp Issues](./references/github_com_Svetlitski_fcp_issues.md)