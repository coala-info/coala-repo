---
name: macsylib
description: macsylib is a Python library and toolset for detecting complex macromolecular systems in prokaryotic genomes by managing and searching biological models. Use when user asks to list available models, search for or install model packages, validate model integrity, or retrieve citation information for specific models.
homepage: https://github.com/gem-pasteur/macsylib
---


# macsylib

## Overview

`macsylib` is a specialized Python library and toolset designed for the detection of complex macromolecular systems (such as secretion systems or pili) in prokaryotic genomes. It provides the framework for modeling these systems and searching for them within protein datasets using similarity searches. The primary command-line interface, `msl_data` (formerly `macsydata`), is used to manage the lifecycle of biological models, including discovery, installation, and validation.

## Core CLI Usage

The `msl_data` tool is the primary interface for managing the models required for system detection.

### Model Management
*   **List available models**: View all model packages available in the remote `macsy-models` repository.
    ```bash
    msl_data available
    ```
*   **Search for models**: Find specific model packages by keyword.
    ```bash
    msl_data search <query>
    ```
*   **Install a model package**: Download and install a specific model package.
    ```bash
    msl_data install <package_name>
    ```
*   **Uninstall a model package**:
    ```bash
    msl_data uninstall <package_name>
    ```

### Validation and Citation
*   **Check model integrity**: Validate the grammar and structure of a model package. Use the `--grammar` flag for specific version checks (available in v1.0.4+).
    ```bash
    msl_data check <path_to_model> --grammar <version>
    ```
*   **Get citation information**: Retrieve the correct citation for a specific model package to ensure proper academic credit.
    ```bash
    msl_data cite <package_name>
    ```

## Expert Tips and Best Practices

*   **HMMER Dependency**: `macsylib` requires `hmmer >= 3.1`. Ensure HMMER is installed and available in your system PATH before running detection workflows.
*   **Model Decoupling**: Models are no longer shipped with the library. Always use `msl_data` to fetch the latest versions of models from the `macsy-models` repository.
*   **Manual Installation**: For models not hosted in the official repository, download the archive (do not extract it) and use `msl_data` to install it from the local file.
*   **Virtual Environments**: It is highly recommended to install `macsylib` within a dedicated Python virtual environment to avoid dependency conflicts with other bioinformatics tools.
*   **Grammar Versioning**: If you are developing or modifying models, use `msl_data check` frequently. Version 1.0.4 introduced deep model checking which is essential for ensuring compatibility with the latest search engine logic.

## Reference documentation
- [MacSyLib GitHub Repository](./references/github_com_gem-pasteur_macsylib.md)
- [MacSyLib Release Tags and Version History](./references/github_com_gem-pasteur_macsylib_tags.md)
- [Bioconda MacSyLib Overview](./references/anaconda_org_channels_bioconda_packages_macsylib_overview.md)