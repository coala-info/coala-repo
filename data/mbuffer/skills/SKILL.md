---
name: mbuffer
description: mbuffer is a high-performance multithreaded tool that buffers data between a producer and a consumer to smooth out I/O spikes and monitor transfer speeds. Use when user asks to prevent tape drive underruns, transfer data over a network, or diagnose performance bottlenecks in a command-line pipeline.
homepage: https://github.com/ilovezfs/mbuffer-osx
---


# mbuffer

## Overview

mbuffer (measuring buffer) is a high-performance replacement for the standard `buffer` tool. It acts as a multithreaded bridge between a data producer and a consumer, providing a configurable memory or file-based buffer to smooth out I/O spikes. Its primary advantages include real-time display of transfer speeds, support for extremely large buffers via memory-mapped I/O, and built-in TCP/IP networking capabilities. Use this skill when you need to prevent "shoe-shining" in tape drives, transfer data over a trusted network, or diagnose performance bottlenecks in a command-line pipeline.

## Common CLI Patterns

### Basic Throughput Monitoring
To monitor the speed of a data pipeline without significant configuration:
```bash
tar cf - /source/directory | mbuffer | tar xf - -C /destination/
```

### Network Data Transfer
mbuffer can act as a simple, high-speed network pipe. Note that there is no built-in security/encryption.

**On the receiving host (Server):**
```bash
mbuffer -I 8080 > received_data.tar
```

**On the sending host (Client):**
```bash
tar cf - /data | mbuffer -O 192.168.1.10:8080
```

### Optimizing for Tape Backups
To prevent tape drive underruns, use a large buffer and lock it in memory if possible:
```bash
tar cf - /data | mbuffer -m 1G -L -p 25 -f -o /dev/nst0
```
*   `-m 1G`: Sets the buffer size to 1 Gigabyte.
*   `-L`: Locks the buffer in RAM to prevent swapping.
*   `-p 25`: Starts writing only when the buffer is 25% full.
*   `-f`: Forces output to the specified file/device.

### Using File-Based Buffering
For datasets larger than available RAM, use memory-mapped files:
```bash
producer | mbuffer -t -m 10G | consumer
```
*   `-t`: Uses a temporary file for the buffer (ensure the filesystem is not `tmpfs`).

## Expert Tips and Best Practices

*   **64-bit Requirement**: If you need a total buffer size of 2GB or larger, mbuffer must be compiled as a 64-bit executable.
*   **Block Size Alignment**: Match the block size (`-s`) to your hardware's requirements (e.g., `-s 128k` or `-s 256k` for modern tape drives) to maximize efficiency.
*   **Avoid tmpfs for Temp Files**: When using the `-t` (temporary file) option, do not place the file on a `tmpfs` filesystem, as this negates the benefit of offloading from RAM.
*   **Network Security**: Since mbuffer has no built-in authentication or encryption, only use the `-I` (input) and `-O` (output) network flags within a trusted LAN or over a secure VPN/SSH tunnel.
*   **I/O Speed Display**: By default, mbuffer outputs progress and speed to stderr. If you are redirecting stderr, you can use `-l <file>` to log status messages to a specific file.

## Reference documentation
- [mbuffer port to OS X README](./references/github_com_ilovezfs_mbuffer-osx.md)