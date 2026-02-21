---
name: galaxy-workflow-executor
description: The `galaxy-workflow-executor` is a utility designed to bridge the gap between Galaxy's web-based workflow system and CLI-driven environments.
homepage: https://github.com/ebi-gene-expression-group/galaxy-workflow-executor
---

# galaxy-workflow-executor

## Overview
The `galaxy-workflow-executor` is a utility designed to bridge the gap between Galaxy's web-based workflow system and CLI-driven environments. It leverages the BioBlend library to schedule workflows, upload datasets, and retrieve results. This skill provides the procedural knowledge required to prepare workflow files, generate parameter templates, and execute runs with robust state management for error recovery.

## Core CLI Usage

### 1. Workflow Preparation
Before execution, you must obtain the workflow definition in JSON format.
- **Action**: In the Galaxy UI, go to **Workflows** -> **Share workflow** -> **Download**.
- **Requirement**: Ensure workflow steps are annotated with **labels**. Labels are the primary keys used to map parameters and inputs in the CLI.

### 2. Generating Parameter Templates
Use the generator script to create a template for tool parameters based on your workflow labels.
```bash
generate_params_from_workflow.py -C galaxy_credentials.yaml -G <instance_name> -W workflow.json -o <output_dir>
```
- `-C`: Path to your Galaxy credentials (formatted like `parsec` config).
- `-G`: The specific Galaxy instance name defined in your credentials.
- `-W`: The downloaded workflow JSON file.

### 3. Executing the Workflow
The primary execution command handles data upload, tool configuration, and result retrieval.
```bash
run_galaxy_workflow.py -C galaxy_credentials.yaml -G <instance_name> -w workflow.json -p parameters.yaml -i inputs.yaml
```
**Key Flags:**
- `-i`: Path to the inputs file (mapping labels to local paths or Galaxy IDs).
- `-l` or `--library-name`: Upload results directly to a specific Galaxy Data Library (requires admin privileges).
- `--no-downloads`: Skip downloading results to the local filesystem.
- `--keep-histories`: Prevent the executor from deleting the history after completion.
- `--state-file`: Specify a custom path for the `exec_state.pickle` file.

## Expert Tips and Best Practices

### State Persistence and Recovery
The executor saves progress in `exec_state.pickle`. If a connection drops or a tool fails, re-running the command with the same working directory will attempt to resume from the last successful step.
- **Warning**: If you switch to a different workflow or change input files, delete the `.pickle` file or use `--state-file` to point to a new location to avoid state conflicts.

### Handling Input Data
- **Local Files**: Use absolute paths in your inputs configuration for reliability.
- **Existing Datasets**: If data is already in Galaxy, use `dataset_id` or `library_id` instead of a local path to save upload time.

### Error Management
- **Allowed Errors**: You can provide an optional YAML file to specify step labels that are permitted to fail without stopping the entire execution. This is useful for workflows with non-critical steps or known edge-case failures.
- **Cleanup**: By default, the tool deletes the workflow and history from the Galaxy instance upon success to save space. Use `--keep-histories` if you need to perform manual inspection or debugging in the UI.

### Result Retrieval
Only outputs marked as "visible" (the "eye" icon in the Galaxy Workflow Editor) are downloaded or moved to libraries. Ensure your workflow JSON has the correct output visibility settings before running the executor.

## Reference documentation
- [Galaxy workflow executor Overview](./references/github_com_ebi-gene-expression-group_galaxy-workflow-executor.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_galaxy-workflow-executor_overview.md)