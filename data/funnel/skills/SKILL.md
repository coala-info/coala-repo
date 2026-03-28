---
name: funnel
description: Funnel is a distributed batch processing system that schedules and executes Docker-based tasks across various infrastructure. Use when user asks to create tasks, manage the task lifecycle, monitor task status, or run containerized commands on distributed resources.
homepage: https://ohsu-comp-bio.github.io/funnel/
---


# funnel

## Overview
Funnel is a lightweight, standards-based system for distributed batch processing. It allows you to define a "Task"—which includes input data, a sequence of Docker-based commands (executors), and output locations—and handles the scheduling and execution of that task on a variety of infrastructure. This skill provides the necessary patterns for interacting with the Funnel CLI and API to manage the lifecycle of these tasks.

## Task Definition Patterns
Tasks are defined as JSON objects. A task consists of three primary components:
- **Inputs**: Files or directories to be downloaded to the worker before execution.
- **Executors**: A sequence of Docker images and commands to run.
- **Outputs**: Files or directories to be uploaded to storage after execution.

### Basic Task Template
```json
{
  "name": "Example Task",
  "inputs": [
    {
      "url": "s3://bucket/input.txt",
      "path": "/inputs/input.txt"
    }
  ],
  "executors": [
    {
      "image": "alpine",
      "command": ["cat", "/inputs/input.txt"],
      "stdout": "/outputs/stdout.txt"
    }
  ],
  "outputs": [
    {
      "url": "s3://bucket/output.txt",
      "path": "/outputs/stdout.txt"
    }
  ]
}
```

## CLI Usage Guide

### Server Management
Start a local development server (uses BoltDB and local Docker by default):
```bash
funnel server run
```

### Task Lifecycle
- **Create**: `funnel task create task.json` (Returns the Task ID).
- **Get Status**: `funnel task get <ID>` (Use `--view BASIC` or `--view FULL` for logs).
- **List**: `funnel task list` (Supports pagination and views).
- **Cancel**: `funnel task cancel <ID>`.

### The "Run" Shortcut
For simple one-liners, use the `run` command which generates the task JSON automatically:
```bash
funnel run 'md5sum $src' --in src=~/data.txt --print
```

## Resource Requests
To ensure tasks have sufficient hardware, include a `resources` object in the JSON:
- `cpuCores`: Integer count.
- `ramGb`: Float value.
- `diskGb`: Float value.
- `preemptible`: Boolean (for AWS Spot or GCP Preemptible instances).

## Best Practices
- **Containerization**: Every executor must specify a Docker image. Ensure the image contains the tools required for the `command`.
- **Path Mapping**: Always use absolute paths within the container for `path` fields in inputs and outputs.
- **Sequential Execution**: Executors run in the order defined. If one fails (non-zero exit code), the task stops.
- **Storage Backends**: Funnel supports S3, GS, FTP, HTTP, and local files. Ensure the Funnel server/worker is configured with the necessary credentials for remote storage.
- **Task Views**: When querying large numbers of tasks, use `MINIMAL` view to save bandwidth. Use `FULL` only when you need to inspect `stdout` or `stderr` logs.



## Subcommands

| Command | Description |
|---------|-------------|
| dashboard | Start a Funnel dashboard in your terminal. |
| full-hello | A simple hello world example that demonstrates the full CWL functionality. |
| funnel aws | Development utilities for creating funnel resources on AWS |
| funnel run | Run a task. |
| funnel storage | Access storage via Funnel's client libraries. |
| funnel worker | Funnel worker commands. |
| funnel_completion | Generate shell completion code |
| gce | Manage GCE resources for funnel |
| node | Funnel node subcommands. |
| server | Funnel server commands. |
| task | Make API calls to a TES server. |

## Reference documentation
- [Funnel Overview](./references/ohsu-comp-bio_github_io_funnel.md)
- [Task API Details](./references/ohsu-comp-bio_github_io_funnel_docs_tasks.md)
- [Installation and Setup](./references/ohsu-comp-bio_github_io_funnel_download.md)