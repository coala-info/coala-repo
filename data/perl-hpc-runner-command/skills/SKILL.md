---
name: perl-hpc-runner-command
description: `perl-hpc-runner-command` (invoked via the `hpcrunner.pl` script) is a specialized framework for orchestrating data analysis on HPC clusters.
homepage: https://github.com/biosails/HPC-Runner-Command
---

# perl-hpc-runner-command

## Overview

`perl-hpc-runner-command` (invoked via the `hpcrunner.pl` script) is a specialized framework for orchestrating data analysis on HPC clusters. It transforms standard shell scripts into managed workflows by interpreting special comment-based directives. Use this skill when you need to automate bioinformatics pipelines that require job dependency tracking, resource allocation (CPU/Memory), and detailed execution logging without manually writing complex scheduler submission scripts (like Slurm or PBS).

## Project Initialization

To start a new analysis with a standardized directory structure:

```bash
hpcrunner.pl new MyProjectName
```
This creates a "sane" directory structure for organizing your scripts, data, and logs.

## Workflow File Syntax

Workflows are defined in `.sh` files using `#HPC` and `#TASK` directives.

### Job and Dependency Management
*   **Define a Job Group**: Use `#HPC jobname=name` to group subsequent commands.
*   **Set Dependencies**: Use `#HPC deps=jobname` to ensure a job only runs after the specified job completes successfully.
*   **Tag Specific Tasks**: Use `#TASK tags=label` for granular control within a job group.

### Resource Allocation
Specify scheduler variables directly in the workflow file:
*   `#HPC cpus_per_task=4`
*   `#HPC mem=16GB`
*   `#HPC partition=long`
*   `#HPC commands_per_node=1` (Controls how many tasks run simultaneously on a single allocation)

## Execution Patterns

### Cluster Submission
To submit a workflow to the cluster scheduler (e.g., Slurm):
```bash
hpcrunner.pl submit_jobs --infile my_workflow.sh
```

### Local or Interactive Execution
To run the same workflow on a local workstation or an interactive HPC node without a scheduler:
```bash
hpcrunner.pl single_node --infile my_workflow.sh
```

## Auditing and Results

The tool automatically creates an `hpc-runner` directory to store logs and metadata.

*   **View Execution Tree**: Use `tree hpc-runner` to see the log structure.
*   **Check Statistics**: Audit the success, failure, and timing of your jobs:
    ```bash
    hpcrunner.pl stats
    hpcrunner.pl stats -h  # For detailed help on stats filtering
    ```

## Expert Tips

*   **Composable Workflows**: You can declare dependencies between different job types. For example, a `blastx` job can depend on an `unzip` job by using `#HPC deps=unzip`.
*   **Task-Level Dependencies**: By using `#TASK tags` in both the parent and child jobs, you can make specific tasks depend on their counterparts (e.g., `blastx` for Sample1 only starts after `unzip` for Sample1 finishes).
*   **Logging**: `HPC::Runner::Command` is designed for "obsessive logging." Always check the `hpc-runner` directory if a task fails; it provides individual stdout/stderr for every task defined in your workflow.

## Reference documentation
- [HPC::Runner::Command Overview](./references/github_com_biosails_HPC-Runner-Command.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_perl-hpc-runner-command_overview.md)