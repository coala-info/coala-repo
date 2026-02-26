---
name: bioconductor-cbea
description: CBEA performs set-based enrichment analysis for microbiome relative abundance data using competitive balances. Use when user asks to transform taxa-by-sample matrices into set-by-sample matrices, perform taxonomic enrichment analysis, or calculate enrichment scores for microbiome datasets.
homepage: https://bioconductor.org/packages/3.16/bioc/html/CBEA.html
---


# bioconductor-cbea

name: bioconductor-cbea
description: Perform set-based enrichment analysis for microbiome relative abundance data using Competitive Balances for Taxonomic Enrichment Analysis (CBEA). Use this skill when analyzing taxonomic sets (e.g., metabolic pathways, aerobic/anaerobic groupings) in microbiome datasets to transform taxa-by-sample matrices into set-by-sample matrices for downstream differential abundance, classification, or clustering.

## Overview

CBEA is a method for taxonomic enrichment analysis that utilizes the isometric log-ratio (ILR) transformation. It treats taxonomic sets as "balances" against the background of other taxa, providing a competitive enrichment score. This approach is specifically designed for the compositional nature of microbiome data and allows for the estimation of a null distribution via parametric or permutation-based methods to account for inter-taxa correlation.

## Core Workflow

### 1. Data Preparation

CBEA primarily works with `TreeSummarizedExperiment` objects but can also accept raw matrices or data frames.

```r
library(CBEA)
library(BiocSet)
library(TreeSummarizedExperiment)

# Load example data
data("hmp_gingival")
abun <- hmp_gingival$data # TreeSummarizedExperiment
metab_sets <- hmp_gingival$set # BiocSet object
```

- **Taxa Names**: Ensure element names in your `BiocSet` match the `rownames` of your abundance data.
- **Zero Handling**: CBEA adds a pseudocount (default 1e-5) if zeros are present. For specific zero-handling, pre-process data before calling `cbea`.

### 2. Running CBEA

The `cbea` function is the primary interface.

```r
results <- cbea(
    obj = abun, 
    set = metab_sets, 
    abund_values = "16SrRNA", # Name of assay in TSE
    output = "cdf",           # Options: "cdf", "zscore", "pval", "sig", "raw"
    distr = "mnorm",          # "norm" or "mnorm" (mixture normal)
    adj = TRUE,               # Adjust for variance inflation
    parametric = TRUE,        # Use parametric fit (FALSE for permutations)
    n_perm = 100              # Number of permutations for null estimation
)
```

### 3. Output Types (`output` argument)

- `raw`: Returns the raw ILR-based enrichment scores without distribution fitting.
- `cdf` / `zscore`: Returns scores relative to the estimated null distribution (standardized). Best for downstream machine learning or clustering.
- `pval`: Returns unadjusted p-values for enrichment per sample.
- `sig`: Returns a binary indicator (0/1) of enrichment based on the `thresh` argument (default 0.05).

### 4. Processing Results

CBEA provides `tidy` and `glance` methods (compatible with the `broom` package) to extract results into data frames.

```r
library(broom)

# Get a tibble of scores (samples by sets)
final_scores <- tidy(results)

# Get model diagnostics and goodness-of-fit
diagnostics <- glance(results, "fit_diagnostic")

# Compare data distribution vs fitted distribution
fit_comp <- glance(results, "fit_comparison")
```

## Advanced Features

### Parallel Computing
CBEA uses `BiocParallel` for parallelization across sets.

```r
library(BiocParallel)
results <- cbea(abun, set = metab_sets, 
                parallel_backend = MulticoreParam(workers = 2))
```

### Inputting Matrices
If not using `TreeSummarizedExperiment`, specify the orientation:

```r
results <- cbea(obj = my_matrix, set = my_biocset, 
                taxa_are_rows = TRUE)
```

## Tips and Troubleshooting

- **BiocSet**: Use the `BiocSet` package to construct your gene/taxa sets. It allows for easy filtering and mapping of taxonomic IDs.
- **Variance Inflation**: Always set `adj = TRUE` when you suspect high inter-taxa correlation, as this prevents inflated Type I error rates.
- **Mixture Models**: If the null distribution of scores is complex, `distr = "mnorm"` (mixture normal) often provides a better fit than a single normal distribution.

## Reference documentation

- [Basic Usage](./references/basic_usage.md)