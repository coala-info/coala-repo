---
name: bioconductor-seq.hotspot
description: This tool optimizes targeted sequencing panels by identifying genomic hotspots and selecting the minimal set of amplicons to capture the maximum number of mutations. Use when user asks to identify mutation hotspots, generate candidate amplicon pools, or design efficient sequencing panels using greedy or exhaustive selection algorithms.
homepage: https://bioconductor.org/packages/release/bioc/html/seq.hotSPOT.html
---

# bioconductor-seq.hotspot

## Overview

The `seq.hotSPOT` package is designed to optimize the creation of targeted sequencing panels, particularly for ultradeep sequencing of healthy or diseased tissues. It identifies genomic "hotspots"—areas with high mutation density—and determines the minimal set of amplicons required to capture the maximum number of mutations. This is highly effective for reducing the cost of sequencing compared to whole-exome or whole-genome approaches.

## Workflow and Core Functions

### 1. Data Preparation
Input data must be a data frame containing at least two columns:
- `chr`: Chromosome (e.g., 4, 17, "X")
- `pos`: Genomic position of the mutation
- `gene` (Optional): Gene name associated with the mutation

```r
library(seq.hotSPOT)
data("mutation_data")
head(mutation_data)
```

### 2. Generating the Amplicon Pool
The `amp_pool` function identifies hotspot regions and generates a candidate list of amplicons. It uses a "rank and recovery" system to group mutations within a specified amplicon length.

```r
# amp: length of the amplicon in base pairs (e.g., 100bp)
amps <- amp_pool(data = mutation_data, amp = 100)
```

### 3. Forward Selection (Fast Optimization)
The `fw_hotspot` function uses a greedy algorithm to build a panel. It iteratively selects the amplicon that captures the highest number of *new* (uncovered) mutations until the desired panel length is reached or all mutations are covered.

```r
# len: desired cumulative length of the sequencing panel in bp
fw_bins <- fw_hotspot(bins = amps, 
                      data = mutation_data, 
                      amp = 100, 
                      len = 1000, 
                      include_genes = TRUE)
```

### 4. Comprehensive Selection (Exhaustive Optimization)
The `com_hotspot` function performs a more rigorous search for the optimal combination of amplicons. It breaks large hotspot regions into smaller bins and evaluates combinations to maximize mutation capture.

```r
# size: maximum number of amplicons to evaluate in exhaustive combinations per bin
com_bins <- com_hotspot(fw_panel = fw_bins, 
                        bins = amps, 
                        data = mutation_data, 
                        amp = 100, 
                        len = 1000, 
                        size = 3, 
                        include_genes = TRUE)
```

## Tips for Effective Use

- **Computational Efficiency**: For very large datasets, start with `fw_hotspot`. Use `com_hotspot` only if you need to squeeze more efficiency out of the panel, and keep the `size` parameter low (e.g., 3) to prevent long runtimes.
- **Integration**: Combine this package with `RTCGA.mutations` to pull real-world cancer mutation data from the TCGA database as input.
- **Panel Constraints**: The `len` parameter is critical; it represents your "budget" in base pairs. The output will rank amplicons by their contribution, allowing you to see the point of diminishing returns in mutation capture.
- **Interpreting Results**: The output data frames include `Cumulative Panel Length` and `Cumulative Mutations`, which are essential for plotting "capture curves" to justify panel size.

## Reference documentation

- [hotSPOT-vignette](./references/hotSPOT-vignette.md)