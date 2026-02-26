---
name: neurodocker
description: Neurodocker generates custom Dockerfiles and Singularity recipes for neuroimaging environments and minifies existing containers. Use when user asks to create reproducible scientific environments, build Docker or Singularity images, or minimize container size.
homepage: https://github.com/kaczmarj/neurodocker
---


# neurodocker

neurodocker/SKILL.md
---
name: neurodocker
description: |
  Generates custom Dockerfiles and Singularity recipes for neuroimaging environments and minifies existing containers. Use when you need to:
  - Create reproducible scientific environments for neuroimaging software.
  - Build Docker or Singularity images with specific software packages and dependencies.
  - Minimize the size of existing Docker containers.
  - Generate Dockerfiles or Singularity recipes programmatically.
---
## Overview

Neurodocker is a command-line tool designed to simplify the creation and management of containerized environments for neuroimaging research. It allows users to generate custom Dockerfiles and Singularity recipes, specifying desired software packages, versions, and configurations. Additionally, it can be used to minify existing Docker containers, reducing their size for more efficient storage and distribution.

## Usage Instructions

Neurodocker is primarily used via its command-line interface (CLI). The core functionality involves specifying the desired output format (Dockerfile or Singularity recipe) and listing the software packages and their configurations.

### Generating Dockerfiles and Singularity Recipes

The general syntax for generating container recipes is:

```bash
neurodocker <output_format> --pkg <package_specifications> [options]
```

Where:
- `<output_format>` can be `dockerfile` or `singularity`.
- `<package_specifications>` are arguments that define the software to be installed.

#### Common Package Specifications:

*   **Conda packages**: Use `--conda <package_name>`. You can specify channels with `--conda-channel <channel_name>`.
    ```bash
    neurodocker dockerfile --conda neuroimaging --conda-channel conda-forge
    ```
*   **Pip packages**: Use `--pip <package_name>`.
    ```bash
    neurodocker dockerfile --pip nipype
    ```
*   **System packages**: Use `--install <package_name>`.
    ```bash
    neurodocker dockerfile --install git vim
    ```
*   **Custom commands**: Use `--run <command>`.
    ```bash
    neurodocker dockerfile --run "apt-get update && apt-get install -y --no-install-recommends some-package"
    ```

#### Example: Creating a Dockerfile with FSL and ANTs

```bash
neurodocker dockerfile \
  --conda fsl ants \
  --conda-channel conda-forge \
  --install git \
  --run "echo 'Neurodocker setup complete.'"
```

This command will generate a Dockerfile that installs FSL and ANTs from conda, adds the `conda-forge` channel, installs `git` as a system package, and runs a final command.

#### Example: Creating a Singularity Recipe with NiBabel

```bash
neurodocker singularity \
  --pip nibabel \
  --install wget \
  --run "echo 'NiBabel installed.'"
```

This command generates a Singularity recipe.

### Minifying Docker Containers

Neurodocker can also be used to reduce the size of existing Docker containers. This typically involves running neurodocker within the container itself to analyze and remove unnecessary files.

```bash
docker run --rm repronim/neurodocker:latest minify <image_name>
```

Replace `<image_name>` with the name of the Docker image you want to minify.

### Advanced Options

*   **Base image**: Specify a base image using `--base <image_name>`.
    ```bash
    neurodocker dockerfile --base ubuntu:20.04 --conda fsl
    ```
*   **Working directory**: Set the working directory with `--workdir <path>`.
    ```bash
    neurodocker dockerfile --workdir /app --conda fsl
    ```
*   **User**: Specify a user for the container with `--user <username>`.
    ```bash
    neurodocker dockerfile --user neuro --conda fsl
    ```

### Expert Tips

*   **Combine package managers**: Neurodocker supports mixing conda, pip, and system package installations within a single recipe.
*   **Use `--conda-channel`**: Explicitly specify channels like `conda-forge` or `bioconda` to ensure package availability and version control.
*   **Leverage `--run` for complex setup**: For installations that require multiple steps or specific configurations, use the `--run` command to execute shell commands.
*   **Check the build status**: Refer to the neurodocker documentation for build status pages of supported software to identify reliable base images.
*   **Iterative development**: Start with a minimal set of packages and gradually add more as needed, rebuilding and testing your container at each step.

## Reference documentation
- [Overview](./references/anaconda_org_channels_bioconda_packages_neurodocker_overview.md)
- [Neurodocker GitHub Repository](./references/github_com_ReproNim_neurodocker.md)
- [Neurodocker Documentation (Docs)](./references/github_com_ReproNim_neurodocker_tree_master_docs.md)
- [Neurodocker Wiki](./references/github_com_ReproNim_neurodocker_wiki.md)