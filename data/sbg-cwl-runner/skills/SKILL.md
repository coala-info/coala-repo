---
name: sbg-cwl-runner
description: The sbg-cwl-runner tool acts as a shim that allows the Seven Bridges platform to function as a standard CWL runner for local development and execution. Use when user asks to run CWL workflows on the platform from a local environment, perform CWL conformance testing, or automate file staging and task monitoring.
homepage: https://github.com/kaushik-work/sbg-cwl-runner
metadata:
  docker_image: "quay.io/biocontainers/sbg-cwl-runner:2018.11--py_0"
---

# sbg-cwl-runner

## Overview
The `sbg-cwl-runner` tool (also known as "Coyote") acts as a specialized shim that allows the SBG platform to function as a standard CWL runner. It is designed for users who want to maintain a local-first development workflow while leveraging the scalable compute resources of Seven Bridges. It automates the heavy lifting of resolving local file dependencies, uploading them to the platform, and monitoring task state until completion.

## Command Line Usage

### Basic Execution
The tool follows the standard `cwl-runner` interface. To launch a workflow, provide the workflow file and the job input file:

```bash
sbg-cwl-runner [OPTIONS] WORKFLOW_FILE JOB_FILE
```

### Required Configuration
To target a specific SBG environment, you must specify the project context. This is typically done via the `--project` flag:

```bash
sbg-cwl-runner --project="username/project-id" workflow.cwl job.json
```

### Operational Workflow
When executed, the tool performs the following sequence:
1. **Dependency Resolution**: Scans the CWL workflow and job file for local file references.
2. **Staging**: Uploads any missing files or updated workflow components to the SBG platform.
3. **Task Creation**: Initializes a new task on the platform using the SBG API.
4. **Monitoring**: Polls the platform for task status.
5. **Retrieval**: Once the task reaches a 'COMPLETED' state, it fetches the `stderr` logs and the final output object to your local environment.

## Expert Tips and Best Practices

- **Conformance Testing**: This tool is the primary method for running CWL conformance tests against the SBG platform. Use the `RUNNER=sbg-cwl-runner` environment variable when executing standard test scripts.
- **Parallelism**: When running large batches of tests or tasks, use the `-j` flag (e.g., `-j100`) to manage concurrent task submissions.
- **API Credentials**: Ensure your `sevenbridges-python` configuration is active, as the runner relies on this library to authenticate and communicate with the SBG API.
- **Project IDs**: Always verify the project ID string (format: `owner/project`). The runner will fail if the project does not exist or if the authenticated user lacks write permissions.

## Reference documentation
- [GitHub Repository for sbg-cwl-runner](./references/github_com_kghose_sbg-cwl-runner.md)