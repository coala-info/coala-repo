---
name: bioconductor-asset
description: The package allows the user to search through all possible subsets of z-scores to identify the subset of traits giving the best meta-analyzed z-score. Further, it returns a p-value adjusting for the multiple-testing involved in the search. It also allows for searching for the best combination of disease subtypes associated with each variant.
homepage: https://bioconductor.org/packages/release/bioc/html/ASSET.html
---

# bioconductor-asset

## Overview

ASSET (Association analysis for SubSETs) is an R package for pooling association signals across multiple studies or traits. Unlike standard meta-analysis, ASSET searches for the subset of studies that yields the strongest evidence of association. It provides p-values adjusted for the multiple testing inherent in this subset search and can handle correlation between studies (e.g., from shared controls).

The package is primarily used for:
1. **h.traits**: Meta-analysis of summary-level data across different studies or correlated traits.
2. **h.types**: Analysis of individual-level data where a disease is categorized into multiple distinct subtypes.

## Core Workflows

### 1. Meta-analysis of Multiple Traits (h.traits)

Use `h.traits` when you have summary statistics (betas and standard errors) from multiple independent or correlated studies.

```r
library(ASSET)

# Required inputs:
# snps: Vector of SNP names
# studies: Vector of study names
# beta: Matrix of log-odds ratios (SNPs x Studies)
# sigma: Matrix of standard errors (SNPs x Studies)
# ncase: Matrix of case counts
# ncntl: Matrix of control counts

# Perform subset search meta-analysis
res <- h.traits(snps, studies, beta, sigma, ncase, ncntl, meta=TRUE)

# Summarize results
h.summary(res)
```

**Key Parameters:**
- `cor`: A correlation matrix if studies are not independent (e.g., shared controls).
- `zmax.args` / `pval.args`: Use these to restrict the subset search (e.g., via a custom `sub.def` function) to reduce the search space.

### 2. Analysis of Disease Subtypes (h.types)

Use `h.types` when you have individual-level data and want to see which disease subtypes are associated with a variant.

```r
# Required inputs:
# dat: Data frame containing all subjects
# response.var: Name of the column with disease subtypes (e.g., "TYPE")
# snp.vars: Vector of SNP column names
# adj.vars: Vector of covariate names (Age, PC1, etc.)
# types.lab: Vector of the specific subtype labels to analyze
# cntl.lab: The label used for controls in the response.var column

ret <- h.types(dat, "TYPE", snp.vars, adj.vars, types.lab, "CONTROL", logit=TRUE)

# Summarize results
h.summary(ret)
```

## Interpreting Results

The `h.summary()` function returns several key components:
- **Meta**: Standard fixed-effects meta-analysis results.
- **Subset.1sided**: Results from searching for the best subset of studies with effects in the same direction (positive).
- **Subset.2sided**: Results from a search that allows for effects in opposite directions (combining a positive-effect subset and a negative-effect subset).
- **Pheno/Pheno.1/Pheno.2**: Lists the specific studies or subtypes that form the "best subset" for that SNP.

## Tips for Success

- **Data Alignment**: Ensure that the `beta`, `sigma`, `ncase`, and `ncntl` matrices all have the same dimensions and that row/column names match your SNP and Study vectors.
- **Directionality**: ASSET is particularly powerful when a variant only affects a subset of traits or has opposing effects in different populations.
- **Missing Data**: The package handles missing genotypes (NA), but ensure your case/control counts reflect the non-missing samples for each specific SNP.
- **Formula Warnings**: If you see warnings regarding `formula.character` being deprecated in `h.types`, ensure your `snp.vars` and `adj.vars` are clean character vectors.

## Reference documentation

- [ASSET Vignette](./references/vignette.md)