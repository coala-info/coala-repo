---
name: bioconductor-anvilbase
description: AnVILBase provides standardized S4 generics and cloud platform abstractions for interacting with the AnVIL ecosystem on Google Cloud and Azure. Use when user asks to identify the current cloud platform, manage workspaces, interact with data tables, or perform cloud storage operations like copying and listing files.
homepage: https://bioconductor.org/packages/release/bioc/html/AnVILBase.html
---

# bioconductor-anvilbase

name: bioconductor-anvilbase
description: Use this skill when working with the Bioconductor package AnVILBase in R. This package provides the foundational S4 generics and cloud platform abstraction for interacting with the AnVIL (Analysis Visualization and Informatics Lab-space) ecosystem, specifically for Google Cloud Platform (AnVILGCP) and Azure (AnVILAz). Use this skill to identify the current cloud platform, manage workspaces, interact with data tables, and handle cloud storage operations (copy, list, backup) within an AnVIL environment.

# bioconductor-anvilbase

## Overview

`AnVILBase` is a core Bioconductor package that defines a standardized interface (S4 generics) for interacting with cloud computing resources on AnVIL. It acts as a bridge, allowing code to remain platform-agnostic while downstream packages like `AnVILGCP` or `AnVILAz` provide the specific implementations for Google or Azure. It is essential for managing workspaces, tables, workflows, and notebooks in a unified way.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("AnVILBase")
library(AnVILBase)
```

## Cloud Platform Identification

The package automatically detects the environment to determine if you are running on Google Cloud or Azure.

```r
# Check the current cloud platform
cloud_platform()

# Get the namespace of the active platform (e.g., "AnVILGCP" or "AnVILAz")
avplatform_namespace()
```

## Workspace Management

Workspaces are the primary containers for data and analysis on AnVIL.

- `avworkspace()`: Set or get the active workspace.
- `avworkspaces()`: List available workspaces.
- `avworkspace_name()`: Retrieve the name of the current workspace.
- `avworkspace_namespace()`: Retrieve the billing project/namespace.

## Table Operations

AnVIL uses tables to organize metadata and file references.

- `avtables()`: List all tables in the current workspace.
- `avtable("table_name")`: Retrieve a specific table as a data frame.
- `avtable_import(df)`: Upload a data frame as a table to the workspace.
- `avtable_import_set()`: Create a "set" table (e.g., grouping samples).
- `avtable_delete("table_name")`: Remove a table.
- `avtable_delete_values("table_name", values)`: Delete specific rows from a table.

## Cloud Storage and File Management

These functions handle data movement between the local environment and cloud buckets.

- `avlist()`: List files in the cloud storage associated with the workspace.
- `avcopy(source, destination)`: Copy files to or from the cloud.
- `avbackup(source)`: Backup local files to the cloud.
- `avrestore(source)`: Restore files from the cloud to the local session.
- `avstorage()`: Get the URI (e.g., `gs://` or `https://`) of the cloud storage bucket.

## Notebooks and Workflows

- `avnotebooks()`: List notebooks available in the workspace.
- `avnotebooks_localize()`: Download notebooks from the cloud to the local runtime.
- `avnotebooks_delocalize()`: Upload local notebooks back to the cloud.
- `avworkflow_jobs()`: Check the status of submitted workflow jobs.

## Usage Tips
- **Platform Agnostic**: Always prefer using `AnVILBase` generics over platform-specific functions to ensure your scripts work on both GCP and Azure environments.
- **Environment Variables**: `AnVILBase` relies on environment variables set by the AnVIL runtime. If `cloud_platform()` returns an unexpected result, verify your environment configuration.
- **API Responses**: The package includes internal helpers to process complex API responses into user-friendly R objects (like tibbles).

## Reference documentation
- [Introduction to AnVILBase](./references/AnVILBaseIntroduction.md)