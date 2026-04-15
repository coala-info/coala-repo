---
name: bioconductor-mirtarrnaseq
description: bioconductor-mirtarrnaseq identifies miRNA-mRNA interactions by integrating expression data with miRanda predictions using regression models, correlation analysis, or fold-change differences. Use when user asks to identify mRNA targets of miRNAs, perform regression analysis on miRNA/mRNA cohorts, or calculate expression correlations across multiple time points.
homepage: https://bioconductor.org/packages/release/bioc/html/mirTarRnaSeq.html
---

# bioconductor-mirtarrnaseq

name: bioconductor-mirtarrnaseq
description: miRNA and mRNA interaction analysis using various regression models (Gaussian, Poisson, Negative Binomial, Zero-Inflated) and correlation approaches. Use this skill when analyzing matching miRNA/mRNA expression data from the same experiment (cohorts or time points) to identify mRNA targets of miRNAs using statistical modeling and miRanda predictions.

# bioconductor-mirtarrnaseq

## Overview

The `mirTarRnaSeq` package facilitates the identification of miRNA-mRNA interactions by integrating expression data with sequence-based target predictions (miRanda). It supports three primary analysis workflows:
1. **Cohort Analysis**: Using regression models (GLMs) to identify interactions across a sample cohort.
2. **Multi-Time Point Analysis**: Using Pearson correlation across 3 or more time points.
3. **Two-Time Point Analysis**: Using fold-change differences to identify significant shifts between two conditions.

## Core Workflows

### 1. Regression Analysis (Sample Cohorts)
This workflow is used when you have matching miRNA and mRNA expression matrices (samples as columns, genes/miRNAs as rows).

```r
library(mirTarRnaSeq)

# 1. Load miRanda predictions for a species
# Supports: "Human", "Mouse", "Drosophila", "C.elegans", "Epstein_Barr", etc.
miRanda <- getInputSpecies("Epstein_Barr", threshold = 140)

# 2. Prepare data (Combine mRNA and miRNA dataframes)
miRNA_select <- c("ebv-mir-BART9-5p")
Combine <- combiner(mRNA_df, miRNA_df, miRNA_select)
geneVariant <- geneVari(Combine, miRNA_select)

# 3. Run Models
# Options: glm_gaussian(), glm_poisson(), glm_nb(), glm_zeroinfl()
results <- runModels(Combine, geneVariant, miRNA_select, 
                     family = glm_gaussian(), scale = 100)

# 4. Multivariate/Interaction Models
# Use mode="multi" for multivariate or mode="inter" for synergy
multi_results <- runModels(Combine, geneVariant, miRNA_select, 
                           family = glm_multi(), mode = "multi")
```

### 2. Correlation Analysis (3+ Time Points)
Used to identify targets based on expression profiles across a time series.

```r
# 1. Prepare fold change data (list of dataframes)
mrna_fc <- one2OneRnaMiRNA(mrna_file_list, pthreshold = 0.05)$foldchanges
mirna_fc <- one2OneRnaMiRNA(mirna_file_list)$foldchanges

# 2. Calculate correlation and background distribution
corr_matrix <- corMirnaRna(mrna_fc, mirna_fc, method = "pearson")
background <- sampCorRnaMirna(mrna_fc, mirna_fc, Shrounds = 100, Srounds = 1000)

# 3. Identify significant interactions intersecting with miRanda
sig_corrs <- threshSig(corr_matrix, background, pvalue = 0.05)
results <- miRandaIntersect(sig_corrs, background, mrna_fc, mirna_fc, miRanda)

# 4. Visualize
mirRnaHeatmap(results$corr, upper_bound = -0.9)
```

### 3. Fold Change Difference (2 Time Points)
Used for simple condition vs. control comparisons.

```r
# 1. Estimate differences
inter0 <- twoTimePoint(mrna_fc, mirna_fc)
background <- twoTimePointSamp(mrna_fc, mirna_fc, Shrounds = 10)

# 2. Filter by significance and miRanda
sig_inter <- threshSigInter(inter0, background)
results <- mirandaIntersectInter(sig_inter, background, mrna_fc, mirna_fc, miRanda)

# 3. Plot results
final_res <- finInterResult(results)
drawInterPlots(mrna_fc, mirna_fc, final_res)
```

## Key Functions and Parameters

- `getInputSpecies()`: Retrieves pre-parsed miRanda target predictions.
- `runModels()`: The primary engine for regression. Use `family = glm_multi()` to automatically select the best model based on AIC.
- `scale`: A parameter in regression functions (often set to 100 or 10) to handle data scaling for specific distributions like Poisson.
- `miranda_sponge_predict()`: Formats data for compatibility with the SPONGE package for sparse partial correlation.

## Tips for Success

- **Data Normalization**: For regression, ensure both mRNA and miRNA data are on the same scale (e.g., both TPM or both Z-scores using `tzTrans()`).
- **Model Selection**: Use `plot(density(AIC_values))` to compare model performance. Lower AIC indicates a better fit for your specific dataset.
- **Computational Efficiency**: Running `runAllMirnaModels()` on large datasets is time-consuming. Filter for differentially expressed genes or high-variance miRNAs first.
- **miRanda Thresholds**: The `threshold` in `getInputSpecies` filters by miRanda score; higher values are more stringent.

## Reference documentation
- [mirTarRnaSeq](./references/mirTarRnaSeq.md)