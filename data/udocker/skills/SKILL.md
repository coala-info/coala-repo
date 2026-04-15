---
name: udocker
description: udocker provides Docker-like container capabilities in user space without requiring root privileges or a daemon. Use when user asks to pull, create, run, or inspect container images and instances, search for images, get an interactive shell, mount volumes, or import Docker tarballs.
homepage: https://github.com/indigo-dc/udocker
metadata:
  docker_image: "quay.io/biocontainers/udocker:1.1.1--py27_0"
---

# udocker

## Overview

udocker is a specialized tool designed to provide Docker-like capabilities in user space. It allows users to download and run containers without requiring a background service (daemon) or administrative rights. It works by extracting container filesystems and using various "execution modes" to simulate a root-like environment or leverage user namespaces. This makes it an essential tool for researchers and developers working on restricted shared infrastructure who need to ensure environment reproducibility.

## Core CLI Workflow

The standard udocker workflow follows a three-step process: pull the image, create the container instance, and execute.

### 1. Image Management
*   **Search for images**: `udocker search <image_name>`
*   **Pull an image**: `udocker pull <repo/image:tag>`
*   **List downloaded images**: `udocker images` (or `udocker -l`)
*   **Remove an image**: `udocker rmi <repo/image:tag>`

### 2. Container Lifecycle
*   **Create a container**: `udocker create --name=<my_container> <repo/image:tag>`
*   **List created containers**: `udocker ps`
*   **Rename a container**: `udocker rename <old_name> <new_name>`
*   **Delete a container**: `udocker rm <container_id>`

### 3. Execution and Interaction
*   **Run a command**: `udocker run <container_id> <command>`
*   **Interactive shell**: `udocker run -i -t <container_id> /bin/bash`
*   **Mounting volumes**: `udocker run -v /path/on/host:/path/in/container <container_id>`
*   **Environment variables**: `udocker run -e VAR=VALUE <container_id>`

## Advanced Configuration and Performance

### Execution Modes
udocker supports multiple engines to run containers. If a container fails or runs slowly, try changing the execution mode using `udocker setup --execmode=<mode> <container_id>`.

*   **P1 (PRoot)**: The most compatible mode; works on almost all systems but has higher performance overhead.
*   **R1 (runc)**: Better performance; requires user namespaces to be enabled on the host.
*   **F1 (Fakechroot)**: Uses LD_PRELOAD; fast but may have compatibility issues with certain binaries.
*   **S1 (Singularity)**: Uses the host's Singularity installation if available.

### Maintenance and Debugging
*   **Inspect metadata**: `udocker inspect <container_id>`
*   **Locate container files**: `udocker inspect -p <container_id>` (Useful for manual file manipulation in `$HOME/.udocker/containers`).
*   **Debug output**: Use the `-D` flag before the command (e.g., `udocker -D run <container_id>`) to see detailed execution logs.

## Expert Tips
*   **Storage Location**: By default, udocker stores everything in `$HOME/.udocker`. If your home directory has a small quota, change the location by setting the `UDOCKER_DIR` environment variable.
*   **Importing Docker Tarballs**: If you cannot pull from a registry, you can load images exported from a standard Docker engine using `udocker load -i <image.tar>`.
*   **NVIDIA Support**: For GPGPU applications, use the `--nvidia` flag during `run` to attempt to pass through host GPU drivers.

## Reference documentation
- [udocker GitHub Repository](./references/github_com_indigo-dc_udocker.md)
- [udocker Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_udocker_overview.md)