---
name: bioconductor-outrider
description: OUTRIDER detects aberrant gene expression outliers in RNA-seq data using a negative binomial autoencoder framework. Use when user asks to identify individual sample outliers in transcriptomic data, control for latent confounders, or visualize outlier significance via volcano and Q-Q plots.
homepage: https://bioconductor.org/packages/release/bioc/html/OUTRIDER.html
---

# bioconductor-outrider

name: bioconductor-outrider
description: Detects aberrant gene expression outliers in RNA-seq data using a negative binomial autoencoder framework. Use this skill when you need to identify individual sample outliers (rather than group differences) in count-based transcriptomic data, control for technical/biological confounders automatically, and visualize outlier significance via volcano or Q-Q plots.

# bioconductor-outrider

## Overview

OUTRIDER (OUTlier in RNA-Seq fInDER) is designed for rare disease diagnostics and precision medicine. Unlike differential expression tools (DESeq2/edgeR) that compare groups, OUTRIDER identifies specific genes in specific samples that deviate significantly from the population distribution. It uses a denoising autoencoder to control for latent confounders and fits a negative binomial distribution to provide statistically robust outlier calls.

## Core Workflow

### 1. Data Initialization
Create an `OutriderDataSet` (ODS) from a count matrix or a `SummarizedExperiment`.

```R
library(OUTRIDER)

# From a matrix
ods <- OutriderDataSet(countData = count_matrix, colData = sample_annotation)

# From a SummarizedExperiment
ods <- OutriderDataSet(se)
```

### 2. Preprocessing and Filtering
Filter out lowly expressed genes to improve power and reduce computational load.

```R
# Filter genes: default requires at least 1 read in 1/100 samples
ods <- filterExpression(ods, minCounts = TRUE, filterGenes = TRUE)
```

### 3. The One-Step Pipeline
For most users, the wrapper function handles confounding control, model fitting, and P-value calculation.

```R
ods <- OUTRIDER(ods)
```

### 4. Detailed Step-by-Step Analysis
If manual control is needed (e.g., choosing specific encoding dimensions):

```R
# 1. Estimate size factors (normalization)
ods <- estimateSizeFactors(ods)

# 2. Find optimal encoding dimension (q) for the autoencoder
ods <- estimateBestQ(ods) 

# 3. Control for confounders
ods <- controlForConfounders(ods, q = mcols(ods)$baseQ)

# 4. Fit the Negative Binomial model
ods <- fit(ods)

# 5. Calculate P-values and Z-scores
ods <- computePvalues(ods, alternative = "two.sided", method = "BY")
ods <- computeZscores(ods)
```

## Interpreting Results

### Extracting Significant Outliers
The `results()` function provides a tidy table of outliers meeting significance thresholds.

```R
# Default: padj < 0.05
res <- results(ods)

# Custom thresholds
res <- results(ods, padjCutoff = 0.1, zScoreCutoff = 2)
```

### Visualization
OUTRIDER provides several diagnostic and result plots:

*   **Sample Correlation**: `plotCountCorHeatmap(ods, normalized = TRUE)` - Check if confounders were removed.
*   **Volcano Plot**: `plotVolcano(ods, "sampleID")` - View outliers for a specific sample.
*   **Expression Rank**: `plotExpressionRank(ods, "geneID")` - See where a specific sample falls in the population for a gene.
*   **Q-Q Plot**: `plotQQ(ods, "geneID")` - Evaluate the fit of the negative binomial model for a gene.
*   **Power Analysis**: `plotPowerAnalysis(ods)` - Visualize what fold-changes are detectable given the mean counts.

## Advanced Features

### Excluding Samples from Fit
If you have known replicates or positive controls that might bias the autoencoder, exclude them from the training phase:

```R
sampleExclusionMask(ods[,"Sample_A"]) <- TRUE
ods <- OUTRIDER(ods) # Sample_A will get P-values but won't influence the model
```

### Using External Normalization
If you prefer PEER or PCA over the autoencoder, you can provide a `normalizationFactors` matrix directly to the ODS object before fitting.

## Reference documentation

- [OUTRIDER - OUTlier in RNA-Seq fInDER](./references/OUTRIDER.md)