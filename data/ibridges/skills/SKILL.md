---
name: ibridges
description: The `ibridges` tool is a high-level wrapper for the `python-irodsclient`, designed to simplify data management for scientific researchers.
homepage: https://github.com/iBridges-for-iRODS/iBridges
---

# ibridges

## Overview
The `ibridges` tool is a high-level wrapper for the `python-irodsclient`, designed to simplify data management for scientific researchers. It provides a streamlined interface for moving data between local storage and iRODS servers while maintaining metadata and ensuring data integrity. Use this skill to automate data transfers, perform bulk synchronizations, or interactively manage remote collections without needing to handle the low-level complexities of the iRODS protocol.

## Configuration and Authentication
Before using `ibridges`, you must have an `irods_environment.json` file configured.

- **CLI Initialization**: Run `ibridges init` to establish a connection and cache your credentials.
- **Python Authentication**: Use the interactive module for a simple session setup:
  ```python
  from ibridges.interactive import interactive_auth
  session = interactive_auth()
  ```

## Common CLI Patterns
The CLI uses a specific URI-like syntax for iRODS paths: `irods:path/to/collection`.

### Data Navigation
- **List Home Collection**: `ibridges list`
- **List Specific Path**: `ibridges list "irods:~/my_folder"`
- **List Absolute Path**: `ibridges list "irods:/zoneName/home/username"`

### Data Transfer
- **Upload**: `ibridges upload local_file.dat "irods:~/destination_collection"`
- **Download**: `ibridges download "irods:~/remote_file.dat" ./local_destination`
- **Synchronize**: `ibridges sync ./local_folder "irods:~/remote_backup"`
  - *Tip*: `sync` is preferred for large datasets as it only transfers modified or missing files.

## Python API Usage
For scripts and automated workflows, use the functional interface.

```python
from ibridges import upload, download, sync

# Uploading a file
upload(session, "/local/path/file.txt", "/irods/path/file.txt")

# Downloading a collection
download(session, "/irods/path/collection", "/local/path", recursive=True)

# Synchronizing local to remote
sync(session, "/local/path", "/irods/path", copy_empty_directories=True)
```

## Best Practices
- **Path Syntax**: Always use the `irods:` prefix in the CLI to distinguish remote paths from local paths.
- **Home Shortcut**: Use `~` to refer to your iRODS home directory (e.g., `irods:~/data`).
- **Metadata**: `ibridges` is optimized for metadata-heavy environments. When uploading, ensure your environment supports the metadata standards required by your institution (e.g., Yoda).
- **Tickets**: Use the ticket system to grant temporary access to specific data objects or collections for users who do not have standard iRODS accounts.

## Reference documentation
- [iBridges GitHub Repository](./references/github_com_iBridges-for-iRODS_iBridges.md)
- [iBridges Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ibridges_overview.md)