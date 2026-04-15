---
name: jobtree
description: jobTree is a Python-based pipeline management system designed for executing complex, recursive bioinformatics workflows on local machines or large-scale clusters. Use when user asks to run a pipeline, monitor job status, restart failed runs, or analyze performance statistics.
homepage: https://github.com/benedictpaten/jobTree
metadata:
  docker_image: "quay.io/biocontainers/jobtree:09.04.2017--py_2"
---

# jobtree

## Overview
jobTree is a Python-based pipeline management system designed for complex, recursive computations where tasks can dynamically schedule sub-tasks. It is particularly effective for bioinformatics workflows that need to scale from a single machine to large-scale clusters. This skill assists in navigating the legacy jobTree environment, focusing on command-line operations for pipeline execution, error recovery, and performance profiling.

## Core CLI Operations

### Running a Pipeline
To execute a jobTree script, run the Python script directly with the required jobTree arguments.
- **Basic Command**: `python your_script.py --jobTree ./state_dir --batchSystem singleMachine`
- **Cluster Execution**: Change `--batchSystem` to `parasol`, `lsf`, or `gridEngine` depending on your environment.
- **Logging**: Use `--logLevel INFO` or `--logLevel DEBUG` to monitor progress.
- **Statistics**: Add the `--stats` flag during execution if you intend to analyze performance later.

### Monitoring Status
Use `jobTreeStatus` to check the health of a running or finished pipeline.
- **Check Progress**: `jobTreeStatus ./state_dir`
- **Detailed Error Reporting**: `jobTreeStatus ./state_dir --verbose` (This prints log files for failed jobs).
- **Validation**: Use `--failIfNotComplete` in automated environments to return a non-zero exit code if the pipeline is unfinished.

### Restarting Failed Runs
If a pipeline fails due to cluster instability or a specific job error, you can resume from the point of failure.
- **Resume Command**: `jobTreeRun --jobTree ./state_dir`
- **Note**: jobTree preserves the state in the directory specified by `--jobTree`. Do not delete this directory if you intend to restart.

### Performance Analysis
If the pipeline was run with the `--stats` flag, use `jobTreeStats` to generate a report.
- **Human Readable Report**: `jobTreeStats ./state_dir --pretty`
- **Sorting**: Use `--sortCategory time` or `--sortCategory memory` to identify bottlenecks.
- **Data Export**: Use `--raw` to output XML data for custom parsing.

## Expert Tips
- **Environment Setup**: Ensure `PYTHONPATH` includes the parent directory of both `sonLib` and `jobTree`. jobTree requires `sonLib` to function.
- **Directory Management**: The `--jobTree` directory is not automatically deleted. For a fresh run, you must manually remove the existing directory or specify a new path.
- **Resource Specification**: When writing scripts, define default CPU and memory requirements to prevent the batch system from over-allocating or killing jobs for exceeding limits.
- **Python Version**: jobTree is designed for Python 2.5 through 2.7. It is not compatible with Python 3.x (use Toil for Python 3 support).



## Subcommands

| Command | Description |
|---------|-------------|
| jobTreeRun | Options |
| jobTreeStats | Prints statistics about a jobTree. |
| jobTreeStatus | Prints the status of a job tree. |

## Reference documentation
- [github_com_benedictpaten_jobTree.md](./references/github_com_benedictpaten_jobTree.md)