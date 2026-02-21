---
name: apptainer
description: Apptainer is a specialized container platform designed for ease of use on shared systems and High-Performance Computing (HPC) environments.
homepage: https://github.com/apptainer/apptainer
---

# apptainer

## Overview
Apptainer is a specialized container platform designed for ease of use on shared systems and High-Performance Computing (HPC) environments. It utilizes the Singularity Image Format (SIF), an immutable single-file container format that is easily transported and shared. Unlike traditional container runtimes, Apptainer emphasizes integration over isolation, ensuring that the user inside the container has the same privileges and identity as the user outside, which simplifies access to host resources like GPUs, parallel filesystems, and network stacks.

## Core CLI Operations

### Running and Executing
* **Run the default command**: Use `apptainer run <image.sif>` to execute the runscript defined in the image metadata.
* **Execute specific commands**: Use `apptainer exec <image.sif> <command>` to run an arbitrary command within the container environment.
* **Interactive shell**: Use `apptainer shell <image.sif>` to spawn an interactive shell inside the container.
* **Instance management**: Use `apptainer instance start <image.sif> <name>` to run a container in the background as a service.

### Building Images
* **Build from a definition file**: Use `apptainer build <output.sif> <recipe.def>`.
* **Build from a URI**: Use `apptainer build <output.sif> docker://<image>:<tag>` to convert Docker/OCI images to SIF.
* **Rootless builds**: Use the `--fakeroot` flag to build images without root privileges. This utilizes user namespaces to simulate root during the build process.
* **Sandbox mode**: Use `apptainer build --sandbox <directory> <source>` to create a writable directory for development. Note that SIF files are immutable; changes require a sandbox or a new build.

### Image Management
* **Pulling images**: Use `apptainer pull <name.sif> <source>` to download and convert images from registries (Docker Hub, ORAS, IPFS).
* **Inspecting metadata**: Use `apptainer inspect <image.sif>` to view labels, runscripts, and environment variables defined in the image.

## Best Practices and Expert Tips

### Resource Integration
* **GPU Acceleration**: Use the `--nv` flag for NVIDIA GPUs or `--rocm` for AMD GPUs to automatically bind the necessary host drivers into the container.
* **Bind Mounts**: Apptainer automatically binds the user's `$HOME`, `/tmp`, and `/dev`. Use the `--bind` or `-B` flag (e.g., `-B /data:/mnt`) to map additional host directories.
* **Environment Variables**: Variables prefixed with `APPTAINERENV_` on the host are automatically converted to variables inside the container (e.g., `APPTAINERENV_FOO=bar` becomes `FOO=bar`).

### Security and Permissions
* **User Identity**: Remember that you are the same user inside the container as outside. You cannot gain additional privileges on the host system by default.
* **Security Flags**: Use `--security` options to apply SELinux or AppArmor profiles if required by the host environment.
* **Writable Storage**: If a container needs to write to its own filesystem (not a bind mount), use the `--writable-tmpfs` flag to add a temporary writable layer in RAM.

### Performance and Storage
* **Temporary Directory**: Set the `APPTAINER_TMPDIR` environment variable to a fast local disk (like `/scratch` or `/tmp`) to speed up image builds and prevent filling up the root partition.
* **Caching**: Manage the local image cache using `apptainer cache list` and `apptainer cache clean` to recover disk space.

## Reference documentation
- [Apptainer README](./references/github_com_apptainer_apptainer.md)
- [Security Policy and Advisories](./references/github_com_apptainer_apptainer_security.md)