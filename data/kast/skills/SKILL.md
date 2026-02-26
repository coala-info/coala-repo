---
name: kast
description: "Manages Conda packages and environments, primarily for the bioconda channel. Use when user asks to install, update, remove, or search for bioconda packages, or when managing Conda environments for bioinformatics workflows."
homepage: https://github.com/DelphiWorlds/Kastri
---


# kast

yaml
name: kast
description: |
  Manages Conda packages and environments, primarily for the bioconda channel.
  Use when needing to install, update, remove, or search for bioconda packages,
  or when managing Conda environments for bioinformatics workflows.
```
## Overview
The `kast` skill is designed to help manage Conda packages and environments, with a specific focus on the bioconda channel. It allows users to perform common Conda operations such as installing, updating, and removing packages, as well as searching for available software. This skill is particularly useful for bioinformatics and scientific computing workflows where Conda and bioconda are standard package management tools.

## Usage

The `kast` tool is primarily used via its command-line interface (CLI). Here are some common and expert usage patterns:

### Package Management

*   **Install a package:**
    ```bash
    kast install <package_name>
    ```
    To install a specific version:
    ```bash
    kast install <package_name>=<version>
    ```
    To install from a specific channel (e.g., bioconda):
    ```bash
    kast install -c bioconda <package_name>
    ```

*   **Update a package:**
    ```bash
    kast update <package_name>
    ```
    To update all packages in the current environment:
    ```bash
    kast update --all
    ```

*   **Remove a package:**
    ```bash
    kast remove <package_name>
    ```

*   **Search for packages:**
    ```bash
    kast search <package_name_or_keyword>
    ```
    To search specifically within the bioconda channel:
    ```bash
    kast search -c bioconda <package_name_or_keyword>
    ```

### Environment Management

*   **Create a new environment:**
    ```bash
    kast create --name <environment_name> <package1> <package2> ...
    ```
    To create an environment with packages from specific channels:
    ```bash
    kast create -c conda-forge -c bioconda --name my_env python=3.9 pandas numpy
    ```

*   **Activate an environment:**
    ```bash
    conda activate <environment_name>
    ```
    (Note: `kast` itself doesn't activate environments; this is a standard `conda` command.)

*   **List all environments:**
    ```bash
    kast env list
    ```
    or
    ```bash
    conda info --envs
    ```

*   **Remove an environment:**
    ```bash
    kast env remove --name <environment_name>
    ```

### Advanced Tips

*   **Pinning packages:** To ensure a specific version of a package is always used in an environment, you can create a `environment.yml` file and use `conda env create` or `conda env update`.
*   **Exporting environments:** To share your environment configuration:
    ```bash
    kast env export > environment.yml
    ```
*   **Using `conda-forge` and `bioconda`:** For bioinformatics, it's common to use both `conda-forge` (for general scientific packages) and `bioconda` (for specialized biological software). Always specify channels when installing to ensure you get the correct versions and dependencies.
    ```bash
    kast install -c bioconda -c conda-forge <package_name>
    ```
*   **Troubleshooting dependency conflicts:** If you encounter dependency issues, try creating a new environment with the specific packages you need, or consult the bioconda documentation for known compatibility issues.

## Reference documentation
- [Kast Overview (bioconda)](./references/anaconda_org_channels_bioconda_packages_kast_overview.md)