---
name: cromwell
description: Cromwell is an execution engine that orchestrates scientific data processing workflows by translating WDL scripts into tasks across local and cloud environments. Use when user asks to run WDL workflows, validate WDL syntax, generate input JSON templates, or manage workflow execution via a REST API server.
homepage: https://github.com/broadinstitute/cromwell
---


# cromwell

## Overview

Cromwell is a specialized execution engine designed to handle the complexity of scientific data processing. It translates WDL scripts into executable tasks across diverse environments, ranging from local workstations to massive cloud clusters like Google Cloud Batch and AWS Batch. This skill provides the necessary command-line patterns and operational logic to deploy, validate, and manage these workflows efficiently.

## Core CLI Usage

Cromwell is typically distributed as a Java executable (JAR). The two primary modes of operation are `run` (single execution) and `server` (REST API mode).

### Running a Workflow
To execute a workflow immediately from the command line:
```bash
java -jar cromwell.jar run <workflow.wdl> --inputs <inputs.json>
```

**Optional Arguments:**
- `--options <options.json>`: Specify workflow-level configurations (e.g., default runtime attributes, call caching).
- `--metadata <metadata.json>`: Output execution metadata to a file upon completion.
- `--imports <zip_file>`: Provide a ZIP file containing sub-workflows or WDL dependencies.

### Server Mode
For production environments or multi-user setups, run Cromwell as a persistent service:
```bash
java -jar cromwell.jar server
```
Once running, the server exposes a REST API (default port 8000) and a Swagger UI for workflow submission and monitoring.

## Workflow Validation with Womtool

Before execution, always validate WDL syntax using `womtool`, Cromwell's companion utility.

### Validate Syntax
```bash
java -jar womtool.jar validate <workflow.wdl>
```

### Generate Input Template
Automatically create the required JSON input schema for a specific WDL:
```bash
java -jar womtool.jar inputs <workflow.wdl> > inputs.json
```

### Graphing Workflows
Generate a visual representation of the workflow logic:
```bash
java -jar womtool.jar graph <workflow.wdl>
```

## Expert Tips and Best Practices

### 1. Enable Call Caching
To avoid re-running expensive tasks that have already completed successfully, enable call caching in your `options.json`:
```json
{
  "write_to_cache": true,
  "read_from_cache": true
}
```
*Note: This requires a configured metadata database (e.g., MySQL or PostgreSQL) rather than the default in-memory database.*

### 2. Runtime Attributes
Define resource requirements within the WDL `runtime` block to ensure Cromwell requests appropriate hardware from the backend:
- `docker`: Specify the container image.
- `memory`: Define RAM (e.g., "8 GB").
- `cpu`: Number of cores.
- `disks`: Disk space and type (e.g., "local-disk 100 SSD").

### 3. Handling Dependencies
If your workflow imports other WDL files, package them into a ZIP file and use the `--imports` flag. Ensure the import paths in your main WDL match the structure inside the ZIP.

### 4. Monitoring and Troubleshooting
- **Metadata**: Use the `/metadata` API endpoint or the `--metadata` flag to inspect task-level logs, return codes, and execution status.
- **Execution Directory**: Cromwell creates a `cromwell-executions` folder. Each workflow has a unique UUID; navigate to `cromwell-executions/<workflow_uuid>/call-<task_name>/execution/` to find `stdout` and `stderr` for specific failures.

## Reference documentation
- [Cromwell GitHub Repository](./references/github_com_broadinstitute_cromwell.md)
- [Bioconda Cromwell Overview](./references/anaconda_org_channels_bioconda_packages_cromwell_overview.md)