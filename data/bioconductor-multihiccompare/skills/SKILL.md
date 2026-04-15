---
name: bioconductor-multihiccompare
description: This tool performs joint normalization and differential chromatin interaction detection for multiple Hi-C datasets using a general linear model framework. Use when user asks to normalize Hi-C contact matrices, detect differentially interacting regions across replicates, or perform comparative analysis of chromatin architecture between experimental conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/multiHiCcompare.html
---

# bioconductor-multihiccompare

name: bioconductor-multihiccompare
description: Joint normalization and differential chromatin interaction detection for multiple Hi-C datasets using multiHiCcompare. Use when comparing Hi-C contact matrices across multiple replicates or experimental conditions to identify significant differentially interacting regions (DIRs).

# bioconductor-multihiccompare

## Overview
`multiHiCcompare` is a Bioconductor package for the comparative analysis of multiple Hi-C datasets. It extends the `HiCcompare` framework by providing joint normalization (Cyclic Loess or Fast Loess) and a General Linear Model (GLM) framework based on `edgeR` to detect significant differences in chromatin interactions. It operates on processed Hi-C data in sparse upper triangular matrix format.

## Core Workflow

### 1. Data Preparation
Data must be in a sparse format: `chr`, `region1`, `region2`, `IF` (Interaction Frequency).

```r
library(multiHiCcompare)

# Load example data
data("HCT116_r1", "HCT116_r2", "HCT116_r3", "HCT116_r4")

# Create the hicexp object
# groups: 0 for control, 1 for treatment
# filter: removes low IF and high zero-proportion interactions
hicexp <- make_hicexp(HCT116_r1, HCT116_r2, HCT116_r3, HCT116_r4, 
                       groups = c(0, 0, 1, 1), 
                       zero.p = 0.8, A.min = 5, filter = TRUE)
```

### 2. Joint Normalization
Choose between Cyclic Loess (more accurate) or Fast Loess (faster).

```r
# Cyclic Loess
hicexp <- cyclic_loess(hicexp, parallel = TRUE, span = 0.2)

# OR Fast Loess (Fastlo)
hicexp <- fastlo(hicexp, parallel = TRUE)

# Visualize normalization with MD plots
MD_hicexp(hicexp)
```

### 3. Differential Testing
Use `hic_exactTest` for simple two-group comparisons or `hic_glm` for complex designs.

```r
# Simple Exact Test
hicexp <- hic_exactTest(hicexp, p.method = 'fdr')

# GLM with covariates (e.g., batch effects)
batch <- c(1, 2, 1, 2)
design <- model.matrix(~factor(meta(hicexp)$group) + factor(batch))
hicexp <- hic_glm(hicexp, design = design, coef = 2, method = "QLFTest")
```

### 4. Results and Visualization
Extract significant Differentially Interacting Regions (DIRs).

```r
# Get top DIRs as BEDPE
results_table <- results(hicexp)
top_dirs <- topDirs(hicexp, logfc_cutoff = 1, p.adj_cutoff = 0.05, return_df = 'pairedbed')

# Visualization
MD_composite(hicexp) # Highlight DIRs on MD plot
manhattan_hicexp(hicexp) # Identify hotspot regions
```

## Key Functions
- `make_hicexp()`: Constructor for the Hi-C experiment object.
- `cyclic_loess()` / `fastlo()`: Joint normalization methods.
- `hic_exactTest()`: Pairwise differential comparison.
- `hic_glm()`: Complex differential comparison using GLMs.
- `topDirs()`: Filter and format results for downstream analysis.
- `exportJuicebox()`: Export DIRs for visualization in Juicebox.

## Tips
- **Parallelization**: Set `parallel = TRUE` in normalization and testing functions to significantly speed up processing on multi-core systems.
- **Filtering**: Use `zero.p` and `A.min` in `make_hicexp` to remove noise. High-resolution matrices (e.g., < 50kb) are often too sparse for effective loess normalization.
- **Input Formats**: Use `HiCcompare::hicpro2bedpe` for HiC-Pro data or `HiCcompare::cooler2sparse` for `.cool` files.

## Reference documentation
- [multiHiCcompare Vignette](./references/multiHiCcompare.md)
- [Visualizing multiHiCcompare results in Juicebox](./references/juiceboxVisualization.md)