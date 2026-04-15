---
name: bioconductor-drimseq
description: DRIMSeq implements a Dirichlet-multinomial framework for modeling multivariate count data to analyze transcript usage in RNA-seq experiments. Use when user asks to identify differential transcript usage between conditions or detect transcript usage quantitative trait loci.
homepage: https://bioconductor.org/packages/release/bioc/html/DRIMSeq.html
---

# bioconductor-drimseq

## Overview

DRIMSeq implements a Dirichlet-multinomial framework for modeling multivariate count data, specifically designed for RNA-seq transcript usage. It models the ratios of features (e.g., transcripts) within a group (e.g., a gene) rather than total abundance. The package supports two main workflows:
1.  **Differential Transcript Usage (DTU):** Identifying changes in transcript proportions between experimental conditions (e.g., Control vs. Knockdown).
2.  **Transcript Usage QTL (tuQTL):** Identifying genetic variants (SNPs) associated with changes in transcript proportions.

## Core Workflow: Differential Transcript Usage (DTU)

### 1. Data Preparation
Create a `dmDSdata` object using a count table (with `gene_id` and `feature_id` columns) and a sample metadata data frame.

```r
library(DRIMSeq)

# counts: data.frame with gene_id, feature_id, and sample columns
# samples: data.frame with sample_id and grouping variables
d <- dmDSdata(counts = pasilla_counts, samples = pasilla_samples)
```

### 2. Filtering
Filter out lowly expressed genes and transcripts to improve power and reliability.
- `min_samps_feature_expr`: Min samples where a transcript must have `min_feature_expr` counts.
- `min_samps_gene_expr`: Min samples where a gene must have `min_gene_expr` counts.

```r
d <- dmFilter(d, 
              min_samps_gene_expr = 7, min_gene_expr = 10,
              min_samps_feature_expr = 3, min_feature_expr = 10)
```

### 3. Precision Estimation
Estimate the Dirichlet-multinomial precision (inverse of dispersion). Use a design matrix to account for conditions and batch effects.

```r
design_full <- model.matrix(~ group, data = samples(d))
set.seed(123) # For reproducibility in subset selection
d <- dmPrecision(d, design = design_full)
```

### 4. Proportion Estimation (Fitting)
Fit the full model to estimate transcript proportions and regression coefficients. Set `bb_model = TRUE` to enable transcript-level testing via the beta-binomial model.

```r
d <- dmFit(d, design = design_full, bb_model = TRUE)
```

### 5. Testing
Perform likelihood ratio tests by specifying which coefficient to drop (null model).

```r
d <- dmTest(d, coef = "groupKD")
# Access results
res_gene <- results(d) # Gene-level
res_tx <- results(d, level = "feature") # Transcript-level
```

## Core Workflow: tuQTL Analysis

### 1. Data Preparation
Requires `GRanges` for genes and SNPs to associate variants within a specific `window`.

```r
d <- dmSQTLdata(counts = geuv_counts, 
                gene_ranges = geuv_gene_ranges,
                genotypes = geuv_genotypes, 
                snp_ranges = geuv_snp_ranges,
                samples = geuv_samples, 
                window = 5e3)
```

### 2. Filtering and Analysis
The tuQTL pipeline follows a similar logic to DTU but operates on gene-SNP blocks.

```r
d <- dmFilter(d, minor_allele_freq = 5)
d <- dmPrecision(d, speed = TRUE) # speed=TRUE uses one precision per gene
d <- dmFit(d)
d <- dmTest(d) # Uses permutation-based p-value adjustment by default
```

## Visualization and Interpretation

- **Data Exploration:** `plotData(d)` shows histograms of features per gene.
- **Precision:** `plotPrecision(d)` plots precision vs. mean expression to check for trends.
- **P-values:** `plotPValues(d)` checks the distribution of p-values.
- **Proportions:** `plotProportions(d, gene_id = "...", group_variable = "group")` visualizes observed vs. estimated transcript ratios. Use `plot_type = "boxplot2"` for large sample sizes (QTL).

## Key Tips
- **Batch Effects:** Include batch variables in the `model.matrix` (e.g., `~ condition + batch`) to account for technical variation.
- **Parallelization:** Use `BPPARAM = BiocParallel::MulticoreParam()` in `dmPrecision`, `dmFit`, and `dmTest` to speed up computation on large datasets.
- **Stage-wise Testing:** For DTU, it is recommended to use the `stageR` package on DRIMSeq outputs to control FDR across gene and transcript levels simultaneously.
- **Precision vs. Dispersion:** DRIMSeq uses "precision" ($\gamma_0$). High precision means low dispersion (low inter-library variation).

## Reference documentation
- [DRIMSeq](./references/DRIMSeq.md)