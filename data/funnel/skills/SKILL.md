---
name: funnel
description: Funnel is a toolkit for distributed task execution that runs sequences of Docker containers and manages remote file transfers. Use when user asks to create or list tasks, manage a local server, monitor task status, or construct JSON task definitions.
homepage: https://ohsu-comp-bio.github.io/funnel/
---


# funnel

## Overview

Funnel is a toolkit for distributed task execution that implements the GA4GH Task Execution Schema (TES). It allows you to run a sequence of Docker containers as a single "task," handling the complexities of downloading input files from remote storage (like S3 or Google Storage), executing commands, and uploading results. This skill helps you navigate the Funnel CLI and construct the JSON task definitions required to orchestrate these workflows.

## CLI Usage Patterns

### Server Management
To start a local development server using the default BoltDB and local storage:
```bash
funnel server run
```
The server typically listens on `localhost:8000` (HTTP) and `localhost:9090` (gRPC).

### Task Lifecycle
*   **Create a task**: Submit a JSON definition to the server.
    ```bash
    funnel task create my_task.json
    ```
*   **List tasks**: View all tasks. Use views to control output verbosity.
    ```bash
    funnel task list --view MINIMAL
    ```
*   **Get task details**: Retrieve the state and logs for a specific ID.
    ```bash
    funnel task get <task-id> --view FULL
    ```
*   **Cancel a task**: Stop a queued or running task.
    ```bash
    funnel task cancel <task-id>
    ```

### Quick Execution
The `run` command is a shortcut for creating simple tasks without a full JSON file.
```bash
funnel run 'md5sum $src' --in src=file:///path/to/file.txt
```
Use the `--print` flag to see the generated JSON instead of executing it:
```bash
funnel run 'echo hello' --print
```

### Remote Connection
To point the CLI at a remote Funnel instance, use the `-S` flag or set the environment variable:
```bash
export FUNNEL_SERVER="http://funnel.example.com"
funnel task list
```

## Task Definition Best Practices

### Task Structure (JSON)
A standard task consists of four main components:
1.  **Resources**: Define `cpuCores`, `ramGb`, and `diskGb`.
2.  **Inputs**: Map a `url` (S3, GS, HTTP, FTP) to a container `path`.
3.  **Executors**: A list of Docker `image` names and `command` arrays to run sequentially.
4.  **Outputs**: Map a container `path` to a destination `url`.

### Optimization Tips
*   **Task Views**: When listing or getting tasks, use `--view MINIMAL` for IDs/States, `BASIC` for metadata/resources, and `FULL` only when you need to inspect `stdout` or `stderr` logs.
*   **Sequential Execution**: Executors run in order. If any executor returns a non-zero exit code, the task stops and enters an `EXECUTOR_ERROR` state.
*   **Storage Types**: For directories, ensure you set `"type": "DIRECTORY"` in the input/output definition to ensure the worker handles the recursive transfer correctly.
*   **Embedded Scripts**: For small scripts, use the `content` field in an input instead of uploading a separate file to S3/GS.

## Monitoring
*   **Web Dashboard**: Access the visual interface at `http://localhost:8000`.
*   **Terminal Dashboard**: Use the built-in CLI monitor:
    ```bash
    funnel dashboard
    ```

## Reference documentation
- [Funnel Overview](./references/ohsu-comp-bio_github_io_funnel.md)
- [Task API and Schema](./references/ohsu-comp-bio_github_io_funnel_docs_tasks.md)
- [Installation and Quickstart](./references/ohsu-comp-bio_github_io_funnel_download.md)