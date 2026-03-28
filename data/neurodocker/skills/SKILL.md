---
name: neurodocker
description: Neurodocker automates the creation of Docker and Singularity container recipes for neuroimaging software. Use when user asks to generate container recipes, install neuroimaging tools like FSL or AFNI, or minify container images to reduce their size.
homepage: https://github.com/kaczmarj/neurodocker
---

# neurodocker

## Overview

Neurodocker is a command-line utility designed to automate the creation of container recipes for the neuroimaging community. Rather than manually scripting the installation of large, dependency-heavy software suites, you can use high-level CLI flags to define an environment. It handles the underlying complexity of environment variables, system dependencies, and installation paths for both Docker and Singularity formats. Additionally, it offers a minification feature that prunes unused files from a container based on the actual commands you intend to run, significantly reducing image size.

## Core CLI Patterns

### Generating Recipes
The primary workflow involves piping the output of the `generate` command into a file.

*   **Docker**: `neurodocker generate docker [options] > Dockerfile`
*   **Singularity**: `neurodocker generate singularity [options] > Singularity.def`

### Required Global Options
Every generation command requires a package manager and a base image:
*   `-p, --pkg-manager`: Use `apt` (Debian/Ubuntu) or `yum` (CentOS/Fedora).
*   `-b, --base-image`: Specify the starting image (e.g., `debian:bullseye-slim`).

### Common Software Flags
Software is added using specific flags, often accepting `key=value` pairs for configuration:
*   `--fsl`: Installs FMRIB Software Library. Use `version=6.0.7.1`.
*   `--afni`: Installs AFNI. Use `method=binaries` and `version=latest`.
*   `--ants`: Installs Advanced Normalization Tools. Use `version=2.4.3`.
*   `--freesurfer`: Installs FreeSurfer. Use `version=7.4.1`.
*   `--miniconda`: Installs a Python environment. Use `conda_install="numpy pandas"` or `pip_install="scipy"`.

## Expert Tips and Best Practices

### Non-Interactive Builds
Many neuroimaging tools (especially FSL) require license agreement prompts. Use the `--yes` flag to automatically accept these prompts during recipe generation for CI/CD or automated workflows.

### Environment Management
*   **User Switching**: Use `--user [name]` to create and switch to a non-root user for better security.
*   **Working Directory**: Use `--workdir /path` to set the default directory for subsequent commands.
*   **Copying Files**: Use `--copy source destination` to move local files (like FreeSurfer licenses) into the image.

### Minification Workflow
To reduce a 2GB image to a few hundred MBs:
1.  **Run the container**: `docker run --rm -itd --name my_container my_image:latest`
2.  **Trace usage**: Run `neurodocker minify --container my_container --dir /opt "my_analysis_command"`
3.  **Export**: Pipe the pruned container back into a new image: `docker export my_container | docker import - my_image_minified`

### Avoiding "Dirty" Recipes
Do not use the `-t` or `--tty` flag when running the neurodocker generator via `docker run`. This can inject non-printable characters into the resulting Dockerfile, causing build failures.

## Common CLI Examples

**Standard FSL + Miniconda Environment:**
```bash
neurodocker generate docker \
    --pkg-manager apt \
    --base-image debian:bullseye-slim \
    --yes \
    --fsl version=6.0.7.1 \
    --miniconda version=latest conda_install="notebook" \
    --user neuro \
    --workdir /home/neuro
```

**Multi-Software Singularity Recipe:**
```bash
neurodocker generate singularity \
    --pkg-manager yum \
    --base-image centos:7 \
    --ants version=2.3.4 \
    --afni method=binaries version=latest
```



## Subcommands

| Command | Description |
|---------|-------------|
| neurodocker | Neurodocker is a command-line interface to generate custom Dockerfiles and Singularity recipes. |
| neurodocker | Neurodocker is a command-line interface to generate custom Dockerfiles and Singularity recipes. |
| neurodocker | neurodocker: error: argument subparser_name: invalid choice: 'valid' (choose from 'generate', 'reprozip') |

## Reference documentation
- [Command-line Interface](./references/repronim_org_neurodocker_user_guide_cli.html.md)
- [Examples](./references/repronim_org_neurodocker_user_guide_examples.html.md)
- [Minify Containers](./references/repronim_org_neurodocker_user_guide_minify.html.md)
- [Installation](./references/repronim_org_neurodocker_user_guide_installation.html.md)