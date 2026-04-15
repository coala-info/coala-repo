---
name: bioconductor-mmuphin
description: MMUPHin performs meta-analysis of microbiome datasets by providing tools for batch effect adjustment and statistical discovery across multiple studies. Use when user asks to adjust for batch effects, perform meta-analysis differential abundance testing, or discover discrete and continuous structures in microbiome data.
homepage: https://bioconductor.org/packages/release/bioc/html/MMUPHin.html
---

# bioconductor-mmuphin

name: bioconductor-mmuphin
description: Meta-analysis of microbiome cohorts using the MMUPHin R package. Use this skill for (1) covariate-controlled batch and cohort effect adjustment, (2) meta-analysis differential abundance testing, (3) meta-analysis unsupervised discrete structure (clustering) discovery, and (4) meta-analysis unsupervised continuous structure discovery across multiple microbiome studies.

# bioconductor-mmuphin

## Overview
MMUPHin is a comprehensive R package designed for the meta-analysis of microbiome datasets. It addresses the challenges of heterogeneity across different studies (batches) by providing a uniform pipeline for batch correction and downstream statistical discovery. It is particularly effective for compositional data and handles zero-inflation common in microbial abundance tables.

## Core Workflows

### 1. Batch Effect Adjustment
Use `adjust_batch` to correct for study-specific effects while preserving biological signals of interest.

```r
library(MMUPHin)
# feature_abd: feature-by-sample matrix (proportions or counts)
# batch: name of the study/batch variable in metadata
# covariates: biological variables to preserve (e.g., "condition")

fit_adj <- adjust_batch(feature_abd = CRC_abd,
                        batch = "studyID",
                        covariates = "study_condition",
                        data = CRC_meta,
                        control = list(zero_inflation = TRUE))

# Access corrected abundances
corrected_abd <- fit_adj$feature_abd_adj
```

### 2. Meta-analysis Differential Abundance
Use `lm_meta` to perform differential abundance testing across multiple studies. This function wraps `Maaslin2` for within-batch analysis and `metafor` for aggregating effect sizes.

```r
fit_meta <- lm_meta(feature_abd = CRC_abd,
                    batch = "studyID",
                    exposure = "study_condition",
                    covariates = c("gender", "age"),
                    data = CRC_meta)

# View meta-analysis results (effect sizes, p-values, heterogeneity)
results <- fit_meta$meta_fits
```

### 3. Discrete Structure Discovery (Clustering)
Use `discrete_discover` to identify if samples form distinct clusters that are reproducible across different studies.

```r
library(vegan)
# Calculate dissimilarity (e.g., Bray-Curtis)
D <- vegdist(t(CRC_abd))

fit_discrete <- discrete_discover(D = D,
                                  batch = "studyID",
                                  data = CRC_meta,
                                  control = list(k_max = 10))

# Evaluation statistics (internal and external validation) are in:
# fit_discrete$internal_mean
# fit_discrete$external_mean
```

### 4. Continuous Structure Discovery
Use `continuous_discover` to identify "consensus" gradients (loadings) that are recurrent across batches using a network-based PCA approach.

```r
fit_continuous <- continuous_discover(feature_abd = CRC_abd,
                                      batch = "studyID",
                                      data = CRC_meta)

# Access consensus scores and loadings
scores <- fit_continuous$consensus_scores
loadings <- fit_continuous$consensus_loadings
```

## Data Requirements and Tips
- **Feature Table**: Must be a feature-by-sample matrix. MMUPHin handles both counts and proportions.
- **Metadata**: Must be a data frame where row names match the column names of the feature table.
- **Batch Variable**: Ensure the batch variable is a factor.
- **Zero-Inflation**: By default, `adjust_batch` uses a zero-inflated model. If your data is not zero-inflated (e.g., high-level taxonomic aggregates), you can set `zero_inflation = FALSE` in the control list.
- **Diagnostics**: Most functions generate diagnostic plots (PDFs) by default. You can customize the filenames or disable them by setting the `diagnostic_plot` parameter to `NULL` in the `control` list.

## Reference documentation
- [MMUPHin Reference Manual](./references/reference_manual.md)