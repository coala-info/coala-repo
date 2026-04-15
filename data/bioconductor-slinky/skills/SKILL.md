---
name: bioconductor-slinky
description: The slinky package provides a streamlined interface for analyzing LINCS L1000 transcriptional data by integrating local expression files with the clue.io API. Use when user asks to query the clue.io API, load GCTX expression data into SummarizedExperiment objects, or perform differential expression analysis using the characteristic direction method on L1000 datasets.
homepage: https://bioconductor.org/packages/3.8/bioc/html/slinky.html
---

# bioconductor-slinky

name: bioconductor-slinky
description: Expert guidance for the Bioconductor R package 'slinky' to analyze LINCS L1000 transcriptional data. Use this skill when you need to query the clue.io API, filter metadata, load GCTX expression data, identify same-plate controls, or perform differential expression analysis (characteristic direction) on L1000 datasets.

# bioconductor-slinky

## Overview
The `slinky` package provides a streamlined interface for working with the Library of Integrated Network-Based Cellular Signatures (LINCS) L1000 dataset. It simplifies the complex task of integrating three disparate resources: large HDF5-based expression files (.gctx), tab-delimited metadata (.info), and the clue.io web API. It is designed to handle the 1.3 million+ instances of the L1000 dataset efficiently by using disk-backed access via `rhdf5`, allowing for sophisticated queries and differential expression analysis without requiring massive RAM.

## Core Workflow

### 1. Initialization
To use `slinky`, you need a clue.io API key and paths to the L1000 data files.

```r
library(slinky)
# Define paths and key
key <- "YOUR_API_KEY" 
gctx <- "path/to/data.gctx"
info <- "path/to/metadata.txt"

# Initialize the Slinky object
sl <- Slinky(key, gctx, info)
```

### 2. Data Selection and Querying
You can identify instances (samples) using local metadata or the clue.io API.

*   **Local Metadata:** Access the `metadata(sl)` slot. Subsetting the `Slinky` object is faster than subsetting the loaded data.
    ```r
    col.ix <- which(metadata(sl)$pert_iname == "amoxicillin" & metadata(sl)$cell_id == "MCF7")
    sl_subset <- sl[, col.ix]
    ```
*   **API Querying:** Use `clueInstances` for complex filters (e.g., "gold" status).
    ```r
    # Find gold-standard amoxicillin instances
    ids <- clueInstances(sl, where_clause = list(pert_type = "trt_cp", 
                                                 pert_iname = "amoxicillin", 
                                                 is_gold = TRUE))
    ```

### 3. Loading Data
Convert selected instances into standard Bioconductor objects.

*   **SummarizedExperiment:** The preferred way to load data with annotations.
    ```r
    # Load specific IDs with controls automatically identified
    se <- loadL1K(sl, ids = ids, controls = TRUE)
    
    # Load only landmark genes (first 978 rows)
    se_landmark <- loadL1K(sl, ids = ids, inferred = FALSE)
    ```

### 4. Differential Expression (Characteristic Direction)
The `diffexp` function automates the identification of same-plate controls and calculates the "characteristic direction" vector.

```r
# Calculate differential expression for a perturbagen
cd_vector <- diffexp(sl, treat = "amoxicillin", split_by_plate = FALSE)

# Analysis split by plate (returns a matrix)
cd_matrix <- diffexp(sl, treat = "E2F3", 
                     where_clause = list(pert_type = "trt_sh", cell_id = "MCF7"), 
                     split_by_plate = TRUE)
```

## Key Functions
- `Slinky()`: Constructor for the Slinky object.
- `loadL1K()`: High-level function to fetch data and metadata into a `SummarizedExperiment`.
- `clueInstances()`: Query the clue.io API for specific instance IDs.
- `clueVehicle()` / `controls()`: Identify appropriate control instances (e.g., DMSO) for treated samples.
- `readGCTX()`: Low-level reading of the GCTX HDF5 file.
- `diffexp()`: Performs differential expression using the characteristic direction method.
- `download()`: Utility to fetch L1000 expression or info files.

## Tips and Best Practices
- **Memory Efficiency:** Always subset the `Slinky` object (e.g., `sl[rows, cols]`) before calling `readGCTX` or `as(sl, "SummarizedExperiment")` to avoid loading the entire dataset into RAM.
- **Landmark Genes:** The first 978 rows of a standard LINCS GCTX file are the measured "landmark" genes; the rest are computationally inferred.
- **Batch Effects:** L1000 data is highly susceptible to plate-based batch effects. Always use same-plate controls (via `controls = TRUE` in `loadL1K` or using `diffexp`) when possible.
- **API Syntax:** When querying via `where_clause`, use Loopback framework syntax (e.g., `list(pert_iname = list(inq = c("drugA", "drugB")))` for "IN" queries).

## Reference documentation
- [LINCS analysis with slinky](./references/LINCS-analysis.md)