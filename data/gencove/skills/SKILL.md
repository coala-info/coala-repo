---
name: gencove
description: The Gencove tool manages low-pass sequencing analysis workflows and genomic data on the Gencove Base platform. Use when user asks to upload sequencing files, manage projects and pipelines, list samples, or download genomic deliverables and metadata.
homepage: https://docs.gencove.com
---

# gencove

## Overview
The Gencove skill enables seamless integration with Gencove Base, a platform designed for low-pass sequencing analysis. It provides a structured workflow for genomic data management, allowing users to move from raw sequencing files to processed genotypes and reports. This skill is particularly useful for automating bioinformatics pipelines, managing large-scale genomic projects, and retrieving standardized deliverables.

## Quick Start
Install the CLI and perform a basic upload:
```bash
pip install gencove
# Upload a directory of sequencing files
gencove upload <local-directory-path>
```
Alternatively, use `uvx` for a zero-install execution:
```bash
uvx gencove upload <local-directory-path>
```

## Authentication
Configure credentials using environment variables to avoid interactive prompts:
- `GENCOVE_API_KEY`: Recommended for automated environments and bypassing MFA.
- `GENCOVE_EMAIL` and `GENCOVE_PASSWORD`: Use for standard login (will trigger MFA if enabled).

*Note: Do not set both API Key and Email/Password simultaneously.*

## Core CLI Workflows

### Project Management
Data is organized into projects. Use these commands to navigate your environment:
- **List Projects**: `gencove projects list`
- **Create Project**: `gencove projects create <project-name> <pipeline-uuid>`
- **List Pipelines**: `gencove pipelines list` (to find available analysis configurations)

### Sample Operations
Samples are the primary unit of analysis within projects:
- **List Samples**: `gencove samples list <project-id>`
- **Download Results**: `gencove samples download-deliverables <sample-id> --destination <path>`
- **Metadata**: `gencove samples get-metadata <sample-id>`

### Regional Configuration
If your data resides in a specific geographical region (e.g., European Union), you must specify the host:
```bash
gencove <command> --host https://api.eu1.gencove.com
```

## Expert Tips & Best Practices
- **Virtual Environments**: Always install the CLI in a dedicated virtual environment (`venv`) to avoid dependency conflicts with other bioinformatics tools.
- **API Keys**: Prefer API keys over passwords for production scripts to ensure stability and security.
- **Batch Downloads**: For large projects, use the `samples list` command to iterate through IDs and automate the `download-deliverables` process.
- **Host Consistency**: If the Web UI URL is `web.eu1.gencove.com`, ensure your CLI host is set to `api.eu1.gencove.com`.



## Subcommands

| Command | Description |
|---------|-------------|
| gencove basespace autoimports autoimport_list | List BaseSpace autoimports. |
| gencove basespace autoimports autoimport_list | List BaseSpace autoimports |

## Reference documentation
- [Gencove Base Getting Started](./references/docs_gencove_com_base_getting-started.md)
- [Gencove CLI GitHub README](./references/github_com_gncv_gencove-cli_blob_master_README.md)