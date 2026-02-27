---
name: bioconductor-panp
description: The bioconductor-panp package determines gene expression presence-absence calls for Affymetrix microarrays using negative probesets to calculate empirical p-values. Use when user asks to calculate P/M/A calls, determine if a gene is expressed on an Affymetrix chip, or generate detection calls from RMA or GCRMA preprocessed data.
homepage: https://bioconductor.org/packages/release/bioc/html/panp.html
---


# bioconductor-panp

## Overview

The `panp` (Presence-Absence calls with Negative Probesets) package provides a pipeline to determine if a gene is expressed (Present), potentially expressed (Marginal), or not expressed (Absent) on Affymetrix microarrays. Unlike the standard MAS5 detection calls, `panp` uses Negative Strand Matching Probesets (NSMPs) as negative controls to derive empirical p-values. This allows users to decouple the expression normalization method (e.g., RMA) from the detection call method.

## Workflow

### 1. Data Preparation
`panp` requires an `ExpressionSet` object. You must first preprocess your raw CEL files using a library like `affy` or `gcrma`.

```r
library(affy)
library(gcrma)
library(panp)

# Load CEL files
data <- ReadAffy()

# Preprocess to create an ExpressionSet
# panp works with both log2 (RMA/GCRMA) and non-log data
eset <- gcrma(data)
```

### 2. Generating P/A Calls
The primary function is `pa.calls()`. It calculates p-values based on the survivor function of NSMP intensities.

```r
# Generate calls using default cutoffs (tight = 0.01, loose = 0.02)
PA_results <- pa.calls(eset, looseCutoff = 0.02, tightCutoff = 0.01, verbose = TRUE)

# Results are returned as a list containing two matrices:
# PA_results$Pcalls: Matrix of "P", "M", or "A" strings
# PA_results$Pvals: Matrix of numeric p-values
```

### 3. Extracting and Filtering Results
You can extract the matrices for downstream filtering or export.

```r
calls <- PA_results$Pcalls
pvals <- PA_results$Pvals

# Example: Get IDs of genes called "Present" in the first sample
present_genes <- rownames(calls)[calls[, 1] == "P"]

# Export results to CSV
write.table(calls, file="presence_calls.csv", sep=",", col.names=NA)
```

## Implementation Details

- **Supported Chips**: Currently optimized for HG-U133A and HG-U133 Plus 2.0.
- **Cutoff Logic**:
  - **Present (P)**: p-value < `tightCutoff`
  - **Marginal (M)**: `tightCutoff` <= p-value < `looseCutoff`
  - **Absent (A)**: p-value >= `looseCutoff`
- **Warnings**: You may see a warning: `Collapsing to unique x values...`. This is a benign side effect of the interpolation process used to derive intensity cutoffs from p-values.

## Reference documentation

- [Presence-Absence Calls on AffyMetrix HG-U133 Series Microarrays with panp](./references/panp.md)