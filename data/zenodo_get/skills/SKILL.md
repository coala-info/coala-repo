---
name: zenodo_get
description: zenodo_get downloads datasets and research artifacts from the Zenodo repository using Record IDs or DOIs. Use when user asks to download files from Zenodo, filter downloads with glob patterns, resume interrupted transfers, or retrieve record citations.
homepage: https://github.com/dvolgyes/zenodo_get
metadata:
  docker_image: "hubentu/zenodo-get"
---


# zenodo_get

## Overview
This skill provides procedural knowledge for using `zenodo_get`, a specialized utility for retrieving datasets and files from the Zenodo repository. It simplifies the process of fetching open-access research artifacts by handling DOI resolution, download resumption, and checksum verification. Use this skill when you need to programmatically download scientific data or when a user provides a Zenodo link/ID and needs specific files extracted.

## CLI Usage Patterns

### Basic Downloads
The tool accepts either a numeric Record ID or a full DOI.
- **Download by ID**: `uvx zenodo_get 1234567`
- **Download by DOI**: `uvx zenodo_get 10.5281/zenodo.1234567`

### Targeted Retrieval
Avoid downloading entire multi-gigabyte datasets by using glob patterns.
- **Filter by extension**: `uvx zenodo_get [ID] -g "*.csv"`
- **Specific directory**: `uvx zenodo_get [ID] -o ./data_folder`

### Reliability and Verification
For large transfers or unstable connections, use these flags:
- **Resume/Fresh Start**: Use `-n` to ignore partial downloads and start fresh; otherwise, it attempts to resume.
- **Checksums**: Use `-m` to generate a local `md5sums.txt` for post-download integrity checks.
- **Error Handling**: Use `-e` to skip a file that fails and continue with the rest of the record.

### Exporting URLs
If you prefer using an external downloader (like `wget` or `aria2`), extract the direct download links:
- `uvx zenodo_get [ID] -w urls.txt`

## Python API Integration
When writing scripts, use the `download` function for cleaner integration than `subprocess`.

```python
from zenodo_get import download

# Download specific types to a target directory
download(
    record_or_doi="10.5281/zenodo.1234567",
    output_dir="./raw_data",
    file_glob=("*.json", "*.csv"),
    continue_on_error=True
)
```

## Expert Tips
- **Rate Limiting**: If encountering 429 errors, increase the backoff factor using `--backoff-factor 2.0`.
- **Timeouts**: For very large files on slow connections, increase the timeout from the default 25s using `-t 60`.
- **Citations**: To quickly get the BibTeX or citation info for a record, use `uvx zenodo_get [ID] --cite`.



## Subcommands

| Command | Description |
|---------|-------------|
| zenodo_get | Command-line interface for downloading files from Zenodo records. |

## Reference documentation
- [Zenodo_get README](./references/github_com_dvolgyes_zenodo_get_blob_main_README.md)
- [Tool Overview](./references/anaconda_org_channels_conda-forge_packages_zenodo_get_overview.md)