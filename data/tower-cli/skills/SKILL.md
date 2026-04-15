---
name: tower-cli
description: `tower-cli` is the command-line interface for managing Seqera Platform resources and Nextflow pipelines. Use when user asks to launch a pipeline, manage compute environments, administer workspaces, or configure the CLI.
homepage: https://github.com/seqeralabs/tower-cli
metadata:
  docker_image: "quay.io/biocontainers/tower-cli:0.21.0--hdfd78af_0"
---

# tower-cli

## Overview

The `tower-cli` (invoked as `tw`) is the primary interface for managing Seqera Platform resources from the terminal. It allows users to launch Nextflow pipelines, monitor execution, manage cloud compute environments, and administer organization workspaces. This skill provides the necessary patterns for configuring the environment and executing core commands to streamline pipeline lifecycle management.

## Configuration and Health

Before executing commands, ensure the CLI is authenticated and pointing to the correct Seqera instance.

- **Authentication**: Export your access token as an environment variable.
  ```bash
  export TOWER_ACCESS_TOKEN=<your_token>
  ```
- **Target Workspace**: Set a specific workspace ID to avoid using the default user workspace.
  ```bash
  export TOWER_WORKSPACE_ID=<workspace_id>
  ```
- **API Endpoint**: For Enterprise installations, override the default cloud endpoint.
  ```bash
  export TOWER_API_ENDPOINT=https://<your-tower-domain>/api
  ```
- **Verification**: Run a health check to confirm connectivity and authentication status.
  ```bash
  tw info
  ```

## Common CLI Patterns

### Pipeline Management
- **Launch a Pipeline**: Use the `launch` command to start a workflow.
  ```bash
  tw launch <pipeline_name_or_url> [flags]
  ```
- **Specify Revision**: Use `--revision` or the newer `--commit-id` to pin a specific version of the code.
- **Resource Allocation**: Override head job resources for large-scale runs.
  ```bash
  tw launch <pipeline> --head-job-cpus 2 --head-job-memory 4096
  ```

### Compute Environments
- **List Environments**: View available compute resources in the current workspace.
  ```bash
  tw compute-envs list
  ```
- **Forge Configuration**: When creating or modifying AWS Batch Forge environments, use specific flags for disk and instance tuning.
  ```bash
  tw compute-envs create aws-batch ... --boot-disk-size 50 --instance-type-size small
  ```

### Workspace and Organization
- **Switch Contexts**: List all accessible workspaces to find the correct ID.
  ```bash
  tw workspaces list
  ```
- **Participant Management**: Update user roles within an organization.
  ```bash
  tw participants update --user <username> --role <role_name>
  ```

## Expert Tips

- **Shell Autocompletion**: Enable tab-completion for your current session to discover commands and flags dynamically.
  ```bash
  source <(tw generate-completion)
  ```
- **JSON Output**: For automation and scripting, use the `--output json` flag (where supported) to pipe results into tools like `jq`.
- **Custom SSL Certificates**: If working behind a corporate proxy with a private CA, specify the trust store directly.
  ```bash
  tw -Djavax.net.ssl.trustStore=/path/to/cacerts <command>
  ```
- **Standard Input**: Some file-based options support reading from stdin using the `-` character, allowing for dynamic configuration injection.

## Reference documentation
- [Seqera Tower CLI Overview](./references/github_com_seqeralabs_tower-cli.md)
- [Tower CLI Installation and Usage](./references/anaconda_org_channels_bioconda_packages_tower-cli_overview.md)
- [Recent Feature Commits](./references/github_com_seqeralabs_tower-cli_commits_master.md)