---
name: dropbox
description: This skill enables efficient management of Dropbox resources using a lightweight, BASH-based CLI tool.
homepage: https://github.com/andreafabrizi/Dropbox-Uploader
---

# dropbox

## Overview
This skill enables efficient management of Dropbox resources using a lightweight, BASH-based CLI tool. It allows for robust file operations—including chunked uploads for large files, recursive directory downloads, and direct URL-to-Dropbox saving—without the overhead of a full desktop synchronization client. It is particularly useful for headless servers, cron-based automation, and scripts requiring secure, API-based access to Dropbox storage.

## Core CLI Usage
The primary script is `dropbox_uploader.sh`. All commands follow the pattern: `./dropbox_uploader.sh [PARAMETERS] COMMAND...`

### Essential Commands
- **List contents**: `./dropbox_uploader.sh list [REMOTE_DIR]`
- **Upload**: `./dropbox_uploader.sh upload <LOCAL_FILE/DIR> <REMOTE_FILE/DIR>`
  - Supports wildcards (e.g., `upload *.zip /backups/`).
  - Automatically uses chunked uploading (50MB chunks) for files larger than 150MB.
- **Download**: `./dropbox_uploader.sh download <REMOTE_FILE/DIR> [LOCAL_FILE/DIR]`
- **Share**: `./dropbox_uploader.sh share <REMOTE_FILE>` (Returns a public URL).
- **Search**: `./dropbox_uploader.sh search <QUERY>`
- **Direct Transfer**: `./dropbox_uploader.sh saveurl <URL> <REMOTE_DIR>` (Saves a file from a URL directly to Dropbox without downloading it locally first).

### Management Commands
- **Space Usage**: `./dropbox_uploader.sh space` (Shows account quota and usage).
- **Account Info**: `./dropbox_uploader.sh info`
- **Directory Creation**: `./dropbox_uploader.sh mkdir <REMOTE_DIR>`
- **File Operations**: Supports `delete`, `move`, `copy`, and `rename` using standard remote paths.

## Expert Tips and Best Practices

### Automation and Cron Jobs
When running as a cron job, the script cannot reliably detect the user's home directory. Always use the `-f` flag to specify the absolute path to the configuration file:
`0 2 * * * /path/to/dropbox_uploader.sh -f /home/user/.dropbox_uploader upload /local/data /remote/backup`

### Performance and Filtering
- **Skip Existing**: Use the `-s` parameter to skip files that already exist on the destination during upload or download, effectively performing a simple sync.
- **Exclusions**: Use `-x <PATTERN>` to ignore specific files or directories (e.g., `-x .git`).
- **Human Readable**: Use the `-h` flag with the `list` command to see file sizes in KB/MB/GB.
- **Quiet Mode**: Use `-q` in scripts to suppress progress meters and non-essential output.

### Security
- The script uses Dropbox API v2 and OAuth refresh tokens.
- Configuration is stored in `~/.dropbox_uploader`. Ensure this file has restricted permissions (`chmod 600`).
- To remove access, use the `unlink` command.

## Reference documentation
- [Dropbox Uploader Main Reference](./references/github_com_andreafabrizi_Dropbox-Uploader.md)
- [Dropbox Uploader Wiki](./references/github_com_andreafabrizi_Dropbox-Uploader_wiki.md)