---
name: seqerakit
description: Seqerakit is an automation wrapper for the Seqera Platform CLI that manages complex resource hierarchies and pipeline executions through YAML configuration files. Use when user asks to bootstrap environments, migrate configurations between organizations, automate resource provisioning, or perform dry-runs of platform setups.
homepage: https://github.com/seqeralabs/seqera-kit
---


# seqerakit

## Overview
seqerakit acts as a powerful automation wrapper for the Seqera Platform CLI (`tw`). It allows users to define complex platform hierarchies and resource dependencies in a single YAML file rather than executing dozens of individual commands. Use this skill when you need to bootstrap new environments, migrate configurations between organizations, or automate end-to-end pipeline execution from resource provisioning to final launch.

## Core CLI Usage

### Environment Setup
Before running seqerakit, ensure your authentication tokens are exported:
```bash
export TOWER_ACCESS_TOKEN=<your-token>
# Optional: For Enterprise installations
export TOWER_API_ENDPOINT=<your-enterprise-url>
```

### Primary Commands
- **Info & Connectivity**: Verify your connection to the Seqera Platform.
  ```bash
  seqerakit --info
```
- **Resource Creation**: Process a YAML configuration to build resources.
  ```bash
  seqerakit path/to/config.yaml
```
- **Standard Input**: Pipe configurations directly into the tool.
  ```bash
  cat config.yaml | seqerakit -
```
- **Recursive Deletion**: Remove all resources defined in a YAML file in reverse dependency order.
  ```bash
  seqerakit path/to/config.yaml --delete
```

## Expert Workflows

### Validation and Dry-runs
Always validate your YAML logic before applying changes to a production workspace to prevent partial resource creation.
```bash
seqerakit path/to/config.yaml --dryrun
```

### JSON Integration and Automation
Use the `-j` or `--json` flag to capture resource metadata (like `workflowId` or `workspaceId`) for downstream processing.
- **Capture output**: `seqerakit -j launch.yml > results.json`
- **Merge multiple outputs**: `seqerakit -j launch/*.yml | jq --slurp > all_launches.json`

### Installation Patterns
- **Recommended (uv)**: `uv tool install seqerakit`
- **Direct Execution**: `uv run seqerakit --help`
- **Conda**: `conda install bioconda::seqerakit`

## Best Practices
- **Dependency Ordering**: When writing YAMLs, define parent resources (Organizations) before child resources (Workspaces) to ensure the CLI can resolve references.
- **Environment Variables**: Use environment variables within your shell to manage sensitive data like `TOWER_ACCESS_TOKEN` rather than hardcoding them in scripts.
- **Log Management**: By default, logs are sent to `stderr`. If you are capturing JSON output for a script, redirect `stdout` to a file and monitor `stderr` for real-time progress.

## Reference documentation
- [Seqera-kit GitHub Repository](./references/github_com_seqeralabs_seqerakit.md)
- [Seqera-kit Issues and Known Limitations](./references/github_com_seqeralabs_seqerakit_issues.md)