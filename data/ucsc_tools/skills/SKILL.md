---
name: ucsc_tools
description: The ucsc_tools skill provides a structured workflow for interacting with UCSC Xena data hubs to search, filter, query, download, and prepare omics datasets. Use when user asks to generate a XenaHub object, filter datasets, query metadata, download data, prepare data for analysis, update Xena data hubs, or explore Xena metadata.
homepage: https://github.com/ropensci/UCSCXenaTools
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bedrestricttopositions:482--h0b57e2e_0"
---

# ucsc_tools

## Overview
The `ucsc_tools` skill provides a structured workflow for interacting with the UCSC Xena data hubs. It transforms the complex process of searching through thousands of public omics datasets into a five-step pipeline: generate, filter, query, download, and prepare. This skill is essential for bioinformaticians and clinical researchers who need to integrate multi-omics data—ranging from single-cell RNA-seq to pan-cancer atlases—directly into their R-based analytical environments.

## Core Workflow Patterns

The package follows a functional programming approach, typically linked using the pipe operator (`%>%`).

### 1. Data Discovery and Generation
Start by identifying the target data hub. Use `XenaGenerate()` to create a `XenaHub` object based on the internal `XenaData` reference.

```r
library(UCSCXenaTools)
data(XenaData) # Load the metadata data frame

# Initialize for a specific hub
df_todo <- XenaGenerate(subset = XenaHostNames == "tcgaHub")
```

### 2. Filtering Datasets
Use `XenaFilter()` to narrow down the selection. This function supports Regular Expressions, making it powerful for selecting specific cancer types or data formats.

```r
# Filter for clinical data across specific lung cancer cohorts
df_todo <- df_todo %>% 
  XenaFilter(filterDatasets = "clinical") %>% 
  XenaFilter(filterDatasets = "LUAD|LUSC|LUNG")
```

### 3. Querying and Downloading
Once the selection is defined, check the URL status and execute the download.

```r
# Query the metadata and download the files
xe_download <- XenaQuery(df_todo) %>% 
  XenaDownload(destdir = "path/to/data")
```

### 4. Data Preparation
The final step converts the downloaded files (often in `.tsv.gz` or similar formats) into R-friendly objects like lists or data frames.

```r
# Load the data into R
data_list <- XenaPrepare(xe_download)
```

## Expert Tips and Best Practices

*   **Regex Filtering**: Always use regex in `XenaFilter` to avoid multiple manual filtering steps. For example, `filterDatasets = "RNA-Seq|Mutation"` captures both transcriptomic and genomic variants in one call.
*   **Metadata Exploration**: Before starting a workflow, inspect `XenaData` manually (e.g., `View(XenaData)`) to understand the `XenaCohorts` and `DataSubtype` naming conventions.
*   **Updating Hubs**: If you suspect the local dataset list is out of date, run `XenaDataUpdate()` to fetch the latest metadata from the UCSC Xena servers.
*   **Handling Large Downloads**: For large-scale downloads (like Pan-Cancer Atlas files), ensure `destdir` is set to a location with sufficient disk space, as the default is often a temporary directory.
*   **Single-Cell Data**: Use the specific Single-Cell Hub URL (`https://previewsinglecell.xenahubs.net/`) when targeting scRNA-seq datasets.

## Reference documentation
- [UCSCXenaTools Main Documentation](./references/github_com_ropensci_UCSCXenaTools.md)