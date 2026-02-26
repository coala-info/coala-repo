---
name: dxpy
description: The dxpy toolkit provides a command-line interface and Python library for interacting with the DNAnexus cloud platform. Use when user asks to authenticate, manage projects, upload or download data, search for objects, and monitor cloud jobs.
homepage: https://github.com/dnanexus/dx-toolkit
---


# dxpy

## Overview
The `dxpy` toolkit is the official suite for interacting with the DNAnexus cloud platform. It consists of the `dx` command-line interface (CLI) and a Python library for programmatic access. This skill enables efficient management of genomic data and bioinformatic workflows by providing patterns for authentication, project navigation, data movement, and object searching within the DNAnexus environment.

## Core CLI Patterns

### Authentication and Environment
Before performing any operations, you must authenticate and set your project context.
- **Login**: `dx login` (Follow the interactive prompts or use `--token`).
- **Select Project**: `dx select` to choose a project from a list, or `dx select project-NAME_OR_ID`.
- **Check Environment**: `dx env` to see current user, project, and workspace settings.

### Project Navigation and Management
- **List Content**: `dx ls` (lists files and folders) or `dx ls -l` for detailed metadata.
- **Change Directory**: `dx cd /path/to/folder`.
- **Create Folder**: `dx mkdir folder_name`.
- **Project Info**: `dx describe` (when no object is specified, describes the current project).

### Data Operations
- **Upload**: `dx upload local_file.txt --path /remote/path/`.
- **Download**: `dx download file-ID` or `dx download /remote/path/file.txt`.
- **Describe Object**: `dx describe object-ID` (returns JSON metadata, including size, checksums, and properties).
- **Delete**: `dx rm file-ID` or `dx rm -r folder_name`.

### Searching and Querying
The `dx find` command is the most powerful tool for locating objects across the platform.
- **Find Files**: `dx find data --name "*.fastq.gz"`
- **Find by Property**: `dx find data --property key=value`
- **Find Jobs**: `dx find jobs --state failed` (useful for debugging).
- **Tree View**: `dx find --tree` to visualize the project hierarchy.

## Expert Tips

### Scripting and Automation
- **Brief Output**: Use the `--brief` flag to return only the object ID (e.g., `file-XXXX`). This is essential for piping IDs into other commands or storing them in variables.
- **JSON Output**: Use `--json` with `dx describe` or `dx find` to get structured data for parsing with tools like `jq`.
- **Batch Operations**: Many commands like `dx rm` and `dx describe` accept multiple IDs at once to reduce API overhead.

### Job Management
- **Monitor Logs**: `dx watch job-ID` to stream STDOUT/STDERR from a running cloud job.
- **Terminate**: `dx terminate job-ID` to stop an execution and prevent further billing.
- **Run Applets**: `dx run applet-ID -iinput_name=value` to launch executions from the CLI.

### Environment Variables
For non-interactive scripts, set these variables to bypass manual selection:
- `DX_PROJECT_CONTEXT_ID`: Sets the default project.
- `DX_SECURITY_CONTEXT`: Contains the authentication token.

## Reference documentation
- [DNAnexus Platform SDK](./references/github_com_dnanexus_dx-toolkit.md)
- [dxpy Overview](./references/anaconda_org_channels_bioconda_packages_dxpy_overview.md)