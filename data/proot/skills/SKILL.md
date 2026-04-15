---
name: proot
description: This tool manages Linux distributions on Android via Termux without requiring root privileges. Use when user asks to list, install, remove, login to, backup, or restore Linux distributions.
homepage: https://github.com/termux/proot-distro
metadata:
  docker_image: "quay.io/biocontainers/proot:5.1.0--0"
---

# proot

## Overview

This skill enables the management of Linux distributions on Android via Termux. It utilizes `proot-distro` to provide a seamless way to install, run, and maintain various root file systems (distros) without requiring root privileges or special kernels. It is the standard method for running full Linux CLI environments and desktop environments on mobile devices.

## Usage Patterns

### Basic Management
- **List available distributions**: Use `proot-distro list` (alias: `ls`) to see which distributions are supported and which are currently installed.
- **Install a distribution**: Use `proot-distro install <alias>` (alias: `i`). Example: `proot-distro install debian`.
- **Remove a distribution**: Use `proot-distro remove <alias>` (alias: `rm`) to delete an installation and its files.

### Accessing Environments
- **Start a shell**: Use `proot-distro login <alias>` (alias: `sh`) to enter the distribution's root environment.
- **Run commands directly**: Execute a command inside the distro without entering an interactive shell by using the `--` separator:
  `proot-distro login <alias> -- <command>`
  Example: `proot-distro login ubuntu -- apt update`
- **Login as specific user**: Use the `--user <username>` flag if a non-root user has been created within the distro.

### Backup and Recovery
- **Create a backup**: Save the entire state of a distribution to a tarball:
  `proot-distro backup <alias> --output <filename>.tar.xz`
- **Restore from backup**: Reinstall a distribution from a previously created backup file:
  `proot-distro restore <filename>.tar.xz`

## Expert Tips and Best Practices

- **Use the Short Alias**: For faster typing in version 4.0.0+, use `pd` instead of `proot-distro`.
- **Post-Installation Maintenance**: Always run the distribution's native package manager update (e.g., `apt update && apt upgrade` for Debian/Ubuntu) immediately after a fresh install to ensure security patches are present.
- **Architecture Awareness**: Be aware that ARMv9 devices may require `qemu-user-arm` for 32-bit distributions as they lack native 32-bit instruction support.
- **Isolation Limits**: Remember that `proot` does not provide high-grade security isolation like Docker or virtual machines; it is a user-space implementation of `chroot`.
- **Shared Storage**: By default, Termux storage and the Android `/sdcard` (if permitted) are accessible within the proot environment, making it easy to move files between Android and the Linux distro.

## Reference documentation
- [PRoot Distro Main Documentation](./references/github_com_termux_proot-distro.md)