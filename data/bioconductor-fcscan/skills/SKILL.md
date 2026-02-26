---
name: bioconductor-fcscan
description: This tool detects clusters of genomic features such as transcription factor binding sites or mutations within defined window sizes. Use when user asks to scan BED or VCF files for specific combinations of genomic sites, identify clusters based on feature order or orientation, or find genomic regions enriched with specific site counts.
homepage: https://bioconductor.org/packages/release/bioc/html/fcScan.html
---


# bioconductor-fcscan

name: bioconductor-fcscan
description: Detects clusters of genomic features (TFs, mutations, etc.) using the fcScan R package. Use when you need to scan BED/VCF files, DataFrames, or GRanges for specific combinations, orders, or orientations of genomic sites within a defined window size.

# bioconductor-fcscan

## Overview

The `fcScan` package is designed to identify clusters of genomic features based on user-defined criteria. It is particularly useful for finding regions enriched with combinations of transcription factor binding sites (TFBS) or mutational hotspots. The core functionality is centered around the `getCluster` function, which scans genomic data to find clusters that satisfy specific conditions regarding feature count, order, distance, and orientation.

## Core Workflow

### 1. Prepare Input Data
The package accepts three main input types for the `x` argument:
- **Files**: A vector of paths to BED or VCF files.
- **DataFrame**: A data frame with columns: `seqnames`, `start`, `end`, `strand`, and `site`. (Note: DataFrames are treated as 0-based/BED format).
- **GRanges**: A `GRanges` object with a metadata column named `site`.

### 2. Define Search Criteria
- **Window Size (`w`)**: The maximum allowed size of the cluster.
- **Condition (`c`)**: A named vector defining the required number of each site. Use `0` to explicitly exclude clusters containing a specific site.
  - Example: `c = c("sox2" = 1, "oct4" = 1, "nanog" = 0)`
- **Strand (`s`)**: Use `"+"` or `"-"` for strand-specific searches, or `"*"` (default) for non-strand specific.

### 3. Execute Cluster Scan
Use `getCluster()` to perform the search.

```r
library(fcScan)

# Example with a DataFrame
df <- data.frame(
  seqnames = "chr1",
  start = c(100, 120, 150),
  end = c(110, 130, 160),
  strand = "+",
  site = c("A", "B", "A")
)

clusters <- getCluster(x = df, w = 50, c = c("A" = 1, "B" = 1))
```

## Advanced Parameters

- **Greedy Mode (`greedy`)**: If `TRUE`, allows more sites than specified in `c` as long as they fit in the window. If `FALSE` (default), looks for the exact count.
- **Order (`order`)**: A character vector specifying the required sequence of sites (e.g., `order = c("A", "B")`).
- **Orientation (`site_orientation`)**: Specifies the required strand for each site in the `order` argument (e.g., `c("+", "-")`).
- **Site Distance (`site_overlap`)**: 
  - Positive integer: Minimum distance required between sites.
  - Negative integer: Maximum overlap allowed between sites.
- **Clustering Logic (`cluster_by`)**: Defines how the window is measured. Options: `startsEnds` (default), `endsStarts`, `starts`, `ends`, or `middles`.
- **Performance (`threads`)**: Set `threads = 0` to automatically use all available cores for large datasets.

## Interpreting Results

The output is a `GRanges` object representing the identified clusters. Key metadata columns include:
- `sites`: The specific combination of sites found.
- `isCluster`: Logical; `TRUE` if all conditions (order, orientation, etc.) were met.
- `status`: Provides details on why a cluster failed (e.g., `PASS`, `orderFail`, `excludedSites`, `siteOrientation`, `siteOverlap`).

To see failed clusters for debugging, set `verbose = TRUE` in the `getCluster` call.

## Reference documentation

- [fcScan: features cluster Scan](./references/fcScan_vignette.md)