---
name: anadama2
description: AnADAMA2 is a workflow management framework that orchestrates complex data analysis tasks across local and high-performance computing environments. Use when user asks to run workflow scripts, dispatch tasks to HPC grids, perform dry runs to verify dependencies, or manage computational resources for data analysis.
homepage: http://huttenhower.sph.harvard.edu/anadama2
metadata:
  docker_image: "quay.io/biocontainers/anadama2:0.10.0--pyhdfd78af_0"
---

# anadama2

## Overview
AnADAMA2 is a workflow management framework designed to handle complex data analysis tasks with a focus on reproducibility and efficiency. It acts as a meta-scheduler that can dispatch tasks to local cores or high-performance computing (HPC) grids. By tracking dependencies between files and executables, it ensures that only necessary steps are re-run, while automatically logging the environment and commands used to produce results.

## Core CLI Usage
The primary interaction with AnADAMA2 is through its command-line interface. Use these patterns for efficient workflow management:

- **Basic Execution**: Run a workflow script directly.
  `python workflow_script.py --output <directory>`
- **Grid Execution**: Dispatch tasks to a cluster (e.g., SLURM, SGE) by specifying the scheduler.
  `python workflow_script.py --scheduler <scheduler_name> --jobs <number>`
- **Dry Run**: Preview tasks without executing them to verify the dependency graph.
  `python workflow_script.py --dry-run`
- **Resource Management**: Define memory and time requirements for tasks to prevent job failures on grids.
  `python workflow_script.py --mem <MB> --time <minutes>`

## Best Practices
- **Modular Design**: Subclass base grid meta-schedulers or reporters if the default behavior does not match the specific HPC environment.
- **Automated Documentation**: Always utilize the `auto-doc` feature to generate a summary of the workflow's logic and versions, ensuring the analysis remains interpretable over time.
- **Tracked Objects**: Ensure all input and output files are explicitly defined as tracked objects so AnADAMA2 can correctly identify which parts of the pipeline need updating.
- **Logging**: Use the default logger and command-line reporters to capture essential task information for audit trails.

## Reference documentation
- [AnADAMA2 Overview](./references/anaconda_org_channels_bioconda_packages_anadama2_overview.md)