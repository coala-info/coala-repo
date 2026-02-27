---
name: bioconductor-rlhub
description: This tool provides access to curated, processed R-loop genomic datasets and annotations through the RLHub Bioconductor package. Use when user asks to retrieve R-loop consensus regions, genomic features, R-loop-binding proteins, or RLBase sample manifests for R-loop analysis.
homepage: https://bioconductor.org/packages/3.14/data/experiment/html/RLHub.html
---


# bioconductor-rlhub

name: bioconductor-rlhub
description: Access and utilize processed R-loop data sets from the RLHub Bioconductor package. Use this skill when you need to retrieve R-loop consensus regions, genomic features (RLFS, G-or-C skew), R-loop-binding proteins (RLBPs), or RLBase sample manifests for R-loop analysis and the RLSuite toolchain.

## Overview

RLHub is an `ExperimentHub` data package that serves as the central data provider for the RLSuite toolchain. It contains curated, processed genomic data related to R-loops, including annotations for human (hg38) and mouse (mm10) genomes. The package allows for easy retrieval of high-quality R-loop datasets without needing to process raw sequencing data manually.

## Installation

Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("RLHub")
library(RLHub)
```

## Accessing Data

There are two primary ways to access data in RLHub: using built-in accessor functions or via the `ExperimentHub` interface.

### 1. Built-in Accessor Functions (Recommended)

RLHub provides direct functions for specific datasets. These are the most convenient way to load data.

*   **R-loop Binding Proteins:** `rlbps()`
*   **RLBase Sample Manifest:** `rlbase_samples()`
*   **Genomic Annotations (hg38):** `annots_primary_hg38()` or `annots_full_hg38()`
*   **Genomic Annotations (mm10):** `annots_primary_mm10()` or `annots_full_mm10()`
*   **RLFS-Test Results:** `rlfs_res()`
*   **RLRegion Metadata:** `rlregion_meta()`

Example:
```r
# Load R-loop binding proteins
proteins <- RLHub::rlbps()

# View the first few rows
head(proteins)
```

### 2. ExperimentHub Interface

You can query the `ExperimentHub` database to find and download RLHub resources by their unique IDs (e.g., EH6797).

```r
library(ExperimentHub)
eh <- ExperimentHub()
rlhub_resources <- query(eh, "RLHub")

# Retrieve a specific resource by ID
rlbps <- rlhub_resources[["EH6797"]]
```

## Typical Workflow

1.  **Explore Available Data:** Use `read.csv(system.file("extdata", "metadata.csv", package = "RLHub"))` to see the full list of available datasets and their associated "Tags" (which correspond to function names).
2.  **Load Reference Data:** Download R-loop forming sequences (RLFS) or consensus regions for your organism of interest.
3.  **Integrate with RLSuite:** Use the retrieved data as input for downstream analysis in other RLSuite packages (like `RLSeq`).
4.  **Bulk Loading:** To load all available RLHub resources at once into a list:
    ```r
    rlhub_resources <- query(ExperimentHub(), "RLHub")
    all_data <- loadResources(rlhub_resources, package = "RLHub")
    ```

## Tips

*   **Documentation:** Use `?`RLHub-package`` to see a complete list of all available data accessors.
*   **Caching:** `ExperimentHub` caches data locally after the first download, making subsequent calls much faster.
*   **Metadata:** Always check the `rlbase_samples()` manifest if you are looking for specific experimental conditions or cell types within the RLBase ecosystem.

## Reference documentation

- [Accessing RLHub Data](./references/RLHub.Rmd)
- [Accessing RLHub Data (Markdown)](./references/RLHub.md)