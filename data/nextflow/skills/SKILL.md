---
name: nextflow
description: Nextflow is a reactive workflow framework used to develop and execute portable, reproducible computational pipelines across local and cloud environments. Use when user asks to run bioinformatics workflows, resume failed pipeline executions, manage DSL2 process channels, or configure execution profiles for Docker and HPC schedulers.
homepage: https://github.com/nextflow-io/nextflow
---


# nextflow

## Overview
Nextflow is a reactive workflow framework that enables the development of portable and reproducible computational pipelines. It uses a dataflow programming model where processes are connected via asynchronous FIFO channels. This skill provides expert-level patterns for writing Nextflow scripts, managing configuration profiles, and utilizing the command-line interface for local and cloud-based execution.

## Core CLI Patterns

### Execution and Resumption
The most critical feature of Nextflow is its ability to resume failed or modified runs using a local cache.
*   **Basic Run**: `nextflow run main.nf -profile standard`
*   **Resume**: `nextflow run main.nf -resume` (Always use this to avoid re-computing finished tasks).
*   **Specific Revision**: `nextflow run nextflow-io/hello -r master` (Runs a specific git branch/tag/commit).
*   **Parameter Input**: `nextflow run main.nf --input 'data/*.fastq.gz' --outdir results`

### Workflow Management
*   **Clean Cache**: `nextflow clean -f -quiet` (Removes temporary work directories for past runs).
*   **View History**: `nextflow log` (Lists previous executions and their statuses).
*   **Inspect Metadata**: `nextflow info <run_name_or_id>`

## DSL2 Best Practices

### Process Design
*   **Directives**: Define resources (cpus, memory, container) at the top of the process.
*   **Input/Output**: Use `path` for files and `val` for simple values.
*   **Script Block**: Use triple quotes `"""` for multi-line bash scripts.
*   **Shell Block**: Use `shell` instead of `script` if your bash code contains native `$` variables to avoid conflict with Nextflow variables (use `!{var}` for Nextflow variables in shell blocks).

### Channel Management
*   **Factory Methods**: Use `Channel.fromPath`, `Channel.fromFilePairs`, or `Channel.of`.
*   **Operators**: 
    *   `combine`: For Cartesian products.
    *   `join`: To merge channels based on a common key (e.g., sample ID).
    *   `map`: To transform channel content.
    *   `collect`: To gather all items into a single list.

## Configuration Strategy
Nextflow uses a hierarchical configuration system (`nextflow.config`).

*   **Profiles**: Define environment-specific settings (e.g., `docker`, `slurm`, `awsbatch`).
    ```groovy
    profiles {
        docker {
            docker.enabled = true
            process.container = 'biocontainers/samtools:v1.15.1_cv2'
        }
    }
    ```
*   **Process Selectors**: Assign resources to specific processes using labels.
    ```groovy
    process {
        withLabel: 'high_mem' {
            memory = 64.GB
            cpus = 16
        }
    }
    ```

## Expert Tips
*   **Stub Run**: Use `nextflow run main.nf -stub` to test workflow logic without executing heavy commands (requires a `stub:` block in processes).
*   **Visualization**: Generate execution reports on the fly:
    *   `nextflow run main.nf -with-report report.html`
    *   `nextflow run main.nf -with-dag flowchart.pdf`
    *   `nextflow run main.nf -with-timeline timeline.html`
*   **Environment Isolation**: Always use containers (Docker/Singularity) or Conda to ensure reproducibility across different machines.



## Subcommands

| Command | Description |
|---------|-------------|
| config | Print a project configuration |
| drop | Delete the local copy of a project |
| fs | File system operations |
| kuberun | Execute a workflow in a Kubernetes cluster (experimental) |
| lineage | Explore workflows lineage metadata |
| lint | Lint Nextflow scripts and config files |
| nextflow auth | Manage Seqera Platform authentication |
| nextflow launch | Launch a workflow in Seqera Platform |
| nextflow secrets | Manage pipeline secrets |
| nextflow_clean | Clean up project cache and work directories |
| nextflow_clone | Clone a project into a folder |
| nextflow_info | Print project and system runtime information |
| nextflow_inspect | Inspect process settings in a pipeline project |
| nextflow_log | Print executions log and runtime info |
| nextflow_view | View project script file(s) |
| pull | Download or update a project |
| run | Execute a pipeline project |

## Reference documentation
- [Nextflow GitHub Repository](./references/github_com_nextflow-io_nextflow.md)
- [Development Guidance (CLAUDE.md)](./references/github_com_nextflow-io_nextflow_blob_master_CLAUDE.md)
- [Basic Pipeline Example](./references/nextflow_io_basic-pipeline.html.md)