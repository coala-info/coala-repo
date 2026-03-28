---
name: snk
description: The snk tool transforms Snakemake workflows into standalone command-line interfaces for easier execution and management. Use when user asks to install workflows from GitHub, manage workflow packages, or run Snakemake pipelines using structured CLI commands.
homepage: https://snk.wytamma.com
---

# snk

## Overview
The `snk` tool transforms standard Snakemake workflows into fully-featured, standalone CLIs. This abstraction allows users to interact with complex bioinformatics or data science pipelines without needing to manually edit configuration files or manage complex Snakemake command strings. Use this skill when you need to deploy a Snakemake workflow for end-users, integrate a pipeline into a larger automated system, or simplify the execution of workflows through a structured command-line interface.

## Installation and Setup
Install `snk` via pip or bioconda to begin managing workflows:

```bash
# Via pip
pip install snk

# Via bioconda
conda create -n snk bioconda::snk
```

## Workflow Management
`snk` acts as a package manager for Snakemake workflows.

### Installing Workflows
You can install workflows directly from GitHub repositories or from a local directory.

- **Basic Install**: `snk install wytamma/snk-basic-pipeline`
- **Custom Name**: `snk install wytamma/snk-basic-pipeline --name my-pipeline`
- **Specific Version/Tag**: `snk install wytamma/snk-basic-pipeline --tag v1.0.0`
- **With Dependencies**: Specify Snakemake versions or additional python packages.
  ```bash
  snk install snakemake-workflows/dna-seq-gatk-variant-calling \
    --name variant-calling \
    --snakemake 8.10.8 \
    -d pandas==1.5.3 -d numpy==1.26.4
  ```

### Managing Installed CLIs
Once installed, the workflow becomes a command available in your shell.
- **List all**: `snk list`
- **Remove**: `snk uninstall my-pipeline`

## Using the Generated CLI
Every workflow installed via `snk` generates a CLI with a consistent structure: `[workflow-name] [command] [options]`.

### Running Pipelines
The `run` command is the primary entry point. Configuration options defined in the Snakemake `config.yaml` are automatically converted into CLI flags.

- **View available flags**: `my-pipeline run --help`
- **Execute with custom config**: `my-pipeline run --samples data/samples.tsv --genome hg38`
- **Resource folders**: Use `-r` or `--resource` to point to specific data or config directories.
  ```bash
  my-pipeline run -r .test/config -r .test/data
  ```

### Visualization and Inspection
- **Create a DAG**: Generate a visual representation of the workflow.
  ```bash
  my-pipeline run --dag dag.pdf
  ```
- **Check Info**: View metadata about the installed workflow.
  ```bash
  my-pipeline info
  ```

## Expert Tips
- **Dynamic Arguments**: If a Snakemake config has nested keys, `snk` typically flattens them or uses a dot-notation for the CLI flags. Always check `run --help` after installation to see the exact flag names.
- **Interoperability**: Because `snk` wraps workflows as standard CLIs, they can be easily called from Nextflow, Galaxy, or simple Bash scripts as modular components.
- **Testing**: Use the `.test` resources often bundled in Snakemake repos to verify the installation: `my-pipeline run --use-conda --conda-prefix ~/.conda -r .test/data`.



## Subcommands

| Command | Description |
|---------|-------------|
| snk create | Create a default snk.yaml project that can be installed with snk |
| snk edit | Access the snk.yaml configuration file for a workflow. |
| snk install | Install a workflow. |
| snk list | List the installed workflows. |
| snk uninstall | Uninstall a workflow. |

## Reference documentation
- [Snk README](./references/github_com_Wytamma_snk_blob_master_README.md)
- [Managing Workflows](./references/snk_wytamma_com_managing_workflows.md)
- [Snk-CLI Run Command](./references/snk_wytamma_com_snk-cli_run.md)