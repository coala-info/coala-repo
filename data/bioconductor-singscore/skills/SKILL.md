---
name: bioconductor-singscore
description: Bioconductor-singscore calculates rank-based gene-set enrichment scores for individual transcriptomic samples without requiring cohort-based normalization. Use when user asks to perform N-of-1 gene signature analysis, score bidirectional gene sets, estimate empirical p-values via permutation testing, or visualize rank densities and score landscapes.
homepage: https://bioconductor.org/packages/release/bioc/html/singscore.html
---

# bioconductor-singscore

name: bioconductor-singscore
description: Perform single-sample gene-set scoring using rank-based statistics. Use this skill to calculate enrichment scores for individual transcriptomic samples, handle up- and down-regulated gene signature pairs, estimate empirical p-values via permutation tests, and visualize score landscapes or rank densities.

## Overview

The `singscore` package implements a rank-based method to score individual samples against gene signatures. Unlike methods that require a cohort for normalization (e.g., GSVA), `singscore` treats each sample independently, making it suitable for N-of-1 analysis and clinical applications. It supports bidirectional signatures (up- and down-regulated gene sets) and provides a "stingscore" variant for data with limited gene measurements using stable genes for calibration.

## Core Workflow

### 1. Prepare Gene Sets
Use the `GSEABase` package to manage gene sets. `singscore` functions typically expect `GeneSet` objects.

```r
library(singscore)
library(GSEABase)

# Create GeneSet objects from vectors of gene symbols or IDs
up_gs <- GeneSet(up_vector, setName = "UpRegulated")
dn_gs <- GeneSet(dn_vector, setName = "DownRegulated")
```

### 2. Rank Genes
Rank the expression data for each sample. This is a prerequisite for scoring.

```r
# rankData is a matrix of ranks
rankData <- rankGenes(expression_matrix) 
# Use tiesMethod = 'min' (default) for standard ranking
```

### 3. Calculate Scores
Use `simpleScore` to compute the enrichment scores.

```r
# For a bidirectional signature
scoredf <- simpleScore(rankData, upSet = up_gs, downSet = dn_gs)

# For a single gene set (unidirectional)
scoredf <- simpleScore(rankData, upSet = up_gs)

# If the direction of the gene set is unknown
scoredf <- simpleScore(rankData, upSet = up_gs, knownDirection = FALSE)
```
The resulting data frame contains `TotalScore`, `UpScore`, `DownScore`, and dispersion metrics.

## Advanced Workflows

### Stingscore (Reduced Measurements)
When working with small gene panels instead of whole-transcriptome data, use stable genes to estimate ranks.

```r
# Get stable genes for specific contexts
stable_genes <- getStableGenes(n = 5, type = 'carcinoma')

# Rank using the stable genes as anchors
rankData_st <- rankGenes(small_expression_matrix, stableGenes = stable_genes)

# Score as usual
scoredf_st <- simpleScore(rankData_st, upSet = up_gs, downSet = dn_gs)
```

### Permutation Testing for P-values
To determine if a score is statistically significant compared to a random gene set of the same size:

```r
# 1. Generate null distribution (B = number of permutations)
permuteResult <- generateNull(upSet = up_gs, downSet = dn_gs, rankData = rankData, B = 1000, seed = 1)

# 2. Calculate p-values
pvals <- getPvals(permuteResult, scoredf)
```

## Visualization

### Rank Density Plot
Visualize where the signature genes fall within the transcriptome of a specific sample.
```r
plotRankDensity(rankData[, "SampleName", drop = FALSE], upSet = up_gs, downSet = dn_gs)
```

### Score Landscape
Compare two different scores (e.g., Epithelial vs. Mesenchymal) across a cohort.
```r
# Basic landscape
plotScoreLandscape(scoredf_1, scoredf_2, scorenames = c('Signature1', 'Signature2'))

# Project new samples onto an existing landscape
projectScoreLandscape(plotObj = existing_plot, scoredf_1_new, scoredf_2_new)
```

### Dispersion Plot
Check the relationship between scores and their dispersion (MAD).
```r
plotDispersion(scoredf, annot = sample_metadata_vector)
```

## Tips for Success
- **Gene IDs**: Ensure the gene IDs in your `GeneSet` match the row names of your expression matrix (e.g., Entrez IDs vs. Symbols).
- **Data Scale**: `singscore` is rank-based; while it works on most scales, it is typically applied to normalized data (TPM, RPKM, or log-transformed counts).
- **Parallelization**: `generateNull` supports parallel processing via the `ncores` argument or `BiocParallel` parameters.
- **Interpretation**: A `TotalScore` near 0 indicates no enrichment. Positive scores indicate enrichment in the direction of the signature.

## Reference documentation
- [singscore](./references/singscore.Rmd)
- [singscore](./references/singscore.md)