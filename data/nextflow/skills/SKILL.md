---
name: nextflow
description: Nextflow is a reactive workflow framework and domain-specific language used to create and manage scalable, data-driven pipelines across diverse computing infrastructures. Use when user asks to run or resume computational workflows, manage pipeline configurations, execute scripts across different infrastructure profiles, or orchestrate complex data processing tasks using channels and operators.
homepage: https://github.com/nextflow-io/nextflow
---


# nextflow

## Overview
Nextflow is a reactive workflow framework and domain-specific language (DSL) designed to simplify the creation of complex data-driven pipelines. It leverages the dataflow programming model, where processes are connected via asynchronous channels, allowing for inherent parallelism and high scalability. This skill provides the necessary patterns for writing robust `.nf` scripts, managing configuration profiles, and executing workflows across diverse infrastructure from local machines to AWS Batch or Google Cloud.

## Core CLI Patterns

### Execution and Resume
The most common way to run a pipeline. Always use `-resume` to leverage Nextflow's caching mechanism.
```bash
# Run a local script with a specific profile
nextflow run main.nf -profile docker -resume

# Run a pipeline directly from GitHub
nextflow run nextflow-io/hello -revision master

# Pass parameters to the script
nextflow run main.nf --input 'data/*.fastq.gz' --outdir results/
```

### Environment Management
Nextflow handles dependencies through containers or package managers.
*   **Docker/Podman**: `-with-docker [image]` or `-with-podman`
*   **Conda**: `-with-conda [env.yaml]`
*   **Singularity**: `-with-singularity [image_path]`

### Inspection and Troubleshooting
```bash
# List all previous executions
nextflow log

# Clean up temporary work files for a specific run
nextflow clean -id [run_id]

# Generate execution reports
nextflow run main.nf -with-report report.html -with-timeline timeline.html -with-dag flowchart.png
```

## Expert Best Practices

### 1. The Work Directory
Nextflow executes every task in a unique subdirectory within the `work/` folder. 
*   **Never** manually modify files inside `work/`.
*   If a run fails, check the hidden `.command.log`, `.command.err`, and `.command.sh` files inside the specific task's work directory to debug the exact shell script that was executed.

### 2. Configuration Hierarchy
Use `nextflow.config` to separate code from configuration.
*   **Params**: Use `params` for variables that change per run (e.g., input paths).
*   **Profiles**: Define `profiles` for different environments (e.g., `local`, `slurm`, `awsbatch`).
*   **Process Selectors**: Use `withName:PROCESS_NAME` or `withLabel:label_name` to assign specific resources (CPU, Memory) to processes without hardcoding them in the script.

### 3. Channel Logic
*   **Value Channels**: Use `Channel.value()` or `Channel.of()` for parameters that need to be reused by every instance of a process.
*   **Queue Channels**: Use `Channel.fromPath()` or `Channel.fromFilePairs()` for data that should be consumed once.
*   **Operators**: Use `.combine()`, `.join()`, and `.groupTuple()` to coordinate data flow between processes.

### 4. Resource Management
Always define dynamic resource retries in your config to handle transient "Out of Memory" errors:
```groovy
process {
    errorStrategy = { task.exitStatus in [140,143,137,104,134,139] ? 'retry' : 'terminate' }
    maxRetries = 3
    memory = { 8.GB * task.attempt }
    cpus = { 1 * task.attempt }
}
```

## Reference documentation
- [Nextflow GitHub Repository](./references/github_com_nextflow-io_nextflow.md)
- [Bioconda Nextflow Package](./references/anaconda_org_channels_bioconda_packages_nextflow_overview.md)