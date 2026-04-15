---
name: bioconductor-gcsscore
description: This tool calculates differential gene expression significance scores from Affymetrix GeneChip microarray probe-level data using the GCS-score algorithm. Use when user asks to calculate S-scores from CEL files, perform pairwise microarray comparisons, or analyze differential expression for Whole Transcriptome and 3' IVT arrays.
homepage: https://bioconductor.org/packages/3.10/bioc/html/GCSscore.html
---

# bioconductor-gcsscore

name: bioconductor-gcsscore
description: Analysis of Affymetrix GeneChip microarray data using the GCS-score algorithm. Use this skill to calculate differential gene expression significance scores (S-scores) directly from probe-level data (.CEL files) for both Whole Transcriptome (WT) and 3' IVT arrays, without requiring separate expression summaries.

# bioconductor-gcsscore

## Overview

The `GCSscore` package implements an improved S-Score algorithm for Affymetrix microarrays. It utilizes a GC-content-based non-specific binding (NSB) model, allowing it to function on modern arrays that lack mismatch (MM) probes. The resulting GCS-score follows a standard normal distribution (Z-score), where values represent the significance of differential expression between two chips. A score of 0 indicates no change, while absolute values greater than 2 or 3 indicate increasing statistical significance.

## Core Workflow

### 1. Loading the Package
```r
library(GCSscore)
library(data.table) # Recommended for handling output
```

### 2. Single Comparison (Two-Chip Analysis)
To compare two specific `.CEL` files:
```r
# Define paths to CEL files
cel1 <- "path/to/sample1.CEL"
cel2 <- "path/to/sample2.CEL"

# Run GCSscore
# method = 1: Gene-level (transcriptclusterid) for WT arrays
# method = 2: Exon-level (probesetid) for WT arrays
results <- GCSscore(celFile1 = cel1, celFile2 = cel2, method = 1)

# results is an ExpressionSet; convert to data.table for easier viewing
results_dt <- data.table::as.data.table(cbind(
  results@featureData@data, 
  results@assayData[["exprs"]]
))
```

### 3. Batch Processing
For multiple pairwise comparisons, use a `celTable` (a 3-column data.frame/data.table).
*   **Column 1:** Run Name
*   **Column 2:** Path to CEL file 1
*   **Column 3:** Path to CEL file 2

```r
# Create or read the batch table
batch_info <- data.table(
  run_name = c("comp1", "comp2"),
  CelFile1 = c("A1.CEL", "A1.CEL"),
  CelFile2 = c("B1.CEL", "C1.CEL")
)

# Run batch analysis
batch_results <- GCSscore(celTable = batch_info, celTab.names = TRUE)
```

## Function Parameters

- `typeFilter`: Set to `1` to include only well-annotated probes (recommended); `0` for all probes.
- `method`: 
    - For WT arrays: `1` (gene-level), `2` (exon-level).
    - For 3' IVT arrays: `1` (GC-content background), `2` (PM-MM background).
- `rm.outmask`: Set to `TRUE` to exclude probes flagged as MASKED or OUTLIER in the CEL files.
- `fileout`: Set to `TRUE` to automatically save results as a timestamped CSV.

## Interpreting Results

Since GCS-scores follow a standard normal distribution ($N(0,1)$), you can calculate p-values directly:

```r
# Extract scores
scores <- results_dt$Sscore

# Calculate two-sided p-values
p_values <- 2 * (1 - pnorm(abs(scores)))

# Filter for significant changes (e.g., |Sscore| > 3)
significant_genes <- results_dt[abs(Sscore) >= 3]
```

## Tips
- **Memory:** The package uses `affxparser` to read CEL files efficiently, but processing many large WT arrays in batch may require significant RAM.
- **Annotation:** The package automatically handles probe grouping based on the array type detected in the CEL header. Ensure the appropriate Bioconductor annotation packages (e.g., `.db` packages) are installed for your specific array.

## Reference documentation
- [GCSscore](./references/GCSscore.md)