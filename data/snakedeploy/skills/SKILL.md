---
name: snakedeploy
description: Snakedeploy is a specialized tool designed to bridge the gap between a published Snakemake workflow and its local execution.
homepage: https://github.com/snakemake/snakedeploy
---

# snakedeploy

## Overview
Snakedeploy is a specialized tool designed to bridge the gap between a published Snakemake workflow and its local execution. It allows users to "install" a workflow from a remote repository without manually cloning the source code. By generating a local wrapper (a Snakefile that points to the remote source) and the necessary configuration boilerplate, it ensures that the workflow remains version-controlled and reproducible while allowing for local customization of parameters and environments.

## Installation
Install snakedeploy via the bioconda channel:
```bash
conda install -c bioconda snakedeploy
```

## Core CLI Usage

### Deploying a Workflow
The primary use case is deploying a remote workflow to a local directory. This creates a `Snakefile` that uses the `module` directive to pull the remote code, along with a `config/` directory.
```bash
snakedeploy deploy-workflow <github-repo-url> <local-destination-path> --tag <version-tag>
```
*   **Example**: `snakedeploy deploy-workflow https://github.com/snakemake-workflows/rna-seq-star-deseq2 . --tag v2.1.0`

### Managing Environments
To ensure long-term reproducibility, use snakedeploy to pin the specific versions of software in the workflow's Conda environments.
```bash
snakedeploy update-conda-envs --pin-envs
```
This command generates explicit environment files that lock every dependency to a specific build.

### Organizing Files
For workflows that involve complex file structures, use the collection subcommand to organize files into a tabular format:
```bash
snakedeploy collect-files
```

### Developer Scaffolding
If developing Snakemake plugins or new projects, snakedeploy provides scaffolding commands to generate the required directory structures and boilerplate:
*   **Plugin Scaffolding**: `snakedeploy scaffold plugin`
*   **Logger Scaffolding**: `snakedeploy scaffold logger-plugin`

## Best Practices
*   **Version Pinning**: Always specify a `--tag` or `--branch` when deploying to ensure you are not using the "main" branch, which may change and break reproducibility.
*   **Configuration**: After deployment, immediately inspect the generated `config/config.yaml`. Snakedeploy provides the schema-defined defaults, but you must provide the paths to your local data.
*   **Profile Deployment**: Use snakedeploy to manage execution profiles (e.g., for Slurm or SGE). Recent versions (v0.11+) automatically include profile directories and license files in the deployment.
*   **Clean Deployments**: Always deploy into a clean directory to avoid conflicts between the generated `Snakefile` and existing files.

## Reference documentation
- [snakedeploy - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_snakedeploy_overview.md)
- [GitHub - snakemake/snakedeploy](./references/github_com_snakemake_snakedeploy.md)
- [snakedeploy Tags/Releases](./references/github_com_snakemake_snakedeploy_tags.md)