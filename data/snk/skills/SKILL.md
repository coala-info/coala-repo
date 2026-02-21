---
name: snk
description: The `snk` tool transforms Snakemake workflows into fully-functional command-line interfaces.
homepage: https://snk.wytamma.com
---

# snk

## Overview
The `snk` tool transforms Snakemake workflows into fully-functional command-line interfaces. It simplifies the distribution and execution of pipelines by handling environment management and providing a standardized CLI for workflow configuration. Use this skill to streamline the deployment of Snakemake-based analytical pipelines.

## Installation and Setup
Install `snk` via Conda from the Bioconda channel:
```bash
conda install bioconda::snk
```

## Core CLI Patterns
`snk` allows you to "install" a Snakemake workflow as a local executable.

### Workflow Installation
To create a CLI for a Snakemake workflow located in a GitHub repository or local directory:
```bash
snk install [workflow_path_or_url]
```
Once installed, the workflow becomes available as a command named after the repository or directory.

### Executing Workflows
Run an installed workflow using its generated CLI. `snk` automatically maps CLI flags to Snakemake configuration parameters:
```bash
[workflow-name] run --samples samples.csv --output results/
```

### Managing Workflows
- **List installed workflows**: `snk list`
- **Uninstall a workflow**: `snk uninstall [workflow-name]`
- **Inspect workflow configuration**: `[workflow-name] config`

## Best Practices
- **Environment Isolation**: Always use `snk` within a dedicated Conda environment to avoid dependency conflicts between different workflows.
- **Configuration**: Use the `--configfile` flag if you have complex nested configurations that are difficult to pass via CLI flags.
- **Dry Runs**: Before executing a heavy pipeline, use the Snakemake-inherited dry-run flag (usually passed through the `run` command) to validate the execution DAG.

## Reference documentation
- [snk Overview](./references/anaconda_org_channels_bioconda_packages_snk_overview.md)