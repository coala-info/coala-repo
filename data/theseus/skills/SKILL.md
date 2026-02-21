---
name: theseus
description: Theseus is a modern operating system written from scratch in Rust that leverages "intralingual design" to shift resource management from the runtime/kernel into the compiler.
homepage: https://github.com/theseus-os/Theseus
---

# theseus

## Overview

Theseus is a modern operating system written from scratch in Rust that leverages "intralingual design" to shift resource management from the runtime/kernel into the compiler. This skill assists developers in navigating the Theseus codebase, configuring the specialized toolchain required for building a safe-language OS, and executing the procedural workflows for testing the kernel in virtualized environments like QEMU.

## Environment Setup

### Native Linux (Debian/Ubuntu)
Install the required system dependencies to handle the bootloader and emulation:
```bash
sudo apt-get install make gcc nasm pkg-config grub-pc-bin mtools xorriso qemu qemu-kvm wget
```

### macOS
1. Use `gmake` instead of the system `make`.
2. Run the provided setup script: `sh ./scripts/mac_os_build_setup.sh`.
3. If using Apple Silicon, ensure you are using an x86_64 emulated shell if necessary for specific toolchain components.

### Windows (WSL2)
1. Ensure an X Server (like VcXsvr) is running on the Windows host.
2. Set the `DISPLAY` environment variable in your shell:
   `export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0`

## Build and Run Patterns

The primary interface for Theseus is its Makefile.

- **Standard Run**: Builds the OS and launches it in QEMU.
  `make run`
- **KVM Acceleration**: Use this for significantly faster execution on Linux hosts.
  `make orun host=yes`
- **Exit QEMU**: Press `Ctrl + A`, then `X`.
- **Clean Build**: If encountering strange link errors or crate mismatches.
  `make clean`

## Docker Workflow

Docker is the recommended way to avoid host dependency conflicts.

1. **Initialize**: `chmod +x docker/*.sh`
2. **Build Image**: `./docker/build_docker.sh` (Only needs to be run once or when dependencies change).
3. **Development**: `./docker/run_docker.sh`
   - This drops you into a shell inside the container where you can run `make run`.
   - Note: KVM does not work inside the Docker container. To use KVM, build inside Docker and run `make orun host=yes` on the host.

## Development Best Practices

- **Submodules**: Theseus relies heavily on submodules. Always clone with `--recurse-submodules` or run `git submodule update --init --recursive` after pulling.
- **Crate Management**: Theseus treats almost everything as a crate. When adding new functionality, determine if it should be a new crate in `kernel/`, `libs/`, or `applications/`.
- **Memory Management**: Avoid raw pointers. Use the `MappedPages` abstraction for memory-mapped I/O or hardware buffers to maintain the "intralingual" safety guarantees.
- **No Standard Library**: Most of the kernel and many libraries are `no_std`. Use `libtheseus` for OS-specific abstractions.

## Troubleshooting

- **SDL/Video Errors**: Usually caused by a missing or misconfigured X Server on WSL or macOS. Verify the `DISPLAY` variable.
- **Linker Errors**: Ensure the `rust-toolchain.toml` is respected. Theseus uses specific nightly versions of Rust.
- **Boot Failures**: If building from Docker and the boot fails, ensure the Docker image was built correctly and that you have sufficient permissions for the loop devices used during image creation.

## Reference documentation
- [Theseus Main README](./references/github_com_theseus-os_Theseus.md)
- [Theseus Project Wiki](./references/github_com_theseus-os_Theseus_wiki.md)