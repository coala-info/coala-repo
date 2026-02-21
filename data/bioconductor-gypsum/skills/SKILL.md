---
name: bioconductor-gypsum
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gypsum.html
---

# bioconductor-gypsum

name: bioconductor-gypsum
description: Comprehensive guide for using the gypsum R package to interact with the gypsum REST API. Use when the user needs to: (1) List, download, or read files from the Bioconductor gypsum backend, (2) Upload new data assets or versions to the backend, (3) Manage project permissions and quotas, (4) Validate metadata against Bioconductor standards, or (5) Perform administrative tasks like project creation or deletion.

# bioconductor-gypsum

## Overview

The `gypsum` package is an R client for the gypsum REST API, providing a centralized backend for Bioconductor packages to store and retrieve data assets. It supports versioning, deduplication via file linking, permission management, and metadata validation.

## Reading Data

Use these functions to explore and download assets from the public bucket. No authentication is required for reading.

*   **List available content**:
    *   `listAssets(project)`: List all assets within a project.
    *   `listVersions(project, asset)`: List all versions of a specific asset.
    *   `listFiles(project, asset, version)`: List all files in a specific version.
*   **Download files**:
    *   `saveFile(project, asset, version, path)`: Download a single file to a local cache and return the path.
    *   `saveVersion(project, asset, version)`: Download an entire version to a local directory.
*   **Fetch metadata**:
    *   `fetchLatest(project, asset)`: Get the string of the latest version.
    *   `fetchManifest(project, asset, version)`: Get a list of files with their sizes and MD5 sums.
    *   `fetchSummary(project, asset, version)`: Get upload metadata (user, start/finish times).

## Uploading Data

Uploading requires GitHub authentication. Use `setAccessToken()` for non-interactive sessions.

### Basic Upload Workflow
1.  **Initialize**: `init <- startUpload(project, asset, version, files, directory)`
2.  **Upload**: `uploadFiles(init, directory)` (use `concurrent=` for speed).
3.  **Complete**: `completeUpload(init)`
4.  **Abort**: `abortUpload(init)` (use in `tryCatch` to clean up failed attempts).

### Efficient Versioning (Linking)
To avoid re-uploading unchanged files, use links to previous versions:
1.  Clone a previous version: `cloneVersion(project, asset, old_version, destination=dest_dir)`
2.  Modify the local files in `dest_dir`.
3.  Prepare the upload: `to.upload <- prepareDirectoryUpload(dest_dir)`
4.  Pass `to.upload$files` and `to.upload$links` to `startUpload()`.

## Permissions and Probation

*   **Check permissions**: `fetchPermissions(project)` returns owners and authorized uploaders.
*   **Set permissions**: `setPermissions(project, uploaders=list(...))` allows owners to add users or organizations.
*   **Probation**: Uploads from "untrusted" users are probational.
    *   `approveProbation(project, asset, version)`: Make a probational upload permanent.
    *   `rejectProbation(project, asset, version)`: Delete a probational upload.

## Quotas and Metadata

*   **Storage Quota**:
    *   `fetchQuota(project)`: View the baseline and growth rate of storage.
    *   `fetchUsage(project)`: Check current storage consumption in bytes.
*   **Metadata Validation**:
    *   `schema <- fetchMetadataSchema()`: Get the standard Bioconductor JSON schema.
    *   `validateMetadata(metadata_list, schema)`: Ensure your metadata list conforms to standards before uploading.

## Administration

Administrators can perform high-level management:
*   `createProject(project, owners, uploaders)`: Initialize a new project.
*   `setQuota(project, baseline, growth, year)`: Adjust storage limits.
*   `removeProject(project)`: Delete an entire project (use with caution).
*   `refreshLatest(project, asset)`: Manually update the "latest" version pointer.

## Reference documentation

- [Interacting with the gypsum REST API](./references/userguide.md)