---
name: dxua
description: The dxua tool is a command-line utility designed for robust, multi-threaded data ingestion and directory synchronization into the DNAnexus platform. Use when user asks to upload files or directories, resume interrupted transfers, assign metadata to uploads, or configure parallelized data streaming.
homepage: https://documentation.dnanexus.com/user/objects/uploading-and-downloading-files/batch/upload-agent
metadata:
  docker_image: "quay.io/biocontainers/dxua:1.5.31--0"
---

# dxua

## Overview
The `dxua` (DNAnexus Upload Agent) is a dedicated command-line utility designed for robust data ingestion into the DNAnexus ecosystem. Unlike standard API uploads, it is optimized for large-scale data transfer, offering automatic compression, multi-threaded uploading, and the ability to resume interrupted transfers by tracking file signatures. Use this skill to construct precise CLI commands for batch uploads, directory synchronization, and metadata assignment.

## Core Usage Patterns

### Basic Uploads
- **Single File**: `ua --project <project-id> <local-file>`
- **Multiple Files**: `ua --project <project-id> <file1> <file2> <file3>`
- **Directory (Contents only)**: Append a trailing slash to the source path: `ua <dir_name>/`
- **Directory (Create remote folder)**: Omit the trailing slash: `ua <dir_name>`
- **Recursive Upload**: Use the `--recursive` flag to maintain subfolder structures.

### Environment & Authentication
- **Check Configuration**: Use `ua --env` to verify the current project, auth token, and API server.
- **Diagnostic**: Run `ua --test` to troubleshoot connectivity or permission issues.
- **Manual Override**: Use `--auth-token` and `--project` flags if environment variables (`DX_AUTH_TOKEN`, `DX_PROJECT_CONTEXT_ID`) are not set.

### Optimization & Performance
- **Compression**: Enabled by default (appends `.gz`). Use `--do-not-compress` for files that are already compressed or must remain in their original format.
- **Threading**: For high-core machines, balance resources using:
  - `--read-threads`: Parallel disk reads.
  - `--compress-threads`: Parallel compression.
  - `--upload-threads`: Parallel HTTPS connections.
- **Chunk Size**: Adjust with `-s` or `--chunk-size` (e.g., `100M`). Smaller chunks are better for unstable connections; larger chunks improve throughput on high-bandwidth links.

### Metadata & Organization
- **Target Folder**: Use `-f` or `--folder` to specify the destination path within the project.
- **Renaming**: Use `-n` or `--name` to change the filename on the platform.
- **Properties & Tags**: 
  - Add key-value pairs: `--property key1=val1 --property key2=val2`
  - Add searchable tags: `--tag <tag_name>`
- **JSON Details**: Use `--details '{"key": "value"}'` for complex metadata.

### Advanced Workflows
- **Piping Data**: Upload output directly from another process using `--read-from-stdin <remote_filename>`.
- **Scripting**: Use `--wait-on-close` in scripts to ensure the file is fully "closed" and available for downstream analysis before the command exits.
- **Resumption**: `dxua` automatically attempts to resume failed uploads. To force a fresh upload of a duplicate file, use `--do-not-resume`.

## Expert Tips
- **Trailing Slashes**: The presence or absence of a trailing slash on a directory path significantly changes the remote folder structure. Always verify the intended destination layout.
- **Visibility**: Use `--visibility hidden` for temporary or intermediate files that should not clutter the UI.
- **Throttling**: On shared networks, use `--throttle` (e.g., `5M`) to limit upload speed and prevent bandwidth exhaustion.

## Reference documentation
- [Upload Agent | DNAnexus Documentation](./references/documentation_dnanexus_com_user_objects_uploading-and-downloading-files_batch_upload-agent.md)
- [Upload Agent Specification](./references/documentation_dnanexus_com_user_objects_uploading-and-downloading-files_batch_upload-agent_1.md)