---
name: perl-biox-workflow-command
description: BioX-Workflow-Command is an opinionated templating system designed to streamline the creation and execution of bioinformatics pipelines.
homepage: https://github.com/biosails/BioX-Workflow-Command
---

# perl-biox-workflow-command

## Overview

BioX-Workflow-Command is an opinionated templating system designed to streamline the creation and execution of bioinformatics pipelines. It transforms high-level workflow definitions into executable commands, providing a structured way to handle complex genomic data processing. Use this skill to navigate the `biox` command-line interface for rapid pipeline prototyping and execution management.

## Command Line Interface Patterns

### Workflow Execution
The primary command for running pipelines is `biox run`.
- **Standard Run**: Execute a workflow by specifying the workflow file with `-w` or `--workflow`.
- **HPC Dependency Generation**: Use the `--auto_deps` flag to automatically create HPC dependencies. This feature relies on accurately defined INPUT and OUTPUT parameters within the workflow structure to calculate the execution graph.

### Workflow Scaffolding
- **Create New Workflow**: Use `biox new` to generate a boilerplate workflow file. You can pre-define rules using the `--rules` flag followed by a comma-separated list (e.g., `rule1,rule2,rule3`).
- **Extend Existing Workflow**: Use `biox add` to append new rules to an existing workflow file without overwriting previous configurations.

### Maintenance and Auditing
- **File Status**: Use `biox stats` to generate a table showing the status of files defined in the workflow. This requires the workflow to have explicit INPUT and OUTPUT definitions for each rule.
- **Help and Documentation**: 
    - Global help: `biox --help` or `biox-workflow.pl --help`.
    - Command-specific help: `biox [command] --help` (e.g., `biox run --help`).

## Expert Tips and Best Practices

- **Input/Output Accuracy**: The utility of `biox stats` and `--auto_deps` is entirely dependent on the completeness of the INPUT/OUTPUT definitions. Ensure these are accurate to avoid broken dependency chains in HPC environments.
- **Legacy Entry Points**: In some environments, the tool may be accessed via the `biox-workflow.pl` script. The arguments remain consistent with the `biox` wrapper.
- **Rule Management**: When scaffolding with `biox new`, include the most common steps of your pipeline (e.g., `align,sort,index`) to generate the necessary variables and placeholders immediately.
- **Symbolic Links**: Be aware that certain versions (e.g., 2.3.2) may have known issues following symbolic links; verify file paths if the tool fails to locate inputs.

## Reference documentation
- [BioX-Workflow-Command GitHub Repository](./references/github_com_biosails_BioX-Workflow-Command.md)
- [BioX-Workflow-Command Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-biox-workflow-command_overview.md)