---
name: bleach
description: BleachBit is a cleanup utility that removes unnecessary files to free up storage and securely deletes data to protect user privacy. Use when user asks to clean system files, shred sensitive data, preview disk space recovery, or list available cleaners.
homepage: https://github.com/bleachbit/bleachbit
metadata:
  docker_image: "quay.io/biocontainers/bleach:1.4.2--py35_0"
---

# bleach

## Overview
BleachBit is a powerful, open-source cleanup utility that identifies and removes unnecessary files to free up storage and protect user privacy. While it offers a graphical interface, this skill focuses on its command-line capabilities, which allow for precise, scriptable maintenance across various applications and system components. It is particularly effective for "antiforensics"—permanently deleting data so it cannot be recovered.

## Command Line Usage

### Basic Execution
If running from the source repository, use the Python entry point:
`python3 bleachbit.py [options] [cleaners]`

### Discovery and Preview
Before deleting files, always identify available cleaners and perform a dry run.
- **List all available cleaners**: `python3 bleachbit.py --list`
- **Preview changes (Dry Run)**: `python3 bleachbit.py --preview system.tmp`
  - This shows which files will be deleted and how much space will be recovered without actually modifying the disk.

### Cleaning Operations
To execute the actual deletion, use the `--clean` flag followed by one or more cleaner modules.
- **Clean specific items**: `python3 bleachbit.py --clean firefox.cookies system.tmp`
- **Clean multiple categories**: `python3 bleachbit.py --clean apt.clean yum.clean chromium.cache`

### Secure Deletion (Shredding)
BleachBit can overwrite files to prevent recovery.
- **Shred specific files or folders**: `python3 bleachbit.py --shred /path/to/sensitive_file`

### Automation and Headless Tips
- **Bypass first-run prompts**: Use the `--no-first-start` flag in scripts to prevent the application from waiting for user interaction during its initial execution.
- **Overwrite free space**: To hide previously deleted files, use the cleaner `system.free_disk_space`. Note that this is time-consuming and writes heavily to the disk.
- **Exit Codes**: Monitor exit codes for automation; a non-zero code typically indicates an error or that some files could not be deleted (often due to permissions).

## Expert Best Practices
- **Permissions**: On Linux, cleaning system-wide areas (like APT or localized files) requires root privileges (`sudo`). Cleaning browser data should be done as the local user.
- **Browser State**: Ensure browsers (Chrome, Firefox, etc.) are closed before running their respective cleaners to avoid database locks or incomplete cleaning.
- **Specific Cleaners**: Cleaners are structured as `domain.option`. For example, `browser.cache` only clears the cache, while `browser` might clear everything if the tool defaults to all options (check `--help` for version-specific behavior).

## Reference documentation
- [BleachBit README](./references/github_com_bleachbit_bleachbit.md)
- [BleachBit Commits (CLI Arguments)](./references/github_com_bleachbit_bleachbit_commits_master.md)