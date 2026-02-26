---
name: ppx
description: "ppx provides a Python interface for automated discovery and retrieval of public proteomics data from repositories like PRIDE and MassIVE. Use when user asks to find proteomics projects, download mass spectrometry data files, or manage local and cloud-based proteomics data caches."
homepage: https://github.com/wfondrie/ppx
---


# ppx

## Overview

The `ppx` skill provides a streamlined Python interface for accessing public proteomics data. Instead of manual FTP downloads, it allows for automated discovery and retrieval of project files. It manages a local data cache to prevent redundant downloads and supports streaming data directly to cloud storage backends like AWS S3, Google Cloud Storage, and Azure Blob Storage.

## Core Usage Patterns

### Finding and Exploring Projects
To interact with a dataset, first initialize a project object using its unique identifier (e.g., PXD or MSV IDs).

```python
import ppx

# Initialize a project from PRIDE
proj = ppx.find_project("PXD000001")

# List all files available on the remote repository
all_files = proj.remote_files()

# Filter for specific file types using glob patterns
raw_files = proj.remote_files("*.raw")
mzml_files = proj.remote_files("*.mzML")
```

### Downloading Data
Files are downloaded to a local directory. `ppx` tracks what has already been downloaded to avoid unnecessary network traffic.

```python
# Download a specific file
proj.download("README.txt")

# Download multiple files based on a pattern
proj.download("*.fasta")
```

### Managing Data Directories
By default, `ppx` stores data in `~/.ppx`. You can customize this globally or per-project.

*   **Environment Variable**: Set `PPX_DATA_DIR` in your shell to change the default root.
*   **Session-wide**: Use `ppx.set_data_dir("/path/to/data")`.
*   **Project-specific**: Pass the `local` argument to `find_project`.

```python
# Use a specific local directory for one project
proj = ppx.find_project("PXD000001", local="data/raw_data")
```

### Cloud Storage Integration
`ppx` supports cloud URIs for data management. This requires `cloudpathlib` and appropriate provider credentials.

```python
# Stream downloads directly to an S3 bucket
proj = ppx.find_project("PXD000001", local="s3://my-proteomics-bucket/PXD000001")
proj.download("metadata.txt")
```

## Expert Tips

*   **Offline Access**: Once files are downloaded, you can access them without an internet connection by specifying the repository name: `ppx.find_project("PXD000001", repo="PRIDE")`.
*   **MassIVE Reanalysis**: `ppx` supports MassIVE reanalysis identifiers. Use the `repo="MassIVE"` argument if the identifier is ambiguous.
*   **Timeout Management**: For large metadata queries on slow connections, you can pass a `timeout` argument (in seconds) to `find_project()`.
*   **Local File Verification**: Use `proj.local_files()` to see which files are already present in your cache before initiating a download.

## Reference documentation
- [ppx - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ppx_overview.md)
- [GitHub - wfondrie/ppx: A Python interface to proteomics data repositories](./references/github_com_wfondrie_ppx.md)