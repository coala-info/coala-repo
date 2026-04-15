---
name: ibridges
description: The ibridges tool provides a simplified high-level interface for interacting with iRODS to perform secure data management and metadata operations. Use when user asks to initialize iRODS connections, upload or download files, synchronize local and remote folders, or manage metadata attributes.
homepage: https://github.com/iBridges-for-iRODS/iBridges
metadata:
  docker_image: "quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0"
---

# ibridges

## Overview

The ibridges tool acts as a high-level wrapper around the `python-irodsclient`, designed to lower the barrier for interacting with iRODS (integrated Rule-Oriented Data System). It provides a simplified interface for common data operations while enforcing safe defaults to prevent accidental data loss. Key capabilities include interactive authentication, recursive data transfers, metadata manipulation, and synchronization between local file systems and iRODS collections. It is cross-platform, supporting Windows, macOS, and Linux.

## Quick Start & Authentication

Before performing any operations, you must initialize a connection. iBridges relies on an `irods_environment.json` file for configuration.

### CLI Initialization
```bash
# Initialize connection and create environment file if missing
ibridges init
```

### Python Authentication
```python
from ibridges.interactive import interactive_auth
session = interactive_auth()
```

## Common CLI Patterns

The CLI uses a URI-like syntax (`irods:`) to distinguish between local and remote paths.

| Task | Command |
| :--- | :--- |
| **List Collection** | `ibridges list "irods:~/my_collection"` |
| **Upload File** | `ibridges upload local_file.txt "irods:~/destination_coll"` |
| **Download File** | `ibridges download "irods:~/remote_file.txt" ./local_dir` |
| **Sync Folders** | `ibridges sync ./local_folder "irods:~/remote_folder"` |
| **Create Collection** | `ibridges mkdir "irods:~/new_collection"` |

## Data Transfer Best Practices

### Handling Overwrites and Errors
iBridges is conservative by default. When using `upload`, `download`, or `sync`, you can control behavior using flags:

*   **Overwrite existing data**: Use `--overwrite` (CLI) or `overwrite=True` (Python).
*   **Ignore errors**: Use `--ignore-err` (CLI) or `ignore_err=True` (Python) to skip existing files and continue the batch process.
*   **Safety Combo**: To overwrite existing data but turn other errors into warnings, set both to `True`.

### Large File Transfers
If transfers of very large files (terabytes) fail with a `NetworkError`, it is often due to the checksum calculation exceeding the default timeout (7 hours).
*   **Fix**: Increase `connection_timeout` in your `irods_environment.json`.

## Metadata Management

iBridges allows for easy searching and manipulation of metadata (Attribute-Value-Unit triples).

### Searching by Metadata
```bash
# Search for objects with a specific key-value pair
ibridges search --key "Project" --value "Genomics_2024"
```

### Python Metadata Operations
```python
from ibridges.meta import MetaData
from ibridges.path import IrodsPath

# Access metadata for a path
path = IrodsPath(session, "~/my_data_object")
meta = MetaData(path.dataobject)

# Add metadata
meta.add("Author", "John Doe")

# Note: Metadata starting with 'org_' is hidden by default on some systems (e.g., Yoda).
# To view all, initialize MetaData with blacklist=None.
```

## Expert Tips

1.  **Session Access**: In Python, the `ibridges` session object contains a reference to the underlying `python-irodsclient` session. If you need advanced features not exposed by ibridges, use `session.irods_session`.
2.  **Path Handling**: Always use the `IrodsPath` class in Python scripts to ensure paths are correctly parsed and validated against the server.
3.  **Tickets**: Use the `tickets` module to create temporary access tokens for outside users without requiring them to have full iRODS accounts.
4.  **Shell Mode**: Simply running `ibridges` without arguments enters an interactive shell mode which is faster for multiple consecutive commands as it maintains the connection.



## Subcommands

| Command | Description |
|---------|-------------|
| ibridges alias | Print existing aliases or create new ones. |
| ibridges cd | Change current working collection for the iRODS server. |
| ibridges download | Download a data object or collection from an iRODS server. |
| ibridges init | Create a cached password for future use. |
| ibridges meta-del | Delete metadata for one collection or data object. |
| ibridges mkcoll | Create a new collecion with all its parent collections. |
| ibridges sync | Synchronize files/directories between local and remote. |
| ibridges tree | Show collection/directory tree. |
| ibridges_ls | List a collection on iRODS. |
| ibridges_meta-add | Add a metadata item to a collection or data object. |
| ibridges_meta-list | List the metadata of a data object or collection on iRODS. |
| ibridges_rm | Remove collection or data object. |
| ibridges_search | Search for dataobjects and collections. |
| ibridges_setup | Use templates to create an iRODS environment json. |
| ibridges_upload | Upload a data object or collection to an iRODS server. |

## Reference documentation
- [iBridges CLI Reference](./references/ibridges_readthedocs_io_en_latest_cli.html.md)
- [iBridges Python API Guide](./references/ibridges_readthedocs_io_en_latest_ibridges_python.html.md)
- [Frequently Asked Questions](./references/ibridges_readthedocs_io_en_latest_faq.html.md)
- [iBridges GitHub README](./references/github_com_iBridges-for-iRODS_iBridges.md)