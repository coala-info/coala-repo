---
name: chimeraslayer
description: Manages bioinformatics packages and environments using the chimeraslayer tool. Use when user asks to install, update, search, or list chimeraslayer packages or manage bioinformatics environments.
homepage: https://anaconda.org/channels/bioconda/packages/chimeraslayer/overview
metadata:
  docker_image: "biocontainers/chimeraslayer:v20101212dfsg1-2-deb_cv1"
---

# chimeraslayer

chimeraslayer/
├── SKILL.md
└── references/
    └── anaconda_org_channels_bioconda_packages_chimeraslayer_overview.md
```

```markdown
name: chimeraslayer
description: |
  Manages and interacts with the chimeraslayer tool, a bioinformatics package manager.
  Use when Claude needs to perform tasks related to installing, updating, or querying chimeraslayer packages, or when managing bioinformatics environments using chimeraslayer.
  Specifically useful for tasks involving bioconda channel management and package resolution within a bioinformatics context.

## Overview
The chimeraslayer skill is designed to help manage bioinformatics software and dependencies using the chimeraslayer tool, which is often associated with the bioconda channel on Anaconda.org. This skill enables Claude to interact with chimeraslayer for installing, updating, and querying packages, facilitating the setup and maintenance of complex bioinformatics environments.

## Usage Instructions

Chimeraslayer is typically used via its command-line interface (CLI) for package management. The following are common patterns and expert tips for using chimeraslayer effectively.

### Core Commands

*   **Install a package:**
    ```bash
    chimeraslayer install <package_name>
    ```
    This command installs the specified package and its dependencies. It's recommended to specify the channel if known, especially for bioinformatics packages which are often on `bioconda`.

*   **Install a package from a specific channel:**
    ```bash
    chimeraslayer -c bioconda install <package_name>
    ```
    This is a crucial pattern for bioinformatics. Always consider specifying the `bioconda` channel to ensure you get the correct versions and dependencies.

*   **Update a package:**
    ```bash
    chimeraslayer update <package_name>
    ```
    Updates the specified package to the latest available version.

*   **Update all packages:**
    ```bash
    chimeraslayer update --all
    ```
    Updates all installed packages in the current environment. Use with caution, as this can sometimes lead to dependency conflicts.

*   **Search for a package:**
    ```bash
    chimeraslayer search <package_name_or_keyword>
    ```
    Searches for packages matching the query across all configured channels.

*   **List installed packages:**
    ```bash
    chimeraslayer list
    ```
    Displays all packages currently installed in the active environment.

*   **View package information:**
    ```bash
    chimeraslayer info <package_name>
    ```
    Shows detailed information about a specific installed package, including its version, build, and dependencies.

### Environment Management

Chimeraslayer often works within the context of Conda environments.

*   **Create a new environment:**
    ```bash
    chimeraslayer create -n <environment_name> python=<version>
    ```
    Creates a new environment with a specified Python version. You can add other packages during creation.

*   **Activate an environment:**
    ```bash
    conda activate <environment_name>
    ```
    Note: Activation is typically handled by `conda`, not directly by `chimeraslayer` commands themselves, but it's essential for using packages installed by chimeraslayer.

### Expert Tips

*   **Channel Priority:** Understand channel priority. `bioconda` should generally have a high priority for bioinformatics tools. You can manage channel priorities using `chimeraslayer config --set channel_priority strict` or by listing channels in order of preference in your `.condarc` file.
*   **Dependency Resolution:** If you encounter dependency conflicts, try installing packages one by one or specifying exact versions. Sometimes, creating a new, clean environment is the most effective solution.
*   **`--freeze-installed` flag:** When creating environments or installing packages, consider using `--freeze-installed` to prevent existing packages from being updated or changed, ensuring stability.
    ```bash
    chimeraslayer create -n my_env python=3.9 --freeze-installed
    ```
*   **`--strict-channel-priority`:** For critical environments, enforce strict channel priority to avoid unexpected package installations from lower-priority channels.
    ```bash
    chimeraslayer config --set channel_priority strict
    ```
*   **Troubleshooting 404 Errors:** A "404 Not Found" error, as seen in the provided documentation, typically indicates that the package or channel is not available at the specified URL. This could be due to a typo, the package being removed, or an incorrect channel configuration. Double-check package and channel names.

## Reference documentation
- [Anaconda.org - chimeraslayer overview](./references/anaconda_org_channels_bioconda_packages_chimeraslayer_overview.md)