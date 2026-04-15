---
name: screamingbackpack
description: ScreamingBackpack synchronizes data resources between local and remote environments by generating and comparing manifest files. Use when user asks to create a data manifest, compare local datasets against remote sources, or update local data to match a remote repository.
homepage: https://github.com/minillinim/ScreamingBackpack
metadata:
  docker_image: "quay.io/biocontainers/screamingbackpack:0.2.333--py_1"
---

# screamingbackpack

## Overview

ScreamingBackpack is a specialized utility for synchronizing data resources between local environments and remote sources. It operates by generating and comparing lightweight manifest files (`.dmanifest`) that contain file paths, sizes, and SHA256 hashes. This approach allows users to identify specific differences between datasets and perform targeted updates without the overhead of full-directory transfers or complex version control systems. It is particularly useful for managing large data dependencies in bioinformatics or scientific workflows.

## CLI Usage Patterns

The `screamingBackpack` binary supports three primary modes of operation.

### 1. Creating a Manifest
Generate a manifest file to describe the current state of a local data directory.
```bash
# Creates a default .dmanifest in the current directory
screamingBackpack create /path/to/data/repo
```

### 2. Comparing Manifests (Diff)
Compare a local manifest against a source manifest (local file or remote URL) to identify discrepancies.
```bash
# Compare local data against a remote source
screamingBackpack diff /local/path/repo http://remote-source.com/data/
```

### 3. Updating Local Data
Synchronize the local repository to match the remote source based on manifest differences.
```bash
# Update local data to reflect the remote source
screamingBackpack update /local/path/repo http://remote-source.com/data/
```

## Python API Integration

For programmatic control, use the `ManifestManager` class.

```python
from screamingBackpack.manifestManager import ManifestManager

# Initialize with a specific manifest type
MM = ManifestManager(manType="MyDataset")

# Create a manifest with a custom name
MM.createManifest("/path/to/data", manifestName="v1.manifest")

# Perform a diff between local and remote
MM.diffManifests(
    localManifestLocation="/local/data",
    sourceManifestLocation="http://remote-server.org/data",
    printDiffs=True
)

# Update local data (prompt=True will ask for confirmation)
MM.updateManifest(
    "/local/data", 
    "http://remote-server.org/data", 
    prompt=True
)
```

## Expert Tips and Best Practices

- **Manifest Format**: The manifest is a three-column space-separated file: `local_path sha256_hash size_in_bytes`. Folders are represented with a `-` for hash and `0` for size.
- **Integrity Verification**: ScreamingBackpack uses SHA256 hashes. If a file's content changes but the size remains the same, the `diff` command will still detect the change.
- **Remote Syncing**: When using `diff` or `update` with a remote source, ensure the `sourceManifestLocation` is a fully qualified URL. The tool will attempt to download the remote manifest first to calculate the required operations.
- **Dry Runs**: Always use the `diff` command before `update` to preview which files will be downloaded or deleted.
- **Custom Manifest Names**: By default, the tool looks for `.dmanifest`. If you are managing multiple versions or subsets of data in the same directory, use the `manifestName` parameter in the API or ensure the specific manifest file is passed to the CLI.

## Reference documentation
- [ScreamingBackpack Overview](./references/github_com_minillinim_ScreamingBackpack.md)