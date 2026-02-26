---
name: sequana_pipetools
description: Sequana_pipetools is a utility for managing the lifecycle and execution of Snakemake-based bioinformatics pipelines within the Sequana ecosystem. Use when user asks to initialize new pipeline projects, diagnose SLURM log errors, visualize workflow DAGs, or generate configuration validation schemas.
homepage: https://github.com/sequana/sequana_pipetools
---


# sequana_pipetools

## Overview
sequana_pipetools is the foundational utility for the Sequana ecosystem, designed to streamline the lifecycle of Snakemake-based bioinformatics pipelines. It provides a standardized interface for pipeline developers to create new projects and for users to manage execution in High-Performance Computing (HPC) environments. This skill assists in project scaffolding, log introspection, and pipeline metadata management.

## Common CLI Patterns

### Project Initialization
To create a new Sequana pipeline skeleton using the official cookiecutter template:
```bash
sequana_pipetools --init-new-pipeline
```
Follow the interactive prompts to define the pipeline name, description, and keywords.

### HPC and SLURM Diagnostics
When running pipelines on a cluster, use the diagnostic tool to identify common errors in SLURM logs:
```bash
sequana_pipetools --slurm-diag
```
This command automatically scans the current directory and the `./logs` directory for files matching the `slurm` pattern and provides a summary of failures.

### Pipeline Introspection and Stats
To view statistics about Sequana pipelines currently installed on your system (including rule counts and wrappers used):
```bash
sequana_pipetools --stats
```

### Workflow Visualization
Convert Snakemake Directed Acyclic Graph (DAG) files from `.dot` format to images:
```bash
sequana_pipetools --dot2png dag.dot
```

### Configuration Management
For developers, generate a starting point for a validation schema from an existing configuration file:
```bash
sequana_pipetools --config-to-schema config.yaml > schema.yaml
```

### Shell Completion
Enable tab-completion for specific Sequana pipelines (e.g., fastqc, rnaseq) in a bash environment:
```bash
sequana_pipetools --completion <pipeline_name>
```

## Developer Best Practices
* **Standardized Options**: When writing the `main.py` for a new pipeline, import `sequana_pipetools.options` to use pre-built Click options like `ClickSnakemakeOptions`, `ClickSlurmOptions`, and `ClickInputOptions`. This ensures the pipeline API remains consistent with the rest of the Sequana ecosystem.
* **Modular Rules**: Use the Sequana wrappers (https://github.com/sequana/sequana-wrappers) in conjunction with pipetools to ensure rules are rigorously tested and reusable.
* **Schema Validation**: Always use the `--config-to-schema` output as a baseline and manually refine it to ensure robust input validation for your pipeline users.

## Reference documentation
- [Sequana Pipetools GitHub Repository](./references/github_com_sequana_sequana_pipetools.md)
- [Sequana Pipetools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sequana_pipetools_overview.md)