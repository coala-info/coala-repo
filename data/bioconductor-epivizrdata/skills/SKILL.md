---
name: bioconductor-epivizrdata
description: This tool manages and serves genomic data from Bioconductor objects to the Epiviz interactive visualization application. Use when user asks to create data managers, register genomic datasets like GRanges or SummarizedExperiment, and prepare data for WebSocket-based visualization sessions.
homepage: https://bioconductor.org/packages/release/bioc/html/epivizrData.html
---


# bioconductor-epivizrdata

name: bioconductor-epivizrdata
description: Provides specialized knowledge for using the epivizrData R package to manage and serve genomic data from Bioconductor objects to the Epiviz interactive visualization application. Use this skill when you need to create data managers, register genomic datasets (GRanges, SummarizedExperiment, etc.), and prepare data for WebSocket-based visualization sessions.

## Overview

The `epivizrData` package serves as the data management layer for the Epiviz visualization ecosystem. It provides a standardized way to wrap Bioconductor objects into "measurements" that can be queried by the Epiviz JS application. It decouples data handling from the server logic, allowing users to register various data types (base-pair resolution, feature-based, or heatmaps) for interactive exploration.

## Core Workflow

### 1. Initialize the Data Manager
The `EpivizDataMgr` object is the central hub for managing datasets. It requires an `epivizrServer` object to handle the communication.

```r
library(epivizrData)
library(epivizrServer)

# Create a server (usually on a specific port)
server <- epivizrServer::createServer(port=7123L)

# Create the data manager
data_mgr <- epivizrData::createMgr(server)
```

### 2. Adding Measurements
Use the `add_measurements` method to register Bioconductor objects. The package automatically determines the appropriate wrapper based on the object class and the `type` argument.

```r
library(GenomicRanges)

# Example: Adding a GRanges object (Base-pair resolution)
gr <- GRanges("chr10", IRanges(start=1:1000, width=100), score=rnorm(1000))
data_mgr$add_measurements(gr, "my_gr_data", type="bp", columns="score")

# Example: Adding a SummarizedExperiment (Feature-based)
# data_mgr$add_measurements(se, "my_se_data", columns=c("sample1", "sample2"))
```

### 3. Supported Data Types
The `type` argument in `add_measurements` (or the `register` function) defines how the data is treated:
- `bp`: Base-pair resolution data (e.g., BigWig tracks, GRanges with scores).
- `feat`: Feature-based data (e.g., Gene expressions, SummarizedExperiment).
- `gene`: Specific gene-track visualizations.

## Key Functions and Methods

- `createMgr(server)`: Constructor for the `EpivizDataMgr` R6 object.
- `data_mgr$add_measurements(obj, ms_obj_name, ...)`: The primary method to add data.
- `data_mgr$list_measurements()`: Lists all currently registered datasets in the manager.
- `data_mgr$rm_measurement(ms_obj_name)`: Removes a specific dataset by name.
- `epivizrData::register(obj, ...)`: The underlying generic function used to wrap Bioconductor objects into Epiviz-compatible classes.

## Tips for Success
- **Column Selection**: Always specify the `columns` argument to indicate which metadata columns or assay rows should be treated as numeric measurements.
- **Server Dependency**: `epivizrData` is designed to work with `epivizrServer`. Ensure the server is initialized before the manager.
- **Object Compatibility**: While `GRanges` is the most common input, the package supports `SummarizedExperiment`, `ExpressionSet`, and `OrganismDb` objects.

## Reference documentation
- [epivizrData Usage](./references/epivizrData.Rmd)
- [epivizrData Usage](./references/epivizrData.md)