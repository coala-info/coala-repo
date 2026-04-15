---
name: bioconductor-anvil
description: The AnVIL package provides an R interface to interact with the AnVIL cloud ecosystem for managing workspaces, data tables, and workflows. Use when user asks to manage Terra workspaces, interact with Google Cloud Storage buckets, manipulate data tables, or programmatically execute and monitor WDL workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/AnVIL.html
---

# bioconductor-anvil

## Overview

The `AnVIL` package provides an R interface to the AnVIL cloud ecosystem. It allows users to interact with Terra workspaces, manage cloud-based files via `gsutil` wrappers, and programmatically control workflows. It is particularly useful for automating data movement between local environments and the cloud, and for managing large-scale genomic data tables.

## Core Workflows

### 1. Workspace Management
Before performing most operations, define the active workspace.

```r
library(AnVIL)

# Set active workspace
avworkspace("namespace/name")

# Discover current settings
avworkspace_namespace()
avworkspace_name()

# Clone a workspace
avworkspace_clone("source-namespace/source-name", "dest-namespace/dest-name")
```

### 2. Working with Data Tables
AnVIL uses "Tables" to organize metadata and file paths.

```r
# List available tables
avtables()

# Read a table into a tibble
sample_data <- avtable("sample")

# Import/Update a table from R
my_metadata <- data.frame(sample_id = c("s1", "s2"), status = c("control", "case"))
avtable_import(my_metadata)

# Create a set (e.g., participant_set) from existing table rows
avtable_import_set(sample_data, "participant", "set_name", "participant_id")
```

### 3. Cloud Storage (GCS) Operations
Use `gsutil_*` functions to manage files in Google buckets.

```r
# Get the bucket associated with the current workspace
bucket <- avbucket()

# List files in a bucket
gsutil_ls(bucket)

# Copy files
gsutil_cp("local_file.txt", bucket)
gsutil_cp(paste0(bucket, "/remote_file.txt"), "local_copy.txt")

# Sync directories (localize/delocalize)
localize(bucket, "local_dir")   # Cloud to Local
delocalize("local_dir", bucket) # Local to Cloud

# Stream data without downloading
pipe <- gsutil_pipe(paste0(bucket, "/data.csv"), "rb")
data <- readr::read_csv(pipe)
```

### 4. Workflow Execution
Manage WDL workflows from within R.

```r
# List workflows in the workspace
avworkflows()

# Set the active workflow
avworkflow("namespace/workflow_name")

# Get and update configuration
config <- avworkflow_configuration_get()
inputs <- avworkflow_configuration_inputs(config)

# Run a workflow on a specific entity (e.g., a row in a table)
avworkflow_run(config, entityName = "sample_01", dry = FALSE)

# Monitor jobs
avworkflow_jobs()

# Stop a job
avworkflow_stop(submissionId = "your-id-here", dry = FALSE)
```

### 5. Fast Binary Installation
In the AnVIL cloud environment, use `BiocManager` to install pre-compiled binaries for speed.

```r
# Fast installation of Bioconductor packages
BiocManager::install("GenomicFeatures")

# Manage project-specific libraries
add_libpaths("~/my_project_lib")
```

## Developer Tools
For advanced users, the package provides direct access to REST APIs via Service objects.

```r
terra <- Terra()
leonardo <- Leonardo()
rawls <- Rawls()

# Explore endpoints
tags(terra)
terra$status()
```

## Tips
- **Dry Runs**: Many functions (like `avworkflow_run` or `avnotebooks_localize`) have a `dry = TRUE` default. Set `dry = FALSE` to execute the action.
- **Gadgets**: Use `avworkspace_gadget()` or `avtable_gadget()` for a GUI-based selection of resources.
- **DRS**: Use `drs_stat()` and `drs_cp()` to resolve Data Repository Service URIs to usable cloud paths.

## Reference documentation
- [Dockstore and Bioconductor for AnVIL](./references/BiocDockstore.md)
- [Introduction to the AnVIL package](./references/Introduction.md)
- [Running an AnVIL workflow within R](./references/RunningWorkflow.md)