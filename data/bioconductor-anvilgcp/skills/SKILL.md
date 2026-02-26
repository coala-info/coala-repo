---
name: bioconductor-anvilgcp
description: This package provides an R interface for managing Google Cloud Platform services and data structures within the AnVIL platform. Use when user asks to manage AnVIL workspaces, interact with Google Cloud Storage buckets, manipulate AnVIL data tables, or synchronize notebooks.
homepage: https://bioconductor.org/packages/release/bioc/html/AnVILGCP.html
---


# bioconductor-anvilgcp

name: bioconductor-anvilgcp
description: Interface for Google Cloud Platform (GCP) services on the AnVIL platform. Use when managing AnVIL workspaces, interacting with Google Cloud Storage (GCS) buckets via gsutil, executing gcloud commands, or manipulating AnVIL data tables and notebooks within an R environment.

# bioconductor-anvilgcp

## Overview

The `AnVILGCP` package provides an R interface to interact with Google Cloud Platform (GCP) services specifically tailored for the AnVIL platform. It bridges the gap between AnVIL workspace management and native GCP tools by providing wrappers for `gcloud` and `gsutil` utilities, alongside functions for handling AnVIL-specific data structures like Tables, Workspace Data, and Cloud Buckets.

## Workspace Management

Before performing most operations, you must define the active workspace context.

```r
library(AnVILGCP)

# Set the active workspace
avworkspace("billing-project-id/workspace-name")

# Or set components individually
avworkspace_namespace("billing-project-id")
avworkspace_name("workspace-name")

# Clone an existing workspace
avworkspace_clone("source-namespace/source-name", "dest-namespace", "dest-name")
```

## Working with AnVIL Tables

AnVIL organizes data into tables (e.g., participants, samples).

```r
# List available tables
avtables()

# Retrieve a table as a tibble
samples <- avtable("sample")

# Import a local data frame to an AnVIL table
# Note: Tables are imported asynchronously
job_status <- avtable_import(my_dataframe)
avtable_import_status(job_status)

# Create set tables (e.g., sample_set) from existing tables
avtable_import_set(samples, "sample", "set_name", "name")
```

## Google Cloud Storage (gsutil)

Use `gsutil_*` functions to manage files in Google Cloud Storage buckets.

```r
# Get the bucket URI for the current workspace
bucket <- avstorage()

# List files in a bucket
gsutil_ls(bucket)

# Copy files (supports local-to-cloud, cloud-to-local, or cloud-to-cloud)
gsutil_cp("local_file.csv", bucket)

# Stream data directly from a bucket without saving to disk
pipe <- gsutil_pipe(paste0(bucket, "data.csv"), "rb")
data <- readr::read_csv(pipe)

# Synchronize directories
gsutil_rsync(source_dir, dest_dir, dry = FALSE)
```

## Backup and Restore

Convenience functions for moving data between the compute node and the workspace bucket.

```r
# Backup current working directory to workspace bucket
avbackup(getwd(), recursive = TRUE)

# Restore files from bucket to compute node
avrestore(paste0(avstorage(), "backup_folder"))

# Localize/Delocalize (one-way sync)
localize(source_uri, destination_path)
delocalize(source_path, destination_uri)
```

## Notebook Management

Manage R Markdown (.Rmd) and Jupyter (.ipynb) notebooks associated with the workspace.

```r
# List notebooks in the workspace
avnotebooks()

# List notebooks on the local runtime
avnotebooks(local = TRUE)

# Sync notebooks from workspace to local runtime
avnotebooks_localize(dry = FALSE)

# Sync local notebooks to the workspace
avnotebooks_delocalize(dry = FALSE)
```

## GCloud Command Access

Execute arbitrary `gcloud` SDK commands directly from R.

```r
# Check current account and project
gcloud_account()
gcloud_project()

# Run generic gcloud commands
gcloud_cmd("projects", "list")

# Access help for gcloud commands
gcloud_help("compute")
```

## Reference documentation

- [Working with AnVIL on GCP](./references/AnVILGCPIntroduction.md)