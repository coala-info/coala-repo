---
name: bioconductor-gscreend
description: This package identifies essential genes in pooled CRISPR screens by modeling gRNA log fold changes with a skew-normal distribution and aggregating results via Robust Ranking Aggregation. Use when user asks to identify essential genes from CRISPR screens, analyze pooled perturbation data, or calculate gene-level rankings from gRNA counts.
homepage: https://bioconductor.org/packages/release/bioc/html/gscreend.html
---


# bioconductor-gscreend

## Overview

The `gscreend` package provides a statistical framework for identifying essential genes in pooled CRISPR perturbation screens. It models the null hypothesis of gRNA log fold changes (LFC) using a skew-normal distribution fitted via least quantile regression. This approach accounts for the dependency of LFC variance on initial gRNA abundance (T0 counts). The package aggregates gRNA-level p-values into gene-level rankings using Robust Ranking Aggregation (RRA).

## Core Workflow

### 1. Data Preparation
`gscreend` requires a `SummarizedExperiment` object. The assay should contain raw counts, and `colData` must specify timepoints as "T0" (reference/library) and "T1" (after selection).

```r
library(gscreend)
library(SummarizedExperiment)

# counts_matrix: rows = gRNAs, cols = samples
# rowData: must contain 'sgRNA_id' and 'gene'
# colData: must contain 'timepoint' (T0 or T1)

se <- SummarizedExperiment(
    assays = list(counts = counts_matrix),
    rowData = rowData,
    colData = colData
)

# Initialize the gscreend object
pse <- createPoolScreenExp(se)
```

### 2. Running the Analysis
The `RunGscreend` function automates normalization, LFC calculation, model fitting, and gene ranking.

```r
# Run full pipeline with default parameters
pse_an <- RunGscreend(pse)
```

### 3. Quality Control
Inspect the model fit and replicate consistency to ensure the statistical assumptions hold.

```r
# Check correlation between T1 replicates
plotReplicateCorrelation(pse_an)

# Inspect the fitted skew-normal parameters across T0 bins
plotModelParameters(pse_an)
```

### 4. Extracting Results
Results are extracted for a specific direction (negative for essential genes, positive for growth-enhancing genes).

```r
# Get essential genes (negative selection)
res_neg <- ResultsTable(pse_an, direction = "negative")

# View top hits
head(res_neg[order(res_neg$fdr), ])
```

## Key Functions

- `createPoolScreenExp()`: Constructor for the analysis object. Validates naming conventions for timepoints.
- `RunGscreend()`: The main wrapper function. Performs size normalization, LFC calculation, skew-normal fitting, and RRA.
- `ResultsTable()`: Extracts gene-level statistics including FDR, p-values, and mean LFC.
- `plotModelParameters()`: Visualizes how the distribution of LFCs changes relative to the initial library abundance.

## Tips for Success

- **Timepoint Naming**: Ensure `colData(se)$timepoint` uses exactly "T0" for the library/baseline and "T1" for the treatment/end-point replicates.
- **Gene Mapping**: The `rowData` must have a column named `gene` to allow the aggregation of gRNAs to the gene level.
- **Normalization**: `RunGscreend` performs median-ratio size normalization by default. If your data is already normalized, ensure the input counts are appropriate for the skew-normal fitting process.

## Reference documentation

- [Vignette illustrating the usage of gscreend on simulated data](./references/gscreend_simulated_data.md)
- [R Markdown source for simulated data analysis](./references/gscreend_simulated_data.Rmd)