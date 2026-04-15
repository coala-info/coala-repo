---
name: pypeflow
description: pypeflow is a lightweight Python-native workflow management library used to define and execute data processing pipelines with dependency tracking. Use when user asks to manage complex file dependencies, wrap command-line tools into pipelines, or execute tasks on cluster resource managers like Slurm and PBS.
homepage: https://github.com/PacificBiosciences/pypeFLOW
metadata:
  docker_image: "quay.io/biocontainers/pypeflow:2.2.0--py27_0"
---

# pypeflow

## Overview
pypeflow is a lightweight, Python-native workflow management library that provides a declarative way to define data processing pipelines. It excels at wrapping command-line tools and managing complex file dependencies, ensuring that only necessary steps are re-run when data or scripts change. It serves as a robust alternative to traditional Makefiles for bioinformatics, offering better integration with Python and cluster resource managers like Slurm and PBS.

## Installation
The preferred method for installing pypeflow is via Bioconda:

```bash
conda install -c bioconda pypeflow
```

Alternatively, it can be installed from source:

```bash
python setup.py install
```

## Core Concepts and Best Practices

### Dependency Tracking
pypeflow operates on the principle of explicit modeling. Every task must have clearly defined inputs and outputs. The engine uses these to build a Directed Acyclic Graph (DAG) and determines which tasks need execution based on file timestamps and existence.

### Task Scripting
Tasks in pypeflow are typically defined as shell scripts wrapped in Python objects. 
- **Use `{input.ALL}`**: When a task has multiple inputs, you can use the `{input.ALL}` placeholder within your shell script to reference all input files at once.
- **Avoid Parameter Quoting**: Recent updates suggest avoiding manual quoting of parameters within the task scripts to prevent shell interpretation errors.

### Environment Management
Use the `PYPEFLOW_PRE` environment variable to define setup commands (like sourcing profiles or loading modules) that should run before every task script. This ensures a consistent execution environment across different nodes in a cluster.

### Cluster Integration with pwatcher
pypeflow uses a sub-component called `pwatcher` to handle job submissions.
- **Local Execution**: Default for small-scale testing.
- **Cluster Execution**: Supports Slurm, SGE, and PBS. 
- **Job IDs**: When using PBS, ensure the system is configured to return and track job IDs correctly for `qdel` operations.
- **Resource Configuration**: When using Slurm, ensure that memory (MB) and processor (NPROC) requirements are explicitly passed through the configuration to avoid default resource exhaustion.

### Workflow Organization
- **Modular Design**: Break complex pipelines into smaller, reusable Python functions that return task objects.
- **Clean Up**: pypeflow tracks intermediate files; ensure your output paths are organized into subdirectories to prevent root-level clutter in large-scale runs.

## Reference documentation
- [pypeflow - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pypeflow_overview.md)
- [PacificBiosciences/pypeFLOW: a simple lightweight workflow engine](./references/github_com_PacificBiosciences_pypeFLOW.md)
- [pypeFLOW Wiki - Home](./references/github_com_PacificBiosciences_pypeFLOW_wiki.md)