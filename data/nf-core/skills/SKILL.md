---
name: nf-core
description: The nf-core tool is a command-line interface designed to manage, launch, and develop standardized Nextflow pipelines. Use when user asks to list available pipelines, launch a workflow with an interactive wizard, download pipelines for offline use, or create and lint new pipeline projects.
homepage: http://nf-co.re/
---


# nf-core

## Overview
The `nf-core` tool is a Python-based command-line interface designed to streamline the experience of working with Nextflow pipelines. It acts as a companion for users who need to discover and run validated workflows, as well as for developers building new pipelines that adhere to community standards. This skill focuses on the core CLI functionality for pipeline management, environment setup, and standardized development workflows.

## Installation and Setup
The `nf-core` helper tool is typically installed via Conda or Pip.

```bash
# Installation via Conda (recommended for bioinformatics environments)
conda install bioconda::nf-core

# Installation via Pip
pip install nf-core
```

## Common CLI Patterns

### Pipeline Discovery and Information
Use these commands to browse available pipelines and check for updates.

*   **List all pipelines**: `nf-core pipelines list`
    *   Displays all available nf-core pipelines, their latest version, and whether you have a local version cached.
*   **Check for updates**: The `list` command automatically flags if your local version is outdated compared to the latest GitHub release.

### Running and Launching Pipelines
While pipelines are executed via `nextflow run`, the `nf-core` tool provides a wizard to help configure complex parameters.

*   **Interactive Launch**: `nf-core pipelines launch <pipeline_name>`
    *   Starts an interactive command-line wizard that walks through all available parameters for a specific pipeline.
    *   It validates inputs and can save your configuration to a JSON or YAML file for reproducibility.
*   **Offline Usage**: `nf-core pipelines download <pipeline_name>`
    *   Downloads all necessary pipeline files and container images (Docker/Singularity) for use on systems without internet access.

### Development and Contribution
For developers creating or maintaining pipelines, `nf-core` enforces strict linting and structural standards.

*   **Create a new pipeline**: `nf-core pipelines create`
    *   Initializes a new pipeline based on the official nf-core template.
*   **Linting**: `nf-core pipelines lint <pipeline_dir>`
    *   Checks the code against nf-core community guidelines. This is a requirement for any pipeline to be officially joined to the nf-core organization.
*   **Schema Management**: `nf-core pipelines schema build`
    *   Helps create and edit the `nextflow_schema.json` file used for parameter validation and the launch wizard.

## Expert Tips
*   **Profile Selection**: Always use the `-profile` flag when running pipelines (e.g., `-profile docker` or `-profile singularity`) to ensure software dependencies are handled automatically.
*   **Version Specificity**: When running a pipeline, specify the version using the `-r` flag (e.g., `nextflow run nf-core/rnaseq -r 3.10.1`) to ensure long-term reproducibility of your analysis.
*   **Syncing**: If you are developing a pipeline, use `nf-core pipelines sync` to keep your pipeline's infrastructure up to date with the latest version of the nf-core template.

## Reference documentation
- [nf-core Overview](./references/nf-co_re_index.md)
- [Bioconda nf-core Package](./references/anaconda_org_channels_bioconda_packages_nf-core_overview.md)