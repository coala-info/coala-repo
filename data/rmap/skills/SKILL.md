---
name: rmap
description: rmap provides a command-line interface for interacting with the reMarkable Cloud to manage files and directories. Use when user asks to list cloud contents, upload or download files, synchronize directories, and manage tablet metadata from the terminal.
homepage: https://github.com/juruen/rmapi
---


# rmap

## Overview
The `rmap` (rmapi) skill enables command-line interaction with the reMarkable Cloud. It provides a way to bypass the official desktop application for tasks like bulk file transfers, directory synchronization, and metadata inspection. It supports both an interactive shell and non-interactive execution, making it a powerful tool for scripting workflows and managing tablet content from any terminal environment.

## Common CLI Patterns

### File Navigation and Discovery
*   **List contents**: Use `ls` to view files `[f]` and directories `[d]` in the current cloud path.
*   **Change directory**: Use `cd /path/to/folder` to navigate the cloud file system.
*   **Search files**: Use `find` with regex for deep searches.
*   **Case-insensitive search**: `find . (?i)filename`
*   **Metadata inspection**: Use `stat <file>` to view specific cloud metadata and UUIDs.

### Uploading and Downloading
*   **Single file upload**: `put local_file.pdf /cloud_folder`
*   **Bulk/Recursive upload**: `mput /local/directory` uploads all contents to the current cloud directory.
*   **Single file download**: `get /cloud/file.pdf`
*   **Bulk/Recursive download**: `mget /cloud/folder` downloads the directory and its contents locally.
*   **Export with annotations**: `geta /cloud/document.pdf` downloads the file and attempts to render a PDF including handwritten strokes (experimental).

### File Management
*   **Create folders**: `mkdir /new_folder`
*   **Rename or move**: `mv source_path destination_path`
*   **Delete**: `rm file_or_empty_directory` (Note: Directories must be empty to be removed).

## Expert Tips and Configuration

### Non-Interactive Scripting
For automation, pass commands directly as arguments to the binary. The tool returns exit code `0` on success and `1` on failure.
Example: `rmapi mget .` (Backs up all cloud files to the current local directory).

### Environment Variables
*   **Custom Config Path**: Set `RMAPI_CONFIG=/path/to/token` to use a specific authentication file instead of the default `~/.rmapi`.
*   **Hidden Files**: Set `RMAPI_USE_HIDDEN_FILES=1` to see and traverse files ignored by default.
*   **Thumbnails**: Set `RMAPI_THUMBNAILS=1` to generate a thumbnail of the first page when uploading/processing PDFs.
*   **Concurrency**: For the new sync protocol, use `RMAPI_CONCURRENT=N` to adjust the number of parallel HTTP requests (default is 20).

### Handling the New Sync Protocol
If uploads fail while downloads work, the account may be on the new reMarkable sync protocol. The tool includes experimental support for this; ensure you have backups before performing heavy write operations if the tool warns about protocol versions.

## Reference documentation
- [rmapi README](./references/github_com_juruen_rmapi.md)