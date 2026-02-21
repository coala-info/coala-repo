---
name: versionix
description: Versionix is a lightweight utility designed to standardize the extraction of version information from command-line tools.
homepage: https://github.com/sequana/versionix
---

# versionix

## Overview
Versionix is a lightweight utility designed to standardize the extraction of version information from command-line tools. It eliminates the guesswork involved in identifying which argument a specific software uses to report its version and how that output is formatted. By utilizing a combination of generalized regular expressions and a specialized registry for complex cases, it provides a clean, consistent version string (e.g., "1.2.3") for a wide variety of applications.

## Installation
Install via pip or conda to ensure the tool is available in your environment:
- **Pip**: `pip install versionix --upgrade`
- **Conda**: `conda install bioconda::versionix`

## Command Line Usage

### Basic Version Retrieval
To get the version of any executable installed on your system path, simply pass the command name to versionix:
```bash
versionix <executable_name>
```
*Example:*
```bash
versionix ls
versionix fastqc
```

### Working with the Registry
While versionix uses a general regex that works for approximately 80% of tools, some software requires specific metadata to parse correctly.
- **List registered tools**: View all tools that have specialized parsing logic.
  ```bash
  versionix --registered
```
- **Check statistics**: View the number of registered tools and general usage stats.
  ```bash
  versionix --stats
```

### Help and Metadata
Access the built-in help for additional flags and usage examples:
```bash
versionix --help
```

## Best Practices
- **Pipeline Reproducibility**: Use versionix at the start of a workflow to log the exact versions of all dependencies, ensuring the environment can be recreated.
- **Registry First**: If a tool returns an unexpected format or fails to return a version, check `versionix --registered` to see if it requires a specific entry or if a PR is needed for that tool's metadata.
- **Stream Handling**: Versionix automatically handles cases where tools print version info to `stderr` instead of `stdout`. You do not need to manually redirect streams when using the tool.
- **Pure Python**: Since the tool is pure Python, it can be easily integrated into minimal environments or containers without complex dependency chains.

## Reference documentation
- [github_com_sequana_versionix.md](./references/github_com_sequana_versionix.md)
- [anaconda_org_channels_bioconda_packages_versionix_overview.md](./references/anaconda_org_channels_bioconda_packages_versionix_overview.md)