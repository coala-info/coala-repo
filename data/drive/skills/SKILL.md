---
name: drive
description: The drive tool is a command-line interface for interacting with Google Drive using a push and pull synchronization model. Use when user asks to initialize a local drive directory, push or pull files, list remote content, manage Google Docs exports, or delete files from Google Drive.
homepage: https://github.com/odeke-em/drive
metadata:
  docker_image: "quay.io/biocontainers/drive:0.3.9--0"
---

# drive

## Overview

The `drive` tool is a lightweight command-line interface designed for efficient interaction with Google Drive. Unlike the official sync client, it operates on a "push/pull" model similar to Git, giving you explicit control over when and what data is synchronized. It is particularly useful for headless servers, automation scripts, and developers who prefer terminal-based file management.

## Core Workflows

### Initialization
Before performing any operations, you must initialize a local directory to track your Google Drive content.

- **Standard OAuth**: `drive init ~/gdrive`
- **Service Account**: `drive init --service-account-file credentials.json ~/gdrive`
- **De-initialize**: `drive deinit` (removes local credentials and config)

### Synchronizing Data
- **Pull (Download)**: `drive pull`
  - Downloads remote changes that don't exist locally.
  - Use `-depth N` to limit traversal (e.g., `drive pull -depth 2`).
  - Use `-id` to pull specific files by their Google Drive ID.
  - Use `-hidden` to include files starting with a dot.
- **Push (Upload)**: `drive push`
  - Uploads local changes to the remote drive.
  - Use `-no-clobber` to prevent overwriting existing remote files.
  - Use `-destination path/to/folder` to push to a specific remote location.

### File Management
- **Listing**: `drive list` (use `-long` for details like size and modTime).
- **Status**: `drive stat <path>` (shows detailed metadata for a specific file).
- **Moving/Renaming**: `drive move <src> <dest>` or `drive rename <src> <newname>`.
- **Deleting**: `drive trash <path>` (moves to trash) or `drive delete <path>` (permanent).
- **Empty Trash**: `drive empty-trash`.

### Google Docs Handling
By default, Google Docs are exported as PDFs during a pull.
- **Custom Export**: `drive pull -export docx,txt,pdf`
- **Same Directory**: Use `-same-exports-dir` to keep exports alongside the original file reference.

## Expert Tips

### Using .driveignore
Create a `.driveignore` file in your root directory to exclude specific patterns from sync.
- Uses regular expressions.
- Prefix a pattern with `!` to create an exception (include).
- Example:
  ```
  \.so$
  \.swp$
  !^\.bashrc
  ```

### Traversal Depth Control
- `0`: Terminate immediately.
- `1`: Current directory only.
- `-1`: Infinite recursion (default for many commands).

### Checksum Verification
By default, `drive` uses file size and modification time to detect changes. To force a rigorous checksum check:
`drive pull -ignore-checksum=false`

### Configuration with .driverc
You can set persistent flags in a `.driverc` file (global in `~/.driverc` or local in the drive root).
Format: `key=value`
Example:
```
depth=10
no-prompt=true
[list]
long=true
```



## Subcommands

| Command | Description |
|---------|-------------|
| cp | Copy files or directories. |
| del | Deletes files or directories. |
| diff | Compares files or directories. |
| drive_about | Gives information about the drive. |
| drive_copy | Copy files or directories |
| drive_delete | Deletes files or folders from Google Drive. |
| drive_edit-desc | Edit the description of a drive. |
| drive_list | List files and directories |
| drive_ls | List files and directories in Google Drive. |
| drive_move | Move files or directories. |
| drive_open | Open files or directories. |
| drive_pub | Usage of pub |
| drive_pull | Pulls files and directories from Google Drive. |
| drive_push | Pushes files and directories to Google Drive. |
| drive_rename | Rename a file or directory on Google Drive. |
| drive_stat | Statistics about files and directories. |
| drive_trash | Trash files and directories. |
| emptytrash | Empties the trash |
| mv | Move files or directories. |
| share | Share a file |
| touch | Touch files with specified modification times. |
| unpub | Unpublish paths or IDs. |

## Reference documentation
- [Home - drive wiki](./references/github_com_odeke-em_drive_wiki.md)
- [drive README](./references/raw_githubusercontent_com_odeke-em_drive_refs_heads_master_README.md)
- [MIME type short keys](./references/github_com_odeke-em_drive_wiki_List-of-MIME-type-short-keys.md)