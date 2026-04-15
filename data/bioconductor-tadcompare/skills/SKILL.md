---
name: bioconductor-tadcompare
description: TADCompare identifies and classifies differential Topologically Associated Domain boundaries across pairwise, time-series, or multiple replicate Hi-C datasets. Use when user asks to identify differential TAD boundaries, perform time-course analysis of chromatin architecture, find consensus TADs across replicates, or visualize boundary changes between contact matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/TADCompare.html
---

# bioconductor-tadcompare

## Overview

TADCompare is an R package designed for the identification and classification of differential Topologically Associated Domain (TAD) boundaries. It supports various Hi-C data formats and provides specialized functions for pairwise comparisons, time-series analysis, and consensus TAD calling. It classifies boundary changes into categories such as Shifted, Merged, Split, and Strength Change.

## Core Workflows

### 1. Pairwise TAD Comparison
Use `TADCompare()` to find differences between two contact matrices.

```r
library(TADCompare)

# Load data (n x n matrices or sparse 3-column format)
data("rao_chr22_prim")
data("rao_chr22_rep")

# Run comparison (resolution is estimated if not provided)
results <- TADCompare(rao_chr22_prim, rao_chr22_rep, resolution = 50000)

# Access results
head(results$TAD_Frame)       # Boundaries and their classifications
head(results$Boundary_Scores) # Scores for all genomic regions
plot(results$Count_Plot)      # Summary of boundary types
```

### 2. Time-Course Analysis
Use `TimeCompare()` to track how TAD boundaries evolve across three or more time points.

```r
# time_mats is a list of contact matrices
data("time_mats")

# Identify temporal changes
time_results <- TimeCompare(time_mats, resolution = 50000)

# Categories include: Highly common, Dynamic, Early/Late Appearing/Disappearing
head(time_results$TAD_Bounds)
plot(time_results$Count_Plot)
```

### 3. Consensus TAD Calling
Use `ConsensusTADs()` to find stable TAD boundaries across multiple replicates or conditions, filtering out noise.

```r
# Get consensus boundaries across replicates
con_tads <- ConsensusTADs(time_mats, resolution = 50000)

# Access consensus scores
head(con_tads$Consensus)
```

### 4. Visualization
Use `DiffPlot()` to visualize boundary scores and contact matrices for specific genomic regions.

```r
p <- DiffPlot(tad_diff    = results, 
              cont_mat1   = rao_chr22_prim,
              cont_mat2   = rao_chr22_rep,
              resolution  = 50000,
              start_coord = 18000000,
              end_coord   = 22000000,
              show_types  = TRUE)
plot(p)
```

## Data Input Formats
TADCompare is flexible with input formats:
- **n x n**: Square symmetric matrices (Fastest).
- **n x (n+3)**: TopDom format (chr, start, end columns followed by matrix).
- **Sparse 3-column**: region1, region2, IF (Interaction Frequency).
- **External files**: Supports `.hic` (via `straw`), `.cool` (via `HiCcompare`), and HiC-Pro outputs.

## Downstream Analysis: GO Enrichment
Boundary coordinates can be converted to BED format for enrichment analysis using `rGREAT`.

```r
library(rGREAT)
# Convert TAD_Frame to BED
bed_data <- results$TAD_Frame %>% 
  dplyr::filter(Type == "Shifted") %>%
  dplyr::mutate(chr = "chr22", start = Boundary, end = Boundary) %>%
  dplyr::select(chr, start, end)

# Run GREAT
job <- submitGreatJob(bed_data, species = "hg19")
tbl <- getEnrichmentTables(job)
```

## Tips and Best Practices
- **Resolution**: Always specify the `resolution` parameter explicitly to ensure accuracy.
- **Normalization**: While `TADCompare` handles raw data, global scaling (normalization) is recommended before using `DiffPlot` for better visual comparison.
- **Pre-specified TADs**: If you have TADs from another caller (e.g., SpectralTAD), pass them to the `pre_tads` argument in `TADCompare()` to test only those specific boundaries.
- **Performance**: $n \times n$ matrices are processed significantly faster than sparse formats.

## Reference documentation
- [Input data formats](./references/Input_Data.md)
- [Gene Ontology Enrichment Analysis](./references/Ontology_Analysis.md)
- [TAD comparison between two conditions](./references/TADCompare.md)