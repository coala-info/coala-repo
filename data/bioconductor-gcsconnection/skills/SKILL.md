---
name: bioconductor-gcsconnection
description: This tool provides an R connection interface to read, write, and manage files on Google Cloud Storage. Use when user asks to authenticate with Google Cloud, create connections to GCS buckets, manage files using an S4 interface, or optimize data transfer performance.
homepage: https://bioconductor.org/packages/3.11/bioc/html/GCSConnection.html
---


# bioconductor-gcsconnection

name: bioconductor-gcsconnection
description: Provides specialized workflows for connecting to and managing files on Google Cloud Storage (GCS) using the Bioconductor R package GCSConnection. Use this skill when you need to: (1) Authenticate with Google Cloud via service accounts or gcloud SDK, (2) Create R connections to read or write files directly from/to GCS buckets (gs://), (3) Manage GCS files using an S4 file manager interface (listing, copying, deleting), or (4) Optimize GCS data transfer performance using buffer settings.

# bioconductor-gcsconnection

## Overview

The `GCSConnection` package provides a standard R connection interface for Google Cloud Storage. It allows users to treat GCS objects as local files for reading and writing, while also providing a convenient S4-based file management system to navigate buckets and folders.

## Authentication

Before accessing private data, you must authenticate. Public data can be accessed anonymously.

- **Auto-authentication**: Set the `GOOGLE_APPLICATION_CREDENTIALS` or `GCS_AUTH_FILE` environment variable to your JSON key path.
- **Manual JSON**: `gcs_cloud_auth("path/to/key.json")`
- **gcloud SDK**: `gcs_cloud_auth(gcloud = TRUE)`
- **Anonymous**: `gcs_cloud_auth(json_file = NULL)`
- **Check Status**: `gcs_get_cloud_auth()`

## Working with Connections

You can create connections using URI strings or by specifying bucket and file names separately.

### Reading Data
```r
# Using URI
con <- gcs_connection(description = "gs://bucket-name/path/to/file.vcf", open = "r")
data <- readLines(con, n = 10)
close(con)

# Using bucket/file parameters
con <- gcs_connection(description = "file.txt", bucket = "my-bucket", open = "r")
```

### Writing Data
**Note**: Write connections are not seekable. Closing the connection makes the file immutable on GCS.
```r
con <- gcs_connection(description = "gs://my-bucket/output.txt", open = "w")
writeLines(c("row1", "row2"), con)
close(con)
```

## File Management (S4 Interface)

The package provides a directory-like object to browse GCS.

- **List Directory**: `x <- gcs_dir("gs://bucket/folder/")` (Use trailing slashes for folders to improve performance).
- **Navigate**: Use `$` or `[[` to access files or subdirectories. Use `..` to go up.
  - `file_obj <- x$my_data.csv`
  - `parent <- x[[".."]]`
- **File Operations**:
  - **Get Connection**: `con <- file_obj$get_connection(open = "r")`
  - **Copy**: `file_obj$copy_to("local/path/")`
  - **Delete**: `file_obj$delete(quiet = FALSE)` (Requires write permissions).

## Performance Tuning

Adjust buffer sizes to optimize network requests. The default is 1MB.

- **Read Buffer**: `gcs_read_buff(size_in_bytes)` / `gcs_get_read_buff()`
- **Write Buffer**: `gcs_write_buff(size_in_bytes)` / `gcs_get_write_buff()`
- **Note**: Minimum write buffer is 256 KB.

## Reference documentation

- [Introduction](./references/Introduction.md)