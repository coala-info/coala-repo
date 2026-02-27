---
name: bioconductor-regsplice
description: The regsplice package implements a computationally efficient method for detecting differential exon usage in RNA-seq or exon microarray data using L1-regularization. Use when user asks to identify differential exon usage, detect alternative splicing, or fit regularized generalized linear models to exon-level data.
homepage: https://bioconductor.org/packages/release/bioc/html/regsplice.html
---


# bioconductor-regsplice

## Overview

The `regsplice` package implements a sensitive and computationally efficient method for detecting differential exon usage (DEU). It uses lasso (L1-regularization) to improve the power of generalized linear models. It is applicable to both RNA-seq read counts and exon microarray intensities.

## Data Preparation

To begin an analysis, prepare the following four components:
1. **counts**: A matrix or data frame of exon-level read counts (RNA-seq) or log2-transformed intensities (microarray).
2. **gene_IDs**: A vector of gene identifiers corresponding to the exons.
3. **n_exons**: A vector indicating the number of exon bins per gene.
4. **condition**: A factor or vector specifying the experimental groups (e.g., "control", "treated").

## Quick Start Workflow

Use the `regsplice()` wrapper function to run the entire pipeline in one step.

```r
library(regsplice)

# Create the data object
rs_data <- RegspliceData(counts, gene_IDs, n_exons, condition)

# Run the complete analysis
# seed is recommended for reproducibility of the lasso fit
rs_results <- regsplice(rs_data, seed = 123)

# View top results
summaryTable(rs_results, n = 20, threshold = 0.05)
```

## Detailed Step-by-Step Workflow

For more control over the analysis (e.g., custom filtering or normalization), execute the steps individually:

1. **Initialize Data**: Create a `RegspliceData` object.
   ```r
   rs_data <- RegspliceData(counts, gene_IDs, n_exons, condition)
   ```

2. **Filtering (RNA-seq only)**: Remove zero-count and low-count exons.
   ```r
   rs_data <- filterZeros(rs_data)
   rs_data <- filterLowCounts(rs_data, filter_min_per_exon = 6, filter_min_per_sample = 0)
   ```

3. **Normalization (RNA-seq only)**: Calculate TMM normalization factors.
   ```r
   rs_data <- runNormalization(rs_data)
   ```

4. **Voom Transformation (RNA-seq only)**: Apply `limma-voom` to calculate weights.
   ```r
   rs_data <- runVoom(rs_data)
   ```

5. **Model Fitting**: Fit regularized, null, and (optionally) full models.
   ```r
   rs_results <- initializeResults(rs_data)
   rs_results <- fitRegMultiple(rs_results, rs_data, seed = 123)
   rs_results <- fitNullMultiple(rs_results, rs_data)
   ```

6. **Likelihood Ratio Tests**: Calculate p-values.
   ```r
   # when_null_selected = "ones" sets p=1 if lasso selects no interaction terms
   rs_results <- LRTests(rs_results, when_null_selected = "ones")
   ```

## Working with Exon Microarray Data

When using microarray data, modify the workflow as follows:
- **Pre-processing**: Log2-transform intensities before providing them to `RegspliceData()`.
- **Disable RNA-seq steps**: Skip `filterZeros()`, `filterLowCounts()`, `runNormalization()`, and `runVoom()`.
- **Wrapper settings**: If using the `regsplice()` wrapper, set `filter_zeros = FALSE`, `filter_low_counts = FALSE`, `normalize = FALSE`, and `voom = FALSE`.

## Interpreting Results

The results are stored in a `RegspliceResults` object. Use these functions to extract information:

- `summaryTable(rs_results)`: Returns a data frame of the most significant genes.
- `p_adj(rs_results)`: Extracts Benjamini-Hochberg adjusted p-values (FDR).
- `LR_stats(rs_results)`: Extracts the likelihood ratio test statistics.

## Advanced Options

- **alpha**: Set the elastic net parameter (default `alpha = 1` for lasso).
- **lambda_choice**: Choose between `"lambda.min"` (default) or `"lambda.1se"` for the optimal penalty parameter in `cv.glmnet`.

## Reference documentation

- [regsplice workflow](./references/regsplice-workflow.md)