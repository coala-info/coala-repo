---
name: apptainer
description: Apptainer is a container platform designed for high-performance computing that executes applications in secure, portable, and immutable single-file images. Use when user asks to pull images from registries, build SIF files from definition files, run interactive shells, execute commands within containers, or access host GPUs and filesystems.
homepage: https://github.com/apptainer/apptainer
metadata:
  docker_image: "quay.io/biocontainers/apptainer:latest"
---

# apptainer

## Overview

Apptainer is a powerful container platform designed specifically for the needs of shared computing environments and High-Performance Computing (HPC). Unlike other container runtimes, Apptainer prioritizes "integration over isolation," meaning it makes it easy to access host resources like GPUs, high-speed networks, and parallel filesystems. It uses a unique single-file image format (SIF) that is immutable and easily shareable. Crucially, Apptainer maintains a secure user model where the user inside the container has the same privileges as the user outside, preventing unauthorized privilege escalation on shared systems.

## Common CLI Patterns

### Image Acquisition and Inspection
*   **Pull from Docker Hub**: `apptainer pull docker://ubuntu:22.04` (creates an `ubuntu_22.04.sif` file).
*   **Pull from OCI Registry**: `apptainer pull oras://registry.example.com/image:tag`.
*   **Inspect Metadata**: `apptainer inspect ubuntu.sif` to view build dates, labels, and original definition settings.

### Container Execution
*   **Interactive Shell**: `apptainer shell my_container.sif` (drops you into the container environment).
*   **Execute a Command**: `apptainer exec my_container.sif python3 script.py`.
*   **Run Default Script**: `apptainer run my_container.sif` (executes the `%runscript` defined in the image).
*   **Run directly from Docker Hub**: `apptainer run docker://alpine` (downloads and runs in one step).

### Building Images
*   **Build from Definition File**: `apptainer build my_image.sif image.def`.
*   **Convert Docker to SIF**: `apptainer build my_image.sif docker://godlovedc/lolcow`.
*   **Sandbox Mode**: `apptainer build --sandbox my_directory/ docker://ubuntu` (creates a writable directory for development).

## Expert Tips and Best Practices

### Resource Integration
*   **GPU Support**: Always use the `--nv` flag for NVIDIA GPUs or `--rocm` for AMD GPUs to inject the necessary host drivers into the container.
    *   Example: `apptainer exec --nv my_cuda_image.sif ./gpu_app`
*   **Binding Host Paths**: By default, Apptainer binds `$HOME`, `/tmp`, and `$PWD`. Use `--bind` (or `-B`) to map additional host directories.
    *   Example: `apptainer exec --bind /data:/mnt/data my_image.sif ls /mnt/data`

### Security and Permissions
*   **Unprivileged Builds**: On modern Linux kernels, you can build SIF files without root privileges using the `--fakeroot` flag.
*   **Writable Overlays**: Since SIF files are immutable, use `--overlay` to persist changes or write data to a specific layer without modifying the base image.
*   **User Identity**: Remember that you are the same user inside the container. If you cannot write to a directory on the host, you cannot write to it from inside the container.

### Compatibility
*   **Singularity Migration**: Apptainer is the successor to Singularity. Most `singularity` commands are aliased to `apptainer`, but updating scripts to use the `apptainer` binary is recommended for long-term compatibility.



## Subcommands

| Command | Description |
|---------|-------------|
| apptainer build | Build an Apptainer image |
| apptainer cache | Manage your local Apptainer cache. You can list/clean using the specific types. |
| apptainer capability | Manage Linux capabilities for users and groups. Capabilities allow you to have fine grained control over the permissions that your containers need to run. |
| apptainer checkpoint | Manage container checkpoint state (experimental) |
| apptainer completion | Generate the autocompletion script for apptainer for the specified shell. |
| apptainer config | Manage various apptainer configuration (root user only). The config command allows root user to manage various configuration like fakeroot user mapping entries. |
| apptainer delete | Deletes requested image from the library |
| apptainer exec | Run a command within a container |
| apptainer inspect | Show metadata for an image. Inspect will show you labels, environment variables, apps and scripts associated with the image determined by the flags you pass. |
| apptainer instance | Manage containers running as services. Instances allow you to run containers as background processes. This can be useful for running services such as web servers or databases. |
| apptainer key | Manage your trusted, public and private keys in your local or in the global keyring (local keyring: '~/.apptainer/keys' if 'APPTAINER_KEYSDIR' is not set, global keyring: '/usr/local/etc/apptainer/global-pgp-public') |
| apptainer keyserver | The 'keyserver' command allows you to manage standalone keyservers that will be used for retrieving cryptographic keys. |
| apptainer oci | Manage OCI containers. Allow you to manage containers from OCI bundle directories. NOTE: all oci commands requires to run as root. |
| apptainer overlay | The overlay command allows management of EXT3 writable overlay images. |
| apptainer plugin | The 'plugin' command allows you to manage Apptainer plugins which provide add-on functionality to the default Apptainer installation. |
| apptainer pull | The 'pull' command allows you to download or build a container from a given URI. |
| apptainer push | Upload image to the provided URI. The 'push' command allows you to upload a SIF container to a given URI (library:// or oras://). |
| apptainer registry | Manage authentication to OCI/Docker registries. The 'registry' command allows you to manage authentication to standalone OCI/Docker registries, such as 'docker://' or 'oras://'. |
| apptainer remote | Manage apptainer remote endpoints through its subcommands. A 'remote endpoint' is a group of services compatible with the container library API. |
| apptainer run | Run the user-defined default command within a container. This command will launch an Apptainer container and execute a runscript if one is defined for that container. |
| apptainer run-help | Show the user-defined help for an image |
| apptainer search | Search a Container Library for container images matching the search query. You can specify an alternate architecture, and/or limit the results to only signed images. |
| apptainer shell | Run a shell within a container |
| apptainer sif | Manipulate Singularity Image Format (SIF) images. A set of commands are provided to display elements such as the SIF global header, the data object descriptors and to dump data objects. It is also possible to modify a SIF file via this tool via the add/del commands. |
| apptainer sign | Add digital signature(s) to an image. The sign command allows a user to add one or more digital signatures to a SIF image. By default, one digital signature is added for each object group in the file. |
| apptainer test | Run the user-defined tests within a container |
| apptainer verify | The verify command allows a user to verify one or more digital signatures within a SIF image. |

## Reference documentation
- [Apptainer Index](./references/apptainer_org_index.md)
- [GitHub Apptainer Repository](./references/github_com_apptainer_apptainer.md)
- [Apptainer Get Started](./references/apptainer_org_get-started.md)