---
name: kronos
description: Kronos is a Python-based workflow assembler that automates the creation and execution of modular bioinformatics pipelines for cancer genome analytics. Use when user asks to assemble genomic workflows, manage task dependencies, execute pipelines on HPC clusters, or perform implicit file merging and data chunking.
homepage: https://github.com/jtaghiyar/kronos
---


# kronos

## Overview
Kronos is a specialized Python-based workflow assembler tailored for cancer genome analytics and informatics. It transforms modular bioinformatics tools into cohesive, automated pipelines. By managing task dependencies and providing built-in mechanisms for implicit file merging and data chunking, Kronos allows developers to focus on the analytical logic of their genomic workflows rather than the underlying execution plumbing.

## Installation
Kronos requires Python 2.7.5. It can be installed via the Python Package Index or Conda:

- **Using pip**: `pip install kronos_pipeliner`
- **Using Conda**: `conda install bioconda::kronos`

## Core CLI Operations

### Initializing a Workflow
To begin a new project, use the configuration generator to create the necessary setup files.
- **Command**: `kronos make_config`
- **Tip**: This command automatically populates the configuration with the current username and version metadata.

### Executing Workflows
The `run` command is the primary entry point for pipeline execution.
- **Basic Execution**: `kronos run`
- **Removing Prefixes**: Use the `--no_prefix` flag if you need to prevent the tool from prepending task-specific prefixes to output files.
- **Multithreading**: As of version 2.1.0, Kronos utilizes multithreading for task management, improving performance on multi-core systems.

### Cluster Integration and Scheduling
Kronos supports execution on high-performance computing (HPC) clusters using DRMAA.
- **Requirement**: Ensure `drmaa-python` is installed.
- **Command**: `kronos run -b drmaa` or `kronos run --job_scheduler drmaa`
- **Memory Management**: Kronos supports floating-point values for memory requests in task requirements.

## Advanced Workflow Management

### Task Merging
Kronos features an "implicit merge" mechanism that automatically combines outputs from parallel tasks.
- **Implicit Merge**: Enabled by default. It combines identical implicit merge tasks into a single operation to save resources.
- **Disabling Merge**: If a specific task requires manual or explicit merging, set the `merge` attribute to `False` in the task's run subsection.
- **Storage**: All merged files are stored in a dedicated directory named `merge`.

### Data Chunking with Interval Files
For tasks that process genomic regions, use interval files to define chunks.
- **Precedence**: If a task is assigned an interval file, it takes precedence over standard synchronization with predecessor tasks.
- **Tagging**: You can add optional tags to each chunk in an interval file (tab-separated). These tags are used as suffixes for the resulting task names.
  - *Format*: `chunk1 tag1 chunk2 tag2`

### Task-Specific Requirements
While a `__GENERAL__` section can define global requirements, you can override these for specific tasks.
- **Precedence**: Requirements listed in a specific task's `run` subsection take precedence over the `__GENERAL__` section. This allows you to use different versions of the same software for different steps in the pipeline.

## Reference documentation
- [GitHub - jtaghiyar/kronos](./references/github_com_jtaghiyar_kronos.md)
- [Kronos Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kronos_overview.md)
- [Kronos Commit History and Changelog](./references/github_com_jtaghiyar_kronos_commits_master.md)