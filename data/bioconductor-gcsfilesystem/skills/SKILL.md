---
name: bioconductor-gcsfilesystem
description: The bioconductor-gcsfilesystem package provides a unified R interface to mount Google Cloud Storage buckets as local file systems on Windows, Linux, and macOS. Use when user asks to mount Google Cloud Storage buckets, access remote cloud files using standard R functions, or manage GCS mount points.
homepage: https://bioconductor.org/packages/3.12/bioc/html/GCSFilesystem.html
---


# bioconductor-gcsfilesystem

## Overview

The `GCSFilesystem` package provides a unified R interface to mount Google Cloud Storage buckets to the local operating system. It acts as a wrapper around `gcsfuse` (Linux/macOS) or `GCSDokan` (Windows). Once mounted, files in the bucket can be accessed using standard R file manipulation functions like `list.files()`, `read.table()`, or specialized Bioconductor readers.

## Prerequisites

Before using this package, the system must have the following external dependencies installed:
- **Windows**: [GCSDokan](https://github.com/Jiefei-Wang/GCSDokan)
- **Linux/macOS**: [gcsfuse](https://github.com/GoogleCloudPlatform/gcsfuse)

## Authentication

The package uses Google Application Default Credentials (ADC).
1. **Environment Variable**: Set `GOOGLE_APPLICATION_CREDENTIALS` to the path of your service account JSON key file.
2. **Manual**: Provide the path directly in R using the `key_file` argument in `gcs_mount()`.
3. **Anonymous Access**: Some public buckets (e.g., `genomics-public-data`) allow anonymous access on Windows without credentials. On Linux/macOS, `gcsfuse` generally requires credentials even for public buckets.

## Core Workflow

### 1. Mounting a Bucket
Mount a full bucket or a specific subdirectory to a local path.

```r
library(GCSFilesystem)

# Define remote bucket and local mount point
remote_path <- "genomics-public-data/clinvar"
local_mount <- file.path(tempdir(), "gcs_clinvar")

# Create the local directory if it doesn't exist
dir.create(local_mount, recursive = TRUE)

# Mount the bucket
gcs_mount(bucket = remote_path, mount_point = local_mount)
```

### 2. Accessing Files
Once mounted, treat the `local_mount` as a standard directory.

```r
# List files in the bucket
files <- list.files(local_mount, recursive = TRUE)

# Read a file directly from the mount
# Example: reading a README or metadata file
data <- read.lines(file.path(local_mount, "README"))
```

### 3. Managing Mounts
List active mount points or disconnect them when finished.

```r
# View all active GCS mounts
gcs_list_mountpoints()

# Unmount a specific directory
gcs_unmount(local_mount)
```

## Advanced Configuration

### Billing Projects
If a bucket has "Requester Pays" enabled, you must specify your Google Cloud Project ID to avoid access errors.
```r
gcs_mount("private-bucket", local_mount, billing = "my-gcp-project-id")
```
*Note: Do not use the billing argument for public buckets that do not require it, as it may result in unnecessary charges.*

### Performance Tuning
- **Refresh Rate**: Metadata is cached for 60 seconds by default. Adjust this using the `refresh` argument (in seconds) if the remote bucket changes frequently.
- **Caching (Windows Only)**: Control how data is cached locally using `cache_type` ("none", "disk", or "memory") and `cache_arg`.

## Troubleshooting
- **Empty Directories**: If a mount succeeds but `list.files()` returns nothing, check if the bucket requires a `billing` project ID or if your credentials have sufficient IAM permissions (Storage Object Viewer).
- **Mount Failures**: Ensure the background utilities (`gcsfuse` or `GCSDokan`) are in the system PATH.

## Reference documentation
- [Quick-Start-Guide](./references/Quick-Start-Guide.md)