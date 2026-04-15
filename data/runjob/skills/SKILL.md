---
name: runjob
description: runjob is a job scheduler and pipeline manager that executes bioinformatics tasks in parallel across local and HPC environments. Use when user asks to submit batch jobs, manage task dependencies, execute workflows on Slurm or SGE clusters, or group shell script commands for resource-efficient execution.
homepage: https://github.com/yodeng/runjob
metadata:
  docker_image: "quay.io/biocontainers/runjob:2.10.9--pyhdfd78af_0"
---

# runjob

## Overview
`runjob` is a specialized job scheduler and pipeline manager designed for bioinformatics workflows. It allows users to define a series of tasks and execute them in parallel while respecting resource limits and dependencies. It supports multiple backends, including local execution, Sun Grid Engine (SGE), and Slurm, making it portable across different high-performance computing (HPC) environments.

## Common CLI Patterns

### Basic Job Submission
Run all tasks in a job file with a concurrency limit:
`runjob -j tasks.list -n 20`

### Cluster Integration
Explicitly set the submission mode for Slurm or SGE:
`runjob -j tasks.list --slurm -q workq`
`runjob -j tasks.list --sge -q all.q`

### Resource Allocation
Define CPU and memory requirements for the batch:
`runjob -j tasks.list -c 4 -m 16G`

### Handling Shell Scripts (runsge/runshell)
Group multiple lines from a shell script into single job units to reduce cluster overhead:
`runsge -j pipeline.sh -g 5 -n 10`
*This executes 5 lines of `pipeline.sh` per submitted job, with 10 jobs running concurrently.*

### Pipeline Control
- **Retry on failure**: `runjob -j tasks.list -r 3 -R 10` (Retry 3 times with 10s delay).
- **Force re-run**: `runjob -j tasks.list -f` (Ignore previous success status).
- **Partial run**: `runjob -j tasks.list -s 10 -e 20` (Run only lines 10 through 20).

## Expert Tips
- **DAG Visualization**: Use `--dag` to generate a DOT language representation of your job dependencies. This is useful for verifying complex workflows before execution.
- **Strict Mode**: Use `--strict` in production pipelines. If any job fails, `runjob` will attempt to kill all remaining jobs and exit, preventing wasted resources on a broken pipeline.
- **Log Management**: Always specify a log directory with `-L` to keep stdout/stderr files organized, especially when running hundreds of tasks.
- **Pre/Post Hooks**: Use `--init "cmd"` and `--callback "cmd"` with `runsge` to run setup or cleanup tasks on the local node before and after the batch.
- **Resource Monitoring**: `runjob` monitors job status automatically; use `-d` (debug) if you need to see the internal polling and submission logic.

## Reference documentation
- [runjob GitHub Repository](./references/github_com_yodeng_runjob.md)
- [Bioconda runjob Overview](./references/anaconda_org_channels_bioconda_packages_runjob_overview.md)