---
name: bioconductor-frma
description: The frma package provides a preprocessing algorithm for Affymetrix microarrays that uses frozen parameter vectors to analyze samples individually or in small batches. Use when user asks to preprocess microarray data using fRMA, estimate absolute expression with the barcode algorithm, or assess sample quality using GNUSE.
homepage: https://bioconductor.org/packages/release/bioc/html/frma.html
---


# bioconductor-frma

## Overview

The `frma` package provides a specialized preprocessing algorithm that allows Affymetrix microarrays to be analyzed individually or in small batches while maintaining the advantages of multi-array methods like RMA. It achieves this by using "frozen" parameter vectors (probe effects and variances) derived from large public datasets. Additionally, the package includes the `barcode` algorithm to estimate absolute expression (expressed vs. unexpressed) rather than just relative intensity.

## Typical Workflow

### 1. Data Input
Depending on the array platform, use either `affy` or `oligo` to read CEL files.

```r
library(frma)

# For older platforms (e.g., HGU133Plus2)
library(affy)
affy_batch <- ReadAffy()

# For newer platforms (e.g., Gene ST, Exon ST)
library(oligo)
feature_set <- read.celfiles(list.celfiles())
```

### 2. Running fRMA
The `frma` function automatically detects the platform and attempts to load the required parameter package (e.g., `hgu133plus2frmavecs`).

```r
# Basic preprocessing
object <- frma(affy_batch)

# Access expression matrix
exp_matrix <- exprs(object)
```

### 3. Quality Control (GNUSE)
The Global Normalized Unscaled Standard Error (GNUSE) assesses the quality of individual samples relative to the training data used for the frozen parameters.

```r
# Calculate quality statistics
# Median values near 1.0 indicate high quality
gnuse_stats <- GNUSE(object, type="stats")
```

### 4. Gene Expression Barcode
The barcode function converts expression values into binary calls (1 = expressed, 0 = unexpressed).

```r
# Create binary barcode
bc <- barcode(object)

# Alternative outputs (z-score, p-value, or probability/weight)
bc_probs <- barcode(object, output="weight")
bc_zscore <- barcode(object, output="z-score")
```

## Advanced Options

### Summarization Methods
You can specify how probes are combined into gene-level estimates using the `summarize` argument in `frma()`:
- `robust_weighted_average`: (Default) Uses M-estimation and precomputed variances.
- `random_effect`: Recommended when analyzing a batch of new arrays together.
- `weighted_average`, `median`, or `average`.

### Returning Extra Information
To obtain residuals or weights for quality diagnostics, use the `output.param` argument:

```r
object <- frma(affy_batch, summarize="robust_weighted_average", 
               output.param=c("weights", "residuals"))
```

## Key Tips
- **Memory Management**: If you encounter memory errors with large datasets, process arrays in smaller batches. Because the parameters are "frozen," the results for a specific array are consistent regardless of which other arrays are in the batch.
- **Required Packages**: Ensure the specific `<platform>frmavecs` package is installed for your array type.
- **Custom Vectors**: If a platform is not supported, you can create your own frozen vectors using the `frmaTools` package.

## Reference documentation
- [Frozen Robust Multi-Array Analysis and the Gene Expression Barcode](./references/frma.md)