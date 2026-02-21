---
name: bioconductor-experimenthub
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ExperimentHub.html
---

# bioconductor-experimenthub

name: bioconductor-experimenthub
description: Access and manage large-scale experiment data from the Bioconductor ExperimentHub web service. Use this skill when you need to search for, download, and cache curated datasets (e.g., single-cell RNA-seq, microarray, proteomics) provided by Bioconductor packages.

## Overview

`ExperimentHub` is a client interface for retrieving large biological datasets stored in the Bioconductor cloud. It functions similarly to `AnnotationHub` but focuses on experimental data rather than annotation resources. Data is downloaded once, cached locally, and returned as standard R/Bioconductor objects (e.g., `SummarizedExperiment`, `GRanges`, `ExpressionSet`).

## Core Workflow

### 1. Initialization
Create an `ExperimentHub` object to connect to the service.
```r
library(ExperimentHub)
eh <- ExperimentHub()
```

### 2. Searching for Data
You can explore the hub using metadata columns or the `query()` function.
*   **Explore Metadata**: Use `$` to access columns like `dataprovider`, `species`, or `rdataclass`.
    ```r
    unique(eh$species)
    unique(eh$rdataclass)
    ```
*   **Search**: Use `query()` with keywords (package names, species, or data types).
    ```r
    # Search for alpineData package resources
    res <- query(eh, "alpineData")
    
    # Search for mouse data
    mm_data <- query(eh, "Mus musculus")
    ```

### 3. Inspecting and Retrieving
*   **View Metadata**: Select a specific record by its ID (e.g., "EH166") to see detailed info.
    ```r
    res["EH166"]
    ```
*   **Download/Load**: Use the double bracket `[[` operator to download the data into your R session.
    ```r
    data_obj <- res[["EH166"]]
    ```

## Configuration and Caching

### Managing the Cache
ExperimentHub stores files locally to avoid repeated downloads.
*   **Check Cache Location**: `hubCache(eh)`
*   **Change Cache**: Set the `EXPERIMENT_HUB_CACHE` environment variable or use `setExperimentHubOption("CACHE", "/path/to/dir")`.
*   **Proxy Settings**: If behind a firewall, set the proxy:
    ```r
    setExperimentHubOption("PROXY", "http://user:pass@proxy:8080")
    ```

### Snapshot Dates
To ensure reproducibility, you can lock the hub to a specific version of the database.
```r
dates <- possibleDates(eh)
snapshotDate(eh) <- dates[1] # Set to a specific historical date
```

## Troubleshooting
*   **Package Dependencies**: If a resource requires a specific package to be loaded (e.g., `GenomicAlignments`), `ExperimentHub` will usually prompt you or try to load it. Ensure the "preparer package" listed in the metadata is installed.
*   **Locked Cache**: If you encounter permissions errors in shared environments, ensure the `BiocFileCache.sqlite.LOCK` file has `g+rw` permissions.

## Reference documentation
- [ExperimentHub: Access the ExperimentHub Web Service](./references/ExperimentHub.md)