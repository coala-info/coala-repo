---
name: bioconductor-mslp
description: This tool identifies mutation-specific synthetic lethal partners by integrating patient genomic and transcriptomic data with cell-line genetic screens. Use when user asks to predict consensus synthetic lethal partners, identify overexpressed genes in mutated patients, or correlate gene expression with mutations to find therapeutic targets.
homepage: https://bioconductor.org/packages/release/bioc/html/mslp.html
---


# bioconductor-mslp

name: bioconductor-mslp
description: Identify Mutation-specific Synthetic Lethal Partners (SLPs) using the mslp R package. Use this skill to integrate genomic (mutations, CNA) and transcriptomic (RNA-seq) data from patients with genetic screen data (DepMap, Project Drive) to predict consensus SLPs for loss-of-function mutations in cancer.

# bioconductor-mslp

## Overview

The `mslp` package provides an unsupervised pipeline to identify Synthetic Lethal Partners (SLPs) for specific cancer mutations. It operates on two primary assumptions:
1. **Compensation**: Over-expression of an SLP compensates for the loss of function of a mutation.
2. **Correlation**: Expression of mutations correlates with SLPs in wild-type patients.

The package integrates patient-level omics data with cell-line genetic screens to identify "consensus SLPs" that show consistent impact on cell viability across different models.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mslp")
```

## Typical Workflow

### 1. Data Preprocessing
The package expects mutation profiles, Copy Number Alteration (CNA) profiles, and RNA-seq expression/Z-scores (typically from cBioPortal/TCGA).

```R
library(mslp)
# P_mut, P_cna, P_expr, P_z are paths to standard cBioPortal text files
res <- pp_tcga(P_mut, P_cna, P_expr, P_z)

# Extract processed data
mut_data <- res$mut_data
expr_data <- res$expr_data
zscore_data <- res$zscore_data
```

### 2. Predicting Primary SLPs
Primary SLPs are identified using two complementary modules. It is highly recommended to use `future` for parallel processing.

**Compensation Module:** Identifies overexpressed genes in mutated patients using the Rank Products algorithm.
```R
library(future)
plan(multisession, workers = 2)
res_comp <- comp_slp(zscore_data, mut_data)
```

**Correlation Module:** Uses GENIE3 to select potential SLPs correlated with mutations in wild-type patients.
```R
res_corr <- corr_slp(expr_data, mut_data)

# Filter by importance threshold (default robust value is 0.0016)
res_f <- res_corr[im >= 0.0016]
```

### 3. Estimating Importance Thresholds
For specific cancer types, use `est_im` to calculate a custom importance threshold via permutation.
```R
# Run corr_slp on random mutations multiple times
res_random <- lapply(1:3, function(x) corr_slp(expr_data, random_mut_data))
im_res <- est_im(res_random)
threshold <- mean(im_res$roc_thresh)
```

### 4. Calling Consensus SLPs
Consensus SLPs are primary SLPs that are also hits in genetic screens (e.g., CRISPR/RNAi) and show consistency across cell lines.

```R
# 1. Merge primary results
merged_res <- merge_slp(res_comp, res_corr)

# 2. Identify screen hits (requires screen_hit and mut_info data frames)
# screen_hit: columns [screen_entrez, screen_symbol, cell_line]
# mut_info: columns [mut_entrez, cell_line]
scr_res <- lapply(unique_cell_lines, scr_slp, screen_hit, mut_info, merged_res)
scr_res <- data.table::rbindlist(scr_res)

# 3. Calculate consensus using Cohen's kappa
k_res <- cons_slp(scr_res, merged_res)

# 4. Filter for high-confidence partners
final_slps <- k_res[kappa_value >= 0.6 & padj <= 0.1]
```

## Key Functions

- `pp_tcga()`: Preprocesses standard TCGA/cBioPortal files.
- `comp_slp()`: Predicts SLPs based on the compensation hypothesis.
- `corr_slp()`: Predicts SLPs based on the correlation hypothesis (GENIE3).
- `est_im()`: Estimates the importance threshold for filtering correlation results.
- `merge_slp()`: Combines results from compensation and correlation modules.
- `scr_slp()`: Filters SLPs against genetic screen hits.
- `cons_slp()`: Calculates consensus SLPs across multiple cell lines.

## Reference documentation

- [mslp](./references/mslp.md)