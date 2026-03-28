---
name: kronos
description: Kronos is a workflow assembler and manager that orchestrates complex genome informatics and cancer genome analytics pipelines. Use when user asks to assemble multi-step workflows, manage task dependencies using Ruffus, or execute genomic pipelines on local systems and clusters.
homepage: https://github.com/jtaghiyar/kronos
---


# kronos

## Overview
Kronos is a specialized workflow assembler tailored for genome informatics and cancer genome analytics. It functions as a high-level manager that orchestrates complex, multi-step analytical procedures. By leveraging the Ruffus framework, it handles task dependencies and synchronization automatically. It is particularly effective for bioinformaticians who need to transition between local development and large-scale cluster execution while maintaining consistent task requirements and merging logic.

## Installation and Environment
Kronos is designed for Python 2.7 environments.

- **Core Installation**: Use `pip install kronos_pipeliner`.
- **Cluster Support**: To run workflows on a cluster using a job scheduler, the `drmaa-python` library (v0.7.6) must be installed.
- **Dependencies**: Ensure `ruffus` (v2.4.1) and `PyYaml` (v3.11) are present in the environment.

## Command Line Usage

### Workflow Initialization
Use the `make_config` command to generate the necessary configuration files for a new workflow.
- This command automatically populates the configuration with the current username and versioning information.
- It establishes the base structure required for defining tasks and global requirements.

### Pipeline Execution
The `run` command is the primary entry point for executing the assembled workflow.
- **Cluster Execution**: Use the `-b` or `--job_scheduler` flag followed by `drmaa` to submit jobs to a cluster environment.
- **Output Management**: Use the `--no_prefix` flag if you need to prevent the tool from adding prefixes to the input options during execution.

## Expert Workflow Patterns

### Managing Task Requirements
Kronos allows for granular control over software requirements:
- **Global vs. Local**: Requirements defined in a `GENERAL` section apply to all tasks unless overridden.
- **Task-Specific Overrides**: Each task can have its own requirements entry within its `run` subsection. This is useful when different steps of a pipeline require different versions of the same tool.

### Implicit Merging Logic
Kronos features an automated mechanism to merge outputs from parallel tasks.
- **Default Behavior**: Implicit merging is enabled by default (`merge` set to `True`).
- **Disabling Merges**: If a specific task requires an explicit or custom merge step, set the `merge` attribute to `False` in the task's run subsection.
- **Optimization**: Identical implicit merge tasks are automatically combined into a single task to reduce redundant processing.
- **Storage**: All merged files are consolidated into a dedicated directory named `merge`.

### Parallelization via Interval Files
To process genomic data in parallel chunks, utilize interval files.
- **Precedence**: When an interval file is provided for a task, it takes precedence over standard synchronization, meaning the task will not wait for its predecessors in the usual way.
- **Tagging**: You can add optional tags to each chunk in the interval file (separated by tabs). These tags serve as suffixes for the resulting task names, making it easier to track specific genomic regions through the pipeline.

### Resource Allocation
- **Memory**: Kronos supports floating-point values for memory requests, allowing for precise resource allocation on clusters.
- **Concurrency**: The tool utilizes multithreading to manage pipeline execution efficiently.



## Subcommands

| Command | Description |
|---------|-------------|
| kronos run | run kronos-made pipelines with optional initialization |
| kronos_init | initialize a pipeline from a given config file |
| make_component | make a template component |
| make_config | make a template config file |
| update_config | update the fields of a config file based on the ones from another one |

## Reference documentation
- [Kronos README](./references/github_com_jtaghiyar_kronos_blob_master_README.md)
- [Kronos Setup and Entry Points](./references/github_com_jtaghiyar_kronos_blob_master_setup.py.md)