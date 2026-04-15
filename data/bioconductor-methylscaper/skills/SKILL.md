---
name: bioconductor-methylscaper
description: The methylscaper package provides tools for the joint visualization and seriation of endogenous methylation and chromatin accessibility data from single-cell or single-molecule sources. Use when user asks to visualize methylation and accessibility patterns, preprocess scNMT-seq or MAPit data, align fasta reads to a reference, or order genomic matrices using PCA to reveal nucleosome positioning.
homepage: https://bioconductor.org/packages/release/bioc/html/methylscaper.html
---

# bioconductor-methylscaper

## Overview
The `methylscaper` package provides tools for the joint visualization of endogenous methylation (HCG) and chromatin accessibility (GCH). It supports both single-cell (e.g., scNMT-seq) and single-molecule (e.g., MAPit) data. The core workflow involves preprocessing raw data into methylation-state matrices, ordering these matrices using seriation methods (like PCA) to reveal patterns, and generating sequence plots where rows represent individual cells/molecules and columns represent genomic positions.

## Core Workflow

### 1. Data Preprocessing

#### Single-Cell Data
Single-cell data typically comes from Bismark-style extractors. You need two files per cell: one for GCH (accessibility) and one for HCG (methylation).
- **Function**: `subsetSC`
- **Input**: A directory containing "acc" and "met" subfolders.
- **Example**:
```r
# Filter data to a specific chromosome and region
singlecell_subset <- subsetSC(filepath = "path/to/data", 
                             chromosome = 19, 
                             startPos = 8937041, 
                             endPos = 8997041)
```

#### Single-Molecule Data
Single-molecule data requires aligning fasta reads to a reference sequence.
- **Function**: `runAlign`
- **Example**:
```r
fasta <- seqinr::read.fasta("reads.fasta")
ref <- seqinr::read.fasta("reference.fa")[[1]]
sm_data <- runAlign(fasta = fasta, ref = ref)
```

### 2. Preparing for Visualization
Once data is subset or aligned, use `prepSC` to generate the state matrices for a specific genomic window.
```r
# Define the specific window of interest
prep.out <- prepSC(singlecell_subset, startPos = 8966841, endPos = 8967541)
```

### 3. Ordering (Seriation)
Ordering is critical to discover patterns like nucleosome positioning. PCA is the recommended method for efficiency.
- **Function**: `initialOrder`
- **Weighting**: You can weight specific genomic regions to drive the global ordering.
```r
# Initial PCA ordering
orderObj <- initialOrder(prep.out, Method = "PCA")

# Weighted ordering on a specific feature (e.g., accessibility 'acc')
orderObj_weighted <- initialOrder(prep.out, 
                                 weightStart = 50, 
                                 weightEnd = 150, 
                                 weightFeature = "acc")
```

### 4. Visualization
The `plotSequence` function generates the dual-panel plot (HCG on left, GCH on right).
- **Colors**: 
  - **HCG**: Red (Methylated), Black (Unmethylated).
  - **GCH**: Yellow (Accessible/Methylated), Black (Inaccessible/Unmethylated).
  - **Both**: Gray (Inconsistent), White (Missing).
```r
plotSequence(orderObj, Title = "Gene Visualization", plotFast = TRUE)
```

### 5. Refinement
You can locally reorder a subset of rows (cells/molecules) without changing the rest of the plot.
```r
# Refine the first 20 rows
orderObj$order1 <- refineFunction(orderObj, refineStart = 1, refineEnd = 20)
plotSequence(orderObj)
```

## Summary Statistics and Plots
`methylscaper` provides functions to quantify methylation levels across the selected region:
- `methyl_proportion`: Histogram of methylation proportions per cell/molecule.
- `methyl_percent_sites`: Percentage of methylated sites across all samples.
- `methyl_average_status`: Rolling average of methylation status across a window.

```r
# Example summary plots
par(mfrow = c(1, 2))
methyl_proportion(orderObj, type = "met", makePlot = TRUE)
methyl_percent_sites(orderObj, makePlot = TRUE)
```

## Tips and Best Practices
- **Gene Coordinates**: Use `biomaRt` to fetch coordinates for organisms other than Human (GRCh38) or Mouse (GRCm39).
- **Performance**: Use `plotFast = TRUE` for quick iterations; set to `FALSE` for high-resolution publication-quality figures.
- **Interactive Analysis**: Run `methylscaper()` to launch the Shiny app for an interactive "brushing" experience to weight and refine plots.
- **File Naming**: For single-cell data, ensure file pairs are named consistently (e.g., `Sample1_met` and `Sample1_acc`) so the package can pair them correctly.

## Reference documentation
- [Using methylscaper to visualize joint methylation and nucleosome occupancy data](./references/methylScaper.md)