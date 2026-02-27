---
name: bioconductor-metaarray
description: This tool performs statistical meta-analysis of microarray data using latent variable models and Probability of Expression transformations. Use when user asks to perform cross-study microarray analysis, merge disparate datasets, calculate inter-study reproducibility scores, or identify robust gene signatures across independent studies.
homepage: https://bioconductor.org/packages/3.5/bioc/html/metaArray.html
---


# bioconductor-metaarray

name: bioconductor-metaarray
description: Statistical meta-analysis of microarray data using latent variable models, Probability of Expression (POE) transformations, and integrative correlation. Use this skill when performing cross-study microarray analysis, merging disparate datasets, or calculating inter-study reproducibility scores and posterior mean differential expression (z-statistics).

## Overview

The `metaArray` package provides a suite of tools for large-scale meta-analysis of microarray data. It focuses on transforming data into a common scale (Probability of Expression), filtering genes based on inter-study concordance, and calculating meta-analytic differential expression statistics. It is particularly useful for identifying robust gene signatures across multiple independent cancer studies.

## Core Workflows

### 1. Data Preparation and Merging
To perform meta-analysis, datasets must be combined into a `mergeExprSet` object. This often requires finding common genes across studies.

```r
library(metaArray)
library(MergeMaid) # Often used in conjunction

# Find common genes across datasets (e.g., study1, study2)
common_genes <- intersect(rownames(study1), rownames(study2))

# Subset and align datasets
study1_sub <- study1[match(common_genes, rownames(study1)), ]
study2_sub <- study2[match(common_genes, rownames(study2)), ]

# Create ExpressionSet objects for each study
# (Requires phenoData/AnnotatedDataFrame setup)
exp1 <- new("ExpressionSet", exprs = study1_sub, phenoData = pdata1)
exp2 <- new("ExpressionSet", exprs = study2_sub, phenoData = pdata2)

# Merge into a single object
merged_data <- mergeExprs(exp1, exp2)
```

### 2. Probability of Expression (POE) Transformation
POE transforms raw expression values into a [-1, 1] scale, representing the probability that a gene is under-expressed (-1) or over-expressed (1) relative to a reference distribution.

- **MCMC Method (`poe.mcmc`)**: More accurate as it borrows information across genes, but computationally intensive. Recommended for batch mode.
- **EM Method (`poe.em`)**: Faster, fits genes separately. Suitable for very large datasets (10k+ genes).

```r
# Using EM for speed
# Note: Input is typically the expression matrix
poe_results <- poe.em(exprs(merged_data))

# Visualize the EM fit for a specific gene
em.draw(as.numeric(exprs(merged_data)[1,]), cl = ncol(merged_data))
```

### 3. Integrative Correlation Analysis
Use `intcor` to identify genes that show consistent co-expression patterns across different studies. This serves as a reproducibility filter.

```r
# Calculate reproducibility scores
cor_scores <- intcor(merged_data)$avg.cor

# Filter merged data for genes above the median reproducibility
high_rep_data <- merged_data[cor_scores > median(cor_scores), ]
```

### 4. Posterior Mean Differential Expression (Z-score)
The `Zscore` function implements a Bayesian approach to combine differential expression evidence across studies.

```r
# Calculate z-scores for the merged studies
# Set permute > 0 to generate a permutation distribution for significance
z_stats <- Zscore(merged_data, permute = 0)
```

## Key Functions

- `mergeExprs`: Combines multiple `ExpressionSet` objects into a `mergeExprSet`.
- `poe.mcmc` / `poe.em`: Transforms data to the Probability of Expression scale.
- `intcor`: Calculates gene-specific reproducibility scores across studies (handles large datasets better than `MergeMaid::intCor`).
- `Zscore`: Calculates the posterior mean differential expression statistic.
- `em.draw`: Provides diagnostic plots for the EM algorithm fit (likelihood trajectory, mixture density, and POE vs. raw expression).

## Tips for Success
- **Memory Management**: For more than 2,000 common genes, use `intcor` from this package rather than `MergeMaid` to avoid memory allocation errors.
- **Batch Processing**: If using `poe.mcmc`, run the script in a non-interactive R session (`R --no-save < script.R &`) as it can take significant time.
- **Scale-Free Analysis**: POE transformation is highly recommended when studies use different platforms or have high raw-scale variation that masks biological signals.

## Reference documentation
- [metaArray](./references/metaArray.md)