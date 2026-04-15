---
name: bioconductor-flowworkspacedata
description: This package provides experimental flow cytometry data and XML workspaces for testing and demonstrating analysis workflows. Use when user asks to access sample FCS files, load FlowJo or Diva workspaces for testing, or run vignettes for flow cytometry analysis packages.
homepage: https://bioconductor.org/packages/release/data/experiment/html/flowWorkspaceData.html
---

# bioconductor-flowworkspacedata

name: bioconductor-flowworkspacedata
description: Access and manage experimental flow cytometry data, including FlowJo and Diva XML workspaces and FCS files. Use this skill when you need to load sample datasets for testing or demonstrating workflows in flowWorkspace, openCyto, or CytoML packages.

# bioconductor-flowworkspacedata

## Overview

The `flowWorkspaceData` package is a dedicated data experiment package for the Bioconductor ecosystem. It provides the necessary external data (FCS files and XML workspaces) required to run vignettes and tests for flow cytometry analysis packages like `flowWorkspace`, `openCyto`, and `CytoML`. It contains data from whole blood samples and pre-constructed `GatingSet` objects.

## Loading Data and Locating Files

The primary utility of this package is providing file paths to raw data and workspaces stored within the package installation directory.

### Accessing Package Information
To see a summary of the available data and package metadata:
```r
library(flowWorkspaceData)
flowWorkspaceDataInfo()
```

### Locating External Data Files
Use `system.file` to retrieve the absolute paths to the XML workspaces and FCS files required by other analysis packages.

```r
# List all files in the external data directory
dataDir <- system.file("extdata", package = "flowWorkspaceData")
list.files(dataDir)

# Path to a specific FlowJo workspace
wsfile <- system.file("extdata", "manual.xml", package = "flowWorkspaceData")

# Path to FCS files
fcsfiles <- list.files(dataDir, pattern = ".fcs", full.names = TRUE)
```

## Typical Workflows

### Using with flowWorkspace
The data in this package is frequently used to demonstrate how to import a FlowJo workspace into R.

```r
library(flowWorkspace)
flowDir <- system.file("extdata", package = "flowWorkspaceData")
wsfile <- list.files(flowDir, pattern = "manual.xml", full.names = TRUE)

# Open the workspace
ws <- openWorkspace(wsfile)

# Parse the workspace into a GatingSet (requires flowWorkspace)
# gs <- parseWorkspace(ws, name = 1, path = flowDir)
```

### Using with openCyto
The package provides data for automated gating pipelines.

```r
library(openCyto)
# Accessing the csv template for gating strategies
gtFile <- system.file("extdata", "gating_template.csv", package = "flowWorkspaceData")
```

## Tips
- **Lazy Loading**: The package uses lazy loading, but most interactions involve querying the `inst/extdata` directory via `system.file`.
- **Testing**: This package is essential for unit testing any custom functions developed for `GatingSet` or `GatingHierarchy` objects without needing to provide your own large FCS files.
- **Data Source**: The samples are derived from whole blood, which is useful for testing standard lymphocyte gating strategies.

## Reference documentation

- [flowWorkspaceData Reference Manual](./references/reference_manual.md)