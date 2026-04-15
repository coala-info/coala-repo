---
name: ucsc-para
description: The ucsc-para skill manages the Parasol job-scheduling system for genomic pipelines. Use when user asks to submit jobs, monitor job status, recover failed jobs, wait for jobs to complete, manage worker nodes, manage the job scheduler hub, check node status, download data in parallel, or synchronize data across nodes.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-para:469--h664eb37_1"
---

# ucsc-para

## Overview
The `ucsc-para` skill provides procedural knowledge for working with Parasol, a lightweight job-scheduling system developed by the UCSC Genome Browser team. Unlike heavy-duty schedulers, Parasol is specifically optimized for genomic pipelines that require executing massive numbers of relatively short-lived processes. This skill covers the management of the Parasol hub and nodes, job submission workflows, and the use of utility tools like `paraFetch` and `paraSync` for data handling in a distributed environment.

## Core CLI Patterns

### Job Submission Workflow
The standard process for running a batch of jobs involves creating a job list file (usually one command per line) and using the `para` command to manage the lifecycle.

1.  **Initialize and Push**:
    `para create jobList.txt`
    `para push`
    *Note: This registers the jobs with the `paraHub` and begins distribution to available `paraNodes`.*

2.  **Monitoring Status**:
    `para check`
    *Use this to see counts of running, finished, and failed jobs.*

3.  **Handling Failures**:
    `para recover`
    *This identifies crashed or timed-out jobs and prepares them for re-submission.*

4.  **Blocking for Completion**:
    `para wait`
    *Useful in shell scripts to pause execution until the entire batch is finished.*

### Cluster Management
*   **Node Control**: Use `paraNodeStart` and `paraNodeStop` to manage individual worker processes on cluster nodes.
*   **Hub Management**: The `paraHub` process must be running on a master node to coordinate job distribution. Use `paraHubStop` to gracefully shut down the scheduler.
*   **Status Checks**: `paraNodeStatus` provides real-time telemetry on worker node availability and load.

### Data Synchronization
*   **Parallel Downloads**: Use `paraFetch` for high-speed, multi-threaded downloads of genomic data from remote servers.
*   **Node Syncing**: Use `paraSync` to ensure that input files or binaries are consistently distributed across all worker nodes before job execution begins.

## Expert Tips and Best Practices

### Environment Configuration
*   **Permissions**: Freshly downloaded binaries from the UCSC server require explicit execution permissions.
    `chmod +x ./para ./parasol`
*   **Database Access**: Many UCSC utilities (like `hgLoadBed`) require a connection to the public MySQL server. Ensure an `.hg.conf` file exists in your home directory with the correct credentials (typically user: `genomep`, host: `genome-mysql.soe.ucsc.edu`).
*   **Architecture Matching**: Always verify your system architecture with `uname -a` before downloading binaries. UCSC provides specific builds for `linux.x86_64`, `linux.aarch64`, and `macOSX.arm64`.

### Performance Optimization
*   **Job Granularity**: Parasol performs best when jobs are at least 30-60 seconds long. If tasks are shorter, bundle multiple commands into a single script to reduce scheduling overhead.
*   **Batch Sizes**: For extremely large runs (100k+ jobs), use `para`'s batching features to avoid overwhelming the hub's memory.
*   **Resource Limits**: Use the `parasol` command directly for fine-grained control over memory limits and priority levels for specific job batches.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Bioconda ucsc-para Package Info](./references/anaconda_org_channels_bioconda_packages_ucsc-para_overview.md)