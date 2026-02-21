---
name: bioconductor-anvilaz
description: The package provides a programmatic interface to AnVIL resources, including workspaces, notebooks, tables, and workflows. The package also provides utilities for managing resources, including copying files to and from Azure Blob Storage, and creating shared access signatures (SAS) for secure access to Azure resources.
homepage: https://bioconductor.org/packages/release/bioc/html/AnVILAz.html
---

# bioconductor-anvilaz

name: bioconductor-anvilaz
description: Programmatic interface for managing AnVIL resources on Microsoft Azure. Use this skill when working in an R environment to manage Azure-based workspaces, interact with Azure Blob Storage (ABS), manipulate data tables in the AnVIL UI, and monitor workflow jobs.

# bioconductor-anvilaz

## Overview
The `AnVILAz` package provides an R interface for the Analysis Visualization and Informatics Lab-space (AnVIL) running on Microsoft Azure. It allows users to manage workspaces, transfer files between local environments and Azure Blob Storage (ABS), interact with the AnVIL "DATA" tab tables, and track workflow execution.

## Workspace Management
Workspaces are the primary organizational unit in AnVIL Azure.

- **List workspaces**: `avworkspaces()`
- **Get/Set current workspace**: 
  - View current: `avworkspace()`
  - Set current: `avworkspace("namespace/name")`
- **Get components**: `avworkspace_namespace()` and `avworkspace_name()`
- **Clone workspace**: 
  ```r
  avworkspace_clone(namespace, name, to_namespace, to_name)
  ```
Note: This package is specifically for Azure-based workspaces. For GCP-based workspaces, use `AnVILGCP`.

## File Management (Azure Blob Storage)
AnVIL Azure uses Azure Blob Storage (ABS) for file persistence.

- **List files**: `avlist()`
- **Copy files**: `avcopy(source, destination)`
  - Upload: `avcopy("local_file.Rda", "analyses/")`
  - Download: `avcopy("analyses/remote_file.log", "./local_dir/")`
- **Bulk Transfer**:
  - Upload folder: `avbackup("./local_folder/", "remote_destination/")`
  - Download folder: `avrestore("remote_folder/", "local_destination")`
- **Remove files**: `avremove("path/to/remote_file")`

## Notebooks
Notebooks are typically stored in the `analyses/` folder of the ABS container.

- **List notebooks**: `avnotebooks()`
- **Localize (Download all)**: `avnotebooks_localize(destination = "./analyses")`
- **Delocalize (Upload all)**: `avnotebooks_delocalize(source = "./")`

## Data Table Operations
Interact with the "DATA" tab in the AnVIL UI using tibbles.

- **Import Table**: 
  ```r
  avtable_import(my_tibble, table = "tableName", primaryKey = "column_name")
  ```
- **Download Table**: `my_data <- avtable("tableName")`
- **Delete Rows**: `avtable_delete_values(table = "tableName", values = c("id1", "id2"))`
- **Delete Table**: `avtable_delete("tableName")`

## Workflows
Monitor the status of computational pipelines.

- **Job Status**: `avworkflows_jobs()` returns a tibble of recent runs and their states.
- **Workflow Inputs**: `avworkflows_jobs_inputs()` retrieves the input parameters for jobs in the current workspace.

## Reference documentation
- [Working with workspaces on AnVIL Azure](./references/AnVILAzWorkspaces.md)
- [Introduction to the AnVILAz package](./references/IntroductionToAnVILAz.md)